Return-Path: <linux-wireless+bounces-15163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8C9C38A7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 07:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64899280A8D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 06:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF85914F9F9;
	Mon, 11 Nov 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="b84A8ps6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A955B50276
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731307943; cv=none; b=EK6HC4RcsXz3UFhONJqYdxEOPcYmQ/tnx/Cu07EdxSQz8xuyL5O99ai50r5skOpTI4Zhna6Kti5VQPlFcrjkyWeRz5R8XrdVXgFNEgtA6agl/wVkLEwUG9taI+9bsCojflpXg2JvlOmC0h4i2LmDUPlOu7/+fyBCOy4cbGwrrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731307943; c=relaxed/simple;
	bh=Fdtl4xxGmy6BD5KZoIx8BuHh7LLAODMRG2+f1niP7Fs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TG7dF1cwp86Gr6a4W5Lt/cMmoDoCbkpFpYc6KPOpSRba2FexRIsCyoIBfN8WMXX3avxqkJjD/fjJA20YCuqGpejZmmQIUH0tUD1L6dAWwktUStLMS/5KHYRTpYNMUZ4RRJGcODG03OPugr03GttSfbH7Qq7I3VEsngq9W464rQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=b84A8ps6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AB6qHxA51779805, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731307937; bh=Fdtl4xxGmy6BD5KZoIx8BuHh7LLAODMRG2+f1niP7Fs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=b84A8ps642w7cDcgQhMP3eHN+8rHK4afT9Wwzxi0vwvHn7pgtVzmfWXkxOzw6x5Hq
	 hGRXh6lvq/MDi17tLr9EaveSaMiUkYHrkJdc3ayzLDQVW17BA5vAxBCCz6kqQOtnZP
	 gns8gIbpsBW2WqJzhkv+kEq3O2F7O+81NmWBLgxU+Ll3RWqSTCbvBuVmotClBtaTXF
	 KI42IAvgFh9pgQa6RViU1J00zlEO/8B8vCXVer8F/7iJ6NHZWcE6fIMhBm3HX85Rzg
	 t5FPqCVOXsFqD7m5UBNHfVf5shWGiH6i4TgWLBxMpsIV9DkY4bzLXLy8JVTGZr5caK
	 VdVnpe+qoio5g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AB6qHxA51779805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 14:52:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 14:52:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 11 Nov
 2024 14:52:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH 0/3] wifi: rtw89: support dynamic antenna gain (DAG)
Date: Mon, 11 Nov 2024 14:51:29 +0800
Message-ID: <20241111065132.19587-1-pkshih@realtek.com>
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

The DAG is to adjust tranmit power based on platform's antenna gain
allowing higher transmit power under regulatory limits still. Since this
is platform dependency, add a RTAG method to BIOS ACPI.

First patch is to adjust function to share 6GHz subband stuff with
existing SAR feature. Second and third patches are to configure registers
according to values read from BIOS.

Kuan-Chung Chen (3):
  wifi: rtw89: sar: tweak 6GHz SAR subbands span
  wifi: rtw89: introduce dynamic antenna gain feature
  wifi: rtw89: handle different TX power between RF path

 drivers/net/wireless/realtek/rtw89/acpi.c     |  47 ++++
 drivers/net/wireless/realtek/rtw89/acpi.h     |   9 +
 drivers/net/wireless/realtek/rtw89/core.c     |  50 ++++
 drivers/net/wireless/realtek/rtw89/core.h     |  43 +++
 drivers/net/wireless/realtek/rtw89/debug.c    |   4 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 247 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h      |  26 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   2 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  |  46 ++--
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  48 ++--
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   2 +
 drivers/net/wireless/realtek/rtw89/sar.c      |  57 +---
 15 files changed, 486 insertions(+), 101 deletions(-)

-- 
2.25.1


