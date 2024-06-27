Return-Path: <linux-wireless+bounces-9630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E78D919D9F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 04:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1062848C5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 02:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB2712E71;
	Thu, 27 Jun 2024 02:59:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE21CDDA0
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457161; cv=none; b=N3qbbTihBZ8GjuTmJAAspYCWk8jyptVcvaLSungaegbeC1WyXBIU400KtCWPtjCQT9eA77t52sIZpFw+7EpKpWaRZaPDF7Qm5rqprLg3sPYR/3pZuLumtYvWzrMDQQTrKg+GSa6ZVaKTyFpOvbqskiHwTqmoZ4p1TCVkKult33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457161; c=relaxed/simple;
	bh=GWjZXRbB+R87pu86UmMWRr2ne9xjF/LYlr29jtYejBU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kw6ZJQK4j+sT4mdzS1o1SVvCGyD1rsx57iB56VscAK83FgKPhjQT0ROBzvtCHjQPpz1/IEIBfa6wUBw2xsX+WHTlW/ubQWAaC+6oHxCJQGCXHP1joGY1rz2odEIpd92YKAcOAryL2gXyfJLOBikzToFPFG0e/18wmNHOpfbTG6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45R2xGYt92591110, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45R2xGYt92591110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 10:59:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 10:59:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Jun
 2024 10:59:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/4] wifi: rtw89: 8852bt: add RF calibrations IQK, RX DCK, DACK and RCK
Date: Thu, 27 Jun 2024 10:58:45 +0800
Message-ID: <20240627025849.25198-1-pkshih@realtek.com>
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

Complete RF calibrations for 8852BT. The most important one is IQK that
can hugely improve performance, and others are minor but necessary.

Ping-Ke Shih (4):
  wifi: rtw89: 8852bt: rfk: add IQK
  wifi: rtw89: 8852bt: rfk: add RX DCK
  wifi: rtw89: 8852bt: rfk: add DACK
  wifi: rtw89: 8852bt: rfk: add RCK

 drivers/net/wireless/realtek/rtw89/reg.h      |   16 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 1783 +++++++++++++++--
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |    4 +
 3 files changed, 1651 insertions(+), 152 deletions(-)

-- 
2.25.1


