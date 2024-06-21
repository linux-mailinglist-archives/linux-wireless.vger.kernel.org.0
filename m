Return-Path: <linux-wireless+bounces-9432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083D6912593
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 14:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B485A287F4F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918F8152790;
	Fri, 21 Jun 2024 12:36:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B3153BED
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973400; cv=none; b=N7LpLanJavI4Cnk+cNlvDNT3N4fU8z18iEl7e8qagBLV/9eqlAFHBtFVNkC1HMZLtCKnj0V/6vCaaGvGVtN0Cps1hwMzUD+JWuQcGAGjDeAxWtFOq9oU0xfKHQ8q3IPMtyfotbJJvT3SgMPiiRl5olXoY/lhe0eBbqCKuSCoW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973400; c=relaxed/simple;
	bh=EZ8FXZxpNDMr2Tk40mAXTq+G1i9u5AOGPyiV2TPy1Ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pX8SthtqmUquP7CY74P8g+ey6yYIwjQKNPXTZXOS/cPIUq3RvHUJkrDsciBQX37fWCFk1O8gbXG3ZFuFMHAzxpnlPCBv0RbMxNkwbsUZB+e5sbAwJweSC21Z1+7RM4mQIBm9n4KHdfZhgpL/84C6vz8+LQfz/J/S1FlcAKEqPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45LCaYVD14090562, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45LCaYVD14090562
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 20:36:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 20:36:35 +0800
Received: from [127.0.1.1] (172.16.22.19) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 20:36:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH 2/2] wifi: rtw89: 8852b: fix definition of KIP register number
Date: Fri, 21 Jun 2024 20:36:17 +0800
Message-ID: <20240621123617.6687-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621123617.6687-1-pkshih@realtek.com>
References: <20240621123617.6687-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

An incorrect definition caused DPK to fail to backup and
restore a set of KIP registers. Fixing this will improve
RX throughput from 902 to 997 Mbps.

Fixes: 5b8471ace5b1 ("wifi: rtw89: 8852b: rfk: add DPK")
Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 7c90e98dc1d9..12354612441c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -21,7 +21,7 @@
 #define RTW8852B_RF_REL_VERSION 34
 #define RTW8852B_DPK_VER 0x0d
 #define RTW8852B_DPK_RF_PATH 2
-#define RTW8852B_DPK_KIP_REG_NUM 2
+#define RTW8852B_DPK_KIP_REG_NUM 3
 
 #define _TSSI_DE_MASK GENMASK(21, 12)
 #define ADDC_T_AVG 100
-- 
2.25.1


