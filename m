Return-Path: <linux-wireless+bounces-17175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E48A05059
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 03:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09D27A0673
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 02:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E470719ADA4;
	Wed,  8 Jan 2025 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fz270TJh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F14216F288
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302215; cv=none; b=NL0K7KeT++tWqx7vRJ4zyfSFnHqBlXYc47H803PCJLxEMTLl6hpWcFoB6WNBMSsX0fYwHVeHk8iECcvW+MHHtcv4ILomSj53+Ag4EtXExtMIOGO6Y0J6iaQ6JA0Y3xfLr9bj14h5AIHJk/fL9Q4ESSJb8jWDD5pR7RnkRZj/vKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302215; c=relaxed/simple;
	bh=hgpHzSjhC+CcGFqWaMaup0lXRGCnvdSVndKxxmGssdc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ShEzjVhltYOJziZYAAzlYkklUOGaP2e9IA9sTwCJrulJX9KgnwBpZ3IT0KUaWle/spEufhvl4Hjtd1QCE2Ea/HetkccRpfmln/i248KsLbPfZfKPoOc6JG0GX34DGoyXjjcSVvfyowJkD2ohmD7QzDBrqKBF40uxlfHD65RX1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fz270TJh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5082A83f8619981, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736302209; bh=hgpHzSjhC+CcGFqWaMaup0lXRGCnvdSVndKxxmGssdc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=fz270TJhwlNje9px2akxRQAarfClD7DZTXUuspUPJ57mbtjbn2vg16mY0IWuqO4Xg
	 9USjNk2hwBNQ1NliCH6eGoHsB6lwBj+/atFTReXUBMFA7Azqq/h3ketLhbWt7jUO8v
	 pHaUzJna5h9sYFRSlnbPcFDl0EYe+Zxp4vw8PkhrUPJrTMKIPEG4u0VFdu93+TcYso
	 G9Gi7pmo9Ct4bWyUurNqaahPxpsrkG926H5XxjAWugUt0k0XZDEN+6L2luky2yTUjm
	 jNP9dDyR0yfXYNU9h7KtQStSMJWntbCSY+lD0Y14b2xDF4T6pvtk6HhRT7As7uyIJ2
	 w1zNdyI9BkDOA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5082A83f8619981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 8 Jan 2025 10:10:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 8 Jan 2025 10:10:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 8 Jan
 2025 10:10:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/2] wifi: rtw89: support RTL8922AE-VS
Date: Wed, 8 Jan 2025 10:09:53 +0800
Message-ID: <20250108020955.14668-1-pkshih@realtek.com>
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

RTL8922AE-VS is a variant of RTL8922AE. They are very similar and can
share almost all code except RTL8922AE-VS is only up to MCS 11.
Add this chip accordingly.

v2:
 - correct version that firmware can support to read hardware capabilities
   part1 in patch 1/2.

Ping-Ke Shih (2):
  wifi: rtw89: read hardware capabilities part 1 via firmware command
  wifi: rtw89: 8922ae: add variant info to support RTL8922AE-VS

 drivers/net/wireless/realtek/rtw89/Kconfig    |  6 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 18 +++-
 drivers/net/wireless/realtek/rtw89/core.h     | 13 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 26 +++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 16 ++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 94 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/pci.c      |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 10 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |  4 +
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  6 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.h |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    | 16 +++-
 17 files changed, 196 insertions(+), 21 deletions(-)

-- 
2.25.1


