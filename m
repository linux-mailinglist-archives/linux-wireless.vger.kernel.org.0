Return-Path: <linux-wireless+bounces-14570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B439B142B
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 04:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491DF1C2105A
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 02:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99541BC5C;
	Sat, 26 Oct 2024 02:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="H+94qKqd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DDA6FC5
	for <linux-wireless@vger.kernel.org>; Sat, 26 Oct 2024 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729909331; cv=none; b=D9f41mbPQX3GbgW47Nt2H4zYK10ZUlwOKxyRn+6msHChp8UHwPIhlL+M/3HsCzFx8JFxIHODW13lzQL8o8bkTad54C1vT130gHK3s1TG+Cgqe80yGWsIEcf1PA7IJFabznhagH11iM/D95AUbN/A2LBx3GYIIH8rIJhiwXLd4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729909331; c=relaxed/simple;
	bh=n/PjqZ7Fhwb2ck0y1xUw0/CMJHcOVhvn1jnZ7hOCo9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uOCKFKQvUVTRJ4epmT+JLSS5MNUu5wAjSpA6AcMxE985e6DHCSmM8hSA9upQ6CHFfHFuHXI0f1Yk3dIGKlc2iw84uRjESvBIqfv6LIb89XNenEyFXhuX3u0YlnYtEYPAu6bRXqOgAIOfWeEIJ3TFgkuwui/mfOSsE4hHYLiid0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=H+94qKqd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49Q2M45101446434, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729909324; bh=n/PjqZ7Fhwb2ck0y1xUw0/CMJHcOVhvn1jnZ7hOCo9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=H+94qKqd+k8CSr9IDOKMczKgz5XNVturm7OPJXVisatbtBvU5DUNCW9PNtIc1LfW8
	 dGEgcww4WVx2Cd0cY8/YSlq4d86R+U9Sz0MKWeKZk+H04vQH/HlJQdpWRPSWC8U9sm
	 JDLeebCm/pTUzRQDF+g4Lo74/841tnJv8N1QlyZWTOh7xMsLkmw1PrQ6h1uFrDGik8
	 vOol3kHlIBizTsqEtB0xIws45NaRdzUYpZhm6ZXlja80jB/pfHM5yyvkFeARbLwXzZ
	 d6xCl3KlNY4hFgfD38RKvyPThnMrR6xKiu2QAxVNeO7IOCR1800AmgkW5b8YlrpkKs
	 jFUAGG14OxIaA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49Q2M45101446434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 26 Oct 2024 10:22:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 26 Oct 2024 10:22:04 +0800
Received: from [127.0.1.1] (172.16.22.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 26 Oct
 2024 10:22:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH] wifi: rtw89: set pause_data field to avoid transmitting data in scan channels
Date: Sat, 26 Oct 2024 10:21:43 +0800
Message-ID: <20241026022143.7304-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Chih-Kang Chang <gary.chang@realtek.com>

Set pause_data to all of the scan channels, excluding the OP channel,
to prevent data frame transmission to the scan channels, which causes
retransmission. Additionally, this flag won't affect the transmission
of probe requests from the scan channels.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f504d1681fa3..18ee7de2d93b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6298,8 +6298,10 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 			ch_info->period = max_t(u8, ch_info->period,
 						RTW89_DFS_CHAN_TIME);
 		ch_info->dwell_time = RTW89_DWELL_TIME;
+		ch_info->pause_data = true;
 		break;
 	case RTW89_CHAN_ACTIVE:
+		ch_info->pause_data = true;
 		break;
 	default:
 		rtw89_err(rtwdev, "Channel type out of bound\n");
@@ -6398,8 +6400,10 @@ static void rtw89_hw_scan_add_chan_be(struct rtw89_dev *rtwdev, int chan_type,
 			ch_info->period =
 				max_t(u8, ch_info->period, RTW89_DFS_CHAN_TIME);
 		ch_info->dwell_time = RTW89_DWELL_TIME;
+		ch_info->pause_data = true;
 		break;
 	case RTW89_CHAN_ACTIVE:
+		ch_info->pause_data = true;
 		break;
 	default:
 		rtw89_warn(rtwdev, "Channel type out of bound\n");
-- 
2.25.1


