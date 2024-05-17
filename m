Return-Path: <linux-wireless+bounces-7789-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B3A8C897B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 17:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35771C22C2B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943A412FB02;
	Fri, 17 May 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dKW9lrvO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward201c.mail.yandex.net (forward201c.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E912F398;
	Fri, 17 May 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960466; cv=none; b=DjPYO4oiT4ePQKmF/O3byrZ9lFi4ycCEL7Vhb9SjtQ3T2861H5QNavXh1FPrwe208mWAQk4KZLrblcAsNtgptXdSQA4CwTxxG2L7PuAOXCh/iHxMW++W4ZbKV8L9EmNcqBvvilZA70Zgm7buZLz7IUCOY3omlDJz6m5d3+wPywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960466; c=relaxed/simple;
	bh=0u2MHk2i9OZen3eMY5VE2Cb74f2yioPtycCuCasj6J8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6UCTJE9oMxe4lKkn7TWE4bWgfhfxy9jGrM5g8XHp/upSM+iwN59QrmBS9Y/RsHrTy3oNQx2LbibmXGGq8Td4QQL2CAy+6jI9NC8ZqwETy1HCGLikQFw1r3oFhPfqw3lHuPFTqF1+UnvZT7gK8IHV5qaCN+yGtZcSFh4PjnNlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=dKW9lrvO; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward201c.mail.yandex.net (Yandex) with ESMTPS id 3F2B763FC0;
	Fri, 17 May 2024 18:33:46 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:de2c:0:640:e39b:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id E3D65608DE;
	Fri, 17 May 2024 18:33:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id aXHWQ33Zu8c0-K37bRVuG;
	Fri, 17 May 2024 18:33:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1715960017; bh=JzV/mk6KMC1LwaV1EcKob7gOE3lv1oBnCWZ0hjperVQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=dKW9lrvOtG0OM5bXZhLrxQYLKDmB5VKtw/mmIY85H9iZSNUKrg/wNcUmXVmRRSdjv
	 KfsIWvfv0VBzgQJxMhWXRo/ZvA0itHohehslvNCvgtXA2cQ0LPz46N1A7K2CjmWpWF
	 7jWDHpTKeQDe1ddFRfxB8kij+knT8YAkkuI+2aiA=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>,
	Kees Cook <keescook@chromium.org>,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: cfg80211: use __counted_by where appropriate
Date: Fri, 17 May 2024 18:33:31 +0300
Message-ID: <20240517153332.18271-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate 'sub_specs' of 'struct cfg80211_sar_specs', 'channels'
of 'struct cfg80211_sched_scan_request', 'channels' of 'struct
cfg80211_wowlan_nd_match', and 'matches' of 'struct
cfg80211_wowlan_nd_info' with '__counted_by' attribute. Briefly
tested with clang 18.1.1 and CONFIG_UBSAN_BOUNDS running iwlwifi.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/net/cfg80211.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cbf1664dc569..d79180bec7a1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2200,7 +2200,7 @@ struct cfg80211_sar_sub_specs {
 struct cfg80211_sar_specs {
 	enum nl80211_sar_type type;
 	u32 num_sub_specs;
-	struct cfg80211_sar_sub_specs sub_specs[];
+	struct cfg80211_sar_sub_specs sub_specs[] __counted_by(num_sub_specs);
 };
 
 
@@ -2838,7 +2838,7 @@ struct cfg80211_sched_scan_request {
 	struct list_head list;
 
 	/* keep last */
-	struct ieee80211_channel *channels[];
+	struct ieee80211_channel *channels[] __counted_by(n_channels);
 };
 
 /**
@@ -3582,7 +3582,7 @@ struct cfg80211_coalesce {
 struct cfg80211_wowlan_nd_match {
 	struct cfg80211_ssid ssid;
 	int n_channels;
-	u32 channels[];
+	u32 channels[] __counted_by(n_channels);
 };
 
 /**
@@ -3596,7 +3596,7 @@ struct cfg80211_wowlan_nd_match {
  */
 struct cfg80211_wowlan_nd_info {
 	int n_matches;
-	struct cfg80211_wowlan_nd_match *matches[];
+	struct cfg80211_wowlan_nd_match *matches[] __counted_by(n_matches);
 };
 
 /**
-- 
2.45.1


