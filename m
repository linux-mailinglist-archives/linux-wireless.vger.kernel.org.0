Return-Path: <linux-wireless+bounces-30471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B70B3CFE715
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 16:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6E363007C28
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9133C53C;
	Wed,  7 Jan 2026 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J6AIAXbH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7633C50B
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795825; cv=none; b=JshtlE6fX33vrRZEIEK/yfJluz5xsKci3ehs5POfo4BQJBZ+TvRDKNw2o0GEFQVUDI+T2PiX3wrxK3EEe0WOB2UJ7QpT0f76Dj9bxMGawQc/E+aQJvPK5pOUs8DNh2CpzmiLmPUUAVZl6sNdFJe2X7nic35KHr/qRWVGX/acIik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795825; c=relaxed/simple;
	bh=H7ftc4lzXjtGHttBxzaxSlxmNTewwAjPGZzrHBe/do4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGSX0zCNOWR84Yqg2mLpH26hSNSb3bnZANm4stnolnK/tZDkr8R1yn3BOiNAwBeETAawft3bn/ihnrZMbc99KvuQz9t5wrNMpcLIu9s923zOVFNzrIB9ogt2x6POT8rxEfgfweEVZzWULq1k5LyWiy4/VwAqoq43aplvDu74mC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J6AIAXbH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ynobzwzuAdDDtndQVu1PszrZ8VEs3fVQVbRr1EWwoHk=;
	t=1767795823; x=1769005423; b=J6AIAXbHMGB5a7Ph2SwB6UMz8BV9N1v/C3Wm2ZumAFjo9Ix
	DRHKOcBVMzyHXJYi/Uqy56hnH+nKJWepHAPb6PDtJ5P7ts+1njo+zbXVNxw2Bc0CAh7e4cUHW1FL+
	qZAwy/l8BtVm72ZEgeqHUSqSkQxM48x+MOVKPzUsIEAPdgdS7gS29GdX2jAvDAJ8ISPOf3ANAW5YW
	zzz9boBhjjiC5F51WlG1RIaohqXBjYGchChMcocpqPOx3ta+CSnDdBCnyrgM6Ondc/8KnvDJey+8f
	+XTCmob9L1HgBYMyPcPTEwKTG0w0gxbvgzXwPwaAIxnpRX2NML3GKhlqdRAlDzQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURo-00000005agF-3wrW;
	Wed, 07 Jan 2026 15:23:41 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 09/46] wifi: mac80211_hwsim: register beacon timer by calculating TBTT
Date: Wed,  7 Jan 2026 15:22:08 +0100
Message-ID: <20260107152324.36e12460c683.Iccf6164f3feeb5350fcfe0df666248c686b226ae@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

It is easy to calculate the next target beacon transmission time (TBTT)
based on the current TSF and the beacon interval. Use this method to
calculate the time to the next beacon.

With this, the bcn_delta variable can be removed and drift over time due
to the timer firing late is fully avoided.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |  1 -
 .../wireless/virtual/mac80211_hwsim_main.c    | 37 +++++++++++--------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index 5aae80cee8ec..87d5e7c2b643 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -102,7 +102,6 @@ struct mac80211_hwsim_data {
 
 	/* difference between this hw's clock and the real clock, in usecs */
 	s64 tsf_offset;
-	s64 bcn_delta;
 
 	/* Stats */
 	u64 tx_pkts;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 59cf2433b4b6..9dba7896d9f0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1116,6 +1116,12 @@ static inline u64 mac80211_hwsim_get_sim_tsf(void)
 	return ktime_to_us(ktime_get_boottime());
 }
 
+static ktime_t mac80211_hwsim_tsf_to_boottime(struct mac80211_hwsim_data *data,
+					      u64 tsf)
+{
+	return us_to_ktime(tsf - data->tsf_offset);
+}
+
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif)
 {
@@ -1137,8 +1143,6 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	u64 now = mac80211_hwsim_get_tsf(hw, vif);
-	/* MLD not supported here */
-	u32 bcn_int = data->link_data[0].beacon_int;
 	u64 delta = abs(tsf - now);
 	struct ieee80211_bss_conf *conf;
 
@@ -1147,13 +1151,10 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 		return;
 
 	/* adjust after beaconing with new timestamp at old TBTT */
-	if (tsf > now) {
+	if (tsf > now)
 		data->tsf_offset += delta;
-		data->bcn_delta = do_div(delta, bcn_int);
-	} else {
+	else
 		data->tsf_offset -= delta;
-		data->bcn_delta = -(s64)do_div(delta, bcn_int);
-	}
 }
 
 static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
@@ -2274,7 +2275,8 @@ mac80211_hwsim_beacon(struct hrtimer *timer)
 		container_of(link_data, struct mac80211_hwsim_data,
 			     link_data[link_data->link_id]);
 	struct ieee80211_hw *hw = data->hw;
-	u64 bcn_int = link_data->beacon_int;
+	u64 tsf_now;
+	u64 tbtt;
 
 	if (!data->started)
 		return HRTIMER_NORESTART;
@@ -2283,13 +2285,18 @@ mac80211_hwsim_beacon(struct hrtimer *timer)
 		hw, IEEE80211_IFACE_ITER_NORMAL,
 		mac80211_hwsim_beacon_tx, link_data);
 
-	/* beacon at new TBTT + beacon interval */
-	if (data->bcn_delta) {
-		bcn_int -= data->bcn_delta;
-		data->bcn_delta = 0;
-	}
-	hrtimer_forward_now(&link_data->beacon_timer,
-			    ns_to_ktime(bcn_int * NSEC_PER_USEC));
+	/* TSF is the same for all VIFs, parameter is unused */
+	tsf_now = mac80211_hwsim_get_tsf(hw, NULL);
+
+	/* Wrap value to be after the next TBTT */
+	tbtt = tsf_now + link_data->beacon_int;
+
+	/* Round TBTT down to the correct time */
+	tbtt = tbtt - tbtt % link_data->beacon_int;
+
+	hrtimer_set_expires(&link_data->beacon_timer,
+			    mac80211_hwsim_tsf_to_boottime(data, tbtt));
+
 	return HRTIMER_RESTART;
 }
 
-- 
2.52.0


