Return-Path: <linux-wireless+bounces-8582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028638FD600
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F39D282665
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6171413BACE;
	Wed,  5 Jun 2024 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Wop9uO6v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADA113B295
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613287; cv=none; b=QnxO/HIoABaxzQDDBVzVfI8X++n9YWWre41SpV1/KiuLu/sH7vJdJuMLtuEf2BGr3c3G1KsD8VhgSSvYGvU17RJfJP0LthqaC4qUp1ZjDBpf0d/+PjgZg36p5C1YYnbN4wiY5UZ5PnfH6rdEkUDafjIBA4ZI7c/wZ0bGKOzCzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613287; c=relaxed/simple;
	bh=5Chpw2tjoRQ37FnAJyzLfafntMHgiJOQfTyKXeb64p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS477VtEO1pCWs/wjIRZWw4Yt/j3/KVUaslPQL5INmRkN+6DfnHh2JPwvg379Y0y7kt1vMebxgGvQE8oxRGhwVotEPaYezcfkVGW/A4+4eXjniiL4DKM+3y2GwVCI5E2zOqE8iTP6ViHuy+cL9hJVNmNnIhQRJ0FwKIbAuk7X2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Wop9uO6v; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2NJEcI/gwWKWhWtJcgMb3b1YliXBYBRU0fVxhC2YDSU=; b=Wop9uO6vK+JOxR68IqQ6E7MHys
	Y/zyirXDj9fS246aTF7x/shHVIfnkfstB+4U5Qi+iOcm1Hvc/G9z6gu2CgWKy7iitUCi1BUorcVkS
	0ngOtt+qbaP9eX+zAyMFtdloomldjOiGXvpuDD/Jdy1AEwb0zEiJ1xm/QSAZEi9cpCvw=;
Received: from p4ff130d0.dip0.t-ipconnect.de ([79.241.48.208] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sEvQA-008Gwq-00;
	Wed, 05 Jun 2024 20:31:38 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v2 3/7] wifi: cfg80211: extend interface combination check for multi-radio
Date: Wed,  5 Jun 2024 20:31:26 +0200
Message-ID: <8fc2f117346fcb4ed11bb20cdf9cb1f88bcf64b4.1717611760.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.c104c0bb3a14f4ac26aee71f4979846f6ad87742.1717611760.git-series.nbd@nbd.name>
References: <cover.c104c0bb3a14f4ac26aee71f4979846f6ad87742.1717611760.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a field in struct iface_combination_params to check per-radio
interface combinations instead of per-wiphy ones.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h |  2 ++
 net/wireless/util.c    | 29 +++++++++++++++++------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 27355e08ae52..c1439ac975d6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1595,6 +1595,7 @@ struct cfg80211_color_change_settings {
  *
  * Used to pass interface combination parameters
  *
+ * @radio: when set, check radio specific interface combinations.
  * @num_different_channels: the number of different channels we want
  *	to use for verification
  * @radar_detect: a bitmap where each bit corresponds to a channel
@@ -1608,6 +1609,7 @@ struct cfg80211_color_change_settings {
  *	the verification
  */
 struct iface_combination_params {
+	const struct wiphy_radio *radio;
 	int num_different_channels;
 	u8 radar_detect;
 	int iftype_num[NUM_NL80211_IFTYPES];
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2bde8a354631..fc3e8fbb4cc2 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2309,9 +2309,6 @@ static void cfg80211_calculate_bi_data(struct wiphy *wiphy, u32 new_beacon_int,
 {
 	struct wireless_dev *wdev;
 
-	*beacon_int_gcd = 0;
-	*beacon_int_different = false;
-
 	list_for_each_entry(wdev, &wiphy->wdev_list, list) {
 		int wdev_bi;
 
@@ -2366,13 +2363,15 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 					    void *data),
 			       void *data)
 {
+	const struct wiphy_radio *radio = params->radio;
+	const struct ieee80211_iface_combination *c;
 	const struct ieee80211_regdomain *regdom;
 	enum nl80211_dfs_regions region = 0;
-	int i, j, iftype;
+	int i, j, n, iftype;
 	int num_interfaces = 0;
 	u32 used_iftypes = 0;
-	u32 beacon_int_gcd;
-	bool beacon_int_different;
+	u32 beacon_int_gcd = 0;
+	bool beacon_int_different = false;
 
 	/*
 	 * This is a bit strange, since the iteration used to rely only on
@@ -2384,8 +2383,10 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 	 * cfg80211 already - the only thing not would appear to be any new
 	 * interfaces (while being brought up) and channel/radar data.
 	 */
-	cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
-				   &beacon_int_gcd, &beacon_int_different);
+	if (!radio)
+			cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
+						   &beacon_int_gcd,
+						   &beacon_int_different);
 
 	if (params->radar_detect) {
 		rcu_read_lock();
@@ -2402,13 +2403,17 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 			used_iftypes |= BIT(iftype);
 	}
 
-	for (i = 0; i < wiphy->n_iface_combinations; i++) {
-		const struct ieee80211_iface_combination *c;
+	if (radio) {
+		c = radio->iface_combinations;
+		n = radio->n_iface_combinations;
+	} else {
+		c = wiphy->iface_combinations;
+		n = wiphy->n_iface_combinations;
+	}
+	for (i = 0; i < n; i++, c++) {
 		struct ieee80211_iface_limit *limits;
 		u32 all_iftypes = 0;
 
-		c = &wiphy->iface_combinations[i];
-
 		if (num_interfaces > c->max_interfaces)
 			continue;
 		if (params->num_different_channels > c->num_different_channels)
-- 
git-series 0.9.1

