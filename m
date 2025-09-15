Return-Path: <linux-wireless+bounces-27287-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A1B570AC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E24F1771DE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1A29E11D;
	Mon, 15 Sep 2025 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rPnncJ4l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4122214236
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919234; cv=none; b=pAHsRgPJv1M+70qW5XHaQcn2SBV1Hjz++QQYGWksDRuvimrGrD4RZ5Z9wBamffHmTqLWqS2AQPLc4YfIFDT9ZQO762eggDptKVil3Fhhy8lo7VsfCDcFUrfFjUVv6Ks1C/A2aeyugAo/0VLwwsvBQew1xfQSPX+lN4+DcY53sl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919234; c=relaxed/simple;
	bh=LxLYUMqtbfvheTUFCgOrK9otoIk+jBrEgVQxrY2YByk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCdkZZvqwIG9fIfNYu3c+iy1X7hCqMLihK2wLLPWlaTByKqOBmGvIjyxU9vgyyj0jaDBbvXlBPKqpjTOVamTg0Q55FdB56CXOJ7+0Pcx4hZDZozkmpJEwR6J1CSW5s2u+7KHTfSbkrAqh5Vyeq6rY2HGTsWAlsGNs/L8etE23OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rPnncJ4l; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58F6roudF591681, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757919230; bh=igMS3Vdj22pYypfuBrju559IQ3SD2MT3VULuU614gaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rPnncJ4l44cYJt+BAtrW0jpi06Ve5LaNM95XhLVHHjcQnRuShuOawhu0QGxD8CIpQ
	 +GrT3bp1x62+SC3KWUc2uANWBZ/v+Acmls47SzhqLXrxVw4sQvBJFUtbJ1fSrCS7aL
	 hdXBWap3L2dyR0wEmg7rGBv7YF6v0psPKid9av6ISIsL1arqcgo/0K4uqrKTFfA2m8
	 yZPYeIrOmsKvfMsGW65khnyK7Xyip64Yyiu7X5GCgoYJhBeQT9tCUr7jgjiHsVjFcg
	 0qv6AuKfK3UQT4QQhnlrkKfS63863K4wrjxV6ZbibszFPb6j2B8Dsxh6K6MdyNbGL4
	 r156gMtBVREdQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58F6roudF591681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 14:53:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Sep 2025 14:53:50 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 15 Sep
 2025 14:53:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/11] wifi: rtw89: obtain RX path from ppdu status IE00
Date: Mon, 15 Sep 2025 14:52:06 +0800
Message-ID: <20250915065213.38659-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915065213.38659-1-pkshih@realtek.com>
References: <20250915065213.38659-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Chih-Kang Chang <gary.chang@realtek.com>

The header v2 of ppdu status is optional, If it is not enabled, the RX
path must be obtained from IE00 or IE01. Append the IE00 part.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 4 ++++
 drivers/net/wireless/realtek/rtw89/txrx.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 20d8f2221f81..b116f8d718ac 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1897,6 +1897,10 @@ static void rtw89_core_parse_phy_status_ie00(struct rtw89_dev *rtwdev,
 
 	tmp_rpl = le32_get_bits(ie->w0, RTW89_PHY_STS_IE00_W0_RPL);
 	phy_ppdu->rpl_avg = tmp_rpl >> 1;
+
+	if (!phy_ppdu->hdr_2_en)
+		phy_ppdu->rx_path_en =
+			le32_get_bits(ie->w3, RTW89_PHY_STS_IE00_W3_RX_PATH_EN);
 }
 
 static void rtw89_core_parse_phy_status_ie00_v2(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 82d6874337b5..984c9fdbb018 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -572,6 +572,7 @@ struct rtw89_phy_sts_ie00 {
 } __packed;
 
 #define RTW89_PHY_STS_IE00_W0_RPL GENMASK(15, 7)
+#define RTW89_PHY_STS_IE00_W3_RX_PATH_EN GENMASK(31, 28)
 
 struct rtw89_phy_sts_ie00_v2 {
 	__le32 w0;
-- 
2.25.1


