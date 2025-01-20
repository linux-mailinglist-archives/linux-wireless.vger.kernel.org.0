Return-Path: <linux-wireless+bounces-17724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03037A165A4
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 04:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B473A4C17
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 03:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1800133987;
	Mon, 20 Jan 2025 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="l5zw/LoF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B83137C35
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737343678; cv=none; b=a4l/mbO9bEMKvYD3N/RlGFa4va2wzdovZ4UrJL/qWw7jlFLWUKOGua1ScfCfAeGgOetWpzo9g4AYdNTZ69ohomVJAOt3n5CJmZYKsFb8Tdq85Yx6Tt0H/r1fXJT2RgetDNcdGcb/Zl2dh4O71dVfJVNSpRJkcTgPh8XyBLXBW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737343678; c=relaxed/simple;
	bh=CpU3ZUCRa/9pQcnWoRrFUMzkewtBU97h98FU+N6iZ0I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ez7b+YzpV7zZ4u6lKSUOEfdQsSKSaYCo/UQ0Bsrue2Lv5wTsl/9HJcPKvvY/uCR5dPqMvGI0HF9Uow/MXN8+UpASIKIMITwfdyrexItVt8jOUuytFn1qGCQN7YkOhTaF5fdY+2Egbd5RFxbGqUbfjAx5rEQb+6D4xvzzGoKU/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=l5zw/LoF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50K3RqyN62654396, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737343672; bh=CpU3ZUCRa/9pQcnWoRrFUMzkewtBU97h98FU+N6iZ0I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=l5zw/LoFDCj8zawkCY3h2rtbEZokfb07nQCOKHvF7zpWCHxicvIHT/qQRr+7NJKTV
	 HsizmPU3V1Wa2Ky3i8DlboRzGl77gEZJjHXPuy8Wd2x3zU1BuTH1wBK6CMrGaujjUX
	 Ep3ifApsbNY4yfp7thOBmI9FeV8JMNJl4+2MtRVcvM1QDag/geQX+kZSLawPiEv2Q3
	 cc7rAVCx59USx0b+p+Gzih2xF1ocal6SuN3mMZAXS9YM0VFl0oMfH7Z9FetfmiMJU7
	 NIxWO0VAV5d64CYSHIURvZ7risuJzueKz1G2PhU7Qu/X8QWNFZxIKWALcoB9WSMoWm
	 3WwKONZ3TmbHw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50K3RqyN62654396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 11:27:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 Jan 2025 11:27:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 20 Jan
 2025 11:27:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 0/3] wifi: rtw89: regd: add regd table with more fields to firmware file
Date: Mon, 20 Jan 2025 11:27:20 +0800
Message-ID: <20250120032723.19042-1-pkshih@realtek.com>
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

The regd table is to map country code to tables of TX power limit and
added support of two functions TAS and DAG. Append this table to firmware
file as well, and then we can update the changes of regd table via firmware
file in the future.

The patch 3/3 is to refactor initial flow of regd, and correct the naming
by the way.

Zong-Zhe Yang (3):
  wifi: rtw89: regd: support loading regd table from fw element
  wifi: rtw89: regd: handle supported regulatory functions by country
  wifi: rtw89: regd: refactor init/setup flow and prototype

 drivers/net/wireless/realtek/rtw89/core.c |   2 +-
 drivers/net/wireless/realtek/rtw89/core.h |  26 +-
 drivers/net/wireless/realtek/rtw89/fw.c   |  98 ++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  23 +
 drivers/net/wireless/realtek/rtw89/regd.c | 566 +++++++++++-----------
 5 files changed, 440 insertions(+), 275 deletions(-)

-- 
2.25.1


