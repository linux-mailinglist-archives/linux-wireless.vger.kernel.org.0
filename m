Return-Path: <linux-wireless+bounces-13420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEAE98D25D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 13:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0B2282724
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B71E6DFF;
	Wed,  2 Oct 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="P6oh+OFQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC6200112
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869524; cv=none; b=ZzywQ+iK8lNvrX/Y0sPLGA3/rYOpqpLIGsbhVdWQlQawPXYQ4B8fD9QA/TLgNEKZQyy0OLof7wxq3JDyG2IyQiu/KZs42lljF7NmX1C0xQ/aNBViJLzY+1MOKm0kDswbvmWiuf/P+cE1mfMV2E0oEAnPNHpKFyeYORS8XiKR5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869524; c=relaxed/simple;
	bh=McZXVSFxjMQ3tVwKaiNOCvqojI7cGch6yIEtYVz5AzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEbuvelaKF/KsO+h1vc5lgq5ofPPz69tzoDU/gE9s93uRQ3MHDxweMndPFwU7QDF95Gr+6E/oyGRH4IW0kWW22og7hsy1zcmiBjoZiRR2LdjeYFAG/diIwIRK8XOn85/a1BaWQx7VOW7mAPQV641xA+RfLWZMj1tNpomco5uFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=P6oh+OFQ; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=k7dTYlIvNkdA1/OLkNoEasatr6grQTTADxEwtvpaBTU=; b=P6oh+OFQkNzj3ldT4pz9JxfygB
	qbDIq9aazz+Z2/Yv6F4rkbSTsu2zkAWF5/QWiuIIzy+1gIXg99OAYxK4TJiKyPTF57bz4P9W5Azgx
	J7yTwZSUvQMauAFd1QHQM9RR84SAUL+4xRUfOmEnSnAop1JcHMYlNt0gb5MG42qW+kSM=;
Received: from p4ff130c8.dip0.t-ipconnect.de ([79.241.48.200] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1svxnD-003vyr-2a;
	Wed, 02 Oct 2024 13:45:19 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH 08/11] wifi: cfg80211: add monitor SKIP_TX flag
Date: Wed,  2 Oct 2024 13:45:14 +0200
Message-ID: <b83cea553d26a99c5f34d6e39dbf7d9d34825f9e.1727869380.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
References: <cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This can be used to indicate that the user is not interested in receiving
locally sent packets on the monitor interface.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h       | 1 +
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/nl80211.c       | 1 +
 3 files changed, 4 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4dd537da0873..de6c585fb1c2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2278,6 +2278,7 @@ enum monitor_flags {
 	MONITOR_FLAG_OTHER_BSS		= BIT(NL80211_MNTR_FLAG_OTHER_BSS),
 	MONITOR_FLAG_COOK_FRAMES	= BIT(NL80211_MNTR_FLAG_COOK_FRAMES),
 	MONITOR_FLAG_ACTIVE		= BIT(NL80211_MNTR_FLAG_ACTIVE),
+	MONITOR_FLAG_SKIP_TX		= BIT(NL80211_MNTR_FLAG_SKIP_TX),
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 1b8827f920ff..6d11437596b9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4703,6 +4703,7 @@ enum nl80211_survey_info {
  *	overrides all other flags.
  * @NL80211_MNTR_FLAG_ACTIVE: use the configured MAC address
  *	and ACK incoming unicast packets.
+ * @NL80211_MNTR_FLAG_SKIP_TX: do not pass local tx packets
  *
  * @__NL80211_MNTR_FLAG_AFTER_LAST: internal use
  * @NL80211_MNTR_FLAG_MAX: highest possible monitor flag
@@ -4715,6 +4716,7 @@ enum nl80211_mntr_flags {
 	NL80211_MNTR_FLAG_OTHER_BSS,
 	NL80211_MNTR_FLAG_COOK_FRAMES,
 	NL80211_MNTR_FLAG_ACTIVE,
+	NL80211_MNTR_FLAG_SKIP_TX,
 
 	/* keep last */
 	__NL80211_MNTR_FLAG_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 69cdffa87d8e..e2aab62fd8fd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4203,6 +4203,7 @@ static const struct nla_policy mntr_flags_policy[NL80211_MNTR_FLAG_MAX + 1] = {
 	[NL80211_MNTR_FLAG_OTHER_BSS] = { .type = NLA_FLAG },
 	[NL80211_MNTR_FLAG_COOK_FRAMES] = { .type = NLA_FLAG },
 	[NL80211_MNTR_FLAG_ACTIVE] = { .type = NLA_FLAG },
+	[NL80211_MNTR_FLAG_SKIP_TX] = { .type = NLA_FLAG },
 };
 
 static int parse_monitor_flags(struct nlattr *nla, u32 *mntrflags)
-- 
git-series 0.9.1

