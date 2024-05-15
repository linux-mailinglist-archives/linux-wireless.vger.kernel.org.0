Return-Path: <linux-wireless+bounces-7674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1B78C61DC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1611C20DF3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF5B4CB55;
	Wed, 15 May 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qqF5BFkr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26C47F6B
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758750; cv=none; b=aJ+0/PYjGx01aZvLkZt4EFn0SqcKNm8fmHq2zzAcTRH9wWJoNQRIEZr7HQq8f6WxbCpy6ASn/I57jsGzwqukhO1aJq8Xn0UA4pgoXQz1jSm5XD4jG/VzC3v+TtZvrSPjyHwIQG5FZmTMwfpiep6P0cSDuFhdI3NQfOm8H8ffJCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758750; c=relaxed/simple;
	bh=/vYzJ8uW0U8WGjO8T6DSaItwayf/3m+8W5gVtxez3Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibEWnebpCXyt1LYkf7xRuAHwXN6S8lfcWAVVRS+CGzP9F37BzMOJ+35DaFvaTpTRuQUsa3eFEBO+TSqY87JgojDVNoC7H+MIPDhh9cH+5/9fOz9Gmjt5KPUJ7vhfLJdnOxhB+NP80+L/xMxtp40xE3mLiWjN60a2rKlUZ0WgEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qqF5BFkr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=d2nDvE9Q1rLmr+4YaSee4dJNpj6KauiaAeURSi6HZjs=;
	t=1715758747; x=1716968347; b=qqF5BFkr+abvQizBBHj61cf7bNxWFmuWOVOEuMUt3feCpUO
	Sf/VS+H1XG1+zU+WYR5fKumK3Uc3qA2EN7fDO0f6obkz6FgfJooK17yov4IIMS5hU7Unzms3yO+qN
	0Q+FaNPiIzUtzD81m2Gw1gwAmpT7Jw/DC62hXolCVXG53iWQMTAYdMkmitTer9UFekmLCebqoPVg+
	K1WbI9/Xm2j2jtJWyZHWlRY50tstAehnmV5xEmM2Qzbe6AujkqwkgfjhWiqYSe4coEukZpbUzDOQl
	gyx+JA5GEUQauo2o0DehY/TQj7aIKgme4sRl98lRdQR3HHnqSwz70TwfvFzVY4aQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s79E8-000000063rL-1yf4;
	Wed, 15 May 2024 09:39:04 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/6] wifi: ieee80211: add missing doc short descriptions
Date: Wed, 15 May 2024 09:38:36 +0200
Message-ID: <20240515093852.16f4355e918e.I940276a4fb006ada68ab1a3e6077e3229fff0f14@changeid>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240515073852.11273-8-johannes@sipsolutions.net>
References: <20240515073852.11273-8-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Some structures erroneously don't have a short description,
add the missing descriptions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index de2dce743ee2..713266ce48a7 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1101,7 +1101,7 @@ enum ieee80211_vht_opmode_bits {
 };
 
 /**
- * enum ieee80211_s1g_chanwidth
+ * enum ieee80211_s1g_chanwidth - S1G channel widths
  * These are defined in IEEE802.11-2016ah Table 10-20
  * as BSS Channel Width
  *
@@ -4145,7 +4145,7 @@ enum ieee80211_idle_options {
 };
 
 /**
- * struct ieee80211_bss_max_idle_period_ie
+ * struct ieee80211_bss_max_idle_period_ie - BSS max idle period element struct
  *
  * This structure refers to "BSS Max idle period element"
  *
@@ -4180,7 +4180,7 @@ enum ieee80211_sa_query_action {
 };
 
 /**
- * struct ieee80211_bssid_index
+ * struct ieee80211_bssid_index - multiple BSSID index element structure
  *
  * This structure refers to "Multiple BSSID-index element"
  *
@@ -4195,7 +4195,8 @@ struct ieee80211_bssid_index {
 };
 
 /**
- * struct ieee80211_multiple_bssid_configuration
+ * struct ieee80211_multiple_bssid_configuration - multiple BSSID configuration
+ *	element structure
  *
  * This structure refers to "Multiple BSSID Configuration element"
  *
-- 
2.45.0


