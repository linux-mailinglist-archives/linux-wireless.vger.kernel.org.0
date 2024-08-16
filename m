Return-Path: <linux-wireless+bounces-11552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EB7954912
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 14:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53902831DF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D391F12C54D;
	Fri, 16 Aug 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jgKfLU7N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC02E859
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812395; cv=none; b=gQLQYF1UnipPrl9Q+QCS/pn698h2ih53JW897IHxfVlR6QwnN16YAxG8mQZpsL5BJ6G+E8dqdxznReVBfPGUqXacZm10GtBpreTKi5fezwW3Gv/WBlb1fPoDlHE5pd567LqXXu0fX6L9UJOiMjIB4cihOe6AfqKVa0GJ/I/8IMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812395; c=relaxed/simple;
	bh=a2Pmq+NcG2zfBBd0li5J11WTdIcIrLm4UN+tkt8cf4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fl+rEDXQsxwZ73jBFPVjH273DYWYb/XZwknuumQMYp4knewzffZPLFRELZK17LuGZ29OJBk5F3q3XYwv/Q5si1RokbPYhQXdUqfBQ8t0rnUFsKUSrc3kNe3LOOGJjQISFbXeirq234S0n3hHeidW7EV8R+ApESp7dQ7nTIU5mVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jgKfLU7N; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47GCkSAz91027876, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723812389; bh=a2Pmq+NcG2zfBBd0li5J11WTdIcIrLm4UN+tkt8cf4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=jgKfLU7NyxfBjPeN3z2WGz9Hz7RSTang96IBnJIzuq5gzhb+m0PymudaL4qA4OlcE
	 4hbj7dh+z4nOiLAULYaXdlhPA6HbnCTky/D3cwakWxumfPy6EwNYhRRmGNxlU7EerY
	 dXfesv11nc03a5fnvF+0Qj9fYn6nQ+DjadADlc2Qnci19PafS6ExQ+qPzqbAtm/6Yd
	 hoMl84fQWU7ixhsFlIdNKTccY/lfTHEgXYYSn9kgOvE1v2m2TZ4QVa3Vz6P5n96Kov
	 UOsYxl0MIAbW1uZVxAvQyF64F5Neo/fwdFs042Sc15n40IQbS3ll5ar85DNc/44zB5
	 a1O651S4qIM2g==
Received: from mail.realtek.com (smtpsrv.realtek.com[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47GCkSAz91027876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 20:46:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 20:46:29 +0800
Received: from [127.0.1.1] (172.16.21.174) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 Aug
 2024 20:46:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 0/4] wifi: rtw89: coex: add BT-coexistence support of RTL8852BT
Date: Fri, 16 Aug 2024 20:46:10 +0800
Message-ID: <20240816124614.25592-1-pkshih@realtek.com>
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

The first public released firmware for RTL8852BT is 0.29.90.0, and the
BT-coexistence adds new version format 7 mainly. This patchset defines the
version numbers of BT-coexistence report and implements the struct and
parsers accordingly.

Ching-Te Ku (4):
  wifi: rtw89: coex: Update report version of Wi-Fi firmware 0.29.90.0
    for RTL8852BT
  wifi: rtw89: coex: Update Wi-Fi role info version 7
  wifi: rtw89: coex: Bluetooth hopping map for Wi-Fi role version 7
  wifi: rtw89: coex: Add new Wi-Fi role format condition for function
    using

 drivers/net/wireless/realtek/rtw89/coex.c | 508 ++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h |  50 +++
 drivers/net/wireless/realtek/rtw89/fw.c   |  49 ++-
 drivers/net/wireless/realtek/rtw89/fw.h   |  27 +-
 4 files changed, 590 insertions(+), 44 deletions(-)

-- 
2.25.1


