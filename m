Return-Path: <linux-wireless+bounces-13527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51829991080
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 22:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F025B1F25CB5
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66491D8DEA;
	Fri,  4 Oct 2024 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="fgZXKIlO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9571D8A0B
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073332; cv=none; b=Yb/ZAzEUTnjAO3/Ss/vrKdQFKdIID0ZiYi+zHj3RrAxuSOUd6l78o0RuWMHgBdk0W1Vfrv8GFBSCZOBXLl5MCndiAovHqNtTz4mzpWDS/jXKIUzncCuHcbx5JAh0mPIQHblyLug2Ivih1gFfCW1OcV1JJ9JQ2NhdRBIw0NdyWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073332; c=relaxed/simple;
	bh=a3mSckHP8g/RM9HHBrzFb4xvOiIsckxcSLNsiulrz1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u859P4nXymJOOfvpVkkXWfliond1f4j/uWBAkm6hn5rcHFzQsMc//soyUySQ+HneFSVg5CEj0AecHNNzLSggnCH4DOj0hws1Nbn7WxR/mUljAIXriBZrIzJKCtr3feEhz5zsSHe7DHkXiU1vAY8SJa47g9HjzjXC8DDdmrXmluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=fgZXKIlO; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hZfnHovJ0HT5hhZaNjyFfLUm91UujzJV4iiwbyTwd90=; b=fgZXKIlOsm8cmPTxCdi8l9UnxV
	gUe6jw3sdJ+VMQ8jYuU3JxnJyD7ccsuOwzDaOB7U46c9hrgQTaAEIIJLM/0d3dN4V5bBiM4jXsHNA
	1npedJbWh59Gokq8vaWbJ96+ZKDhUFGzwClqpGgllbDnf4qqg6KKYv9JjJyYURg1lxBU=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1swooN-004jVl-31;
	Fri, 04 Oct 2024 22:22:04 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v3 08/11] wifi: cfg80211: add monitor SKIP_TX flag
Date: Fri,  4 Oct 2024 22:21:58 +0200
Message-ID: <0272a15db8a9a147b9ec6f32ec03d7cc3163d0e6.1728063865.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
References: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
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

