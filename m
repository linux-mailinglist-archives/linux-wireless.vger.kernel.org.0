Return-Path: <linux-wireless+bounces-34336-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB5pN2ryz2mt1wYAu9opvQ
	(envelope-from <linux-wireless+bounces-34336-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 19:01:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5947F396B95
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 19:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C1F730B5492
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DE93537F8;
	Fri,  3 Apr 2026 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOXYHiHO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419322DAFDF
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775235281; cv=none; b=oId/0ENJo6o7vC/P+swkWFeenX+f3b400FG4IRcxSVlRgZUpdGMqSTXkutE9CFzas2GPzcBpVlXJaMycnl+vhhdkbnMzpRQtQikCJEi7ljQpHoq2zu5cVtp2regRoc9P4vJ4q5ryZTR5bzsyfsdYW4xty4GpznXYiIUFGAq2QDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775235281; c=relaxed/simple;
	bh=jMzPovgrxq3Y9O/1z3qSvx4DmLp7FmDzM3JKvT0QPcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XsVjiI6PfRhfsdX03q/m8mCFiwqdAnaXV/ck+uWlUwD/dQMTcKBZW3QrhqHRwCocX185kdAArcgZ73dmvhBjnKAlVZIRgqkl1bwMNZ6QuQiSeC2+wqfcRWFbm7jQUXnxvqV4r6Leo307RUvnCJrA3uJrSRTeyKMvHF8SGbjsfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qOXYHiHO; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-470145d7e6cso143423b6e.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775235279; x=1775840079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVRk2kVa3rrw7EUgYoierPZiryQLo5GC1o8qCUJeaZI=;
        b=qOXYHiHOjhxihSmcHtBQo06pYs2GVsUR01mXvqMywbVrOtwFmi+jAfL9zFYrJeMw/e
         Al6cscspSc0zr/8wQdiMFKPGOYdNJdPTD+uJ9sCfLKc9Ql9rPaQeBjUbhnY4AqI8yeEH
         6BXgWzYB8HMFkOJvKqc3EFfNOhpLks19horPHKQOA+/UVcw9nYtPbHLAYJf1rxZF+F3V
         zX79ksNzEp9K5N8JfG7ojQ9mn8c675hbD56MiInHV3Gah3tuUPcyUxw0OkG6ZI3DGVfm
         IagNtwt2CBkJBVYnYJE/EsZNuWWn2I2nyRoItMwxDJs7TCYvke167jnShSXv2c6MJo5G
         gF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775235279; x=1775840079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVRk2kVa3rrw7EUgYoierPZiryQLo5GC1o8qCUJeaZI=;
        b=E9Xn1v3qnesi+Wq7SD+SQISKJLejQYIz0+9bTV3QxyxiwRf3a8VWBES8asM3TRLOPH
         6YgcyqCNoOU04dJoivvknUR5bXSUnFi+pbEZYPk/hm1x1coYooixmyKt/W0e8caRPwX+
         ct5cIqzSQi/cylzkWV9+bybYPlUiRWSv35hL/F/bYLRVCIXm38H8sNk+PJFVNwVhcbfD
         MidZ1f8GKQL8Ltz9/vPxHst+9t9VfmLbXxclGFx2s23N7Wbt8L0PjUTsc1GkG/WhJQvs
         Gbg3ubZXZVZanVD+rjThJUsr+6gp5gh5kxJOMxuatnTaGURmXD/LFKLV/azr8C+TT5Qw
         VB5g==
X-Forwarded-Encrypted: i=1; AJvYcCVife1vcXT/H/XDIJqalZkkRPKdOXqxtRaCnZb6XNvaPQTxX829bDP4NUb6oZFts5/tNBxLd1Er0HrTq0IQQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzo1RqCkhmRW0/vsOm5nETFxA/DEkDEKQ/a9XRgh1324aqbgF8
	9Mxb81jlIM3R+g4m3EntdNoKHUEh5wM52hjyX8AJYVu6la9PIP+t/rok
X-Gm-Gg: ATEYQzz6RqQ1gHFMLXM+qIQ3eOYyP1BA58283troWOClWrNzFMxL0YxoHqf+Y9Oob9K
	hG9f7CJ5Yxa6igwFDw5WGzRMBoRNpPRTbpwxsQjLDpNPdOpPkFASYdYaD3jdHFJnsGkBHv8PkPK
	R9x/+ot0ML6bYHQUuP0MfGPCTUp6naAA38P0D7up44bV3cb/ztO6bh4tBCVY0LVZ9lwDKteSgdU
	UomSHiC948HU6gKXH0EJcC2IVwe7vW/WDqo/8kSeNaNpKc3diKW/jidAoqMbzsQn7gO3pJkVnm3
	kyk3r8Ocup1zhRU404nYMvD4ZrL6uElFabkOhrqcZwdqaCA8gtF4Pz7YgPG+ekeaUiS5r1T5qZY
	bIWcyfRSEEv7i3uK2CaWAMWJby/tyegKaV+N+QNp1ZSC3v8s5mQV7EoFmuFJ+tOiRfcvppJfLYp
	EXJQNSaAdQ8qLZe3WZIbMgY8U8qvhA+YvfDqd/B2VyKQr4Jcr9bEk=
X-Received: by 2002:a05:6808:c1fb:b0:467:15ad:9df0 with SMTP id 5614622812f47-46ef57f0137mr1925091b6e.7.1775235279005;
        Fri, 03 Apr 2026 09:54:39 -0700 (PDT)
Received: from Linux-Ub241.fyre.ibm.com ([170.225.223.17])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d92f66ca2sm3678952b6e.13.2026.04.03.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 09:54:38 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: pkshih@realtek.com
Cc: johannes.berg@intel.com,
	bhelgaas@google.com,
	linux-wireless@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] rtlwifi: rtl8821ae: Remove dead code in rtl8821ae_update_hal_rate_table()
Date: Fri,  3 Apr 2026 09:54:16 -0700
Message-ID: <20260403165416.131684-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,google.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34336-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chelsyratnawat2001@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5947F396B95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The variable 'mimo_ps' is initialized to IEEE80211_SMPS_OFF and never
modified throughout the function. This makes the condition checking for
IEEE80211_SMPS_STATIC always evaluate to false, rendering the entire
if-branch unreachable dead code.

The error was reported by Coverity Scan.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 3a4a33476205..81d36041a79b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -3257,7 +3257,6 @@ static void rtl8821ae_update_hal_rate_table(struct ieee80211_hw *hw,
 	u32 ratr_value;
 	u8 ratr_index = 0;
 	u8 b_nmode = mac->ht_enable;
-	u8 mimo_ps = IEEE80211_SMPS_OFF;
 	u16 shortgi_rate;
 	u32 tmp_ratr_value;
 	u8 curtxbw_40mhz = mac->bw_40;
@@ -3288,19 +3287,15 @@ static void rtl8821ae_update_hal_rate_table(struct ieee80211_hw *hw,
 	case WIRELESS_MODE_N_24G:
 	case WIRELESS_MODE_N_5G:
 		b_nmode = 1;
-		if (mimo_ps == IEEE80211_SMPS_STATIC) {
-			ratr_value &= 0x0007F005;
-		} else {
-			u32 ratr_mask;
+		u32 ratr_mask;
 
-			if (get_rf_type(rtlphy) == RF_1T2R ||
-			    get_rf_type(rtlphy) == RF_1T1R)
-				ratr_mask = 0x000ff005;
-			else
-				ratr_mask = 0x0f0ff005;
+		if (get_rf_type(rtlphy) == RF_1T2R ||
+		    get_rf_type(rtlphy) == RF_1T1R)
+			ratr_mask = 0x000ff005;
+		else
+			ratr_mask = 0x0f0ff005;
 
-			ratr_value &= ratr_mask;
-		}
+		ratr_value &= ratr_mask;
 		break;
 	default:
 		if (rtlphy->rf_type == RF_1T2R)
-- 
2.43.0


