Return-Path: <linux-wireless+bounces-22438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA894AA8CFD
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6C63AE941
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1C1DE3CA;
	Mon,  5 May 2025 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GHoO3QUT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B71DE3B5
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429923; cv=none; b=uJu5/WpTU7TSJYfrBRvblFZ72U84ghIIRzhS9vv/TGJ9an+vMSZCdZe6KtDNriWo+80Zzrpci5LY9BKn6U2YDJiygQq+HDvFKa8sqsvq+GHi5u9RgBzBxLY7Ha+v2uRuy2li17ZWxIaOQ2DMy4u9aT9EAYLtKT3lWfwlUcaW7XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429923; c=relaxed/simple;
	bh=2PbyRDyoLYTtOs2ZsnlzrcCmri/VXpJo5jQBCv+ko1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVeuJLP4ome5xlAxxxK32s4N+kpyZ5CEjUBxL2PETqnEn5QxaAer3nfL39TFEvh6XFSKbpB1NkU1hsreJuDvd6p/OG5Qhuf9zswsLKKcZT7fPhLm1YOtlTqrS00ujc3WIC0Q+3WIW3EMQ6pec+A+Z0PUkcazlKLQJW3WGzmj0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GHoO3QUT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457PJP503831285, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429919; bh=2PbyRDyoLYTtOs2ZsnlzrcCmri/VXpJo5jQBCv+ko1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GHoO3QUTi3n4o+DaQO7DuNRw22yUvcOVwZwz3djF2OGMAQNtT1CzCvKovyYa4sBya
	 2bF6Uv+CarbouaJ/jnmvisRUPIhZnj+XDHKmCM6cm3GuKDoTCEaE7X/p0jwQmE+Gt3
	 PEhD9IGQcGgx+4M0BxmV0ztyYJ6D6BpgNys4x5G8d6kF8uctXDIFrdmxEIdeCZ1RSf
	 twoUghr23zqnYXfZ7CuPcqerVdTaj0T/+cbYiDob4IMWOP9FmnAh7O5zUPFfAy+kis
	 Ox8zzrTxy8eUJ6yX/lPDOdHwdZu3oxkkuGyGI3H5oCd6VBS3WUbekp+CPewRt1FeUV
	 6Y2LolUOXfcrA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457PJP503831285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:25:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:25:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:25:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/11] wifi: rtw89: debug: add MLD table dump
Date: Mon, 5 May 2025 15:24:37 +0800
Message-ID: <20250505072440.45113-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505072440.45113-1-pkshih@realtek.com>
References: <20250505072440.45113-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

Add definition for MLD table dump, this is for debug purpose only.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.h    | 1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index e1083b0f8136..8013c852d5be 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -370,6 +370,7 @@ enum rtw89_mac_mem_sel {
 	RTW89_MAC_MEM_TXD_FIFO_0_V1,
 	RTW89_MAC_MEM_TXD_FIFO_1_V1,
 	RTW89_MAC_MEM_WD_PAGE,
+	RTW89_MAC_MEM_MLD_TBL,
 
 	/* keep last */
 	RTW89_MAC_MEM_NUM,
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index a1ba6ca431d7..8c9d326dc907 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -29,6 +29,7 @@ static const u32 rtw89_mac_mem_base_addrs_be[RTW89_MAC_MEM_NUM] = {
 	[RTW89_MAC_MEM_CPU_LOCAL]	= CPU_LOCAL_BASE_ADDR_BE,
 	[RTW89_MAC_MEM_BSSID_CAM]	= BSSID_CAM_BASE_ADDR_BE,
 	[RTW89_MAC_MEM_WD_PAGE]		= WD_PAGE_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_MLD_TBL]		= MLD_TBL_BASE_ADDR_BE,
 };
 
 static const struct rtw89_port_reg rtw89_port_base_be = {
-- 
2.25.1


