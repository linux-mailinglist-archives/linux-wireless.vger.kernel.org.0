Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340CD78680E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 09:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbjHXHEB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 03:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbjHXHDd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 03:03:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8E172A
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zALOp5VktsXUoujeClhjSu442pyiTs4hvdJBxkxufGw=;
        t=1692860590; x=1694070190; b=xYtlc6r/RKBlOazwBsgNyPIVtiKa55HW5gAMMh83UG/z84b
        ZgzxgNR4xJndwo7IFmFAsLW3oeNt9GEHR15VLfw3M2bU0DF8cbZr1y0pYMK42Rg10YzzZmaqYXB2L
        mXmbH5C/XCPVq1QwluK7G9xmwUXXH5CoRbl9IJITvIeUVO5bQs85XaIjD6Hj2IqIDAwFDAKOOUVHX
        Dx6INOtThaOKJGaCO7KWPuJmaLAQLOYHlj+u2Ql3wUt0YoehX/vxJE++DjEIKEah9qwBJkTxUVxWG
        /iwAwL6nrfklM+9PaIq4a9JzQMNRzHTZEgQgOb6Hc4UvrgkYRvjjPLnRi8d9Frwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qZ4My-008ioQ-3C;
        Thu, 24 Aug 2023 09:03:05 +0200
Message-ID: <b050f2633da4a81ba7cd70ef58c8e95d011e840d.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: fix cfg80211_bss always hold when
 assoc response fail for MLO connection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 24 Aug 2023 09:03:04 +0200
In-Reply-To: <1a193edc-23a8-6631-5beb-2020de489934@quicinc.com>
References: <20230822100409.1242-1-quic_wgong@quicinc.com>
         <c4d2c8987f929f29da96154e0fc6c9e94882310e.camel@sipsolutions.net>
         <bcf65017-0dbc-e957-f382-98c6dc406346@quicinc.com>
         <941b1bdb6852f20722fa3a5b01f546f054f9e8a8.camel@sipsolutions.net>
         <1a193edc-23a8-6631-5beb-2020de489934@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-08-24 at 10:26 +0800, Wen Gong wrote:
> On 8/23/2023 2:34 PM, Johannes Berg wrote:
> > On Wed, 2023-08-23 at 10:28 +0800, Wen Gong wrote:
> > > >                   /* need to have local link addresses for MLO conn=
ections */
> > > >=20
> > > >                   WARN_ON(cr.ap_mld_addr && !cr.links[link_id].addr=
);
> > > >=20
> > > > makes no sense anymore. Not sure if that's the only one.
> > > After this patch, the cr.links[link_id].addr will be a valid local li=
nk
> > > address from
> > >=20
> > > struct cfg80211_rx_assoc_resp, so I think it is not needed remove now=
.
> > You don't understand.
> >=20
> > The issue is that it's set the line above.
> >=20
> > >                  cr.links[link_id].addr =3D data->links[link_id].addr=
;
> > >                  /* need to have local link addresses for MLO connect=
ions */
> > >                  WARN_ON(cr.ap_mld_addr && !cr.links[link_id].addr);
> > But look at that! What values can cr.links[link_id].addr get? Note how
> > it's a pointer - assigned from an array.
>=20
> Oh, I know it now. the cr.links[link_id].addr will always NOT 0 because=
=20
> it is pointer
>=20
> to an array "u8 addr[ETH_ALEN]" of struct cfg80211_rx_assoc_resp.

Yep.

> So maybe we can choose one of the 2 things to do:
>=20
> 1. remove the "WARN_ON(cr.ap_mld_addr && !cr.links[link_id].addr);"
>=20
> 2. change like this:
>=20
> WARN_ON(cr.ap_mld_addr && !is_valid_ether_addr(cr.links[link_id].addr));
>=20

I think we should check that it's valid, because if you don't fill it,
it'll (hopefully) point to zeroed data somewhere.

johannes
