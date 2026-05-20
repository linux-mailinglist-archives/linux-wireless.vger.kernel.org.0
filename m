Return-Path: <linux-wireless+bounces-36707-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN5jIAWtDWq51QUAu9opvQ
	(envelope-from <linux-wireless+bounces-36707-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:45:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E225058E17F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 14:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88FA23138A42
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757523E00A9;
	Wed, 20 May 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lLmSq0Os"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926FC3DCD8F
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280723; cv=none; b=bJTN8OBRR1g0AAl8CS+QpotAdQb6uyJxQtZHvwCybAFXka33RCzoVLQQl+DcmbhWztY66sP9N6EsksyXVJyBCDTJoAMBySu+bEZn+NGhJTONIbeYX2F7ABVovbLmEVDAZLYf/hB6/q6DvleFcHEujKeLROmJh2QXrnNk/sZNHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280723; c=relaxed/simple;
	bh=PqDP25/MiozZXGnzm70d/8zE6pTeinmtsYzxJ7jPboE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLmTpnZQcOYj7IGMibUVm8evDMxFtQDj3TiivxZu66vlNUaw2QGwMZMRpwt5qqU/LmgSOFW4vqK/Fzag96zvGF6zF0tLisysf6n34J/2MTuu8USRXDrpQHtEfou4Io2TRkc10GBoSoqIFz9y9ift5dr3t7I2DHDu2LEwQ3htcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lLmSq0Os; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64KCcdJW3095485, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779280719; bh=LWTTWXPp7J8sEO1QaW8Q1YYZ0+azfnTStfQqD+s8ce4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=lLmSq0Osxa7bStVZhiZsAXLJmm9N/OpNSl+8UrwRh49KIFMAbxPB6WE9B2zw6jZqR
	 DGBjpanAHK3zjNjw6DZ0uP/iazjdsz51kPkL2CiqErQE4vEgZCyfDaZ7gOeCczCILi
	 Sfvb+GbQXtcaui3Uzc9iA/QrfBlqFUdEq48ZAVPOfEdtHwDlCgN6uZo4wW0JttMGkU
	 Y64hwG72ecD61DMopz3UhxcI7gj712Qudz8WzWl5U9avzwLpFHZ6z4BPzwXj255i7M
	 IvQJaU8ZpBVpEGRWXWrKG9czPauBCzk5e4YCRJ/TagX4QdfD/oZkzWJsyb1DieKGpP
	 LSJQ/DVMfOKag==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64KCcdJW3095485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 20:38:39 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 20:38:39 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 20:38:39 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 20 May 2026 20:38:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 3/7] wifi: rtw89: 8922d: support new digital power compensation format
Date: Wed, 20 May 2026 20:38:19 +0800
Message-ID: <20260520123823.1792954-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260520123823.1792954-1-pkshih@realtek.com>
References: <20260520123823.1792954-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36707-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email,realtek.com:mid,realtek.com:dkim];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E225058E17F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The new format shared the base set (7 elements). As there are total 40
sets, save 7 * 39 elements.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index af2df4adfa85..18af9211c2df 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2127,6 +2127,12 @@ static void rtw8922d_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
 			__le32 vals[DIGITAL_PWR_COMP_VALS_NUM];
 		} sets[2][RTW89_TX_COMP_BAND_NR][BB_PATH_NUM_8922D];
 	} *pwr_comp_v0;
+	const struct {
+		__le32 base[DIGITAL_PWR_COMP_BASE_NUM];
+		struct {
+			__le32 vals[DIGITAL_PWR_COMP_VALS_NUM];
+		} sets[2][RTW89_TX_COMP_BAND_NR][BB_PATH_NUM_8922D];
+	} *pwr_comp;
 	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
 	const struct rtw89_fw_element_hdr *txcomp_elm = elm_info->tx_comp;
 	const __le32 (*comp_base)[DIGITAL_PWR_COMP_BASE_NUM];
@@ -2134,7 +2140,11 @@ static void rtw8922d_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
 	u32 addr, val;
 	u32 i;
 
-	if (sizeof(*pwr_comp_v0) == le32_to_cpu(txcomp_elm->size)) {
+	if (sizeof(*pwr_comp) == le32_to_cpu(txcomp_elm->size)) {
+		pwr_comp = (const void *)txcomp_elm->u.common.contents;
+		comp_base = &pwr_comp->base;
+		comp_vals = &pwr_comp->sets[nss][chan->tx_comp_band][path].vals;
+	} else if (sizeof(*pwr_comp_v0) == le32_to_cpu(txcomp_elm->size)) {
 		pwr_comp_v0 = (const void *)txcomp_elm->u.common.contents;
 		comp_base = &pwr_comp_v0->sets[nss][chan->tx_comp_band][path].base;
 		comp_vals = &pwr_comp_v0->sets[nss][chan->tx_comp_band][path].vals;
-- 
2.25.1


