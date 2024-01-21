Return-Path: <linux-wireless+bounces-2293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F978354CD
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 08:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4194B23827
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jan 2024 07:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F3E3613A;
	Sun, 21 Jan 2024 07:19:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E89394
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jan 2024 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705821548; cv=none; b=rUl7dPl73cl/s/7g6pWa3Fucv0zdeJNz7C5fhTsCWHNF+xhl58quP+ZTv3mQIwpwikOowinw+SCEPqbZOlH6YZL3TYKa4/4QNSrk0Nqkrcw3f9OyXHguiSqklFRrz4JJ88H8j7BAuePqkJX42wdYelSUH5CKXIH/a06a6eVv0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705821548; c=relaxed/simple;
	bh=NuDruUuJ+6epCQaTUhNkJD5ZsZpFo3qnYKcGFQOFcks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E3C3CJhDieYDrqDvkl7QNaVQEMejwhADDM6NzZlu+2p+RqBNPcVpM4h9ajDbvF2Lw36rDpHBBgYCN3eIbbNYHI5I/NeGKaVtYnwFDo3pV0tpZwRSWGcp8y+EpVLfd0xdDMRJUPhhLetMfRXFBPzPlbB0QRmLCopF66J+q/dpty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40L7IoubE3102111, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40L7IoubE3102111
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Jan 2024 15:18:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sun, 21 Jan 2024 15:18:50 +0800
Received: from [127.0.1.1] (172.16.17.107) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 21 Jan
 2024 15:18:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: pci: refine PCI SER, RX tag and RX DMA buffer size
Date: Sun, 21 Jan 2024 15:18:22 +0800
Message-ID: <20240121071826.10159-1-pkshih@realtek.com>
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

Some PCI refinements for WiFi 7 chips. First two patches are to refine SER
timer and IMR to have expected SER behavior.

RX tag is a sequence number belong to a RX DMA data, and WiFi 7 chips need
to validate this tag before reading DMA content. This happens rarely, and
no obvious impact with throughput.

The last patch is to enlarge RX buffer size to plus RX descriptor size to
receive a 11454-byte RX packet. Though we still can receive this kind of
packet with smaller buffer size, use suitable size can get better
performance.

Ping-Ke Shih (3):
  wifi: rtw89: pci: update SER timer unit and timeout time
  wifi: rtw89: pci: validate RX tag for RXQ and RPQ
  wifi: rtw89: pci: enlarge RX DMA buffer to consider size of RX
    descriptor

Zong-Zhe Yang (1):
  wifi: rtw89: pci: interrupt v2 refine IMR for SER

 drivers/net/wireless/realtek/rtw89/pci.c      | 65 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h      |  6 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c   |  5 ++
 drivers/net/wireless/realtek/rtw89/reg.h      |  3 +
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  2 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 9 files changed, 74 insertions(+), 11 deletions(-)

-- 
2.25.1


