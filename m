Return-Path: <linux-wireless+bounces-7925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0983D8CB469
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 21:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2E91C21BA9
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F1450A6C;
	Tue, 21 May 2024 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="wel1bhgZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9F50A63;
	Tue, 21 May 2024 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.182.54.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320902; cv=none; b=vCQLEfnKCJPkDTgl6qtpIRQEBtrJlpHfpl84m3BotXoNdBHy4BHYufMFkuSvKUonxQAhBwu5Tm/xNcB4+Vb2TFuqvJTvlW27xBduwaYnyJAUvAlBHvVshGtLvNN8ggwGzQ5i8PdcJfOaEHSIGSSOcdKNyAUvzXGwkkSdizNMfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320902; c=relaxed/simple;
	bh=ClE2otJoZ0W1kPDJn+Gcz9Z/ygh62gvIN22WEfn6lS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aw2pmIGKfp+Tuafy7KZt9sYfE7gtH1+Mnte4kEzBX/85Xx6oDnXa/Toza0ZmPyYaHCD1vFg3/mf9WdWPKDThomKKVfpWroSDY78lGZlrP9U0QfAFvsWnE3pPfQ2XjnDGB8km3PLm7aRbOV5EIkc6T9melV3dc5/Hed6vVN1Rv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=triplefau.lt; dkim=pass (1024-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=wel1bhgZ; arc=none smtp.client-ip=213.182.54.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=triplefau.lt; s=mailo;
	t=1716320791; bh=ClE2otJoZ0W1kPDJn+Gcz9Z/ygh62gvIN22WEfn6lS0=;
	h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	b=wel1bhgZ6illp0Y0+5dESyQY1vo24sQjaYCHDieAvKWCxD9nwVheB4r355r1VH16s
	 nmgl0yYDUPxqHkiNrG/JauiMAkm5f8bhCzergkJKVPJQ9eWgIqsO8zEmmxZ4HsY4oE
	 E/FFPCjmLR2aUZE3HZUVl6dhOIpEp6K/+w4HMmnM=
Received: by b221-6.in.mailobj.net [192.168.90.26] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Tue, 21 May 2024 21:46:31 +0200 (CEST)
X-EA-Auth: bQE2EDSMvwGVfxBwseX4b44Ztx2HnbpDzWTXlEgnWwhFrT9EPv0yeeLkeMa513lQNbDJk9/wPHo/rdrayHYn7GQ9WckV+P8l
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Remi Pommarel <repk@triplefau.lt>,
	Nicolas Escande <nico.escande@gmail.com>,
	Antonio Quartulli <a@unstable.cc>
Subject: [PATCH v2] wifi: cfg80211: Lock wiphy in cfg80211_get_station
Date: Tue, 21 May 2024 21:47:26 +0200
Message-Id: <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wiphy should be locked before calling rdev_get_station() (see lockdep
assert in ieee80211_get_station()).

This fixes the following kernel NULL dereference:

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
 Mem abort info:
   ESR = 0x0000000096000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x06: level 2 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000006
   CM = 0, WnR = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=0000000003001000
 [0000000000000050] pgd=0800000002dca003, p4d=0800000002dca003, pud=08000000028e9003, pmd=0000000000000000
 Internal error: Oops: 0000000096000006 [#1] SMP
 Modules linked in: netconsole dwc3_meson_g12a dwc3_of_simple dwc3 ip_gre gre ath10k_pci ath10k_core ath9k ath9k_common ath9k_hw ath
 CPU: 0 PID: 1091 Comm: kworker/u8:0 Not tainted 6.4.0-02144-g565f9a3a7911-dirty #705
 Hardware name: RPT (r1) (DT)
 Workqueue: bat_events batadv_v_elp_throughput_metric_update
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : ath10k_sta_statistics+0x10/0x2dc [ath10k_core]
 lr : sta_set_sinfo+0xcc/0xbd4
 sp : ffff000007b43ad0
 x29: ffff000007b43ad0 x28: ffff0000071fa900 x27: ffff00000294ca98
 x26: ffff000006830880 x25: ffff000006830880 x24: ffff00000294c000
 x23: 0000000000000001 x22: ffff000007b43c90 x21: ffff800008898acc
 x20: ffff00000294c6e8 x19: ffff000007b43c90 x18: 0000000000000000
 x17: 445946354d552d78 x16: 62661f7200000000 x15: 57464f445946354d
 x14: 0000000000000000 x13: 00000000000000e3 x12: d5f0acbcebea978e
 x11: 00000000000000e3 x10: 000000010048fe41 x9 : 0000000000000000
 x8 : ffff000007b43d90 x7 : 000000007a1e2125 x6 : 0000000000000000
 x5 : ffff0000024e0900 x4 : ffff800000a0250c x3 : ffff000007b43c90
 x2 : ffff00000294ca98 x1 : ffff000006831920 x0 : 0000000000000000
 Call trace:
  ath10k_sta_statistics+0x10/0x2dc [ath10k_core]
  sta_set_sinfo+0xcc/0xbd4
  ieee80211_get_station+0x2c/0x44
  cfg80211_get_station+0x80/0x154
  batadv_v_elp_get_throughput+0x138/0x1fc
  batadv_v_elp_throughput_metric_update+0x1c/0xa4
  process_one_work+0x1ec/0x414
  worker_thread+0x70/0x46c
  kthread+0xdc/0xe0
  ret_from_fork+0x10/0x20
 Code: a9bb7bfd 910003fd a90153f3 f9411c40 (f9402814)

This happens because STA has time to disconnect and reconnect before
batadv_v_elp_throughput_metric_update() delayed work gets scheduled. In
this situation, ath10k_sta_state() can be in the middle of resetting
arsta data when the work queue get chance to be scheduled and ends up
accessing it. Locking wiphy prevents that.

Fixes: 7406353d43c8 ("cfg80211: implement cfg80211_get_station cfg80211 API")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Reviewed-by: Nicolas Escande <nico.escande@gmail.com>
Acked-by: Antonio Quartulli <a@unstable.cc>
---
There are mainly no change since v1 it is only resent because both
linux-wireless and linux-kernel vger mailing list dropped it.

Full thread archive can be found here [0].

Tags from v1 has been added as well as a note on why this lock issue
could end with NULL pointer derefence.

[0]: https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt/
---
 net/wireless/util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2bde8a354631..082c6f9c5416 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2549,6 +2549,7 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 {
 	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
+	int ret;
 
 	wdev = dev->ieee80211_ptr;
 	if (!wdev)
@@ -2560,7 +2561,11 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 
 	memset(sinfo, 0, sizeof(*sinfo));
 
-	return rdev_get_station(rdev, dev, mac_addr, sinfo);
+	wiphy_lock(&rdev->wiphy);
+	ret = rdev_get_station(rdev, dev, mac_addr, sinfo);
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 EXPORT_SYMBOL(cfg80211_get_station);
 
-- 
2.40.0




