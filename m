Return-Path: <linux-wireless+bounces-19469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA82A45913
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 09:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56A07A9694
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 08:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AA617F7;
	Wed, 26 Feb 2025 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JqvShhxk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B81DED6D
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560056; cv=none; b=a9OZwHTzzYIts5TcZYbEA/R/NYtpwENgWgbJn2jJHhEnsL9TVBINfH3zIaN8iH9go92QFP3+rGn7mLoOqCxSnk/JJTcu0D8NBTpOw514jsXxK2hPunlKXISb0Lxkn8wtcC2j1rt/ANZdhY2iY+HfJA6nHaT3iVIKMppSS1lwJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560056; c=relaxed/simple;
	bh=IQOolM7nZUyDgaDwcmSIzR1+IDrx80swiwXqh7F5J/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PcZ0D3UHgle7iQb+MTBncu0IkKQjBlKV/FpP7ZPqTJelc+0ADRYXu6TwRBtlR09QFxLfSXNRKqpIjIoMVwScjZ/Caz5jLx1uZWNMRD2yKVyVLQh4inojer0xkjnqRATyY4q95V/PbK0a7F3m3J7DgjcuQ0/oiiuGhpv/QWB34sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JqvShhxk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51Q8sAO313439539, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740560050; bh=IQOolM7nZUyDgaDwcmSIzR1+IDrx80swiwXqh7F5J/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=JqvShhxkWdnpX2ocqep5R5dWKCAg7ty7hTquxW6UBQtHkePVrsHs8Bb/Y+REDos4I
	 mH5M/zwnGCZ/x7eIYUm5XF5tMyQYiyVOuwDbFRFaN5dshQvgirBNRA0OP0g0Yrfq8c
	 aH3m7qgyDrLcAmEmie8cxbxvGAr3LNYiUgMhF2Gk2xuZhC+HhbGRcuJovt03Ohq/JZ
	 5VPUMk7crl6RcSMdkvlyCJxCP7ih5oMjGLoGGcQrlWc8jkHHasqu6O2+kGj9zWv/bL
	 DKaUhdQaDEa4z7uAKU8YYC9vbygN/ChLwG9ewZbg1p18mv2LZ32/bLhjSPpJu/Oo2X
	 3H4IQvWIva8lQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51Q8sAO313439539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 16:54:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Feb 2025 16:54:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Feb
 2025 16:54:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>
Subject: [PATCH rtw-next 0/3] wifi: rtw89: fw: update role_maintain H2C command
Date: Wed, 26 Feb 2025 16:53:12 +0800
Message-ID: <20250226085315.263982-1-pkshih@realtek.com>
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

The role_maintain H2C command is to tell firmware the role of a mac_id,
and two additional fields are added by this patchset to support coming
MLO.

The last patch is to correct message format by the way.


Ping-Ke Shih (1):
  wifi: rtw89: fw: correct debug message format in
    rtw89_build_txpwr_trk_tbl_from_elm()

Po-Hao Huang (2):
  wifi: rtw89: fw: use struct to fill role_maintain H2C command
  wifi: rtw89: fw: update role_maintain H2C command for roles operating
    on band 1

 drivers/net/wireless/realtek/rtw89/fw.c | 27 +++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/fw.h | 28 +++++++++----------------
 2 files changed, 27 insertions(+), 28 deletions(-)

-- 
2.25.1


