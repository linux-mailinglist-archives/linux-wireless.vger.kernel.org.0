Return-Path: <linux-wireless+bounces-24597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B11AEAD91
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 05:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D7D562BF6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 03:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C1B199FD0;
	Fri, 27 Jun 2025 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QRHARiK7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DAE19DFB4
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 03:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750996369; cv=none; b=kD2oBy9GSsLVnG7SAeeDX3c07cYQAiC31dlhMoIsh7iynthB7drnb+Emef6Ki8G+RDiIJ8BwTDfHgGt2mVaHgu4iKSURF1xV/KBBBOFCmhngTTrJTky72UFS+tVU6SaX885x1A7EEtuYpRtyB4PiE8V0bBDb18EfGf/5e5BhRJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750996369; c=relaxed/simple;
	bh=MtiHSlO0+E1X5Dr7WfmAPO8X5VSeIlnQkAbd0KYUB2w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8/vhXg64krJZ8uf+b2CTLfcHQ3TI/tkWPJG6lBEk+ob9tg8iorDuqCJqYCf/2qt6S9qd4Kbs7dONQyeMHZgXrhb7B6okg30CMu49YglEcKelaGZZXGEySHehHDs97KAOdY0BGtyPDTLJRhIeF8nvY9oID8vLx8GnsLIsK3QIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QRHARiK7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55R3qimM72041746, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750996364; bh=Wh2NHE/pv9fR4VgGwIyz1I4WJ4wZl2EIyIAkvbNyeeo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QRHARiK7lVnkTW/A/S8Eifo5e7AacJAVF5mfUat4qjiuQgPAqv6MgxcSSJVz3Zn6X
	 q386Luo1imalxfM1zPJgb92sHKMiF05Ueja2Ghr7ENDOFZ8HFd89QVPitC8oP9Ab4N
	 +taXr+eH9FeUpHua1To24wfQCs0AC/mFQSCIk96wugymbPliGvQBcaZpysgARimI1a
	 sFWEmX2Uhrjc8Ct4q6E4GX6ChOcDp2RLPnzRtRtsQ3e4ZOPeLTflAqj72QFlBWaT+5
	 keKWgYkA0gPLEXvltn5fjyQSpIK+3Du+q0CZMqAgv2gPoq6UYV30LwPU0HUtjtZZsm
	 JlB4prf2zTtdw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55R3qimM72041746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 11:52:44 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Jun 2025 11:53:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 27 Jun
 2025 11:53:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 1/6] wifi: rtw89: 8851b: rfk: extend DPK path_ok type to u8
Date: Fri, 27 Jun 2025 11:51:56 +0800
Message-ID: <20250627035201.16416-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250627035201.16416-1-pkshih@realtek.com>
References: <20250627035201.16416-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Originally the type of path_ok is bool to denote that DPK is ready on
certain path and can be enabled. For RTL8851B, hardware design can support
more than one calibration set, so use type u8 instead to record the
hardware set in current use.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cdacf100a59a..06ceb77a1cc6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5146,7 +5146,7 @@ struct rtw89_dpk_bkup_para {
 	enum rtw89_band band;
 	enum rtw89_bandwidth bw;
 	u8 ch;
-	bool path_ok;
+	u8 path_ok;
 	u8 mdpd_en;
 	u8 txagc_dpk;
 	u8 ther_dpk;
-- 
2.25.1


