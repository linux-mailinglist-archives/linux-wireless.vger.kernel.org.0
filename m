Return-Path: <linux-wireless+bounces-28522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D36C302F6
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 10:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8132188E7EC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C287B3112D0;
	Tue,  4 Nov 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jXape3lH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7937B61FFE
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247451; cv=none; b=t1ybOeJnSTfK7wSJBnyiJuJe23yTZ3gp7ii3czP3RJzblyUdSmOEKyV0LnslfE6zRNmXZjF+iJWcoiHBAGBTILlVTpRI3sbkmhkZIcfOEd3nrRML7jWXasedtvFcJsT6RF5ud4oIsjPUVMs1JNrdlXO6cgL4tG+KX/6aRH+zpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247451; c=relaxed/simple;
	bh=FHwhUZ9YP0Gp8SInxYzaX2FGiyM1f9uej1Xl59B1Xlo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GheN22WC9t1B1hHSqpFHpHB8i+gJVTFOXQGQ0Dp9iBRc1MbE/nOBaaudMAU3qRy4q36EUhTK3vZxKAXXMVyYBsZFNuE68dDJu3BxirchvZNL9/c7QIDuxtgvWmKgS5SFDuEICx0xbyGuUv2VxqEnwoY/doPL00haXVD08i/hRPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jXape3lH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A49AiBT23073288, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762247444; bh=Nggm0qyPZl9D8HrQpJ53XrHyDs+VqqsrGC+zsDmCHWU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=jXape3lHAa2xP02TR3Kye5Na2k+Xl2LkfIHBgdVCF6LI3BrHh6fL+qXG/2xTQYmYD
	 4BS2VQbKM3hoo+c8BeC0XyhC0RuevMDAi8Ywz2rm4ZSaqZCfKi2XEnpzAIHDYp27zH
	 8wcioM3EYESfwq2TrJJbws/KphiReJMUJkRscjuYqQHxn/42VanjnChOVWb8jMBF7+
	 MVYhphhumWT/vLG1DLC6pO9LunMQkB6CzrvnoL7xTP1/DLzGG/v8nROAV0OcfqzdKe
	 2v5T/NL6WuYp8WjQoNLRl+eRPZdqRBOC3PwSxVDYltdsOWg/I17538kqIo1Qhn+D2U
	 kNsVNx3iESpbw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A49AiBT23073288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 17:10:44 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 17:10:44 +0800
Received: from [127.0.1.1] (172.21.146.58) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 4 Nov 2025 17:10:44 +0800
From: <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 0/8] wifi: rtw89: update rate/bw/GI for injection, and add diagnosis to debugfs
Date: Tue, 4 Nov 2025 17:14:05 +0800
Message-ID: <1762247653-26864-1-git-send-email-pkshih@realtek.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ping-Ke Shih <pkshih@realtek.com>

First three patches are to add diagnosis to debugfs. This feature is to
provide hints to see if MAC hardware went wrong to assist debugging quickly.

Patches 6-8 are related to monitor mode. First is to support injection with
rate/bw/GI. Second is to do calibration on the channel running monitor mode
to have better receiving performance. Third is to configure RX antenna, so
we can test RX performance individually.

Others are patch 4 which implements extension of thermal value programmed
in efuse, and patch 5 fixes Coverity warnings.

Kuan-Chung Chen (1):
  wifi: rtw89: phy: fix out-of-bounds access in
    rtw89_phy_read_txpwr_limit()

Ping-Ke Shih (7):
  wifi: rtw89: pci: add to read PCI configuration space from common code
  wifi: rtw89: fw: parse firmware element of DIAG_MAC
  wifi: rtw89: debug: add parser to diagnose along DIAG_MAC fw element
  wifi: rtw89: 8852c: add compensation of thermal value from efuse
    calibration
  wifi: rtw89: consider data rate/bandwidth/GI for injected packets
  wifi: rtw89: do RF calibration once setting channel when running pure
    monitor mode
  wifi: rtw89: configure RX antenna if chips can support

 drivers/net/wireless/realtek/rtw89/core.c     |  85 +++++
 drivers/net/wireless/realtek/rtw89/core.h     |  17 +
 drivers/net/wireless/realtek/rtw89/debug.c    | 299 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       |  15 +
 drivers/net/wireless/realtek/rtw89/fw.h       |   6 +
 drivers/net/wireless/realtek/rtw89/mac.h      |   2 -
 drivers/net/wireless/realtek/rtw89/mac80211.c |   9 +
 drivers/net/wireless/realtek/rtw89/pci.c      |  16 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  20 ++
 .../wireless/realtek/rtw89/rtw8852b_common.c  |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  41 ++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  12 +-
 12 files changed, 517 insertions(+), 11 deletions(-)

-- 
2.25.1


