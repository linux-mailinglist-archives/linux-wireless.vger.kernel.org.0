Return-Path: <linux-wireless+bounces-14799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10EB9B8947
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 03:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360081F21AEC
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 02:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E016137776;
	Fri,  1 Nov 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K7JiKPKQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A3374D1;
	Fri,  1 Nov 2024 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427750; cv=none; b=asfangKfhKLqpB5v1N1kJND4edNoDHnCFy/Q7m9TcapHiSccOvsf/z7lI042JK2m5Ijvg4eHWzLPAsvX5wSJVQkXw9di1ZPD1qNYScst/OVhE0Wmffbu31JT7XPZVq7ILdCdMx+ig/GcwaiyUWTx23TPMOykZsU5dFSeBbpt+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427750; c=relaxed/simple;
	bh=0prxTGqGTwPgVxr4TmHWXEh/IRjOJE8t+x/6sdo2c/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxKKRkVOwzI5ds7xs926TlO4XcbPwfjFtGbEKDeSjKPUkP6KAWpIsB2EJazc8qr0DhOb2YE28wWuZYGgJE9lSe1NLFH1xl//H/AlprZi3ahYRQfv9At8S0BMUXTkrCNePUK3w7AGCgnudJPTKNKo7levx2Xe/8uJtWu9ZyrxeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K7JiKPKQ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730427741; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cIu6o/sJTje0aSEm9Eb5I1ZzBO0/VkHTOX5o77xLAHQ=;
	b=K7JiKPKQCBoBfoGuKEOfk1x4h/aOnsNVPhfLxKkNldnvKz99leYwExLWp3XX+ZrgQaHm7r81Vvk8TuoI3mp8RpqqCBEtWEp82jI7Lakv5qCstTHTOHprYwqgMJwPnPgDYhv6jR8cvxcuap3OOS2yGEb0QpTSd3dthaJQgH5/+Mk=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WIKHIpB_1730427735 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Nov 2024 10:22:20 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: stas.yakovlev@gmail.com
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2 -next] wifi: ipw2x00: fix bad alignments
Date: Fri,  1 Nov 2024 10:22:15 +0800
Message-Id: <20241101022215.6667-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes incorrect code alignment.

./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:871:2-3: code aligned with following code on line 882.
./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:886:2-3: code aligned with following code on line 900.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11381
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Replace the & in the if statement with &&. Add 'wifi: ' to subject.

 .../net/wireless/intel/ipw2x00/libipw_rx.c    | 44 +++++++++----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index 7e41cb7bbfe0..38731f67cb54 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -868,34 +868,34 @@ void libipw_rx_any(struct libipw_device *ieee,
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
+			if ((fc && (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == 0) {
+				/* promisc: get all */
+				if (ieee->dev->flags & IFF_PROMISC)
+					is_packet_for_us = 1;
+				/* to us */
+				else if (ether_addr_equal(hdr->addr1, ieee->dev->dev_addr))
+					is_packet_for_us = 1;
+				/* mcast */
+				else if (is_multicast_ether_addr(hdr->addr1))
+					is_packet_for_us = 1;
 		}
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
+			if ((fc && (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == IEEE80211_FCTL_FROMDS) {
+				/* promisc: get all */
+				if (ieee->dev->flags & IFF_PROMISC)
 					is_packet_for_us = 1;
-			}
+				/* to us */
+				else if (ether_addr_equal(hdr->addr1, ieee->dev->dev_addr))
+					is_packet_for_us = 1;
+				/* mcast */
+				else if (is_multicast_ether_addr(hdr->addr1)) {
+					/* not our own packet bcasted from AP */
+					if (!ether_addr_equal(hdr->addr3, ieee->dev->dev_addr))
+						is_packet_for_us = 1;
+				}
 		}
 		break;
 	default:
-- 
2.32.0.3.g01195cf9f


