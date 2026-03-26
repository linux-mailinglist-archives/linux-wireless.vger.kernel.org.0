Return-Path: <linux-wireless+bounces-33996-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFyGGv5oxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33996-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:12:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF6E338F52
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA7F13010539
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EEA27FD75;
	Thu, 26 Mar 2026 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEpWER0+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA16325485
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544817; cv=none; b=FfDJ8OFfkTTuBX5i0bzXhYmScTzT4kowAqvvkgFMmIr6wCJqi04XwCTh8urp7Y02JwLGCaDBttU6R3qrcLlY+3dfuhVvCnKNPUBgYNlMMrzVxkZgn4Jf9qyUh9n9NmvBYJK/ovnWjOe/t5PsdT6k+KqB4P1ZSZBREazBPFD2FAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544817; c=relaxed/simple;
	bh=UWywtbx8j0yGtN+UmjEtAmdrtUyBJWNfMATCxk3YwLo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NPey6zsWXH3GHYZm/GF3UvCwqjh0RmFA/+TmX8rblThDoWA6nh/6iSdMcW0YsyeZdKGyM34XUBlznvDQr9V9f4hVBRiwHNrABLXFCWz3FgJ32nWIKxxPABJQm1Y0r/ZYTExBGDD9GleU4lhKBlSSwJcVkV4IrMscxl4JZk2AbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEpWER0+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439c56e822eso1277445f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544814; x=1775149614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IKantzW3+6sVTzbSG+WYQRrVMazsOsa7W8dL2aaUkLs=;
        b=eEpWER0+0cRx70+QB8uhCAGa3I3EDdFL34WnzJPUssHg2JEJGo3aJwFuttWWGgP4VA
         UOvmBkfPx9myZRhSeQU6O7PaCDDJyvXWUTl/VSnN3VwL4R3USUhlGwlXk8oAwKxDKuBa
         PVakqQaFe/bRdcx1Orm5JpZxMoQBEjabQ63XSN+db3M/8OgVIHnVklEyY+g/4RbqFu1c
         Nsaz0G4sfHT9p0ufRnixZjKZXibQbSS+OVJWLCVcvXkYF0W4QnLtMMenGlpmZrPP6Stb
         +KjXNjuh3BEZh/ARmXZ2x3CKMSicDeTmFjRhQhAVOxnkifWz3HZ3Gr1RZHHvHPx2OhWK
         w62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544814; x=1775149614;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKantzW3+6sVTzbSG+WYQRrVMazsOsa7W8dL2aaUkLs=;
        b=pne5j27qdBz9TwGknPvVGe8iMqFQY4Q0YzZiF+TDEafxiGwgH5Nhi/QeZa8E+/kd4Z
         uXnba3M163VqnU+yB3j7mu8SrLJv8m8Poc+txF5t8dLNnyUbmPrQ/ruUS1AFnrD5ciR4
         fvJCH4GGr+aed//7MXNODGY6gEosC2yx0GyW5kmdk7tIsm/f6osn9AZN5CNCzxkLvQYF
         iQutFRZe4vyzQk4UL+0PkUkNPVorKIONsXb2y5qyb3xcefWqA0t6nnueDPw9B1iTlDW5
         T/X1PfG29ARWOcw1DUe6SxvZu5nHXhT+ci0pJzrWUZtxPCbrg0MOgdgsz94iiYzjeVn+
         8W9A==
X-Gm-Message-State: AOJu0YzWnU8uvneR1qGlMdJhgHClrYvk/tabkRExHYktGqAcYOHkGMON
	0NM40asD5RZl3GAw6w9VqlvDona7mQpjqfdhWP3SnF/9Jvi9+39LW/4aCxY+PQ==
X-Gm-Gg: ATEYQzyTITqnndmGrRLryI0YHgVop4IMBmoLJ+fqbKRF0IeQhLoLLksG/EphGbNSNCA
	EXVFK5R8QxSaaYknH2Qs38oenkqAPhqJlXuriloekUxPVJcOAROYHhYYP38Qfy5RdOUG8MJ92hm
	PlBpPCmXcyMvFNWVLaQ69rKFAuVs3CloSRIcf0X9CfrI1QDFUMMr82l/cBqNmxj//WtsLrgh2IB
	1Lqx3KNxsAEA1iUyQEHp+7PyKKuOiPNMC2YDu3uBTQFaiyGetf+guC11AgCxvJ27MagkDlCXCvb
	fQmWu6oWYGNR0RPI2JKM8uFSgLDkpd/Gh9PT4kNKMM76xhZ23p0mkHtV7eAHwq6J8TJYg8QDo2C
	P/E89auSxoNhi9kHPjaPwyD48P7FgSQ7qZzH7BVDYdNeVIwb9Joujqzq6eCGQYaisvq+OUYpS95
	apuDGQt9HEbF1TbAYlf+KltzMnGO6MfQ==
X-Received: by 2002:a05:600c:8b18:b0:485:3b9e:caa7 with SMTP id 5b1f17b1804b1-4871606d79cmr121041135e9.23.1774544814293;
        Thu, 26 Mar 2026 10:06:54 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d236a9sm91567485e9.11.2026.03.26.10.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:06:53 -0700 (PDT)
Message-ID: <d8a90345-ba4d-49a5-a967-af07e7390aab@gmail.com>
Date: Thu, 26 Mar 2026 19:06:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 07/12] wifi: rtw89: Fix rtw8922a_pwr_{on,off}_func()
 for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
Content-Language: en-US
In-Reply-To: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33996-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDF6E338F52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are a few differences in the power on/off functions between PCIE
and USB.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 92 +++++++++++++------
 1 file changed, 63 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index a489aaf90f23..c745e5a58d12 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -298,17 +298,24 @@ static int rtw8922a_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write32_clr(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_R_SYM_ISO_ADDA_P02PP |
 						       B_BE_R_SYM_ISO_ADDA_P12PP);
 	rtw89_write8_set(rtwdev, R_BE_PLATFORM_ENABLE, B_BE_PLATFORM_EN);
-	rtw89_write32_set(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
 
-	ret = read_poll_timeout(rtw89_read32, val32, val32 & B_BE_HAXIDMA_IO_ST,
-				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
-	if (ret)
-		return ret;
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
+		rtw89_write32_set(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
 
-	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_HAXIDMA_BACKUP_RESTORE_ST),
-				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
-	if (ret)
-		return ret;
+		ret = read_poll_timeout(rtw89_read32, val32,
+					val32 & B_BE_HAXIDMA_IO_ST,
+					1000, 3000000, false, rtwdev,
+					R_BE_HCI_OPT_CTRL);
+		if (ret)
+			return ret;
+
+		ret = read_poll_timeout(rtw89_read32, val32,
+					!(val32 & B_BE_HAXIDMA_BACKUP_RESTORE_ST),
+					1000, 3000000, false, rtwdev,
+					R_BE_HCI_OPT_CTRL);
+		if (ret)
+			return ret;
+	}
 
 	rtw89_write32_set(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
 
@@ -317,7 +324,9 @@ static int rtw8922a_pwr_on_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	rtw89_write32_clr(rtwdev, R_BE_SYS_SDIO_CTRL, B_BE_PCIE_FORCE_IBX_EN);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32_clr(rtwdev, R_BE_SYS_SDIO_CTRL,
+				  B_BE_PCIE_FORCE_IBX_EN);
 
 	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_PLL, 0x02, 0x02);
 	if (ret)
@@ -371,6 +380,10 @@ static int rtw8922a_pwr_on_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_SRAM_CTRL, 0, XTAL_SI_SRAM_DIS);
+	if (ret)
+		return ret;
+
 	if (hal->cv != CHIP_CAV) {
 		rtw89_write32_set(rtwdev, R_BE_PMC_DBG_CTRL2, B_BE_SYSON_DIS_PMCR_BE_WRMSK);
 		rtw89_write32_set(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_ISO_EB2CORE);
@@ -382,14 +395,16 @@ static int rtw8922a_pwr_on_func(struct rtw89_dev *rtwdev)
 		rtw89_write32_clr(rtwdev, R_BE_PMC_DBG_CTRL2, B_BE_SYSON_DIS_PMCR_BE_WRMSK);
 	}
 
-	rtw89_write32_set(rtwdev, R_BE_DMAC_FUNC_EN,
-			  B_BE_MAC_FUNC_EN | B_BE_DMAC_FUNC_EN | B_BE_MPDU_PROC_EN |
-			  B_BE_WD_RLS_EN | B_BE_DLE_WDE_EN | B_BE_TXPKT_CTRL_EN |
-			  B_BE_STA_SCH_EN | B_BE_DLE_PLE_EN | B_BE_PKT_BUF_EN |
-			  B_BE_DMAC_TBL_EN | B_BE_PKT_IN_EN | B_BE_DLE_CPUIO_EN |
-			  B_BE_DISPATCHER_EN | B_BE_BBRPT_EN | B_BE_MAC_SEC_EN |
-			  B_BE_H_AXIDMA_EN | B_BE_DMAC_MLO_EN | B_BE_PLRLS_EN |
-			  B_BE_P_AXIDMA_EN | B_BE_DLE_DATACPUIO_EN | B_BE_LTR_CTL_EN);
+	val32 = B_BE_MAC_FUNC_EN | B_BE_DMAC_FUNC_EN | B_BE_MPDU_PROC_EN |
+		B_BE_WD_RLS_EN | B_BE_DLE_WDE_EN | B_BE_TXPKT_CTRL_EN |
+		B_BE_STA_SCH_EN | B_BE_DLE_PLE_EN | B_BE_PKT_BUF_EN |
+		B_BE_DMAC_TBL_EN | B_BE_PKT_IN_EN | B_BE_DLE_CPUIO_EN |
+		B_BE_DISPATCHER_EN | B_BE_BBRPT_EN | B_BE_MAC_SEC_EN |
+		B_BE_H_AXIDMA_EN | B_BE_DMAC_MLO_EN | B_BE_PLRLS_EN |
+		B_BE_P_AXIDMA_EN | B_BE_DLE_DATACPUIO_EN;
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		val32 |= B_BE_LTR_CTL_EN;
+	rtw89_write32_set(rtwdev, R_BE_DMAC_FUNC_EN, val32);
 
 	set_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
 
@@ -465,17 +480,23 @@ static int rtw8922a_pwr_off_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
+		rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HAXIDMA_IO_EN);
 
-	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_HAXIDMA_IO_ST),
-				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
-	if (ret)
-		return ret;
+		ret = read_poll_timeout(rtw89_read32, val32,
+					!(val32 & B_BE_HAXIDMA_IO_ST),
+					1000, 3000000, false, rtwdev,
+					R_BE_HCI_OPT_CTRL);
+		if (ret)
+			return ret;
 
-	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_HAXIDMA_BACKUP_RESTORE_ST),
-				1000, 3000000, false, rtwdev, R_BE_HCI_OPT_CTRL);
-	if (ret)
-		return ret;
+		ret = read_poll_timeout(rtw89_read32, val32,
+					!(val32 & B_BE_HAXIDMA_BACKUP_RESTORE_ST),
+					1000, 3000000, false, rtwdev,
+					R_BE_HCI_OPT_CTRL);
+		if (ret)
+			return ret;
+	}
 
 	rtw89_write32_clr(rtwdev, R_BE_HCI_OPT_CTRL, B_BE_HCI_WLAN_IO_EN);
 
@@ -491,9 +512,22 @@ static int rtw8922a_pwr_off_func(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	rtw89_write32(rtwdev, R_BE_WLLPS_CTRL, 0x0000A1B2);
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE)
+		rtw89_write32(rtwdev, R_BE_WLLPS_CTRL, 0x0000A1B2);
+	else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_SOP_EASWR);
+
 	rtw89_write32_clr(rtwdev, R_BE_SYS_PW_CTRL, B_BE_XTAL_OFF_A_DIE);
-	rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
+
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
+		rtw89_write32_set(rtwdev, R_BE_SYS_PW_CTRL, B_BE_APFM_SWLPS);
+	} else if (rtwdev->hci.type == RTW89_HCI_TYPE_USB) {
+		val32 = rtw89_read32(rtwdev, R_BE_SYS_PW_CTRL);
+		val32 |= B_BE_AFSM_WLSUS_EN;
+		val32 &= ~B_BE_AFSM_PCIE_SUS_EN;
+		rtw89_write32(rtwdev, R_BE_SYS_PW_CTRL, val32);
+	}
+
 	rtw89_write32(rtwdev, R_BE_UDM1, 0);
 
 	return 0;
-- 
2.53.0


