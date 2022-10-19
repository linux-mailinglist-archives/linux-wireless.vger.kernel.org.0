Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7F6042FA
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJSLM6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 07:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJSLMf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 07:12:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082A0303F0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=s36QNv/moHHJ+f1RqNZgsNfQjM0SpYNUcmf7spZNn7Y=;
        t=1666175976; x=1667385576; b=gyEbPrU6sBS5kxCmEah0RJ2cfUAvFtUMMl9Z2gsUbZ5eiLG
        Xq+74oih8jKHvkte6yvui/gt6gGAKsZO9fAnsjr2obvkkv1g8SU+sv4nQzb7ME/eLNNPIj92BT4RC
        ROS4Ypdj1JbLOkpkBgz4Jhiz4lmBE7+iUFTMfIGExLZHOXaWsdzrE148dSdgZdSAphNyv+H1pmYUZ
        4rDh8rGVr0TyKDtYHFH5riZFPt03kBhuVTMab3bCUuQLSxGOWLUV/OObNZEdaw+K5pGMscXJwqwtJ
        iaNQzNs3rkpexByknuTOBvbVi2Q+zaYuTB7UIZU+OjfxNrCl9Z8i2RiOVcUOSIAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ol5Wz-00B30v-0z;
        Wed, 19 Oct 2022 11:38:33 +0200
Message-ID: <5f652efb43226f67e932f5aaf97cd717992bfd81.camel@sipsolutions.net>
Subject: Re: wifi: mac80211: Re: unicast probe response bssid changed by
 "wifi: mac80211: do link->MLD address translation on RX"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     ath11k@lists.infradead.org, ath12k@lists.infradead.org
Date:   Wed, 19 Oct 2022 11:38:32 +0200
In-Reply-To: <9fe7c0f2-e02f-e87f-dced-90e973c8992f@quicinc.com>
References: <e1c5fbac-7e6e-c643-f24d-32cec779f2d3@quicinc.com>
         <9fe7c0f2-e02f-e87f-dced-90e973c8992f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-10-19 at 17:35 +0800, Wen Gong wrote:
> On 9/14/2022 11:13 AM, Wen Gong wrote:
> > Hi Johannes,
> >=20
> > The mac addr of unicast rx packet all changed to the MLD address by=20
> > below patch.
> > Now the probe presponse which is unicast packet is also changed mac=20
> > address here.
> > I found bssid which is the MLD address of my test AP in=20
> > cfg80211_get_bss().
> > For example, if the AP has 2 mlo links, link 1 is 5 GHz band, link 2=
=20
> > is 2.4 GHz band,
> > then the 2 probe reponse will be changed to a same one.
> > seems we should skip probe presponse for the mac address change here,=
=20
> > right?
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?i=
d=3D42fb9148c078004d07b4c39bd7b1086b6165780c=20
> >=20
> > wifi: mac80211: do link->MLD address translation on RX
> >=20
> Hi Johannes,
>=20
> May I get your comment about this?

Yes I've actually seen this issue as well.

> I did below change in my local test to workaround the issue.
>=20
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index a57811372027..eaff5353520a 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -4858,7 +4858,8 @@ static bool ieee80211_prepare_and_rx_handle(struct=
=20
> ieee80211_rx_data *rx,
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 shwt->hwtstamp =3D skb_hwtst=
amps(skb)->hwtstamp;
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> -=C2=A0=C2=A0=C2=A0 if (unlikely(link_sta)) {
> +=C2=A0=C2=A0=C2=A0 if (unlikely(link_sta) &&
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 !(ieee80211_is_probe_resp(hdr->fra=
me_control))) {
>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* translate to MLD addresse=
s */
>=20

Maybe it should also be for beacons or so?

johannes
