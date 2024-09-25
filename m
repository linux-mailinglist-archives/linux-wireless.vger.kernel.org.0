Return-Path: <linux-wireless+bounces-13130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2969850AA
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 03:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8DA1C20F7C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 01:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A6EEAE;
	Wed, 25 Sep 2024 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="E/k6Kjta"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE5136672
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228390; cv=none; b=S3W0l+XYj8o+8lBkF31s5SyzLT9nTgBli1spHjV7xTKqVEUXPwvARxX6P5t6V+jCOXC2Yu4B71og/SE3WlAGKRAQAIXl3ZQtbGKH0yBdZNMYCKXxLJJh/46f4daAhOi4qt6ebO773v8aKrNc2UXj0PVY5Y5NYMXjAjr4YZYoQP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228390; c=relaxed/simple;
	bh=L1cG1uk9fjtebP2SjeainGeUD+4uGMthZo1ccv0Xiq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OjcuaUSc8tuPcmAgluCjFn7/sZCuCjoj3lbW3g2uoOQYh8IwYLG8916BuuhFWvlOmujR0bSehlTZ7xpXCqMaR65HNInDqW2UKbHrTiaaGZTZYa2lEnf6VoruVcnNCIjCMvFFqekxU80UKIYl9caJh9Ivcy2cIau6ZENBLwFA5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=E/k6Kjta; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48P1diZdB3834577, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727228384; bh=L1cG1uk9fjtebP2SjeainGeUD+4uGMthZo1ccv0Xiq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=E/k6Kjta9s7F/Xo4OrGbeAJqBYBtdlXTSUePJOlGDr3XQCfHyAXC04ZsCUbvUJAN4
	 jBmOSGLQbINYNvR7CWlV8cs/wjPNsoMMpBis/Yp0OeX0yM610pa2weri7xAw2eB/55
	 UZygURVeZszgZFGkI6kyjXN1aRTeLuzUN7aAQzb1MScBDKb45kAB/8eqWwL3FjOD04
	 Icij+BaJs3RprAEOAJk1yVfGEtM54ZMogNgp8DaHIKf3i7uQnEektePTWhVyaPq7/r
	 X81jvksFzlOJ0gSAqSTMz7TFHj6k6f3ukZLskCOWGW5J6yUba6P6xNQjFqqZd7Zcmf
	 zzmUOdiKzOfwA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48P1diZdB3834577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 09:39:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 09:39:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 25 Sep
 2024 09:39:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: pci: correct PCI PHY EQ to improve compatibility
Date: Wed, 25 Sep 2024 09:38:57 +0800
Message-ID: <20240925013901.9835-1-pkshih@realtek.com>
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

Somehow WiFi card gets lost in certain platforms during stressed test of
reboot/suspend. This patchset is to improve compatibility to avoid failure.

Ping-Ke Shih (4):
  wifi: rtw89: pci: consolidate PCI basic configurations for probe and
    resume
  wifi: rtw89: 8922ae: disable PCI PHY EQ to improve compatibility
  wifi: rtw89: 8852ce: fix gray code conversion for filter out EQ
  wifi: rtw89: 8852ce: set offset K of PCI PHY EQ to manual mode to
    improve compatibility

 drivers/net/wireless/realtek/rtw89/pci.c    | 68 ++++++++++++------
 drivers/net/wireless/realtek/rtw89/pci.h    | 24 +++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 77 +++++++++++++++++++++
 3 files changed, 149 insertions(+), 20 deletions(-)

-- 
2.25.1


