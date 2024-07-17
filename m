Return-Path: <linux-wireless+bounces-10282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866AC933602
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 06:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5A32842E9
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 04:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38FF7494;
	Wed, 17 Jul 2024 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MJuWMCjI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07C469D
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721190338; cv=none; b=T50U4rZNBPutkOlol/vojI5UI0bTJkmrpYiiBhLcfnk89xzh4RgfbdwJu71i45+J8fvru9yTNW0lm1V0xXspIWeo7wrrZFwKOAwqZXRcKC6+qzTqmxWFyOESUiwckce+u7EJJRpW/XS9/yfSqtnxhX1UaZAOhuL61f+C4GckaM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721190338; c=relaxed/simple;
	bh=Cftz8DC9Cq0uHt+9ZzQt++X9bvD3tPHZTY/NCrRPqpk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=k/WxlN5v/68+k5pVGehBx7r6yw7/pRfJbMXcC2/iXIGuq1xbRQZ6llXZeYf7x3c/C/hacEpH6Q9eAbIKXxOG7tfsnElSQgVTDfSMe7FutzSCMXQt1PX/nPBwrmR/J+3wmKfOX51H4q5eFG3V8oGLG0q6e36sQ56JeuISjWNPHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MJuWMCjI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46H4PWF801707851, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721190332; bh=Cftz8DC9Cq0uHt+9ZzQt++X9bvD3tPHZTY/NCrRPqpk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=MJuWMCjIkvi9jCcgtVCjyras9HSpgXKIaZ5xYnu9vwMJrOlpFHS/y2pMjdogwnRtX
	 mja1DeS/twQDYCKBPE/MWuhM6k2A/2GOteXLw1FSTeQopKqjyjIAaBqDrO509UswaX
	 6NqpWhkJ6/vYyAQ9C3fF1Wc2Ym+Ofot2SvDwcZsaMFXl+ubBAv7LG2YZ2uxFalY954
	 O6FOX/EbglFLdujGXRiPXWZilpIMLtyeZzVlAEwYXMvxXEWNGeXRVQzEPPO5s+pN2b
	 iaXatKFsRsE7upHWIMNiMmF4RHdX9HQ4Fl8pxhqeANT5WJSIYXtqjMdj5A3uyKTnfG
	 3JyZNPu/gXuBg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46H4PWF801707851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 12:25:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 12:25:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Jul
 2024 12:25:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Nick Morrow <morrownr@gmail.com>
Subject: Re: [PATCH] wifi: rtw88: 8821cu: Remove VID/PID 0bda:c82c
In-Reply-To: <335d7fa1-0ba5-4b86-bba5-f98834ace1f8@gmail.com>
References: <335d7fa1-0ba5-4b86-bba5-f98834ace1f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ef15d62c-7613-42fc-81a3-526cad21faa7@RTEXMBS04.realtek.com.tw>
Date: Wed, 17 Jul 2024 12:25:33 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> From: Nick Morrow <morrownr@gmail.com>
> 
> Remove VID/PID 0bda:c82c as it was inadvertently added to the device
> list in driver rtw8821cu. This VID/PID is for the rtw8822cu device
> and it is already in the appropriate place for that device.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Nick Morrow <morrownr@gmail.com>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

0af8cd2822f3 wifi: rtw88: 8821cu: Remove VID/PID 0bda:c82c

---
https://github.com/pkshih/rtw.git


