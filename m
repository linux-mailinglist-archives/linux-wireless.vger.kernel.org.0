Return-Path: <linux-wireless+bounces-36011-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO6CObk9+2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36011-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:10:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B84DABC6
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 517273008280
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DF9466B73;
	Wed,  6 May 2026 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dNMcgxDX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19C3FA5D3
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073013; cv=none; b=m4a3RNMoIRXXI2Xeq8DIWRwkdyVtimWm5pb3ZLxgAU87hGjYShTezJN3vEYbOp7vETa8uCIVvHRJnz/3DKm+Qm5Z9R47Hup81A4qCM3k86gDMQcOfza3lJcEd5czOK/LCovi2P5JXk//QJFQKMcp3XWHcIhoVscsYOUR02lUcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073013; c=relaxed/simple;
	bh=BLAKRX66OWSxN0xMVgzftQIv5P4KT/2kCShIQD9rIYU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJkL/IMtxzWwKFks7ypyb5rPmRWSu7w7ZUhr6hd3cZs4qE027YwB+X4oupHQHDURBO3aKsIMA6Ho7zG1cCiSTJyGhatQNDhTRqutvvaNkVWJbKaHV7wOQrOWx+R8ju+yw6E3yt/NsrFHrHIaSHNr4j6shtQNQGFhKPYRrSYS4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dNMcgxDX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DA6WT01986809, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073006; bh=rn9dZvq69dcruYR5qqisBwsfmVVkfETjoCDdeZkooiY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dNMcgxDXooUp8Hk7Q5s7BLh+pJHR3kZ5P0VXMDWA035JiGGgEb28/CM3r7poOycvz
	 f6E4WP+YCiHZ3DxD5A/CHSuVHId2qD77Lepr58lYQ4akoVUMjux7R6Y0tqodt9cE74
	 bUwccwX5Vyonfahgw8abc86IarpCCGnRRtB6um4bP9lySeri4ORZYgai+Pyf+6JFgD
	 XqIbfEYDVc0xBRTZMJ60H369C1yM+Y3fQ0rfe1MwcLye6AZGf27lzzxbOWKWmWliq7
	 NKtqJ0pKTo/I4SU0MucghT2955YaHE93lxApZ8GXf+DmnlLwcz8uGraJUWK/Gy92yV
	 pgHfA8I5y8nDQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DA6WT01986809
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:10:06 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:10:05 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:10:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 01/14] wifi: rtw89: add AMPDU to radiotap
Date: Wed, 6 May 2026 21:09:47 +0800
Message-ID: <20260506131000.1706298-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260506131000.1706298-1-pkshih@realtek.com>
References: <20260506131000.1706298-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 5F4B84DABC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36011-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The RX desc can report current frame is in AMPDU, but no way point out
if it is a last one in AMPDU. Update AMPDU reference only.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 8 ++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index b85728ceb63c..240502b25b2e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3568,6 +3568,7 @@ void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
 	desc_info->hw_dec = le32_get_bits(rxd_s->dword3, AX_RXD_HW_DEC);
 	desc_info->sw_dec = le32_get_bits(rxd_s->dword3, AX_RXD_SW_DEC);
 	desc_info->addr1_match = le32_get_bits(rxd_s->dword3, AX_RXD_A1_MATCH);
+	desc_info->ampdu = le32_get_bits(rxd_s->dword3, AX_RXD_AMPDU);
 
 	shift_len = desc_info->shift << 1; /* 2-byte unit */
 	drv_info_len = desc_info->drv_info_size << 3; /* 8-byte unit */
@@ -3624,6 +3625,7 @@ void rtw89_core_query_rxdesc_v2(struct rtw89_dev *rtwdev,
 	desc_info->hw_dec = le32_get_bits(rxd_s->dword3, BE_RXD_HW_DEC);
 	desc_info->sw_dec = le32_get_bits(rxd_s->dword3, BE_RXD_SW_DEC);
 	desc_info->addr1_match = le32_get_bits(rxd_s->dword3, BE_RXD_A1_MATCH);
+	desc_info->ampdu = le32_get_bits(rxd_s->dword3, BE_RXD_AMPDU);
 
 	desc_info->bw = le32_get_bits(rxd_s->dword4, BE_RXD_BW_MASK);
 	desc_info->data_rate = le32_get_bits(rxd_s->dword4, BE_RXD_RX_DATARATE_MASK);
@@ -3698,6 +3700,7 @@ void rtw89_core_query_rxdesc_v3(struct rtw89_dev *rtwdev,
 	desc_info->hw_dec = le32_get_bits(rxd_s->dword3, BE_RXD_HW_DEC);
 	desc_info->sw_dec = le32_get_bits(rxd_s->dword3, BE_RXD_SW_DEC);
 	desc_info->addr1_match = le32_get_bits(rxd_s->dword3, BE_RXD_A1_MATCH);
+	desc_info->ampdu = le32_get_bits(rxd_s->dword3, BE_RXD_AMPDU);
 
 	desc_info->bw = le32_get_bits(rxd_s->dword4, BE_RXD_BW_MASK);
 	desc_info->data_rate = le32_get_bits(rxd_s->dword4, BE_RXD_RX_DATARATE_MASK);
@@ -3830,6 +3833,11 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 	    !(desc_info->sw_dec || desc_info->icv_err))
 		rx_status->flag |= RX_FLAG_DECRYPTED;
 
+	if (desc_info->ampdu) {
+		rx_status->flag |= RX_FLAG_AMPDU_DETAILS;
+		rx_status->ampdu_reference = desc_info->ppdu_cnt;
+	}
+
 	rx_status->bw = rtw89_hw_to_rate_info_bw(desc_info->bw);
 
 	data_rate = desc_info->data_rate;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index bccfee7535a7..66dbb1fc3ca8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1130,6 +1130,7 @@ struct rtw89_rx_desc_info {
 	bool hw_dec;
 	bool sw_dec;
 	bool addr1_match;
+	bool ampdu;
 	u8 frag;
 	u16 seq;
 	u8 frame_type;
-- 
2.25.1


