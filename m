Return-Path: <linux-wireless+bounces-14113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1BD9A1850
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 04:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651F61C208BB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 02:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB19443;
	Thu, 17 Oct 2024 02:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EEnZ4DgD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC92625;
	Thu, 17 Oct 2024 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130502; cv=none; b=ghRax7FrvJyk6B1k3UX1qIlaymorj9Cs78D/7HaDyPOpnULHUncl/quyheI4jenqnKT9Wju7d5L2XNlm44cgyFMxXdAHglXYLduiCL14+4rbr9U1HGVDGX4uFTNQF4cZ0JZnZyWffzjjpB6CRqawcwjH36N4lFyd0Mg2/3RrTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130502; c=relaxed/simple;
	bh=SC4WM7SyrvGAlvtEfmjQemW7aCUiGxGu2lCYz48zlP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UbDygNK4IFX3Zg5mhGNucculyKtkw/p7lj+ZaHxhzBZZDchYZnHMt4fHgb67X14OFwrHtnyxNDjGdraqNmDcoL+ijzhiaoDuHfIxojvoNnIVmOfo+gfjDq0JOhONIVyjDoE3Aumc4B6oIjMJvI58bYlb0YwSyc39sIdcCnpKHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EEnZ4DgD; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729130489; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7x6tznArxC49UbjvS63EpyvtdmOUN9sBuqVmm26BtBM=;
	b=EEnZ4DgDOmS9SZGgFnb3WZPXn1T6BTH0xr/f+FzgCjDjb9n13bWNgsgSgUFNmNAxx8Ilxg0rONCWaWz3ucZ31/wEPgwhE1qvQ9GzmQGAeAMRQrlXLVNGSaMoy0Bk7jabl8f33lUF+oJQRlh8Gj3VxRk0UJKbLNQikzSYlVXeTYE=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WHJ61rQ_1729130475 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 10:01:29 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: stas.yakovlev@gmail.com
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ipw2x00: fix bad alignments
Date: Thu, 17 Oct 2024 10:01:13 +0800
Message-Id: <20241017020113.122029-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:871:2-3: code aligned with following code on line 882.
./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:886:2-3: code aligned with following code on line 900.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11381
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../net/wireless/intel/ipw2x00/libipw_rx.c    | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index 7e41cb7bbfe0..566a7b84c739 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -868,35 +868,35 @@ void libipw_rx_any(struct libipw_device *ieee,
 	case IW_MODE_ADHOC:
 		/* our BSS and not from/to DS */
 		if (ether_addr_equal(hdr->addr3, ieee->bssid))
-		if ((fc & (IEEE80211_FCTL_TODS+IEEE80211_FCTL_FROMDS)) == 0) {
-			/* promisc: get all */
-			if (ieee->dev->flags & IFF_PROMISC)
-				is_packet_for_us = 1;
-			/* to us */
-			else if (ether_addr_equal(hdr->addr1, ieee->dev->dev_addr))
-				is_packet_for_us = 1;
-			/* mcast */
-			else if (is_multicast_ether_addr(hdr->addr1))
-				is_packet_for_us = 1;
-		}
+			if ((fc & (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == 0) {
+				/* promisc: get all */
+				if (ieee->dev->flags & IFF_PROMISC)
+					is_packet_for_us = 1;
+				/* to us */
+				else if (ether_addr_equal(hdr->addr1, ieee->dev->dev_addr))
+					is_packet_for_us = 1;
+				/* mcast */
+				else if (is_multicast_ether_addr(hdr->addr1))
+					is_packet_for_us = 1;
+			}
 		break;
 	case IW_MODE_INFRA:
 		/* our BSS (== from our AP) and from DS */
 		if (ether_addr_equal(hdr->addr2, ieee->bssid))
-		if ((fc & (IEEE80211_FCTL_TODS+IEEE80211_FCTL_FROMDS)) == IEEE80211_FCTL_FROMDS) {
-			/* promisc: get all */
-			if (ieee->dev->flags & IFF_PROMISC)
-				is_packet_for_us = 1;
-			/* to us */
-			else if (ether_addr_equal(hdr->addr1, ieee->dev->dev_addr))
-				is_packet_for_us = 1;
-			/* mcast */
-			else if (is_multicast_ether_addr(hdr->addr1)) {
-				/* not our own packet bcasted from AP */
-				if (!ether_addr_equal(hdr->addr3, ieee->dev->dev_addr))
+			if ((fc & (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == IEEE80211_FCTL_FROMDS) {
+				/* promisc: get all */
+				if (ieee->dev->flags & IFF_PROMISC)
+					is_packet_for_us = 1;
+				/* to us */
+				else if (ether_addr_equal(hdr->addr1, ieee->dev->dev_addr))
 					is_packet_for_us = 1;
+				/* mcast */
+				else if (is_multicast_ether_addr(hdr->addr1)) {
+					/* not our own packet bcasted from AP */
+					if (!ether_addr_equal(hdr->addr3, ieee->dev->dev_addr))
+						is_packet_for_us = 1;
+				}
 			}
-		}
 		break;
 	default:
 		/* ? */
-- 
2.32.0.3.g01195cf9f


