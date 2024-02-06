Return-Path: <linux-wireless+bounces-3187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738084ACA4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 04:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080351F243C4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 03:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B45473175;
	Tue,  6 Feb 2024 03:07:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E1482FC
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188833; cv=none; b=Ra7A76oDeoFG8LqC+I3YiTRiIQfM7g9Z0jJFHdA2jOIVVMcCraSfkGwGsv5Pvj8lK7FgR6rcfAhuikAwdD5cnbJtNvYAVkqIr2wZMLDeB4xNfQbfN+MOb9/FDnrWH5SmtfoK0FaM9Qx1pbbjU0SBiCPIqmNOMAhyKvp9WYEva4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188833; c=relaxed/simple;
	bh=VWIIeK3gNnP+X41S9FKn6LCXI/BYLYRvpj9a+XAxHBo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WqwLaUk8aJtSepBE6HPKlOYlqLYL3ZHKsHaMQZbZCgDak9p/SlCtzOjlcnG9CLPdvdP+En42yUjqHSHy4IDBzCDxof4fZaVe8LArnRtoigNNkoEPzB9HhITUwyKlyNX2dgavU42k0bKkRQdmjFQYg04GLpWEsweSUId1+YnaVW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 416371JZ03532234, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 416371JZ03532234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 11:07:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 6 Feb 2024 11:07:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 6 Feb
 2024 11:07:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/6] wifi: rtw89: adjust channel context stuffs for MCC and MLO
Date: Tue, 6 Feb 2024 11:06:18 +0800
Message-ID: <20240206030624.23382-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

We are going to add MCC for WiFi 7 chips that uses similar flow like
WiFi 6 chips but new firmware H2C commands and events are added, because
these new firmware interfaces will support MCC over MLO as well. Before
that, we are adjusting the channel context stuffs by this patchset. Since
we still not support MLO yet, mostly we are adjusting to support legacy MCC.

Zong-Zhe Yang (6):
  wifi: rtw89: drop TIMING_BEACON_ONLY and sync beacon TSF by self
  wifi: rtw89: chan: add sub-entity swap function to cover replacing
  wifi: rtw89: chan: tweak bitmap recalc ahead before MLO
  wifi: rtw89: chan: tweak weight recalc ahead before MLO
  wifi: rtw89: chan: move handling from add/remove to assign/unassign
    for MLO
  wifi: rtw89: chan: MCC take reconfig into account

 drivers/net/wireless/realtek/rtw89/chan.c     | 204 ++++++++++++------
 drivers/net/wireless/realtek/rtw89/chan.h     |   5 +
 drivers/net/wireless/realtek/rtw89/core.c     |  23 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   9 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   1 +
 5 files changed, 174 insertions(+), 68 deletions(-)

-- 
2.25.1


