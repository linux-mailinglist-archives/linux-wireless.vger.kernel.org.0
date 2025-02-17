Return-Path: <linux-wireless+bounces-19031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB99A37B5F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 07:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0ECB188E0BE
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D74156F54;
	Mon, 17 Feb 2025 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="i1ojldG8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B801C383A5
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773895; cv=none; b=JYZVb5CszZ/1Y5wqO2pG89gkTNTBMZ2YPBMwunskrxIFwl9/eDzAdZth4yLu9ya8ZQn23nAcEstd6+L4IWG8OC080YZXA1TeaxVBWBzS/sxCPCNsd0eJHa8Brm28gnAgehbb63Xsiy0yVo2nie+HOR8+Va/tJNT2EASMkaa4pxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773895; c=relaxed/simple;
	bh=8cLyeAfzgqqHICgUgm7biEl1eSgwnB+TJU4Yks/LQk0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k2vsZxbZGCx0rL6g7b++aYY+VUkWpoiGi8HdWMsazJDwhYUvUCumEbCBeDLr23YAlIpA9vZgxrBjcGZYkQReOCwLQFXW00wrngEHZ4B9jj4cHm9qezFrLAIi4ElLJhpOenYJfQPQmryU2H6ZkW1+itkH9rILAf4cU7b/8ry+jFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=i1ojldG8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H6VTojC2636793, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739773889; bh=8cLyeAfzgqqHICgUgm7biEl1eSgwnB+TJU4Yks/LQk0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=i1ojldG8FQOkNDa7tg4toA69k5qgOxLo3y7amU1BH3gPUzHOSggHUOP1UqZnxAzWa
	 32YGWuVpKz3RHwVexQKyj9L1nzpwHKA/99GV9XMTBd/+V9E/+9PEu844cjbxbqIvqJ
	 F0CiVx3tidzzI/O56G9TEkSvjKzsgJmx4ATz7CkECHNLYXun4f/XqEQ2dccFgru2qV
	 DsoL3S24mKNFTrcr136ZNtBjCoi2unVUeIyF4jut/NsmdArVZ4H/yF4elB3MDY5ijR
	 yz88n5AbFcmUxBKMkfr9qKFqyq+VmqIeKsioQX9abZwpwQ4MgpMyYw4tHh6I989Fm+
	 VWN1Qh1VmVeAg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H6VTojC2636793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 14:31:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 14:31:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Feb
 2025 14:31:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/2] wifi: rtw89: update TX time related configuration for WiFi 7 chips
Date: Mon, 17 Feb 2025 14:30:51 +0800
Message-ID: <20250217063053.38936-1-pkshih@realtek.com>
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

BT-coexistence control WiFi TX time to share time slot with Bluetooth
device, so it controls WiFi aggregation time to prevent WiFi occupies
too much time. The original registers and H2C command don't migrate to
definitions of WiFi 7, so change them accordingly.

Ping-Ke Shih (2):
  wifi: rtw89: mac: define registers of agg_limit and txcnt_limit to
    share common flow
  wifi: rtw89: add H2C command of TX time for WiFi 7 chips

 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 55 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 11 ++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 23 +++++---
 drivers/net/wireless/realtek/rtw89/mac.h      |  2 +
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  2 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  7 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 13 files changed, 99 insertions(+), 9 deletions(-)

-- 
2.25.1


