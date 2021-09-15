Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3040C2C8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 11:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhIOJbC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 05:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhIOJbB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 05:31:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEA1C061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=Lwbht+9JyHx9MdypVAeL1o5IiJoUcF7weJP3LwqmfQ4=; t=1631698182; x=1632907782; 
        b=JYHk0op/2A+sj6N8nNSr0qMZGowVl4Domm0HjCJP+WKIVd4OA/79IirKDhr7WDkzlyHV9i9Ctom
        JL1txWMSrPk66JM1VmkhzjzSXc3Y7mgadKinD/hzYbu7ufIdRW77Ru89TAuFpF2u/VPyEv2Yf0HMf
        gE63X+eZf+WoOP36LQ0gn9Tx9rzaxVDFyTRRvNv20A3Klb+4rUAaL8NxI7Wi1Zfymef/wrlOCa6XJ
        rBbI9H2i8fFLrJwZpf6STYBMqgsD/FLTYI7YWxvbcNDtKPN0L0fTNqREEyREhSyYCLun9nMZAVsGK
        wr9a75AAJGKKHOR3gap1ukWP9GPnwhTEmhxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mQREZ-007ED9-Lf;
        Wed, 15 Sep 2021 11:29:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com
Subject: [PATCH v2] mac80211-hwsim: fix late beacon hrtimer handling
Date:   Wed, 15 Sep 2021 11:29:37 +0200
Message-Id: <20210915112936.544f383472eb.I3f9712009027aa09244b65399bf18bf482a8c4f1@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Thomas explained in https://lore.kernel.org/r/87mtoeb4hb.ffs@tglx
that our handling of the hrtimer here is wrong: If the timer fires
late (e.g. due to vCPU scheduling, as reported by Dmitry/syzbot)
then it tries to actually rearm the timer at the next deadline,
which might be in the past already:

 1          2          3          N          N+1
 |          |          |   ...    |          |

 ^ intended to fire here (1)
            ^ next deadline here (2)
                                      ^ actually fired here

The next time it fires, it's later, but will still try to schedule
for the next deadline (now 3), etc. until it catches up with N,
but that might take a long time, causing stalls etc.

Now, all of this is simulation, so we just have to fix it, but
note that the behaviour is wrong even per spec, since there's no
value then in sending all those beacons unaligned - they should be
aligned to the TBTT (1, 2, 3, ... in the picture), and if we're a
bit (or a lot) late, then just resume at that point.

Therefore, change the code to use hrtimer_forward_now() which will
ensure that the next firing of the timer would be at N+1 (in the
picture), i.e. the next interval point after the current time.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com
Fixes: 01e59e467ecf ("mac80211_hwsim: hrtimer beacon")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: add fixes tag - it's kind of old and the patch won't apply,
    but even the original hrtimer code here had this problem
---
 drivers/net/wireless/mac80211_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index ffa894f7312a..0adae76eb8df 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1867,8 +1867,8 @@ mac80211_hwsim_beacon(struct hrtimer *timer)
 		bcn_int -= data->bcn_delta;
 		data->bcn_delta = 0;
 	}
-	hrtimer_forward(&data->beacon_timer, hrtimer_get_expires(timer),
-			ns_to_ktime(bcn_int * NSEC_PER_USEC));
+	hrtimer_forward_now(&data->beacon_timer,
+			    ns_to_ktime(bcn_int * NSEC_PER_USEC));
 	return HRTIMER_RESTART;
 }
 
-- 
2.31.1

