Return-Path: <linux-wireless+bounces-13093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D407B983AB2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 03:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3571528182A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 01:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708351B85DB;
	Tue, 24 Sep 2024 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="LJWSZU4c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5818D
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727140412; cv=none; b=onZvmV0IH+IWrqT1ED2YRwX17nrKhDL5Kg9RKHD6935Ak58rDqWN57ExKJ8EOE/c5sAcrSzPjU6Rj9qSiPKP1PVT7MpekKHB07jrHitzlvBz2sCWNmzwK+qZtPaiZjGG+mhfzapCiqYinf/9QhP+zH9ghOiom+4hLM1lh2PYbig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727140412; c=relaxed/simple;
	bh=paVm5pvu/jyoHHp3yHQXwOjwCKdEe+dMXjrLLEDtcWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akdZC89dpZ64jd//fjUNzzth3SzJiXNqiTIz3UeJGIfCKPkJFgjNjq9OpZpz+qslwn8d6qnIza08p30lpbxkU6KHi7HF6xPCqIzl2yRkV1Kqvc02MQXeCuVGjwEeDOjhproI9RZcGUrFUfoXMKQwlkt/rnxK9Huo7vpibSpO1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=LJWSZU4c; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7A730A80061
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 01:13:28 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id D2ED513C2B0;
	Mon, 23 Sep 2024 18:13:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D2ED513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1727140407;
	bh=paVm5pvu/jyoHHp3yHQXwOjwCKdEe+dMXjrLLEDtcWw=;
	h=From:To:Cc:Subject:Date:From;
	b=LJWSZU4cdyDIwonOcdGnOY2S0kE8Kq/WGfT8t35le/WyIGnKig3yRDG7uHq1atY3R
	 zC/x+3hMLdRBOvD6yFOc+0xBS8NOKOVJHQLicDc2YevOyoLfbI2eGENfxqH/jDjwpp
	 u63Hlm5RFLvU3WP9IxRrEqOMxnGCaFgt5d33XIww=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mac80211:  Fix setting txpower with emulate_chanctx
Date: Mon, 23 Sep 2024 18:13:25 -0700
Message-ID: <20240924011325.1509103-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1727140409-mDr-mHLWV9zm
X-MDID-O:
 us5;ut7;1727140409;mDr-mHLWV9zm;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Propagate hw conf into the driver when txpower changes
and driver is emulating channel contexts.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/cfg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 842d3023c9c7..7e2aaae8398d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3102,6 +3102,7 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 	enum nl80211_tx_power_setting txp_type = type;
 	bool update_txp_type = false;
 	bool has_monitor = false;
+	int old_power = local->user_power_level;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -3184,6 +3185,10 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 		}
 	}
 
+	if (local->emulate_chanctx &&
+	    (old_power != local->user_power_level))
+		ieee80211_hw_conf_chan(local);
+
 	return 0;
 }
 
-- 
2.42.0


