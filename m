Return-Path: <linux-wireless+bounces-22089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9A8A9D671
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 01:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F83163DBD
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 23:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2572296D34;
	Fri, 25 Apr 2025 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="pdZoo/xz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3F2973D8;
	Fri, 25 Apr 2025 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745625231; cv=none; b=Qr+m4XasQjcJzopmS9om/jkMKNpKgZV/BkCIlDZoyBNoVGVHgSJpA5/MY4vpifTJgrzIztiyb4TyFTiVfKTd3ejokOfHBbStWYd4xm0SxlckuCMX0TNhUEtwIp6Wyi9/FzmnHlFunnv3n65paHSoRrrRtmV0a2FAZLNWaAeyaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745625231; c=relaxed/simple;
	bh=+l2uQNfjp3eCNG7iT//Zj58hpXvF2vR+B6wzxlvgWzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEakMCyuJtXWzoh2mS2unPwBllV0aXjxS/4khvHYwKIIf0l9fptyyllbiFfO2Ar3C3ppJiDB49h0QRl6/FzFi55OVuYNDYIO8MHDJ1XoL04/F1+rLGB05Whj+l0JzLrNjrVDtj9vNM/fzEIao2jwBF5IgWbOanJdXQ5b4zHbVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=pdZoo/xz; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=i6e8U/6o6yPo5ap4E0pDGqpDNseeuKYaR2lvyWCF0vQ=; b=pdZoo/xzRudg19Pz
	lt+KnnCXG9/2zQwvKkwp7FLhWQZJRAixt9qFD7E6HPYrV/gKpqmTL8NHMu76mn+X1m4WaBBYQidN/
	ZHSRCUtml+ROfeGGqL5MGx50yvlAP27Z+IPX68KmxnWdpsvUvYIjSY7diR+ApYYuX7K5241LXOzfh
	aIo5h/8mU3s/Y9T3iQ/+OxjO8GgvJctWEq9uhX0pp4C7/dU9lTe/ikzt8cbOQO01rBtCzDN2viOF2
	IwsZ7m6MyWUHbcNHUQvlNK4rwAFI/WT6a1uUCgGM6zhlY4kpGXAQMmlBTBNseZQo5df0uY11QHiVG
	MCaS7QPN2TM3t6Stzg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u8SrU-00Dznj-2S;
	Fri, 25 Apr 2025 23:53:40 +0000
From: linux@treblig.org
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/3] rtlwifi deadcoding
Date: Sat, 26 Apr 2025 00:53:37 +0100
Message-ID: <20250425235340.288340-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  A bunch of small deadcode cleanups for unused functions, many
of which are empty anyway.

  However, one odd thing I noticed while preparing these is
rtl8188ee_bt_hw_init() in
drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
isn't called - lots of the other models have similarly
named functions that are called; is that a bug just
forgetting to call it?

Dave

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (3):
  wifi: rtlwifi: Remove unused rtl_usb_{resume|suspend}
  wifi: rtlwifi: Remove uncalled stub rtl*_phy_ap_calibrate
  wifi: rtlwifi: Remove unused rtl_bb_delay()

 drivers/net/wireless/realtek/rtlwifi/core.c          | 11 -----------
 drivers/net/wireless/realtek/rtlwifi/core.h          |  1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c |  5 -----
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.h |  1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c |  5 -----
 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h |  1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c |  4 ----
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.h |  1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c |  4 ----
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.h |  1 -
 drivers/net/wireless/realtek/rtlwifi/usb.c           | 12 ------------
 drivers/net/wireless/realtek/rtlwifi/usb.h           |  2 --
 12 files changed, 48 deletions(-)

-- 
2.49.0


