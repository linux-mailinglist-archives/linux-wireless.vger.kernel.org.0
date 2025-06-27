Return-Path: <linux-wireless+bounces-24596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CABAEAD90
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 05:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E776562BDC
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 03:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC919E83C;
	Fri, 27 Jun 2025 03:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gSYr99aT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2EE199FD0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750996367; cv=none; b=QOXMeywgT2KyL4UWe1DPQiMfhXD8Ke4BunKKLqPNov/jyYxAJ7IbkTqgTM+hf6Wyzh8qGVb6Q5wisBamcV3s8cgtjja3wBSOmaBXjzAzz5r2wul6xajNeNwYr2VjDes5J9IdMpUEdjeBhdqXJfEhFU41oQ0fIaAtxjNZ//1Zzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750996367; c=relaxed/simple;
	bh=NguE9ozbNMzn2mn6qH0Q7aju2bHOIU0/p9LWEANyA88=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PaKt1tLVlE8i/NoSau4BxjPqov3x9Cp8p353sRJpAOJKwEqeoEOsjOOo14tw6iZKLR8m3e7CnM54AgaEVXGDRzaA0AQBTkoFJMnESNVbhgETVpMISJdYvdhhvK0XFYy+oIatHj4SqZXvXUe/Eb/TlhAopR6+xjSHqeJ4a/bUiCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gSYr99aT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55R3qfW832041712, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750996361; bh=CFtoHLTAOI28eafT37WHwFRRdVFlT1stZxEM1Lmq9Zk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=gSYr99aTbov2F7FWCm9KGJVtDBOHjNFcnzpK0GbSPHikp3wpHG8lDK9nXDw3W7hen
	 fFm/v4cwtwKLcMcMLIpMt7TfPqSg/6tbO08XL5nXIoDCpbLPBw/yxmRxXwPwDFGG0I
	 6g6seGhkH/q1nbMrECcoHQ2AyjfdiikxLRTuLr3BRu12PJo+1YyTSPP0rJEWQdBbTJ
	 7aka4uiPuDaLAxwAFJNvGfAzQYBv1HNcwN94ihZZMweqTvopC3wqm50xB07toQ+BWz
	 4jApg43Zc0XnGp5G8OyTD9KMIZHj9cppXC7yPIYyjeNlOd2ZCQ7xi3wWpgXQvH6nPn
	 ucPNmqEi4Hguw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55R3qfW832041712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 11:52:41 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Jun 2025 11:52:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 27 Jun
 2025 11:52:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 0/6] wifi: rtw89: 8851b: update RF calibration
Date: Fri, 27 Jun 2025 11:51:55 +0800
Message-ID: <20250627035201.16416-1-pkshih@realtek.com>
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
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Certain hardware could be not good enough with old RF calibration. Update
the calibration to align performance with normal hardware.

Ping-Ke Shih (6):
  wifi: rtw89: 8851b: rfk: extend DPK path_ok type to u8
  wifi: rtw89: 8851b: set ADC bandwidth select according to calibration
    value
  wifi: rtw89: 8851b: adjust ADC setting for RF calibration
  wifi: rtw89: 8851b: update NCTL 0xB
  wifi: rtw89: 8851b: rfk: update DPK to 0x11
  wifi: rtw89: 8851b: rfk: update IQK to 0x14

 drivers/net/wireless/realtek/rtw89/core.h     |   3 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  53 +-
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 156 +++++-
 .../realtek/rtw89/rtw8851b_rfk_table.c        |  77 +--
 .../realtek/rtw89/rtw8851b_rfk_table.h        |   2 +-
 .../wireless/realtek/rtw89/rtw8851b_table.c   | 501 +++++++++---------
 7 files changed, 464 insertions(+), 331 deletions(-)

-- 
2.25.1


