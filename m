Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6816F13B3
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 10:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345340AbjD1I5W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 04:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345502AbjD1I5G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 04:57:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161B45FF4
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Cndfm1961jpMjk7aeGQFFrUAS2/uIG05OKh7Dqm+2AQ=;
        t=1682672186; x=1683881786; b=T3Uc7DaelsrF7fxuRfQOrje2b0l5gA/Xr3bRZIJjC/ND/0y
        ag1bfqD88ay+ug8AzNkdDCH8dbu5bcy7gfVrcQ8cGYRR9SIIfCsettceICqNxEv1XKXmdm6ckFQ9I
        2VXPHkJvMGy9Pfp6prQkrssDbDOyhP7w8WLR+8OUMJbL+LKSIFJ3xSc4tpt+dkkr4McLNXd/Mpw0A
        ww04Ls/jaaPDyvZVA0HKDuKJ0R60VVq1bf5k9NxOERzEdVmURNY6nrljjWNuqNxuZYD5KPaIAtLNE
        jlB8jmmdpYfn3eqMUU2FZUXarvBaZWzKaVu8Y5aOlUwMT4o9xYBpLqvxEGVJp8dA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1psJts-00B7C3-1g;
        Fri, 28 Apr 2023 10:56:20 +0200
Message-ID: <966af4d19dff44aafe48505880f55366ce521e8c.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mt76: mt7996: fix endianness of
 MT_TXD6_TX_RATE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        linux-wireless@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek@lists.infradead.org
Date:   Fri, 28 Apr 2023 10:56:19 +0200
In-Reply-To: <16fa938373e3b145cb07a2c98d2428fea2abadba.1682285873.git.ryder.lee@mediatek.com>
References: <16fa938373e3b145cb07a2c98d2428fea2abadba.1682285873.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-04-24 at 05:39 +0800, Ryder Lee wrote:
> To avoid sparse warning:
> sparse: warning: invalid assignment: |=3D
> sparse:    left side has type restricted __le32
> sparse:    right side has type unsigned lon
>=20
> Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES =
support")
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7996/mac.c
> index 130eb7b4fd91..39a4a73ef8e6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -1088,7 +1088,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, =
__le32 *txwi,
>  		else if (beacon && mvif->beacon_rates_idx)
>  			idx =3D mvif->beacon_rates_idx;
> =20
> -		txwi[6] |=3D FIELD_PREP(MT_TXD6_TX_RATE, idx);
> +		txwi[6] |=3D cpu_to_le32(FIELD_PREP(MT_TXD6_TX_RATE, idx));

Btw, and no need to change anything as far as I'm concerned, but just in
case you weren't familiar with it; that kind of thing might be nicer as
le32_encode_bits(), i.e.

	txwi[6] |=3D le32_encode_bits(idx, MT_TXD6_TX_RATE);

Personally, I also generally prefer the typed lower-case versions over
FIELD_GET/PREP etc. but YMMV.

johannes
