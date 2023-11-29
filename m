Return-Path: <linux-wireless+bounces-190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1177FCFA4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 08:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074EA1C2095D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 07:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68A1101C9;
	Wed, 29 Nov 2023 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB694
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 23:02:06 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AT71pyZ62598086, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AT71pyZ62598086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 15:01:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Nov 2023 15:01:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 29 Nov
 2023 15:01:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: improve misbehavior in concurrent mode
Date: Wed, 29 Nov 2023 15:00:42 +0800
Message-ID: <20231129070046.18443-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

In concurrent mode STA + P2P or STA + AP, there are many operating
combinations, and we don't handle some cases well at initial version, so
update this patchset to correct them.

Chih-Kang Chang (2):
  wifi: rtw89: refine remain on channel flow to improve P2P connection
  wifi: rtw89: fix misbehavior of TX beacon in concurrent mode

Po-Hao Huang (2):
  wifi: rtw89: fix not entering PS mode after AP stops
  wifi: rtw89: Refine active scan behavior in 6 GHz

 drivers/net/wireless/realtek/rtw89/core.c     |   6 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  19 +++-
 drivers/net/wireless/realtek/rtw89/mac.c      | 100 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  21 +++-
 drivers/net/wireless/realtek/rtw89/ps.h       |   4 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  17 +++
 7 files changed, 150 insertions(+), 18 deletions(-)

-- 
2.25.1


