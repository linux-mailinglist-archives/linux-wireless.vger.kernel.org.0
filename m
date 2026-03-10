Return-Path: <linux-wireless+bounces-32818-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGe1HvnQr2kfcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32818-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:06:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 001E8246EE2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67AB530EBF40
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA33ECBE0;
	Tue, 10 Mar 2026 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Uazjb7Eg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436B28640C
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129770; cv=none; b=sm4LU+Ra8LwFJXFCUlndQWotY4Ru/3LMtff8m2007qabjGDG3msxz8hxrNlUipzeLAgCsX41d6MmaMe/Qca7JQWkqo9h76+PideTK3deYljVRzju3NMmZVgMTHBP8V+RjHrPojhlEmjwyNTm4i5K35WmDfcWVCN9Rzlpsn5GUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129770; c=relaxed/simple;
	bh=btjsrDnRblUsmgJX3H4xfEOsuzTrEhAQjAuKBa59XOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCv9b2ahR/9b9NnG8IA1GoZx4FmOVefqvc1lWxpDq2zewEk2Crdp6g62iAsbx4nida9D4pDXnOQUammums9vmIfm+bU1ZvwzR52nvksCTlXkUNO9O0birwa4QH309ZPtxxsQDzDq6u6AoQJwGk/9xKbUH5AZS+2GBr9p9VAkjzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Uazjb7Eg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A82m2V22211364, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129768; bh=IwZDvq6nO0xAYmj96bHLoOyscc0dW5oprvVdZAKhoBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Uazjb7EgQPTztsSrWV/DFxn8w770Pdfax8KFVmZLxXmgv2YAvErGUQKxCZaBCS+t+
	 uxnTgVBH1HbMRTYFUQ1UOt/bg6G/rU1pS6rqpmJugarRrfvOMn8ym6u5z7vqsAFlh9
	 KbZQZQ0DjEjTyGH5xytb6m4T0hSwPqlxgBJ+hpjAmqRB5oUbyNc9ENLndc05Js2cr/
	 VIjokTfzo59U92ecInIENHI6v+7/1wXArugmefTlwPmhieEkQhjvCc5q+JLw34TINY
	 HGuWv+N1vc/OGuHZv2+b7Z8ku2K603KtPRVi6Z2qX7CqclWn0Y6nuvffi/lITB0hDZ
	 GaVjkU4pPar2g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A82m2V22211364
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:02:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:02:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:02:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/13] wifi: rtw89: wow: add retry for ensuring packet are processed
Date: Tue, 10 Mar 2026 16:01:42 +0800
Message-ID: <20260310080146.31113-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260310080146.31113-1-pkshih@realtek.com>
References: <20260310080146.31113-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 001E8246EE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32818-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Action: no action

From: Chin-Yen Lee <timlee@realtek.com>

Before entering WoWLAN mode, the driver must ensure that
all received packets have been processed to prevent packet
loss. Consequently, a retry mechanism has been implemented
to guarantee completion.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 15 ++++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a292a14394b2..35fd18fe6470 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -7183,7 +7183,7 @@ int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-int rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable)
+static int _rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable)
 {
 	struct rtw89_mac_h2c_info h2c_info = {};
 	struct rtw89_mac_c2h_info c2h_info = {};
@@ -7206,6 +7206,19 @@ int rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable)
 	return ret;
 }
 
+int rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable)
+{
+	int i, ret;
+
+	for (i = 0; i < CPU_IO_RX_RETRY_CNT; i++) {
+		ret = _rtw89_mac_cpu_io_rx(rtwdev, wow_enable);
+		if (!ret)
+			return 0;
+	}
+
+	return ret;
+}
+
 static int rtw89_wow_config_mac_ax(struct rtw89_dev *rtwdev, bool enable_wow)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 9c77bfaa34ee..88a877556cb3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -17,6 +17,7 @@
 #define BSSID_CAM_ENT_SIZE 0x08
 #define HFC_PAGE_UNIT 64
 #define RPWM_TRY_CNT 3
+#define CPU_IO_RX_RETRY_CNT 3
 
 enum rtw89_mac_hwmod_sel {
 	RTW89_DMAC_SEL = 0,
-- 
2.25.1


