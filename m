Return-Path: <linux-wireless+bounces-34462-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAipAQ/71GmgzQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34462-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 14:39:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37E3AE85E
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 14:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A6530D2DA2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 12:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039DD332EBA;
	Tue,  7 Apr 2026 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2TX/Tod"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961413B3BE2
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565290; cv=none; b=L/5ZaYRUL+XzfcwrB09isxjQC3fIftz3enqE6nfmeiAw90hS7EiNOz5BFRsf19Jlmgsbp+isRmg2M18uMDtmVXIqiqfjiL7Ws1JTa5fLgpbwYVswDvSqkJt+93dj4cQfONXsEKoEeHF3AjjvGBGJ79AIBK/oHR78/6sJ4Nonz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565290; c=relaxed/simple;
	bh=7qhg8bsP4LBNOPqfZ7GWc3e3vDkpgqOHZECzNneb4dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvxgF/X63b169dIsd/hgb7UcqEzj4KmNBMj2BwgX8rxGpVktugkRNL/BMfBkFYzLFmWcmhYnWeRBb1pGOpTseMJsPYiODgGVZh7cvzHbYhj1SZ1rDZzhKcMHLNGPKr1VM0Lf1fpbU5nxQSfc6LNjLcBZWojcuVThrkbkqGWBrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2TX/Tod; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbcd61429cso1252305a34.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775565288; x=1776170088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQ3pOZy9QEydsoYxqlkUVkyV7UI+oJBeoLBJctji3n8=;
        b=R2TX/TodobVp6apm47aSQnr0fNx9pyr94s2Xj6J2N9jkRKNwMAM7fSYyXavM7kIxYd
         Ju1bzZljOnrfJMfKiO+4RFWR8NL7kpp8U+/boTVuasOVa8e+Hq/nhU7TZrrgzaC+Ik1l
         avm0BZBeFMVMfqbwq/UTSmiHt6+BZNjV/jFdes8sq2gi5X/+93WA+oATJUWKa28gMmyT
         JXCLi+xTB+rpW7fKAm6/M8G3lB9imlOxXIgO/r5qf5TTadEl8bRDFr5Ll4q8Si6zSqnx
         ELTt7aA/Vu2qZ8ao8pM1RYtos83kdaG3/AqGZrZeboGm29/glfoyeyFweummRdWpUd0H
         oISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565288; x=1776170088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ3pOZy9QEydsoYxqlkUVkyV7UI+oJBeoLBJctji3n8=;
        b=qQm2Ez9qCZLwrSAVqOyUPPeZOizQfCGhp2tUzTUKN3lnv8LLazDVMhQAHVdgky4Knu
         /1G07/tA5cbfw1urgfIXiA2xkCdQM/OfVce8Y0txfzgyRh8T18Tfgtqe6NrrHefZUIHm
         yPAavKkIuAJDSPUd8Tx5d1EJ9WSPrhq1JObP3HBSH6LtlFg/z6c+5bTUi7iLtu27QXql
         JjTFi+5zyYSfrW89nZGjVo/WfKQLunwpXfR3CMb2NJa2LSoFbkIo9rppj1frpfChP1Pe
         r9Xf8bJkraasRad3Bo0LXcDUEUXKHBQAVgYweqTgnZTeklMsCEzbfLrmBoRYlCcy5ddY
         Z0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVF7VCzJ61GfORPEhHfmRCcFyOJgo5Vr2pVg+CLKgemZj8ZAAL0lQd8tWZM4Or51Dnt2UythS+kicbY8JKXaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjSntw6ZFne0/I7J0r/UNsA84KBpa6qpdHs6voCAz8dB2HyUz
	UW1xdj9GzdlFbwAYRpN4wdTth36wavlW2DEi9fR0tjnys9L4hO3g5s5HpIyM4g==
X-Gm-Gg: AeBDieuE8XFRPFfwgAjziMZz0HeZ5bPxNy9uwWGigdbjXdYBm/I1fGUiIFXPx+/4LLq
	WITbYAARIKpCbhhcSRAteOnzPEt/gBMw145VhnrSHR4pXxSg5V0a1K7vj4d8Exx9YSsBIPyCA0E
	cDqOBybkBhSniOQ0llR2+rZPsHwoqFvLDNLCVVYz/P5/ordMnY7ePloFiHPVD6qRKPAPDz/GX+c
	QE+w3ItE4mKcvpmlBR25wG5Qj43XiOvnU0OPSN2SKS0Fw5fb2m2Qprm4v5CEWqvXKKZ1IBHrU6p
	BrW5FXSCPD1zDcweDtCcuLC4nX4VGiWLTz+N/OgUXIo2jT2knhRamDLbs4WALfZ05IpBNBhGrDq
	3CqtIHu889oj6VGnc/DVS/GulWWfWPIQe88dLkbFR8r8FC8i10Fh5amhxAVLcV4sazzNM5qERav
	5bfuXUXTkIqHpmDOxlaeNP6lndBRVBMc9s/IcSBm6hKG5FdeULcMyzfIvwxH9H6hI=
X-Received: by 2002:a05:6830:2e14:b0:7db:b7ae:ef0e with SMTP id 46e09a7af769-7dbb7aef5e3mr6276348a34.30.1775565287938;
        Tue, 07 Apr 2026 05:34:47 -0700 (PDT)
Received: from Linux-Ub241.fyre.ibm.com ([170.225.223.17])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbb40b1507sm10587614a34.21.2026.04.07.05.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:34:47 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: pkshih@realtek.com
Cc: colin.i.king@gmail.com,
	johannes.berg@intel.com,
	bhelgaas@google.com,
	arnd@arndb.de,
	linux-wireless@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v2] rtlwifi: rtl8821ae: Remove dead code in rtl8821ae_update_hal_rate_table()
Date: Tue,  7 Apr 2026 05:34:27 -0700
Message-ID: <20260407123427.14612-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,google.com,arndb.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34462-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chelsyratnawat2001@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A37E3AE85E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The variable 'mimo_ps' is initialized to IEEE80211_SMPS_OFF and never
modified throughout the function. This makes the condition checking for
IEEE80211_SMPS_STATIC always evaluate to false, rendering the entire
if-branch unreachable dead code.

The error was reported by Coverity Scan.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
Changes in v2:
  - Declared local variable u32 ratr_mask at top of function.

 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 3a4a33476205..c4dcae2d375e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -3257,9 +3257,9 @@ static void rtl8821ae_update_hal_rate_table(struct ieee80211_hw *hw,
 	u32 ratr_value;
 	u8 ratr_index = 0;
 	u8 b_nmode = mac->ht_enable;
-	u8 mimo_ps = IEEE80211_SMPS_OFF;
 	u16 shortgi_rate;
 	u32 tmp_ratr_value;
+	u32 ratr_mask;
 	u8 curtxbw_40mhz = mac->bw_40;
 	u8 b_curshortgi_40mhz = (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SGI_40) ?
 				1 : 0;
@@ -3288,19 +3288,14 @@ static void rtl8821ae_update_hal_rate_table(struct ieee80211_hw *hw,
 	case WIRELESS_MODE_N_24G:
 	case WIRELESS_MODE_N_5G:
 		b_nmode = 1;
-		if (mimo_ps == IEEE80211_SMPS_STATIC) {
-			ratr_value &= 0x0007F005;
-		} else {
-			u32 ratr_mask;
 
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


