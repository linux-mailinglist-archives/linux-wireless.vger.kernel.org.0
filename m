Return-Path: <linux-wireless+bounces-15127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFA69C169A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 07:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F83C1C20FBD
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 06:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70AD1BD9D8;
	Fri,  8 Nov 2024 06:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GLxeCJz1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218A52BB15
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731048763; cv=none; b=hHnAcbmELrHaIecP+zgz90MSyrdGQm61s6QX1iuBdTyMQSE34eqmAiB9StuQ9/QWJzCOaQ6Wsz0NNwmt2ShwNppIeCWfWsYHOVV0mfhsU9NW9a0z+QF588lqPckak70Sa2+cvpwXfYJ/Ac83g1RZYHSM2C+qzRoBSabSL+Kk0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731048763; c=relaxed/simple;
	bh=MbHzrPDlKUoQCIlKr9iv1mNHYBlS9S5PhFoVmuBgoo4=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date; b=VzylxAQcWMGp5rCV3LPurRGNZLdbyGTOf/KvzHLIlwLX6m44s0ubz0GjuZfh/Ztyxjnsj+UBNd4ZyRYbTWEILtYn+Q/Dqx69QaQOFsPkhQo97EpbctyNwlTaRCJT5Gol3ZBQ6knNna9s30so8EWXbMv4+0siECSlQ/oilzkF/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GLxeCJz1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A86qWB011542025, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731048753; bh=MbHzrPDlKUoQCIlKr9iv1mNHYBlS9S5PhFoVmuBgoo4=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=GLxeCJz1RSC+yttmx3+2JXucPpyM/grhhmXHxkR0LdO/7EmeaMhpKKMhUltfW//M2
	 l/VrS5q+bByLv5K4nJTq6ktpLNgM3Mepokq+ENEbw2dhpVh/7hEAy2odf2l/MJ5Yn3
	 bI6kOVNdwSdt49IrveIRXtoszcbXsLyvkqEeR82QjMfdGTETz+OWNAv0LmgFtPdPsX
	 Y6KjS6xI6OocnZYZ0rWuQHljB9YRveldaN7jPuW/EDJJxJHPrxKRpn2U094ac1fJ8B
	 g8Vs+P6i4l1VS7dTt1Ol8loeKcUT9Xkuhqb3TrRanN9JO1MBQc07119aX82Eiu9ofB
	 DujegCMD4+zhg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A86qWB011542025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 14:52:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 14:52:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 8 Nov
 2024 14:52:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-firmware@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <gary.chang@realtek.com>
Subject: [RESEND v2] pull-request: rtw89: 8852a: update fw to v0.13.36.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1082df9a-5d1f-4044-b679-b2308971fc47@RTEXMBS04.realtek.com.tw>
Date: Fri, 8 Nov 2024 14:52:31 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

Update firmware of 8852a to v0.13.36.2

Sorry that I messed my script to send improper first pull-request.

Thank you
Ping-Ke

---

The following changes since commit e817e483c4b5bd0cd73a3d7e26c0a59c86b8c995:

  Merge branch 'rtw88' into 'main' (2024-11-07 13:29:19 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2024-11-08

for you to fetch changes up to b6bfff1a5b0fad254a693b9d4275271d4dda7f03:

  rtw89: 8852a: update fw to v0.13.36.2 (2024-11-08 13:35:28 +0800)

----------------------------------------------------------------
Chih-Kang Chang (1):
      rtw89: 8852a: update fw to v0.13.36.2

 rtw89/rtw8852a_fw.bin | Bin 1423232 -> 1428272 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

