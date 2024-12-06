Return-Path: <linux-wireless+bounces-15948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEE69E670A
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 06:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC4F282CA1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 05:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA60198E71;
	Fri,  6 Dec 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="T6pA4Q8I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F3198840
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464662; cv=none; b=eQowSDlxYrJMzeO3hnM4J+aMyM9sm8FK4YOXbzaX41mxjscqwaxOiySFOT/HrKIJ3mnfL6GysWsCLFycv39THr6A8WQtMBV3TQ1uPoWEr20MSDX5PXZhjmeAjdt3w+f8LV0E/HCJ2h8KGIoVkIx/Ht8t6qdFroOUJDYz4XVux7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464662; c=relaxed/simple;
	bh=drcjG3VUOlyH92NIv5yZQmc3bGrkVhl5+JgA2qxxZWU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hM7vdFlBB3fCvO5Qz2WIUAYui/LCmPVx0CRhCDDDfKYdpG32xt4QfETL+VRaGqP0/9xXtqFhE0et8E1Qv2nrOeV/INboO+gPvOzchCU3yTn8ajI3CphoVM4KcpmGxm+3dYUu4EVlOv8s9lbkB7bYKgu3jVhk3vq23fiG00VpT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=T6pA4Q8I; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B65va0N34126867, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733464656; bh=drcjG3VUOlyH92NIv5yZQmc3bGrkVhl5+JgA2qxxZWU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=T6pA4Q8IsRLm30Jd/f/trjaiy03mgLy3Zmu6gW2O/Z2GDhbsXUu7XhgsJCIGC8B/L
	 Xmy4cSiEC0aeI5svK9Re7EMxq4Jp2cj6vJ5mJRSYjH9eY5lStMg0ziTrWE1v/8aRHB
	 P/bxxv9/z0OJJ5WVAPGaFScMM+PwQDiiFgJXelD2Zb6HSHaFeHwmWZaQnn2pU/gQRc
	 QfCTHpe8Nd6aFiIalyZGLLZWS+IFvgTZv8CXU1jGgdbAcbiP9/39uZmXG4hWI0Caj4
	 RwkHygR/G+i7Z9wPwjM4RoBUiS3er7CCVEkJfhE1d9j4HT9sIOgu/ZR1vieKR0XQgl
	 UuU0x16OMZ/2w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B65va0N34126867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Dec 2024 13:57:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 13:57:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Dec
 2024 13:57:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 0/7] wifi: rtw89: refactor PS flow, rate selection rule and something others
Date: Fri, 6 Dec 2024 13:57:09 +0800
Message-ID: <20241206055716.18598-1-pkshih@realtek.com>
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

First three patches are to refactor PS flow to fit coming MLO PS mode, and
to send channel data to firmware for PS mode.

Patches 4 ~ 5 are to refine TX rate selection rule for HE GI-LTF. This can
improve throughput.

Patch 6 is to regulatory rule from internal database.

The last patch is to a H2C command format for coming firmware.

This patchset contains several small sets, but each of them doesn't have
functional dependency.

Chih-Kang Chang (1):
  wifi: rtw89: 8922a: update format of RFK pre-notify H2C command v2

Eric Huang (1):
  wifi: rtw89: ps: update data for firmware and settings for hardware
    before/after PS

Kuan-Chung Chen (2):
  wifi: rtw89: disable firmware training HE GI and LTF
  wifi: rtw89: 8852c: disable ER SU when 4x HE-LTF and 0.8 GI capability
    differ

Ping-Ke Shih (2):
  wifi: rtw89: ps: refactor PS flow to support MLO
  wifi: rtw89: ps: refactor channel info to firmware before entering PS

Zong-Zhe Yang (1):
  wifi: rtw89: regd: update regulatory map to R68-R51

 drivers/net/wireless/realtek/rtw89/core.c |  52 ++++----
 drivers/net/wireless/realtek/rtw89/core.h |  23 ++++
 drivers/net/wireless/realtek/rtw89/fw.c   | 150 +++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h   |  28 +++-
 drivers/net/wireless/realtek/rtw89/phy.c  |  30 +++--
 drivers/net/wireless/realtek/rtw89/phy.h  |   1 +
 drivers/net/wireless/realtek/rtw89/ps.c   |  42 +++---
 drivers/net/wireless/realtek/rtw89/ps.h   |   4 +-
 drivers/net/wireless/realtek/rtw89/regd.c |  57 ++++----
 drivers/net/wireless/realtek/rtw89/wow.c  |   6 +-
 10 files changed, 292 insertions(+), 101 deletions(-)

-- 
2.25.1


