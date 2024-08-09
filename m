Return-Path: <linux-wireless+bounces-11152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E094C7DD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 03:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0E31C215F5
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 01:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4F62F2A;
	Fri,  9 Aug 2024 01:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cWP2C6fg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F085F38B
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165506; cv=none; b=F4s8scbP8FuwoX508b2glgpInK2x963NVNBEE3OpMMrlewVP4b5JsmM7X3Uq7l7gezk0BG7YiEvJLS37sJdiq95ZG8lNrVFrXa5e2iEHqKyo1QE/eWXWnBsnQoLo9FEAJB2+KMrJt7k4zEJNPZhsWvZ+pZCpw5uoOk6t6RHXRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165506; c=relaxed/simple;
	bh=/GsGsDMDsSn+UaGgY+mo6IFDeVk0gLd/dRo2LK1AEnw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=U6k+qVN04rANuVsPcTxgsb3JhOWdpeajtg6QnrG3U+8k6avNzB+zkd4PRIpB4LTl3dN5FQH70yPzHefHUM6EKY+AfriKCeq15csKyAOzObW4q0bQSDPjE84qIxfzB3ggjvB7t8VxkPW17IRaUfoFcdkPkItwujW9FGLd8SlgrZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cWP2C6fg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47914x5B2128368, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723165499; bh=/GsGsDMDsSn+UaGgY+mo6IFDeVk0gLd/dRo2LK1AEnw=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=cWP2C6fgZsk5yMk04Vc/1/R38Ek4cRB11yVhhzjywb9b2BUOKYSu6OdPXG4xnu9h0
	 xEdQDBOkjLsNhHfH8vMWGpiwSQ88R3jKatwYnWumTJt+jjEGObJkoubpCigrI1OEDw
	 IS9djptqSiDeFtiguXVbgjaLKhTJoKxohmHLAkd5jczhQOr43lv94in7U2chyDPN5t
	 1MmthhZ2WQuwHCGl+DqHtKmbw48R3KWB496mZhbhFlPaJRe2dKLEe0+v9A1BuFUlbE
	 pe+HwQHJLSick38EbyxOkhI0dMZcl1MMel8zs1yTsGhRL0fj9gAiTzqvIgSMp6+6NT
	 EtCPctcDsfwcg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47914x5B2128368
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 9 Aug 2024 09:04:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 09:05:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 09:04:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: Re: [PATCH 1/5] wifi: rtw89: 8852c: support firmware format up to v1
In-Reply-To: <20240805090028.27768-2-pkshih@realtek.com>
References: <20240805090028.27768-1-pkshih@realtek.com> <20240805090028.27768-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <7bda0484-d029-41ac-b4f2-834a0ef5d81e@RTEXMBS04.realtek.com.tw>
Date: Fri, 9 Aug 2024 09:04:59 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Driver has supported different WoWLAN reason code by commit 0e5210217768
> ("wifi: rtw89: wow: update WoWLAN reason register for different FW")
> since firmware version 0.27.80.0. The old driver can't support two
> kinds of WoWLAN reason, so increase firmware format to v1.
> 
> Also driver tables of BB and RF registers and power values will be added
> into v1 format.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patch(es) applied to rtw-next branch of rtw.git, thanks.

45ae0e8cf8c7 wifi: rtw89: 8852c: support firmware format up to v1
0f683c2cf673 wifi: rtw89: wow: implement PS mode for net-detect
c0bc1bce12e4 wifi: rtw89: wow: add WoWLAN net-detect support
e99dd80c8a18 wifi: rtw89: wow: add delay option for net-detect
9fd284aaaead wifi: rtw89: wow: add net-detect support for 8852c

---
https://github.com/pkshih/rtw.git


