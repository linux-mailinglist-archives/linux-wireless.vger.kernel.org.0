Return-Path: <linux-wireless+bounces-13770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29762996266
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0D71C216CA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A77C188A0E;
	Wed,  9 Oct 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="q5gfLgRY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10818870E
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462364; cv=none; b=FSqbP6tkZLZxGO90jlKd7TL8sZSogPyCCvXby+PsJUm88n3wK4Q6kk69zpTjWXQfqd39yqgRpEVXyJ93d1SVZy0RNBg+oousJ29AblGWk8RvwF6XgYBBdi1yBOKPE7HhAg2IKxA+CC1ZraHBlOAhVDMk4JxH7uVj8AKtF35Cjo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462364; c=relaxed/simple;
	bh=T8aWZ6ky5aMDHgPLNEcVU9kDrGQy7UHqv2FTHwcaPcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muhSyc60DuY4SmuCjC4clqU94J/TNP/EagrlOPNKsjYthOnOtB1yZMrIYcFBWkitJnm423xr9laFC292Pa2e4poyTKN4sJZDcGzO3L/aD32ZA9QJkZWYemB3uGtHMS/Oq9UOy+ajwTyzPt51Hti5ysI4OIDxl7QwOuoh3ZJWC44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=q5gfLgRY; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7uDNsfTjVvQpbFVeu1LtI5HvkmVHibvN2xo4MmfehWQ=; b=q5gfLgRYVVj+kr3ZvxgTwqQCpM
	zUCOTC0Rha8hZaFCYAHu2Tpr2h6tIPKn8/TD8EEhkCRVjKB7StCNBWZsaEPmjZKdfD0EHwmspqex5
	VvrsZ/c8DSli9UcuZpQsg8blJKKm0wCoWZKygn1meqB1qEjKkMdeVP+7RhzRw346gNm8=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1syS14-006e0I-2r;
	Wed, 09 Oct 2024 10:25:55 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v5 08/11] wifi: cfg80211: add monitor SKIP_TX flag
Date: Wed,  9 Oct 2024 10:25:49 +0200
Message-ID: <f0c20f832eadd36c71fba9a2a16ba57d78389b6c.1728462320.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.7a6c6087b8cacec78525ec7f4f4d38c649d4a647.1728462320.git-series.nbd@nbd.name>
References: <cover.7a6c6087b8cacec78525ec7f4f4d38c649d4a647.1728462320.git-series.nbd@nbd.name>
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
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 2 ++
 net/wireless/nl80211.c       | 1 +
 3 files changed, 5 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 045866b9ffb9..c5c7ccad439e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2269,6 +2269,7 @@ static inline int cfg80211_get_station(struct net_device *dev,
  * @MONITOR_FLAG_OTHER_BSS: disable BSSID filtering
  * @MONITOR_FLAG_COOK_FRAMES: report frames after processing
  * @MONITOR_FLAG_ACTIVE: active monitor, ACKs frames on its MAC address
+ * @MONITOR_FLAG_SKIP_TX: do not pass locally transmitted frames
  */
 enum monitor_flags {
 	MONITOR_FLAG_CHANGED		= BIT(__NL80211_MNTR_FLAG_INVALID),
@@ -2278,6 +2279,7 @@ enum monitor_flags {
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
index 72749cdda091..8d997fafd5f6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4206,6 +4206,7 @@ static const struct nla_policy mntr_flags_policy[NL80211_MNTR_FLAG_MAX + 1] = {
 	[NL80211_MNTR_FLAG_OTHER_BSS] = { .type = NLA_FLAG },
 	[NL80211_MNTR_FLAG_COOK_FRAMES] = { .type = NLA_FLAG },
 	[NL80211_MNTR_FLAG_ACTIVE] = { .type = NLA_FLAG },
+	[NL80211_MNTR_FLAG_SKIP_TX] = { .type = NLA_FLAG },
 };
 
 static int parse_monitor_flags(struct nlattr *nla, u32 *mntrflags)
-- 
git-series 0.9.1

