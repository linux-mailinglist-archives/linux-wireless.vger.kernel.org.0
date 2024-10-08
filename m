Return-Path: <linux-wireless+bounces-13696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CBE99409E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF0F1F232A8
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ACC204F71;
	Tue,  8 Oct 2024 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="WSKL5t7/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F4204953
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372236; cv=none; b=Y9KmCfm89YwDJgcSCDZf1ADXVCK6OZ8lJTBaQi/WZ5ISO90mg45mOvvspNaOQ03zvqscnPLLupHofDetINRgjjckLYeRP7TyCqJMUeLaoNZTAlOGX4K5v6zaV2OUHuc6N9LgqHO0ot8PCQ5EL6FE0G15Ol3P93ALF1Fs/zZdL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372236; c=relaxed/simple;
	bh=a3mSckHP8g/RM9HHBrzFb4xvOiIsckxcSLNsiulrz1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUVsAvP71oup72DR8VCvLLYvVPZEBQMIN30o6XeXx+wy88snfNZK0wDIAtTtJB+rp1ESzdu44YnazAgNP4+QKg+YJlEqxyAcjwGDA1VKFPA7Y/cY6S4O8S56DdGTJYGYZ/bKOMZdAV514/WVnHfbzEapyZzUw1KvNS0nVZJWrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=WSKL5t7/; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hZfnHovJ0HT5hhZaNjyFfLUm91UujzJV4iiwbyTwd90=; b=WSKL5t7/gjx3aVKIBx+FhL1FYR
	4rKT5S+nbySwSdEfpDogNy275eTt4VVLAISsSSF1ERrKUnh9Wy0fRQHdRaKEi2TDwqh/HNBnERXe9
	6gyh2+z6ApDlF24sQGeZnb2BjwNST00+SiqZqdckXDOjOHUkoIi61Go911CYPenRgMA8=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sy4ZP-006H62-0p;
	Tue, 08 Oct 2024 09:23:47 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v4 08/11] wifi: cfg80211: add monitor SKIP_TX flag
Date: Tue,  8 Oct 2024 09:23:41 +0200
Message-ID: <29ec5fdc9a25a6081337348b3af53b1e02adb492.1728372192.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
References: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
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
index 7845548b15b9..333f06d3ca40 100644
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

