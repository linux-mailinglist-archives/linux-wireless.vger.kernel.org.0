Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E591E6DD45B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 09:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDKHjC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 03:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDKHi5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 03:38:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13442728
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 00:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WwqqQpPTcJ4Oo+IPITxQIyJ74zb7uiwV/oXajxDHbyI=;
        t=1681198731; x=1682408331; b=Za515eYzipFLuhxXhLQOk7DjgiXiMmu6EaStgwoznqeMgJv
        o5h5MDCtnXqzdP7hHBECOKIyGn0ewFmBe/wsfLH0WwH6L27m16oKJh7yrUu6JgBoFy63jYeeYb+Zo
        cTBjovDcU+Gsi9K/8oQDzF3NjjUljTfoBtQkXCKRpfD3KU3gv0HpfHCP2mQzWEDyT4q2Bl4GqAS1L
        QDnvn0zGIkzLpATWCKhQhkjLfzfLwiw5kvwoYIQ4SYXPBCKU6DnK/3gE3ec4vHaDKKRtFNte7Lc3G
        I2Y9tXSBPVYtrcGpi8rz1+vQCwaqkhAeSXFE0Us6OwIPIKWGDZtnoZ4rjx2PtqWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pm8aW-00CdQi-2u;
        Tue, 11 Apr 2023 09:38:48 +0200
Message-ID: <e5adbed1524b27228c152ba14f78c550c8730baa.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Tue, 11 Apr 2023 09:38:48 +0200
In-Reply-To: <d10b88b4-0bd7-a38c-e8d7-8982a281c4b3@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
         <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
         <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
         <d10b88b4-0bd7-a38c-e8d7-8982a281c4b3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-04-04 at 11:28 +0800, Wen Gong wrote:
>=20
> May I also add a field such as "u16 active_links_count" in struct=20
> wiphy_iftype_ext_capab,
> and add logic in function ieee80211_set_vif_links_bitmaps() for station=
=20
> like this ?:
> if (active_links_count && hweight16(links) <=3D active_links_count)
>  =C2=A0=C2=A0=C2=A0 then sdata->vif.active_links =3D links;
>=20

Also here, not sure it makes sense in cfg80211 level?

Though I'm not sure what the idea here is at all - you can refuse to
link switch etc, what would you use this for?

Then again, we haven't really designed out all the link selection stuff,
do we want wpa_s to do it, driver to do it, etc.? Hence debugfs. So
depending on what end up doing there, we will obviously need to
advertise some level of link-concurrency to userspace.

johannes
