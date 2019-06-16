Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67BB4769F
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 21:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfFPTsA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 15:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfFPTsA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 15:48:00 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F7C52084D;
        Sun, 16 Jun 2019 19:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560714479;
        bh=9CfF53/BqKpz2rz/Qvf/k+vUtUVsGB2093RitO7L7Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baqLifUc7eM8ZZtajRvbgL83V2R5foUQNkU4EUHb689gl+pv2j9B/bcN+VwgFLMYV
         RJJIjnjEfxiGT8oZIt/1Q5J/dqvfPw5BgUbSwJTTbxllcHo4dBQfIaRr1tQJHAtfne
         fkorADeZOHUb7r31oEEw0fgfxST7lA4bQiG/2BCE=
Date:   Sun, 16 Jun 2019 12:47:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] lib80211: use crypto API ccm(aes) transform for CCMP
 processing
Message-ID: <20190616194757.GD923@sol.localdomain>
References: <20190614092922.22517-1-ard.biesheuvel@linaro.org>
 <20190616190136.GA923@sol.localdomain>
 <CAKv+Gu_WiUcdKmDhtNf69P=uVxSLqV+RvscN9BhFg62mQTB=vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_WiUcdKmDhtNf69P=uVxSLqV+RvscN9BhFg62mQTB=vA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jun 16, 2019 at 09:07:28PM +0200, Ard Biesheuvel wrote:
> On Sun, 16 Jun 2019 at 21:01, Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Hi Ard,
> >
> > On Fri, Jun 14, 2019 at 11:29:22AM +0200, Ard Biesheuvel wrote:
> > > -static void ccmp_init_blocks(struct crypto_cipher *tfm,
> > > -                          struct ieee80211_hdr *hdr,
> > > -                          u8 * pn, size_t dlen, u8 * b0, u8 * auth, u8 * s0)
> > > +static void ccmp_init_blocks(struct ieee80211_hdr *hdr,
> > > +                          u8 * pn, size_t dlen, u8 * b0, u8 * aad)
> > >  {
> > >       u8 *pos, qc = 0;
> > >       size_t aad_len;
> > >       int a4_included, qc_included;
> > > -     u8 aad[2 * AES_BLOCK_LEN];
> > >
> > >       a4_included = ieee80211_has_a4(hdr->frame_control);
> > >       qc_included = ieee80211_is_data_qos(hdr->frame_control);
> > > @@ -131,17 +123,19 @@ static void ccmp_init_blocks(struct crypto_cipher *tfm,
> > >               aad_len += 2;
> > >       }
> > >
> > > -     /* CCM Initial Block:
> > > -      * Flag (Include authentication header, M=3 (8-octet MIC),
> > > -      *       L=1 (2-octet Dlen))
> > > -      * Nonce: 0x00 | A2 | PN
> > > -      * Dlen */
> > > -     b0[0] = 0x59;
> > > +     /* In CCM, the initial vectors (IV) used for CTR mode encryption and CBC
> > > +      * mode authentication are not allowed to collide, yet both are derived
> > > +      * from this vector b0. We only set L := 1 here to indicate that the
> > > +      * data size can be represented in (L+1) bytes. The CCM layer will take
> > > +      * care of storing the data length in the top (L+1) bytes and setting
> > > +      * and clearing the other bits as is required to derive the two IVs.
> > > +      */
> > > +     b0[0] = 0x1;
> > > +
> > > +     /* Nonce: QC | A2 | PN */
> > >       b0[1] = qc;
> > >       memcpy(b0 + 2, hdr->addr2, ETH_ALEN);
> > >       memcpy(b0 + 8, pn, CCMP_PN_LEN);
> > > -     b0[14] = (dlen >> 8) & 0xff;
> > > -     b0[15] = dlen & 0xff;
> > >
> > >       /* AAD:
> > >        * FC with bits 4..6 and 11..13 masked to zero; 14 is always one
> > > @@ -166,16 +160,6 @@ static void ccmp_init_blocks(struct crypto_cipher *tfm,
> > >               aad[a4_included ? 30 : 24] = qc;
> > >               /* rest of QC masked */
> > >       }
> > > -
> > > -     /* Start with the first block and AAD */
> > > -     lib80211_ccmp_aes_encrypt(tfm, b0, auth);
> > > -     xor_block(auth, aad, AES_BLOCK_LEN);
> > > -     lib80211_ccmp_aes_encrypt(tfm, auth, auth);
> > > -     xor_block(auth, &aad[AES_BLOCK_LEN], AES_BLOCK_LEN);
> > > -     lib80211_ccmp_aes_encrypt(tfm, auth, auth);
> > > -     b0[0] &= 0x07;
> > > -     b0[14] = b0[15] = 0;
> > > -     lib80211_ccmp_aes_encrypt(tfm, b0, s0);
> > >  }
> >
> > How about shifting the contents of aad over by 2 bytes and returning the AAD
> > length from this function instead?  It's confusing to still manually format the
> > AAD length for CCM mode, when actually it's ignored now.
> >
> > Also I suggest fixing up the naming:
> >
> >         ccmp_init_blocks() => ccmp_init_iv_and_aad()
> >         b0 => iv
> >
> > >
> > >  static int lib80211_ccmp_hdr(struct sk_buff *skb, int hdr_len,
> > > @@ -218,13 +202,13 @@ static int lib80211_ccmp_hdr(struct sk_buff *skb, int hdr_len,
> > >  static int lib80211_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
> > >  {
> > >       struct lib80211_ccmp_data *key = priv;
> > > -     int data_len, i, blocks, last, len;
> > > -     u8 *pos, *mic;
> > >       struct ieee80211_hdr *hdr;
> > > -     u8 *b0 = key->tx_b0;
> > > -     u8 *b = key->tx_b;
> > > -     u8 *e = key->tx_e;
> > > -     u8 *s0 = key->tx_s0;
> > > +     struct aead_request *req;
> > > +     struct scatterlist sg[2];
> > > +     u8 *aad = key->tx_aad;
> > > +     u8 b0[AES_BLOCK_LEN];
> > > +     int len, data_len;
> > > +     int ret;
> > >
> > >       if (skb_tailroom(skb) < CCMP_MIC_LEN || skb->len < hdr_len)
> > >               return -1;
> > > @@ -234,31 +218,29 @@ static int lib80211_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
> > >       if (len < 0)
> > >               return -1;
> > >
> > > -     pos = skb->data + hdr_len + CCMP_HDR_LEN;
> > > +     req = kzalloc(sizeof(*req) + crypto_aead_reqsize(key->tfm), GFP_ATOMIC);
> > > +     if (!req)
> > > +             return -ENOMEM;
> > > +
> >
> > Why not kzalloc() and kzfree() instead of aead_request_alloc() and
> > aead_request_free()?  Same in lib80211_ccmp_decrypt().
> >
> 
> Why kzalloc, right? (i.e., without the 'not'). Good question, I'll change that.
> 

Yes ignore the "not", sorry.

- Eric
