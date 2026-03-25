Return-Path: <linux-wireless+bounces-33813-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJoZKjOOw2lVrgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33813-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:26:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60057320AB9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEFC63105533
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 07:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8829D29F;
	Wed, 25 Mar 2026 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rpE+aNk8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA4366553
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423348; cv=none; b=XMNiov/LBQdNawOQm5ZTXhogDq4o4A5V4QnHgGdlA8X9l10tMLxTRtVnuQznhKmmD54/xCEHnpzxdUVYf8EI9UOzLIxCjaC4UgHwBtUV+b1t0KETDOnbd9hEAGbfYffev31Ckph501VdR5EXWuLKn6QBTq7ZkiGmjoS7km0AvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423348; c=relaxed/simple;
	bh=I3OVUDfV7VJaSKrk1kt23kibk/zlXs39rCC6h0uiBhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbNKQz2n2DG/7VeSwMK2Gl47gYl3huM6UyKk8NrXuejWLHggnsLVuerdvKmMzq9c6Ld2efJkwFb3rEWl4/uY2fFb0CQLD2xMQDAKq4IM6G2eRKp3V4kABi2rk6y6v409lwGUTio1nqAC65ubQU+v2QyIYwJrJ422bEoOYbl0hP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rpE+aNk8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62P7MNwmC2939452, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774423343; bh=NCZrFOZW+6pwtQ6q1gjRlAih7Ni2d3QReVvIzeAcISQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rpE+aNk8siRLo575ZhItDNeHj1AS8sfteDdGNEXytXCh5AH6Eqd20kQDj+uUc0bn1
	 H6ism6NPwvYx380GHzy37qX/QGIxrCuuVwawt/EWG+s644wR2f694ZmaBNgyPjJoi6
	 8yCO14JyZ7JzAPyIa2K8FyaMEdkAcKoSnGOIzWVEX5XVGoybBlDitN88o9KF2ilHmm
	 SRGWfCjRECeQpnvZz3/iktnbKZkO9SBLoGc3lxbb+uAqXPn+PmtX0no7RUAK4IjrDv
	 cbEPSbROwJ6n4PJAwc0erDtVDXdlvtQCqVneA+KrgOoZ+xcseGUcB3+m5c6P2dK8ij
	 eWO0a5Nvcnd9Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62P7MNwmC2939452
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:22:23 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 15:22:22 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 25 Mar 2026 15:22:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 4/8] wifi: rtw89: mac: add specific case to dump mac memory for RTL8922D
Date: Wed, 25 Mar 2026 15:21:26 +0800
Message-ID: <20260325072130.41751-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325072130.41751-1-pkshih@realtek.com>
References: <20260325072130.41751-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33813-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60057320AB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8922D can reuse most mac memory addresses, but only
RTW89_MAC_MEM_SECURITY_CAM is different from existing one. Add a function
to return the specific memory address for RTL8922D.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c |  2 +-
 drivers/net/wireless/realtek/rtw89/mac.c   |  4 ++--
 drivers/net/wireless/realtek/rtw89/mac.h   | 13 +++++++++++++
 drivers/net/wireless/realtek/rtw89/ser.c   |  2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 82849d109cc3..7d8d22311018 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -1129,7 +1129,7 @@ static int rtw89_debug_dump_mac_mem(struct rtw89_dev *rtwdev,
 	pages = len / mem_page_size + 1;
 	start_page = start_addr / mem_page_size;
 	residue = start_addr % mem_page_size;
-	base_addr = mac->mem_base_addrs[sel];
+	base_addr = rtw89_mac_mem_base_addrs(rtwdev, sel);
 	base_addr += start_page * mem_page_size;
 
 	for (pp = 0; pp < pages; pp++) {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 35fd18fe6470..54aad37485d6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -43,7 +43,7 @@ static void rtw89_mac_mem_write(struct rtw89_dev *rtwdev, u32 offset,
 				u32 val, enum rtw89_mac_mem_sel sel)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	u32 addr = mac->mem_base_addrs[sel] + offset;
+	u32 addr = rtw89_mac_mem_base_addrs(rtwdev, sel) + offset;
 
 	rtw89_write32(rtwdev, mac->filter_model_addr, addr);
 	rtw89_write32(rtwdev, mac->indir_access_addr, val);
@@ -53,7 +53,7 @@ static u32 rtw89_mac_mem_read(struct rtw89_dev *rtwdev, u32 offset,
 			      enum rtw89_mac_mem_sel sel)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	u32 addr = mac->mem_base_addrs[sel] + offset;
+	u32 addr = rtw89_mac_mem_base_addrs(rtwdev, sel) + offset;
 
 	rtw89_write32(rtwdev, mac->filter_model_addr, addr);
 	return rtw89_read32(rtwdev, mac->indir_access_addr);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 88a877556cb3..93bedf056f17 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -334,6 +334,7 @@ enum rtw89_mac_dbg_port_sel {
 #define NAT25_CAM_BASE_ADDR_BE		0x18820000
 #define RXPLD_FLTR_CAM_BASE_ADDR_BE	0x18823000
 #define SEC_CAM_BASE_ADDR_BE		0x18824000
+#define SEC_CAM_BASE_ADDR_BE_8922D	0x1882C000
 #define WOW_CAM_BASE_ADDR_BE		0x18828000
 #define MLD_TBL_BASE_ADDR_BE		0x18829000
 #define RX_CLSF_CAM_BASE_ADDR_BE	0x1882A000
@@ -1131,6 +1132,18 @@ struct rtw89_mac_gen_def {
 extern const struct rtw89_mac_gen_def rtw89_mac_gen_ax;
 extern const struct rtw89_mac_gen_def rtw89_mac_gen_be;
 
+static inline
+u32 rtw89_mac_mem_base_addrs(struct rtw89_dev *rtwdev, u8 sel)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	if (rtwdev->chip->chip_id == RTL8922D &&
+	    sel == RTW89_MAC_MEM_SECURITY_CAM)
+		return SEC_CAM_BASE_ADDR_BE_8922D;
+
+	return mac->mem_base_addrs[sel];
+}
+
 static inline
 u32 rtw89_mac_reg_by_idx(struct rtw89_dev *rtwdev, u32 reg_base, u8 band)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 75220042a9a7..a507ce1fcd63 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -589,7 +589,7 @@ static void ser_mac_mem_dump(struct rtw89_dev *rtwdev, u8 *buf,
 
 	start_page = start_addr / mem_page_size;
 	residue = start_addr % mem_page_size;
-	base_addr = mac->mem_base_addrs[sel];
+	base_addr = rtw89_mac_mem_base_addrs(rtwdev, sel);
 	base_addr += start_page * mem_page_size;
 
 	while (cnt < len) {
-- 
2.25.1


