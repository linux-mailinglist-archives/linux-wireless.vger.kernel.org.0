Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE166E5C75
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 10:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjDRItP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 04:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjDRItA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 04:49:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178B7690
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2pNhfyigwf3jg3qPzX2v8I+sVoNNXo+B8ure2SdJcVw=;
        t=1681807713; x=1683017313; b=ESmJIsRwKxEhCX/Lld0OZXB0Zu4mphFpb0R7gT9zLfJvObm
        WO3vQUTY/5B1DLOOyFu+g+yDBRyE+TXV+Y7bHHK8cRuUwmeUE6fRFec+4taW0r48HlJ3P48IZl/Dd
        cZUtRnZT92FyV4LesboBgofyAZdvUfdX7qbvdGKDJFBO0PwnRkFBixv+3pGEBeCkZWR/5Pdo496lb
        pj856wWOUDJBCanPvfovCOn4oTYKmBLPxJ2NXEnZt+taFiZX1xayTBLmzoIO/2ZGq/q5eHbcJQXwf
        cR9GfHpavu1nnZ4jJ7TS36LGrql0et7UQqjGWogg9XWuKu3LPg5LVSQJhLLsNYYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1poh0n-001Y87-2I;
        Tue, 18 Apr 2023 10:48:29 +0200
Message-ID: <e40ee96ab2a8d9d079d3a06b7b1c615ab25a2403.camel@sipsolutions.net>
Subject: Re: parsing the multi-link element with STA profile wifi: mac80211:
 support MLO authentication/association with one link
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     ath11k@lists.infradead.org
Date:   Tue, 18 Apr 2023 10:48:28 +0200
In-Reply-To: <571d8ecf-2ca6-8b7b-6e15-be12c56e9f88@quicinc.com>
References: <48715509-62fd-2307-e38f-176234b482c1@quicinc.com>
         <f240b33d507daf898480b0a11eb27d4475e45164.camel@sipsolutions.net>
         <571d8ecf-2ca6-8b7b-6e15-be12c56e9f88@quicinc.com>
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

Hi,

> My case is:
> When connect with 2 links AP, the cfg80211_hold_bss() is called by=20
> cfg80211_mlme_assoc()
> for each BSS of the 2 links,
>=20
> When asssocResp from AP is not success(such as status_code=3D=3D1), the=
=20
> ieee80211_link_data of 2nd link(sdata->link[link_id])
> is NULL because ieee80211_assoc_success()->ieee80211_vif_update_links()=
=20
> is not called.
>=20
> Then struct cfg80211_rx_assoc_resp resp in cfg80211_rx_assoc_resp() and
> struct cfg80211_connect_resp_params cr in __cfg80211_connect_result()=20
> will only have the data of
> the 1st link, and finally cfg80211_connect_result_release_bsses() only=
=20
> call cfg80211_unhold_bss()
> for the 1st link, then BSS of the 2nd link will never free because its=
=20
> hold is awlays > 0 now.

Hah, yes, ouch.

> I found it is not easy to refine it, so do you have any advise/idea?
>=20
> for (link_id =3D 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ieee80211_link_data *l=
ink;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link =3D sdata_dereference(sd=
ata->link[link_id], sdata);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!link)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!assoc_data->link[link_id=
].bss)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resp.links[link_id].bss =3D a=
ssoc_data->link[link_id].bss;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resp.links[link_id].addr =3D =
link->conf->addr;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resp.links[link_id].status =
=3D assoc_data->link[link_id].status;
>=20

But is it really so hard? We only need link for link->conf->addr, and we
can use assoc_data->link[link_id].addr for that instead, no? We need to
store those locally to avoid a use-after-free, but that's at most 15
addresses on the stack, which seems acceptable?

Oh and there's the uapsd stuff but that only matters in the success case
anyway. In fact I'm not even sure the address matters in the
unsuccessful case but we have it pretty easily.

johannes
