Return-Path: <linux-wireless+bounces-28824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3A8C4B351
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 03:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC77E4E3567
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 02:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CF6347FEC;
	Tue, 11 Nov 2025 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Goe+IUJ/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA422BCF43
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827955; cv=none; b=rnxk6FdvlgDHXbnwIFCPFCzJUtMKjEzLZxVgcwNfTo3q602Ng6XLfIH0yrQdgtC/PYaTjsvGKbhvBbZZmiEoDaeUMuoZ6H2hBnZtQVLUgUqyXA2yk8LW/HukkClrv6LOdoRI1c9DcfsSbpjMUbj9FUlwn+apDLxTfR/NFZ8yYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827955; c=relaxed/simple;
	bh=lNS6hFRd4tOcyqL1hCt7xhJSHOrkp9Q+7tXu0yqx5qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNEvUocllQr9Bj9WV2qp+qY0wp5vTZW1Bi1lhTOFYZECjlfK/kpPcJKUJ1yjfjNBb2t0H7KlbPLLgd8BVeT5TcIizceQIGcGEamTBIlMvg7PZFZfI5L1FF/jlgX8zD84j/V63qzyrY94lCKQeEJ0rkCSSMCKrDdhfmt48HNhOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Goe+IUJ/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB2PqnM62922218, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762827952; bh=6k1f2LEtOZ1s03ijVhYXVkp7RYNOThzcXloOoBFssP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Goe+IUJ/icmAbJKAwN7256hRU0wxYJ+NKVrhoi5zyL+o4gUcsCGOOOV8V3iszGYdj
	 7BRVOumLR+m4EtQgS8lOa9CakRbbl4XXIAx/NKyNTtMP+Nv+3DF2i8gQjNqbRyYGJc
	 eZ7kJUqSVhLiQ64yFh3f9a/4LSeuWxOIena5EinbpzbzMKgGIq5ysnXvIhk+Pzgq0b
	 VlnDIdG/XvaSUgnTEDXVkWSQqq7hJsnPJdz+81lFw+0Xy3gch3v/4CSOgH2u5iMJL2
	 anD1YBsNwZF5rXQzM+kE+4ZoTTBligUPzCWmx62YjEctuPIWQFOarcT8FDaFSUKXx2
	 NlPW6yeX+jXCQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB2PqnM62922218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 10:25:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:25:52 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:25:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 10:25:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH v2 rtw-next 5/8] wifi: rtw89: phy: fix out-of-bounds access in rtw89_phy_read_txpwr_limit()
Date: Tue, 11 Nov 2025 10:24:49 +0800
Message-ID: <20251111022452.28093-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251111022452.28093-1-pkshih@realtek.com>
References: <20251111022452.28093-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Kuan-Chung Chen <damon.chen@realtek.com>

Coverity reported a potential out-of-bounds access when 'bw' exceeds the
valid range for the specified band. Add a helper `rtw89_bw_is_valid()`
to check bandwidth validity for each band before accessing limit tables.

Addresses-Coverity-ID: 1598844 ("Out-of-bounds access")
Addresses-Coverity-ID: 1598896 ("Out-of-bounds access")

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 23892c1359a5..28e2b15240a7 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2376,6 +2376,21 @@ static u8 rtw89_channel_to_idx(struct rtw89_dev *rtwdev, u8 band, u8 channel)
 	}
 }
 
+static bool rtw89_phy_validate_txpwr_limit_bw(struct rtw89_dev *rtwdev,
+					      u8 band, u8 bw)
+{
+	switch (band) {
+	case RTW89_BAND_2G:
+		return bw < RTW89_2G_BW_NUM;
+	case RTW89_BAND_5G:
+		return bw < RTW89_5G_BW_NUM;
+	case RTW89_BAND_6G:
+		return bw < RTW89_6G_BW_NUM;
+	default:
+		return false;
+	}
+}
+
 s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch)
 {
@@ -2400,6 +2415,11 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 	};
 	s8 cstr;
 
+	if (!rtw89_phy_validate_txpwr_limit_bw(rtwdev, band, bw)) {
+		rtw89_warn(rtwdev, "invalid band %u bandwidth %u\n", band, bw);
+		return 0;
+	}
+
 	switch (band) {
 	case RTW89_BAND_2G:
 		if (has_ant_gain)
-- 
2.25.1


