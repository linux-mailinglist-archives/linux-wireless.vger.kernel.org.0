Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463A677CB68
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjHOLCv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 07:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjHOLCU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 07:02:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CCCB3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zboR3csukJ2EXgHFJOWfROpkx7Se/GugAkef4pOUFbY=;
        t=1692097338; x=1693306938; b=oRzVbGngpl0naaKHHEQOo1Rp121ILWGDazb7yZPPOwWo1Q3
        5IYumjwR1L2ZKomOOHYEOzFepvaGNWBa9BDlHAOyizLKFPZ4iY00Jn86zm9nmlGhJuk/AUJhhLomg
        3OqNg0JnMicY+SKHOZHfGIGWwUxVcPxXeHY4JUqfZ3arKqX+hzxFru4ErILj/kcyv1AmPJGiHGTIG
        OZhuKSE6U5rIgdhbeoO8jZw76oypjM+5ONvCH8cN+4k7Kj01Ucee5fS3iu2poJurPJxLnJp+CUijc
        wIVQJZbF5VBvJyx8tlWhwXC/lHfeKY910Nqx1nY3SZGdyAz6IiAkdeeRb1d5vibQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVroV-008iim-2z;
        Tue, 15 Aug 2023 13:02:16 +0200
Message-ID: <5864e873e7a81088ecfeb3af3c6bfc27be90adca.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] wifi: cfg80211: fix cqm_config access race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Max Schulze <max.schulze@online.de>, linux-wireless@vger.kernel.org
Date:   Tue, 15 Aug 2023 13:02:15 +0200
In-Reply-To: <3857b8d4-ba9d-7544-98c3-876b80a69bb4@online.de>
References: <ac96309a-8d8d-4435-36e6-6d152eb31876@online.de>
         <20230813151828.ef56f5624c62.I1a1bb102329fc88e4712eaf394cba3025ada0dc7@changeid>
         <3857b8d4-ba9d-7544-98c3-876b80a69bb4@online.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-08-15 at 12:56 +0200, Max Schulze wrote:
> Hello Johannes,
>=20
> thanks for your patch.
>=20
> While it works well in my lab setting, it crashes within minutes in the f=
ield.=20
>=20
> While the crashes look slightly different ("Unable to handle kernel pagig=
n request"... descendant of is_swiotlb_active...) I think the notice before=
hand is much more interesting: do you understand it?
>=20
> : ------------[ cut here ]------------
> : Voluntary context switch within RCU read-side critical section!
[...]
> :  brcmf_sdio_bus_txctl+0xcc/0x1f4 [brcmfmac]
> :  brcmf_proto_bcdc_msg+0xd4/0xf0 [brcmfmac]
> :  brcmf_proto_bcdc_set_dcmd+0x88/0x124 [brcmfmac]
> :  brcmf_fil_cmd_data+0x84/0x180 [brcmfmac]
> :  brcmf_fil_iovar_data_set+0x11c/0x160 [brcmfmac]
> :  brcmf_cfg80211_set_cqm_rssi_range_config+0xe4/0x130 [brcmfmac]
> :  cfg80211_cqm_rssi_update+0x120/0x3f0 [cfg80211]
> :  cfg80211_cqm_rssi_notify+0x78/0x1b4 [cfg80211]
[...]

Oh, yeah, stupid me.

I did RCU protection around cfg80211_cqm_rssi_update() to have that
protected, but failed to realize that this will call back into the
driver too, which then promptly assumes it can sleep.

Well, OK, so this isn't how we can fix this.

That's really bad for multiple reasons though, because it also means we
call back into the driver from a driver call, which is generally not a
good idea since it can easily cause deadlocks.

Anyway, I guess I have to come up with something else. Thanks for
testing, and sorry I didn't realize that before.

johannes
