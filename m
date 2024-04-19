Return-Path: <linux-wireless+bounces-6546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8528AA6CA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 04:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036421C21BCF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 02:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A22715BB;
	Fri, 19 Apr 2024 02:04:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB04137E
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713492242; cv=none; b=S0Ne+OiQyKkAc2NKJ3GBLZ8bdamPyyZ1c91r8c1uBBZaFzhj/e5ejmxDW+++fnx2WY5Igu+2OM6gG/kIfydRbsoz45awhtE2uQWnomNIE4LB4ryuA+r3JfY1MjayoJWx8p5GYRcfi2soT+ngpBKezDhpMTxwMWhb1iB/dWD33dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713492242; c=relaxed/simple;
	bh=rh+RTVftgdCqeRJegfasf8EU04W4qQbszBFoNPRcXqo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=fVdRYHF9gY+JGSa9sySMvLEF2vZI6N3GribfMS/ufz0E4rWX9dugQvxeMDE5BqDNLP59ciHYuZWuZuywE7ItwhZ5Ox/FMwVqMZ7j2MuS6ovrGgmqfAFCTprzmN+naI/JABInsvpHJQ6bfq7Pq4G45PIrppm9g7NyIvm2R5sA1cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43J23uDK2894997, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43J23uDK2894997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 10:03:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 10:03:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 10:03:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Add LED control code for RTL8723BU
In-Reply-To: <c0e93225-4672-48ac-9bdf-9d0fad00116e@gmail.com>
References: <c0e93225-4672-48ac-9bdf-9d0fad00116e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <e4a3c968-9127-45c4-9187-b573d5f349d8@RTEXMBS04.realtek.com.tw>
Date: Fri, 19 Apr 2024 10:03:56 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Software control (on/off) and hardware control (automatic blinking)
> tested with EDUP EP-N8568.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Checkpatch warns:

  WARNING: Missing a blank line after declarations
  #28: FILE: drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c:1711:
  +	u8 ledcfg = rtl8xxxu_read8(priv, REG_LEDCFG2);
  +	ledcfg &= LEDCFG2_DPDT_SELECT;
 
  WARNING: braces {} are not necessary for any arm of this statement
  #30: FILE: drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c:1713:
  +	if (brightness == LED_OFF) {
  [...]
  +	} else if (brightness == LED_ON) {
  [...]
  +	} else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
  [...]

Set patchset state to Changes Requested

[v2] wifi: rtl8xxxu: Add LED control code for RTL8723BU

---
https://github.com/pkshih/rtw.git


