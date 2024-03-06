Return-Path: <linux-wireless+bounces-4406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F272872DA3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 04:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D461C21B55
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 03:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D7479E4;
	Wed,  6 Mar 2024 03:47:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F3E542
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 03:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696833; cv=none; b=OFgKFRBf3x5dDZ4DgI7s1GTd2IOX3gvSpW3nFgS6hqjc2HTHbE0gjK30MsRHIRrAN2B7sBei3qiCApvQwp3Jo+JKOq+TgD1WF0YSjkqbaCMm4TUlS3+aY915aqZ0mpGtWkmi/yibfYhZaWie7F56rI9owLqHpQ+cNS/jhDeVXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696833; c=relaxed/simple;
	bh=fVcs8464nzUib9oKvD/4P4Jz0BJVXkG5v7VRldCLcTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hAXY6oGJkodirZC1unfDlvsAX4env3K8pqFXci8h+I68rns/GYpRQjkOooL6PsqYLQF+MAwy657nMZAeG6DtVxx5B/6ORuu8BPD7kKuDRGyoYs7hnAM98wg8j0pjBhHvrha7QkPerwEEY5IgbCI/d8KeYiQmUKWRE6Lj9mxg/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4263kvShB482434, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4263kvShB482434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 11:46:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 11:46:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 11:46:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: add BT-coexistence materials for 8922A and enable 8922AE
Date: Wed, 6 Mar 2024 11:45:52 +0800
Message-ID: <20240306034558.19648-1-pkshih@realtek.com>
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

The more BT-coexistence materials are added by this patchset to have
initial basic functions, and WiFi features of STA, AP and monitor modes
are also ready now, so we can enable 8922AE.

Since new files are added to Kconfig/Makefile, apply checkers of sparse
and smatch to this patchset, and no any error/warning is reported.

Ching-Te Ku (5):
  wifi: rtw89: coex: Add WiFi role info format version 8
  wifi: rtw89: coex: Add antenna setting function for RTL8922A
  wifi: rtw89: coex: Add TDMA version 7
  wifi: rtw89: coex: Add TDMA slot parameter setting version 7
  wifi: rtw89: 8922a: update chip parameter for coex

Ping-Ke Shih (1):
  wifi: rtw89: 8922a: add 8922ae to Makefile and Kconfig

 drivers/net/wireless/realtek/rtw89/Kconfig    |  15 +
 drivers/net/wireless/realtek/rtw89/Makefile   |  12 +-
 drivers/net/wireless/realtek/rtw89/coex.c     | 962 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/coex.h     |  72 ++
 drivers/net/wireless/realtek/rtw89/core.h     | 108 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  42 +
 drivers/net/wireless/realtek/rtw89/fw.h       |  27 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 156 ++-
 8 files changed, 1283 insertions(+), 111 deletions(-)

-- 
2.25.1


