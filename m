Return-Path: <linux-wireless+bounces-2297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3538354D1
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 08:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A47283354
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E79F364BA;
	Sun, 21 Jan 2024 07:19:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C2364BB
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705821553; cv=none; b=RK8lKsW37jkdz3xYglzm7zb3wBbj46tjpxfo241Gxc0KngzeDMJnlZJYfXkuo02vicDi3Vj0fqAeirFI2wkxlSQpQ84XW80XbbEgZqcX7pdRVF698Ywm20FRtpFm5rsStifWGjm1NymbwSnle3tbfcLsDbiLSmXYesxpLEFvhKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705821553; c=relaxed/simple;
	bh=1bZXKjTvFA/BTCJTzJLdhYaxsoIPOFA9z+2pHb9Ejqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSXgtNdpGgiFeyz5gEpG/4TldQvcyczcpcXSTbe8AucqRPJWjBlSxk/PfEd5udFqWadlG2CytN5lIVX+otJ0glzcuK+ih9q++yc76Ud9Wqu8DjY5+5Fq2rJ/7p7XuAfccrgWeXH57J1NuEKK9ODyypxuPSOvY1+tmUlA4OidPk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40L7J7i543102124, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40L7J7i543102124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Jan 2024 15:19:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sun, 21 Jan 2024 15:19:07 +0800
Received: from [127.0.1.1] (172.16.17.107) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 21 Jan
 2024 15:19:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: pci: enlarge RX DMA buffer to consider size of RX descriptor
Date: Sun, 21 Jan 2024 15:18:26 +0800
Message-ID: <20240121071826.10159-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121071826.10159-1-pkshih@realtek.com>
References: <20240121071826.10159-1-pkshih@realtek.com>
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

Hardware puts RX descriptor and packet in RX DMA buffer, so it could be
over one buffer size if packet size is 11454, and then it will be split
into two segments. WiFi 7 chips use larger size of RX descriptor, so
enlarge DMA buffer size according to RX descriptor to have better
performance and simple flow.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 0543221b4c58..532f78eaf6df 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -997,7 +997,7 @@
 #define RTW89_PCI_TXWD_NUM_MAX		512
 #define RTW89_PCI_TXWD_PAGE_SIZE	128
 #define RTW89_PCI_ADDRINFO_MAX		4
-#define RTW89_PCI_RX_BUF_SIZE		11460
+#define RTW89_PCI_RX_BUF_SIZE		(11454 + 40) /* +40 for rtw89_rxdesc_long_v2 */
 
 #define RTW89_PCI_POLL_BDRAM_RST_CNT	100
 #define RTW89_PCI_MULTITAG		8
-- 
2.25.1


