Return-Path: <linux-wireless+bounces-22832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EF2AB2664
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 05:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71A01899D37
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 03:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1A17A309;
	Sun, 11 May 2025 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uDF17SL6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C413BC0C
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746935568; cv=none; b=gXyPrFUlIMz/+LlekakmPQQGzd8opjhDasgHWaxhwDPGDv550frHfw4Bz23+1hxpxqCtQBd9P/wyK0puYw3qgeoFfbU9J75m2czbjQ9Maq4zhpH0SMXnyq2LblXYlLmEMoaLd4VZM1fONW3aJWgVBzaIrHuZ9w1UiZzzvS3v09A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746935568; c=relaxed/simple;
	bh=iQwDKQ1iYaOWMv8kEsriAMUFKSo+hVmeuAJRIf5y++U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkJi1axi+z2yrX3IPGMje016BpGEJgHugNHLHBOExQyVq5gh2sT7T9kSTMvLQngXB49VE7yPY5hbqiO/ugTxTnCSwpTzwxYqWfXVLiUx3XqR5AYAEljFqXJ/bkpXVsSWM7+ZyijT+58BApAzQCAMlN249rm6pNj30fOs4LOG7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uDF17SL6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 54B3qgKbB3302896, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746935562; bh=iQwDKQ1iYaOWMv8kEsriAMUFKSo+hVmeuAJRIf5y++U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uDF17SL6n30nYRi4sX8edtvl7X6+EkHHD3tAjvnWLCU3uKHQf1T/M6et+l8LSq2/b
	 SBl86WigAR4PjN9wAakt3J0r05UDdgq+ralg1mnLNRhzh/U/43bfExCeOypBQ+w8Il
	 cxV50yK7C+u6Cb3leHlbA+/gpnE4jTS6XfyXai/DmEsNEB0DR56L0wnHJ0oDC29Qh1
	 vYNMcuqdo9RGS6OLJSeXvUHQ463o0uvPclDunXxdqf9xILuEqscJJM7sZnZwy0FhwU
	 J/Y4MHRrWQR0yS4uFDU0TYCkdSkBv8YePe/o5WGaJuLPuc4AW78u7dhXwsMCHCjN7V
	 jWmOqrzHoqLTQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 54B3qgKbB3302896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 11:52:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 May 2025 11:52:43 +0800
Received: from [127.0.1.1] (10.22.224.86) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 11 May
 2025 11:52:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 3/6] wifi: rtw89: mcc: add courtesy mechanism conditions to P2P roles
Date: Sun, 11 May 2025 11:52:14 +0800
Message-ID: <20250511035217.10410-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250511035217.10410-1-pkshih@realtek.com>
References: <20250511035217.10410-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In one enablement of courtesy mechanism, there is one provider and
one receiver. And, receiver can use the provider's time in a given
period. But, to make P2P NoA protocol work as expected as possible,
GO should be present at the time it doesn't announce absent, and GC
should not use the time when GO announces absent. So, don't enable
courtesy mechanism if provider is GO or receiver is GC.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index e733564abc7a..e09541ceb504 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -961,6 +961,15 @@ static int rtw89_mcc_fill_all_roles(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static bool rtw89_mcc_can_courtesy(const struct rtw89_mcc_role *provider,
+				   const struct rtw89_mcc_role *receiver)
+{
+	if (provider->is_go || receiver->is_gc)
+		return false;
+
+	return true;
+}
+
 static void rtw89_mcc_assign_pattern(struct rtw89_dev *rtwdev,
 				     const struct rtw89_mcc_pattern *new)
 {
@@ -980,7 +989,7 @@ static void rtw89_mcc_assign_pattern(struct rtw89_dev *rtwdev,
 	*pattern = *new;
 	memset(&pattern->courtesy, 0, sizeof(pattern->courtesy));
 
-	if (RTW89_MCC_REQ_COURTESY(pattern, aux)) {
+	if (RTW89_MCC_REQ_COURTESY(pattern, aux) && rtw89_mcc_can_courtesy(ref, aux)) {
 		crtz = &pattern->courtesy.ref;
 		ref->crtz = crtz;
 
@@ -994,7 +1003,7 @@ static void rtw89_mcc_assign_pattern(struct rtw89_dev *rtwdev,
 		ref->crtz = NULL;
 	}
 
-	if (RTW89_MCC_REQ_COURTESY(pattern, ref)) {
+	if (RTW89_MCC_REQ_COURTESY(pattern, ref) && rtw89_mcc_can_courtesy(aux, ref)) {
 		crtz = &pattern->courtesy.aux;
 		aux->crtz = crtz;
 
-- 
2.25.1


