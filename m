Return-Path: <linux-wireless+bounces-29408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCCCC924CF
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE2F3A9FF5
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A435026158B;
	Fri, 28 Nov 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eGg/aAb1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34E92609D0
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339671; cv=none; b=kWt3g+yM1sDdZkMFEzrDq779euYEt7vpiUqwl2NYEwpHucB3xmxJANaLN4ymtNSMPfBodxjc24kzJ3/xdkFpY/6rIiqr2M6HCsqV+xvZtK+SCOIx8MJZ63Un7c8D65AVGeS44RGpQY/oU5lBrcR7y7gXEVPR+nlLOj5VQUJXupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339671; c=relaxed/simple;
	bh=0nyCI5z2cEkywu1q3fY+1Z+oHAqY/W2NKrZZrKXI4hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoJ4und6sV63mBgZx0a63TDiMORuE1j1GfErKk4pd4xPMN+2IgIV8YmeajTl2dga0WdgvPQb8acP/e9FqN9Tm1u75JsKniZrVNp7jBUGsODU/V/bTTV90mMxlJ8Wr1NAGE7t+rBu0s8T82aI4Ivn0CFeBVBfrSAaJIs2coQOaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eGg/aAb1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PaOaPufpPbEscrqen7w9kt+oBnXJLWYEBDNtCUFUsqM=;
	t=1764339670; x=1765549270; b=eGg/aAb1D8oIlV/CF4EIIl5yysCimx3w48Qi1h1u8/40KH2
	e/W/xa4z7ofrwWFw1q9DS1VMZhVmf7K3WfjipDKs5YVvMlcZTejE+LkMfB4rX8iTz6Kp5idBiljaB
	yDK8Oag6k1wZyLkyWWx72oP+xbCV9YbF3h6RgqAP+0uFWOVUmBvVJzQG7fxw1RFc5vWha+KtgynUm
	1CFqxnwEx7f4c3H6nf6Uv828txY2gHPefhSdgQCfu+QdJ6D8NZyX0qCLccMUwtYn/lHeFp9rGGiEA
	UTy7tmXTJNafGFpHYA+ZDORV18tkFHL7RWGfXWsvlFSQA/Pa6bPl5BIwQtXjhvVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLP-00000003926-1cTK;
	Fri, 28 Nov 2025 15:21:07 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 08/18] wifi: mac80211_hwsim: register beacon timer by calculating TBTT
Date: Fri, 28 Nov 2025 15:15:46 +0100
Message-ID: <20251128151537.7dc54aea48a1.Iccf6164f3feeb5350fcfe0df666248c686b226ae@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128141537.287627-20-benjamin@sipsolutions.net>
References: <20251128141537.287627-20-benjamin@sipsolutions.net>
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
index 118c4d92d94f..43b969592d44 100644
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
2.51.1


