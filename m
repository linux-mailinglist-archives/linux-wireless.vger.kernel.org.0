Return-Path: <linux-wireless+bounces-5072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35185881B5C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 03:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFCA1F2145F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 02:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED424C8C;
	Thu, 21 Mar 2024 02:57:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974D2900
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989842; cv=none; b=g4kVWpmR5+WPMHg/E3M8YixyLB0bi1iS/2YXM/qVU0BlE2c5VtHyq2/gwP6CwontPMCHLuY3txj1G+uOJ0KFZOJZW6Dd2qA29xf0Izj1caHzNDUNZo/4nCFXoSjFuu3XeFaFiVxizGvevLL9PRF4CUj2YF/+NIv+q5SC+jmh2Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989842; c=relaxed/simple;
	bh=uYUgyqEbfHpt+ef2+jkfR/taqVuyQ4p3mk2bwGyxr9A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MhhxpbUowqZ/pe1HDWUC/W2rng34h8y7hURXA1m/OX7kHMgI7dgM9QVc8PchmUXImMtgWn2vas6pJjkRxPsT3y8k1JJWH3Xny98UgEjvAHnBmdVW38Zev5tSYlIjck4A/fLcpBW12hqDODHWgeyufMsTun3WPLBD9G10Fxe1Bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42L2vDXi9844364, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42L2vDXi9844364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 10:57:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 10:57:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 21 Mar
 2024 10:57:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <leo.li@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: disable txptctrl IMR to avoid flase alarm
Date: Thu, 21 Mar 2024 10:56:03 +0800
Message-ID: <20240321025603.20614-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chia-Yuan Li <leo.li@realtek.com>

The hardware command parser of txptctrl (TX protocol control) has overly
stringent timeout conditions, which results in false alarm. So disable it.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 72e448e91b6f..ccf74d9f9224 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1891,7 +1891,6 @@
 				     B_AX_B0_IMR_ERR_USRCTL_NOINIT | \
 				     B_AX_B0_IMR_ERR_CMDPSR_1STCMDERR | \
 				     B_AX_B0_IMR_ERR_CMDPSR_CMDTYPE | \
-				     B_AX_B0_IMR_ERR_CMDPSR_FRZTO | \
 				     B_AX_B0_IMR_ERR_CMDPSR_TBLSZ | \
 				     B_AX_B0_IMR_ERR_MPDUINFO_RECFG | \
 				     B_AX_B0_IMR_ERR_MPDUIF_DATAERR | \
-- 
2.25.1


