Return-Path: <linux-wireless+bounces-9710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 716DD91D069
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AB71F2161C
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 07:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB6C41C92;
	Sun, 30 Jun 2024 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="WYgp3Q0l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D108F72
	for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2024 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719733867; cv=none; b=gS8WPEMCwwrzRc4RmRds1SDPKgZT5wnx3cLNzgt13xBTeXZ42i8A49tn2tSugBJFupzmZBbsat5fsRZd6WAyDlS8/1qJ82EcjJ0094taZFGNWokrCLAVRP7+35jCOAmTCIMO1QArhtvVGAuUdsJUzKkLUaKY2NBghVc/9x8nN/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719733867; c=relaxed/simple;
	bh=fzDix0avtTN+uvsT9f/yZJnVVcf4wyTqjnbc8eusqfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OK2rNaO/+5D8QgGyLbU6ae1jO4ulHU6kGfDoSOSwdwyDuSsSnWioFuVmysEs+l3f8GmopodtVzrfwqbIax1r9fte+hstc4zyp2/pTgz7eewu+n17Nz+11HBp2UvawIjGeflfvoFOkttFZNgN/n8ShuNKOa3+zjA1ag28JO9Q0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=WYgp3Q0l; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4XJgwF6KjTKdAyuXkBxu+59gxtF/+5/4ZMJrvPcYeHM=; b=WYgp3Q0lGMU3sdpFtcr8IwnElz
	yeU/jvM16d9Nc9SWh4JjnAsJTIgfpNvf75UZ4hcjUjzCrVlWN0QxvexU2v8MqKnRQvaRW7nkO1D28
	nVely4W92eMo3z3JkbXw2BzN82slnkOnkmzlBYwUSYqSzqhkgwKr3YOqWYNVEGXW8JRE=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sNpKo-000sh7-26;
	Sun, 30 Jun 2024 09:50:54 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v2 01/10] wifi: nl80211: split helper function from nl80211_put_iface_combinations
Date: Sun, 30 Jun 2024 09:50:44 +0200
Message-ID: <22a0eee19dbcf98627239328bc66decd3395122c.1719733819.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
References: <cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a helper function that puts the data from struct
ieee80211_iface_combination to a nl80211 message.
This will be used for adding per-radio interface combination data.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/wireless/nl80211.c | 111 ++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 52 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 674368d028f3..deacd5f3f256 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1631,71 +1631,78 @@ static int nl80211_put_iftypes(struct sk_buff *msg, u32 attr, u16 ifmodes)
 	return -ENOBUFS;
 }
 
-static int nl80211_put_iface_combinations(struct wiphy *wiphy,
-					  struct sk_buff *msg,
-					  bool large)
+static int nl80211_put_ifcomb_data(struct sk_buff *msg, bool large, int idx,
+				   const struct ieee80211_iface_combination *c)
 {
-	struct nlattr *nl_combis;
-	int i, j;
+	struct nlattr *nl_combi, *nl_limits;
+	int i;
 
-	nl_combis = nla_nest_start_noflag(msg,
-					  NL80211_ATTR_INTERFACE_COMBINATIONS);
-	if (!nl_combis)
+	nl_combi = nla_nest_start_noflag(msg, idx);
+	if (!nl_combi)
 		goto nla_put_failure;
 
-	for (i = 0; i < wiphy->n_iface_combinations; i++) {
-		const struct ieee80211_iface_combination *c;
-		struct nlattr *nl_combi, *nl_limits;
+	nl_limits = nla_nest_start_noflag(msg, NL80211_IFACE_COMB_LIMITS);
+	if (!nl_limits)
+		goto nla_put_failure;
 
-		c = &wiphy->iface_combinations[i];
+	for (i = 0; i < c->n_limits; i++) {
+		struct nlattr *nl_limit;
 
-		nl_combi = nla_nest_start_noflag(msg, i + 1);
-		if (!nl_combi)
+		nl_limit = nla_nest_start_noflag(msg, i + 1);
+		if (!nl_limit)
 			goto nla_put_failure;
-
-		nl_limits = nla_nest_start_noflag(msg,
-						  NL80211_IFACE_COMB_LIMITS);
-		if (!nl_limits)
+		if (nla_put_u32(msg, NL80211_IFACE_LIMIT_MAX, c->limits[i].max))
 			goto nla_put_failure;
+		if (nl80211_put_iftypes(msg, NL80211_IFACE_LIMIT_TYPES,
+					c->limits[i].types))
+			goto nla_put_failure;
+		nla_nest_end(msg, nl_limit);
+	}
 
-		for (j = 0; j < c->n_limits; j++) {
-			struct nlattr *nl_limit;
+	nla_nest_end(msg, nl_limits);
 
-			nl_limit = nla_nest_start_noflag(msg, j + 1);
-			if (!nl_limit)
-				goto nla_put_failure;
-			if (nla_put_u32(msg, NL80211_IFACE_LIMIT_MAX,
-					c->limits[j].max))
-				goto nla_put_failure;
-			if (nl80211_put_iftypes(msg, NL80211_IFACE_LIMIT_TYPES,
-						c->limits[j].types))
-				goto nla_put_failure;
-			nla_nest_end(msg, nl_limit);
-		}
+	if (c->beacon_int_infra_match &&
+	    nla_put_flag(msg, NL80211_IFACE_COMB_STA_AP_BI_MATCH))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, NL80211_IFACE_COMB_NUM_CHANNELS,
+			c->num_different_channels) ||
+	    nla_put_u32(msg, NL80211_IFACE_COMB_MAXNUM,
+			c->max_interfaces))
+		goto nla_put_failure;
+	if (large &&
+	    (nla_put_u32(msg, NL80211_IFACE_COMB_RADAR_DETECT_WIDTHS,
+			c->radar_detect_widths) ||
+	     nla_put_u32(msg, NL80211_IFACE_COMB_RADAR_DETECT_REGIONS,
+			c->radar_detect_regions)))
+		goto nla_put_failure;
+	if (c->beacon_int_min_gcd &&
+	    nla_put_u32(msg, NL80211_IFACE_COMB_BI_MIN_GCD,
+			c->beacon_int_min_gcd))
+		goto nla_put_failure;
 
-		nla_nest_end(msg, nl_limits);
+	nla_nest_end(msg, nl_combi);
 
-		if (c->beacon_int_infra_match &&
-		    nla_put_flag(msg, NL80211_IFACE_COMB_STA_AP_BI_MATCH))
-			goto nla_put_failure;
-		if (nla_put_u32(msg, NL80211_IFACE_COMB_NUM_CHANNELS,
-				c->num_different_channels) ||
-		    nla_put_u32(msg, NL80211_IFACE_COMB_MAXNUM,
-				c->max_interfaces))
-			goto nla_put_failure;
-		if (large &&
-		    (nla_put_u32(msg, NL80211_IFACE_COMB_RADAR_DETECT_WIDTHS,
-				c->radar_detect_widths) ||
-		     nla_put_u32(msg, NL80211_IFACE_COMB_RADAR_DETECT_REGIONS,
-				c->radar_detect_regions)))
-			goto nla_put_failure;
-		if (c->beacon_int_min_gcd &&
-		    nla_put_u32(msg, NL80211_IFACE_COMB_BI_MIN_GCD,
-				c->beacon_int_min_gcd))
-			goto nla_put_failure;
+	return 0;
+nla_put_failure:
+	return -ENOBUFS;
+}
 
-		nla_nest_end(msg, nl_combi);
-	}
+static int nl80211_put_iface_combinations(struct wiphy *wiphy,
+					  struct sk_buff *msg,
+					  bool large)
+{
+	struct nlattr *nl_combis;
+	int i;
+
+	nl_combis = nla_nest_start_noflag(msg,
+					  NL80211_ATTR_INTERFACE_COMBINATIONS);
+	if (!nl_combis)
+		goto nla_put_failure;
+
+	for (i = 0; i < wiphy->n_iface_combinations; i++)
+		if (nl80211_put_ifcomb_data(msg, large, i + 1,
+					    &wiphy->iface_combinations[i]))
+			goto nla_put_failure;
 
 	nla_nest_end(msg, nl_combis);
 
-- 
git-series 0.9.1

