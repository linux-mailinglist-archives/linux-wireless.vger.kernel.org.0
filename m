Return-Path: <linux-wireless+bounces-12824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED71297792E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 09:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BF01F2429C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E77C1BC089;
	Fri, 13 Sep 2024 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="c3EnTJsr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D11AE845
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211661; cv=none; b=chYWfLtFeSOGVFDAInExmjDweml5/5gukK7DQDW121iS7fXOJc5ztIlWJrH7Z9wRl8jPcxSp7QPdLHk/xm8s9fwtWLm3g165KvuxPHEreWyiYbqa5jGxFSeOoCIKRvZoDMUjvJUXj6BoRXuvlEQnkBuqSNfDdr9WyX7ji1r4ZSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211661; c=relaxed/simple;
	bh=YAgS852NiqW1S/ZdNQFUv/dsotRqkYkauGXeIvlb7Tk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dVe7Zj6aXazZM3vcjtxG9q/vTHseRJPZvfPAeDgVwrYQOQWBy7qCekWuRpxN4zG9QKt1NHBDFcq7pT/8JtnRC0WtCHtCWcbCh9ORmncn0azLx7dUCpjiNsotI8YEBOHSa0Q5Y95ZypSIFBKZGuxlXh9XXKaw23b+OluOnQypFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=c3EnTJsr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48D7EDu642542217, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726211653; bh=YAgS852NiqW1S/ZdNQFUv/dsotRqkYkauGXeIvlb7Tk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=c3EnTJsreOME++ULJdeq7RRFqLzoCmkg3fK5AP3E2LTjRqk5ilj2x/6JkOP+zfYH/
	 X408Gi7Wn0LjYZBDCnhJcbfXmAVcim4V5s9a9PP51ZtjxUrQ4mSd/ruMA8JXafDlFx
	 tIQVBmthN2lejo+ot9RApXIY7hRtmFNvzM+BdOrEnsXM32+QNw34KMl4ht3cJmCleT
	 W71x75H6sXN5F4iYdaI0BbWcUFMw8EqMT4fTkm1fPBWxaqSEurUchWQ/nrUDQ4KR7X
	 hrhdSCJdz6KoYp1eMyIG38dZddemGssZM/BlYQx7b3Mva+dTEY5QnK+0bje6UhCR3O
	 zHMYBx85Ugo5A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48D7EDu642542217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 15:14:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 15:14:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 13 Sep
 2024 15:14:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] wifi: rtw89: update RF calibration to support newer firmware
Date: Fri, 13 Sep 2024 15:13:35 +0800
Message-ID: <20240913071340.41822-1-pkshih@realtek.com>
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

Update RF calibration TSSI timeout time by patch 1/5, and add RX DCK v1
by patch 2/5. The last three patches are to add C2H event parser to
print out RF calibration log from firmware.

Increase firmware version number to 2, so priority firmware is
rtw8922a_fw-2.bin now.

Ping-Ke Shih (5):
  wifi: rtw89: 8922a: rfk: enlarge TSSI timeout time to 20ms
  wifi: rtw89: 8922a: rfk: support firmware command RX DCK v1 format
  wifi: rtw89: rfk: add firmware debug log of TSSI
  wifi: rtw89: rfk: add firmware debug log of IQK
  wifi: rtw89: rfk: update firmware debug log of DACK to v2

 drivers/net/wireless/realtek/rtw89/core.h     |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c       |  35 +++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  65 ++++++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 177 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h      |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   8 +-
 6 files changed, 249 insertions(+), 39 deletions(-)

-- 
2.25.1


