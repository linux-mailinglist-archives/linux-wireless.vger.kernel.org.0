Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5302D79E4DD
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 12:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbjIMK1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 06:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjIMK1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 06:27:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AA0D3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=D4AFccfNPL1or7tuTclNn+d+NrnVo1gsq80w14w3bZw=;
        t=1694600816; x=1695810416; b=SoDsJIXWlJ/zNbuo8ZZ9Wn1Yw5umV61dWn341sWRSDujyQQ
        gLGnh+bYlGIn92U1G9yIiJdfCXs1hf8Vt5snM05dBJleuBMjtFvHP+l/GuQJ8lxPuSTRPIChKipkr
        l+WMKH1sNxd8XKNNvDDsBIaqHCzw20rzErpCAfw6aBPjILuRBSCRQEHXFUFkKVC4PP7ct0TK0HyId
        9RzCLrJQmmKa0ZjmJtKPVmY4ey+coIqFukMK/QlT20dMGlw2RDgoD/T+rNuWmAfNgYxFeKXBo50nl
        Y1E0AQ+MgJSin24Cnvs/Jf0nWoZiHsxUh9Zin6Q6EMP9n/xGF8Yj7eBtpviNB7Cg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgN5B-00EmwK-2Z;
        Wed, 13 Sep 2023 12:26:54 +0200
Message-ID: <1912863dcd17aa50b09d1ddfc889478eb323f901.camel@sipsolutions.net>
Subject: Re: [PATCH v8 0/5] Additional processing in beacon updates (v8)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 13 Sep 2023 12:26:52 +0200
In-Reply-To: <6e680b33-55f5-2c49-3458-6baa4d8cff52@quicinc.com>
References: <20230727174100.11721-1-quic_alokad@quicinc.com>
         <46340c48-285e-4e2a-b6e9-802f922f0c2c@quicinc.com>
         <759fb125-7bfc-7d85-5c71-0a134030a9b9@quicinc.com>
         <6e680b33-55f5-2c49-3458-6baa4d8cff52@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Aloka,

> Please review this series.

Yes, sorry for the delay.

> I know this version is too late to recollect the context of earlier=20
> patches but hopefully following is helpful.
>=20
> Versions 1 to 7 tried to fix this issue - FILS discovery transmission=20
> stops after CSA. I had tried to fix it in mac80211 which did not set=20
> BSS_CHANGED_FILS_DISCOVERY unless new parameters were sent by user-space.
>=20
> For v7, you mentioned that while the flag=3D0 indicates that FILS=20
> configurations did not change, it does not indicate that it got deleted=
=20
> so the driver should decide depending on the existing configuration and
> not depend only on the flag. I have already validated this ath12k patch=
=20
> which fixes the above issue, without cfg80211 and mac80211 patches in=20
> this series:=20
> https://patchwork.kernel.org/project/linux-wireless/patch/20230905174324.=
25296-1-quic_alokad@quicinc.com/
>=20
> And I have changed this series to let the user-space give 'interval=3D0'=
=20
> as the parameter which was basically a no-op earlier. This way the=20
> transmission can be stopped explicitly and include the additional=20
> processing in the change_beacon from the previous versions which was=20
> anyway required.
>=20

Yep, thanks a lot!

I've applied the series since I was rebasing it on the current tree with
the locking changes and while that wasn't hard, I didn't want to
needlessly double the work and have you do it for a resend as well.

I've made some small tweaks and fixes, so please take a look at it, I
hope I didn't mess anything up.

Also, I'd like you to send a follow-up patch that updates the
documentation: now that we pass the whole settings to change_beacon(), I
think we need to document - perhaps as part of the kernel-doc for struct
cfg80211_ap_settings - which of the parameters are actually changing
there. Right now given your patches, it's clear that only beacon,
unsol_bcast_probe_resp and fils_discovery are (currently) allowed to
change.


Alternatively, maybe we should indeed change the prototype again and
introduce a new struct cfg80211_ap_update that contains only the
parameters that change?

That feels a bit harder, but really it isn't by that much - in mac80211
ieee80211_set_fils_discovery() etc. already take the sub-parameters
(&params->fils_discovery), so not a problem there, and in nl80211 we
could as well pass struct cfg80211_fils_discovery directly to
nl80211_parse_fils_discovery() rather than the entire struct
cfg80211_ap_settings, which wouldn't be a massive change.


I think maybe I even prefer the latter if I'm looking at it now, but I'm
not sure I'm not missing something from earlier discussions on this.

What do you think?

johannes
