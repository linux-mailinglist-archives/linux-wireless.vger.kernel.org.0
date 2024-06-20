Return-Path: <linux-wireless+bounces-9291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13BA91027D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 13:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA1C281E58
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B87C1AB34D;
	Thu, 20 Jun 2024 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="l/HIHeyG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB291AC222
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882700; cv=none; b=SnZr2BuptIH3C1HSqOruXPJGrKKgQpii6IukDTgOr/sAZ5gG8R0ORYyt5Wk6qCT5sxNQLLDreQFwrUqXGd4MPIjW+sriJFbBfyiO4Op53g4sA9C5PkdYwqJNZExuGCwxVrBA2P8yqvC1KXAuCTLFXtRobqFj32FXKA0SE7sZEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882700; c=relaxed/simple;
	bh=LjXu/kZgq8JZfB810yY4yvf4SEVAGCC8x+iIKnbAHZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vch7jCzDXQs4mWDsVQ4gaEj2ZuxNYUMjG46Z9EEdRIrk6YMoOzKpIbr57wbAZUYQZ3lK01f2zm6oBA8wYtpB4FGJZh+eMaDLZuHujLiyDMQ3FtsrMHYw86Tk4g94u4x2PU2kGvDYcYGbfXHt34XUYMyypiAuHD3V6ErFgHJmIEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=l/HIHeyG; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jO2vhMaVvl/vQmUG+SrrjOxh6ONrrAkIS1HZcuEVUY8=; b=l/HIHeyG+5c5eW3SY51h4xx8uR
	iVhysJU49YZWBRSheDhZMbME+Iruy+O9SIEK4HAChW9yLSLFPZbYtAaqEPNK0gV9lRj0xeVnBI0wd
	AXpOm0spdaDxfoqmXvOHoCOvHGqgeHNJPIO3DkyKAzM25rzsUM64sgLdE+J+xcvrcViY=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sKFhL-00Ei9k-2z;
	Thu, 20 Jun 2024 13:11:23 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH 01/10] wifi: nl80211: split helper function from nl80211_put_iface_combinations
Date: Thu, 20 Jun 2024 13:11:13 +0200
Message-ID: <2160a27fc614e2a9a3cba9902e14d305db15530e.1718881762.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.a7730420cfba0f204a60e4c30e6b0e07b441ff6b.1718881762.git-series.nbd@nbd.name>
References: <cover.a7730420cfba0f204a60e4c30e6b0e07b441ff6b.1718881762.git-series.nbd@nbd.name>
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
index 8ff5f79d446a..7b0ba0fff082 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1622,71 +1622,78 @@ static int nl80211_put_iftypes(struct sk_buff *msg, u32 attr, u16 ifmodes)
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

