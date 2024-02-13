Return-Path: <linux-wireless+bounces-3548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B09853336
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67CB281052
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED561E523;
	Tue, 13 Feb 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2vIjfRJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9441E51E
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834786; cv=none; b=fZPabtxsaIP2hxPavWqPwgPVIWRha0FTgvvvthsEHUIdm9MpWN0PpnRb0z/rnn6KHIOncokwD5JdZsiC4pKJIaaxy7cIQ8bUrzOWv5wKfknX0JTIuieF4bT8e0SqyxIg+DrB6m3ADB2Bcp4xIU1xDc3i1aSgISE4nf9CcV8Upd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834786; c=relaxed/simple;
	bh=l/LEe8+NTi1Qtmf5+9ALlf3JGrcmLInhdbXN+9cvjrE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=tQSEpLwRyJ3lnBjVpKN1boljgw2gUpNaonPA2Agut0Lwbx0mBtcaKLgX+0R/T1qvv5aL6r0CWD5whTQlOYEtn8/q2nb10JP/CPbNNjLhWfBWqhN1aICxorIZGAy27LZC/TI9MzmJTJR5eWeaXYwJDIfHhvpX5adBDOjDW8jnczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2vIjfRJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so2945484f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 06:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707834783; x=1708439583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWhGIjLRDOkfCrZpzLrIvkBOBQzhv1S2YHh3isTZznc=;
        b=a2vIjfRJcO8Y+Hh4AF4k904w5Rqlg9YOaGTkYv/pYwnNpCx6oB5NrIczPfliBvVBO5
         Ze1PKiN2/hDgJyeIO+1OAl1WR4VL02VKg/SMVYaj5Nvtq222irsIPQ4DQMrDJw5RNplz
         Ygsi9dRQX2BMl07hjTze9XgYDfdCwn7XbN81BnWNwKGjmrdHOk63y9UokSaXkNHKWeS4
         N6Wbg9FaKkZ622mNF3W7o9P7TdrM9So9SM8jXHkBHF8e5LWyDpD5WbltjKPQoG/G3IPA
         fMhGTJFOUfglxDVf9se6bwFQjwWDQa/V4Q3V88A9TMVonaI8JcfZmietzUV73TLbueNv
         RrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834783; x=1708439583;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vWhGIjLRDOkfCrZpzLrIvkBOBQzhv1S2YHh3isTZznc=;
        b=LIu+6cFU+Z8YNIB6ikKcZvfgMUhnQjM2HtKlvGSVSD256uVgtwjInySouJk51IbSkY
         ot8gBKmGRZOLahG9dWsEVwI8y2hVv7ZjRLdafbmH7RPQW9wogOZ6ghXXhR9l8H508g1J
         QHN/bLDKLbAD5Py+GqsyNrY0L3E0QPzPASCRiQlUiP57J3ZOXla5opWbgyJvp+/iZzNL
         6ucGJUdpBMOHEHEh56PzlyUNV6leZE4pL0YsZBcd3vYlqEAn6aHjJwZ3mw8uOjsZILeG
         ewVMKrUcABirOTpHr85YQgCTPL0VVdXxP9Y9X/Iw1CIUQ1UsSkGSWxR4WDEOignmHUNi
         g28g==
X-Gm-Message-State: AOJu0Yzm7/yyYa2HBmEzPyYkLKt6RWWUd6ees9wyIudTfB6eVUyoGNav
	CDYXidQr4mTQ1O96Sx1iU/P9N34dJGTqTOjKqcgviJ4BSjl0b/AI1S4KOUex
X-Google-Smtp-Source: AGHT+IGn9Gw/3csbVnyy9aZXFg0KmNDQJprj909yK+uYNlb6H8fFPp0Mv/ApFhcexZfHycbCe782KQ==
X-Received: by 2002:adf:e6cc:0:b0:33a:ff0f:2416 with SMTP id y12-20020adfe6cc000000b0033aff0f2416mr6289530wrm.69.1707834783028;
        Tue, 13 Feb 2024 06:33:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZcepH8FggtVf1zkY2oTYtqTqYqLLW7PGunL9lopij3FGEZu6sbVHU9VjH52pmltQokbH6qU+XmR3DHNC2zWNouH6JshkXEHz+
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d44cb000000b0033b43a5f53csm9623995wrr.103.2024.02.13.06.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:33:02 -0800 (PST)
Message-ID: <ed960059-5c77-422d-ac4e-fe9fc9d0d296@gmail.com>
Date: Tue, 13 Feb 2024 16:33:02 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtlwifi: rtl8192cu: Fix 2T2R chip type detection
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtl8192cu handles 1T1R devices (RTL8188CUS), 1T2R devices (RTL8191CU),
and 2T2R devices (RTL8192CU). The 2T2R devices were incorrectly detected
as 1T2R because of a mistake in the IS_92C_1T2R macro.

The visible effect of this is that the firmware was allowed to use
TX rates only up to MCS7.

Fix the IS_92C_1T2R macro.

Now my 2T2R device has much better upload speed.
Before: 46 Mbps.
After:  82 Mbps.

Also fix a debug message which was printing "RF_1T1R" even for 1T2R
chips.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/def.h | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/def.h
index 91e4427ab022..4757f93b84e4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/def.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/def.h
@@ -11,7 +11,7 @@
 #define CHIP_VENDOR_UMC_B_CUT		BIT(6)
 
 #define IS_92C_1T2R(version)		\
-	(((version) & CHIP_92C) && ((version) & CHIP_92C_1T2R))
+	(((version) & CHIP_92C_1T2R) == CHIP_92C_1T2R)
 
 #define IS_VENDOR_UMC(version)		\
 	(((version) & CHIP_VENDOR_UMC) ? true : false)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
index 4ff0d4118193..a76f2dc8a977 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
@@ -101,7 +101,8 @@ void rtl92c_read_chip_version(struct ieee80211_hw *hw)
 		rtlphy->rf_type = RF_1T1R;
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 		"Chip RF Type: %s\n",
-		rtlphy->rf_type == RF_2T2R ? "RF_2T2R" : "RF_1T1R");
+		rtlphy->rf_type == RF_2T2R ? "RF_2T2R" :
+		rtlphy->rf_type == RF_1T2R ? "RF_1T2R" : "RF_1T1R");
 	if (get_rf_type(rtlphy) == RF_1T1R)
 		rtlpriv->dm.rfpath_rxenable[0] = true;
 	else
-- 
2.43.0

