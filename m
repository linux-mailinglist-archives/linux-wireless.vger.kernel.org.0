Return-Path: <linux-wireless+bounces-34982-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHcZBV7c5GnCbAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34982-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:45:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 644BC424380
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 15:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E11E300BC8F
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89C43659EE;
	Sun, 19 Apr 2026 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+z45o5O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2665E350D58
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606298; cv=none; b=FsK9idEUgZQEoKQ9bq2RQL/GG3WBLshN7if2kGi8YgylPFzKY44Njqf7tPurEl2Zdw6c3cA+icyRN/8PjR09/99qzCkx2KIGBgaEcO6nJhOUx3iI+WW1bVzAjrXdOsBuvvDpkySHgSamoSKOo1cob2WdKQnM80BlLpLNZdTdn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606298; c=relaxed/simple;
	bh=p1GT+NFn1cqgTqadwFjn+q1gT0q+SLm55t2pc3CRUEc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZMWV8SbTfR3BM2NaVK6Ja3Kemh8MFd1NeZejCOJ1a/YHJaDYlIWT02uzW3sC2bJyi3uryjYTS0FiXEGTLlJw3M0x4Ux1A3hBUEVvqbXV7Enszv6LZa9CRVP5Xe6/oI3IgyH4QvYBosUNRdujB8zYnlGWiVlvy2OVQ4+hdgTp0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+z45o5O; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so1220412f8f.3
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776606295; x=1777211095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=29toaUdoy7B1B/jLdTzW6mYxoMxnIlb134p85JUIwDo=;
        b=Z+z45o5OJ2DUaA8NY1QCzU1F0I2xav2lyDfIUCQGVoENPEZJ2r5e6XSoMiiNRGKLEz
         UtTpsAhpPxKDtKA8j42CCoPtmdweDYTYKW46flhgAT82U3gxTBHD6vAco5ffgJXx6Zdo
         c0zF3vW+u7wwlI3/6ANZ9wgD4OIjSpm9GbB6nUo3vhxroahoK0YRuKXTom1BpwZ/Myzy
         6qM/dv8x0s/Fuyh5iipn8F+o43MXX6l+HvTXE2GFCspVEMqwrbdcRqufwFNtXcW0Ysca
         B3I+1W4ZY79IaX1GUIyDtwFP82rKRxQxvxwq1ngXTy6apRvTdvQLvdJCYV1sfIBOyEIb
         7yiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776606295; x=1777211095;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29toaUdoy7B1B/jLdTzW6mYxoMxnIlb134p85JUIwDo=;
        b=DHk5H5KhxpyMbc3z1F63eYUjOJzkcqco3goFZFw29oXAUFZYnZOiVRkHOGxFMFj6Jb
         CSNhqNvP3Lzt0c7KfbeQzHU/IalPeeLxG2Vr3ieZEvFL+ILfDuBwgubHc2tNY+++jr9h
         SQMkYwg5ZYX3/X1p/P/0jhvusBVvBqF+r8hUtbusCyNMuab6fTmP0jCQ1e2OaJdZFZD0
         4pTkKXltto9Sbsm7ODiskqgryZ5w83koTdSaZ+rIVxIFlljS+P0w4WnIF3FoGfnLYpEv
         R/JncTNNMth0v23bzNBxNxLi4aLhvjyFZIj1V9tcNX4c8TkMF5lvJsp5TqblUvu+N0vf
         Mj2w==
X-Gm-Message-State: AOJu0Yyv5VdCYE8CbyKeIP7yxoVwRMyf5o7TTX1H2tVx9uKEyDOSpKnx
	5F9//9gN/l+QbVh3mOSEEcAtbaQpCG/eJOr4wBqP6zRdI3RyOlPO9r90wP4R5w==
X-Gm-Gg: AeBDieuHjh8rfkgqDRH0VM+zWa5ZXEzJvD80ici1xYLxu6Qc8oE44NwX3L9/YHTVAVV
	oyMZVflCSPheA78pUuV0YXvrrNmbIlrdmnQXtadPIjj5SLQJFeeTIEYX305ZCAOWEeXwlOcTOhp
	R/cKdke7HUGHfIJ8bn5/HuNkjee3m0ulVheqC9X2bCg5S9TnQQIj3Vp13TvNluIgcBaovnOs/Nh
	6tc3NIH4vRsT5i087fiqQMhvY48z3gicfggp5Pr7Z4rREDn7mR2G7HcH/p5oRwYDFfYGWIVexuH
	nGxAMdjD6P9rfs01yBhdyVVKOpEv0kXNuEBhAnBENxOqg3XBQXoAOCxKOur6a17SZ0b2uEY6/io
	XM5MO6gJ1r05MtL9zkm0dIzOFp58G7hUSMr+fR0nW1xSPuPOflpSUhdAlLFNfWswu5cIeHswYVY
	lhVyYhPKaoKMfoLQH3RGyxdMRJZLy7PkTOf6KcfI9e
X-Received: by 2002:a05:6000:2212:b0:43d:7dc2:b655 with SMTP id ffacd0b85a97d-43fe3dcc108mr14495736f8f.15.1776606295338;
        Sun, 19 Apr 2026 06:44:55 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc24cfsm21336816f8f.16.2026.04.19.06.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 06:44:55 -0700 (PDT)
Message-ID: <dccdb944-c31d-483f-8d1a-a51bcfe23916@gmail.com>
Date: Sun, 19 Apr 2026 16:44:54 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 06/11] wifi: rtw89: Fix
 rtw8922a_pwr_{on,off}_func() for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Language: en-US
In-Reply-To: <6ba2910d-020c-41bd-86fa-d1b0e0f7a2f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34982-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 644BC424380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are a few differences in the power on/off functions between PCIE
and USB.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 92 +++++++++++++------
 1 file changed, 63 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 8f6cf64271e8..2bea44faa109 100644
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


