Return-Path: <linux-wireless+bounces-25639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74074B09B8E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 08:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F8218980A7
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C8B19E97C;
	Fri, 18 Jul 2025 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="K7GLU9Dz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833C19F40A
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820793; cv=none; b=GV24mq6aBeiyrGXUugki7gW5ERBU6sDVHrnZlRp78UREugHZfgam9EdpEV2BjsDMI7wSkVLSVQAHEmZ0Ptf/MDraGenHoqjMP4NyRwM175VGG3tTU0G+jxRkrQGVMsNs+1BZuZl62YnFriBrcpNBqnWAWmr0ojjHbhoSg1mh4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820793; c=relaxed/simple;
	bh=D5OvH0VyU8PruRv+llJm9FHxMAnFmUcF1iUIRuMEVg8=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=YEBpeklrXaQkhZbK0b5Hk9NVjKZ5FwTM7gSKIiloiBRlBOoieD54pxfIIRux3h/4sNRBH03KT6Y30k0lEfckrbrs2McJ5Z3V+Cx04E3nxb1s99mifJw7Fr5L7b6cat0nwa4SJJd+9bt53UfGt7VDbikCRlX/FBZ0jvNdpMPHypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=K7GLU9Dz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56I6dnq271151070, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752820789; bh=CeoFU7KE+1DD/nexKNFgqi9bz9Jc/RXRuQRdOimQpN8=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=K7GLU9DzA1yXvzPhI3AsTYNLPCmY3LTRXY1Ul1e4yH4pbVunGyun1jLU4rxv6xYgS
	 56AeCmtzzTKJLvqtPpPw0eJb0h4TxvdqLvHOJo+lQOL4wAGBoNlIUiKqfCugZBSAEV
	 7UQoCZZxCvnvYWeiGZy5FJ1vO6zTwFia/qUbP7VIVU0TC2wxyX5lGobx3oCPWbQ178
	 nBYXSDdAnSgRnspBLNUb+Y6/mPV5Yf9rZnweDhDnlHjaHRCVVT7/4G1mETAycC3BgH
	 nArXYo5G0x6VBJN9QerZ9/lurLWLgLif55FqcSbFV/wZpv4OA26eJ9pVIJs6IPAH7c
	 1nz5tlvSnqlZg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56I6dnq271151070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 14:39:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 14:39:50 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 18 Jul
 2025 14:39:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: wow: Add Basic Rate IE to probe request in scheduled scan mode
In-Reply-To: <20250716122926.6709-1-pkshih@realtek.com>
References: <20250716122926.6709-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ebbf2ce8-6930-41da-924c-06dcda64dfce@RTEXMBS04.realtek.com.tw>
Date: Fri, 18 Jul 2025 14:39:49 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> In scheduled scan mode, the current probe request only includes the SSID
> IE, but omits the Basic Rate IE. Some APs do not respond to such
> incomplete probe requests, causing net-detect failures. To improve
> interoperability and ensure APs respond correctly, add the Basic Rate IE
> to the probe request in driver.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

37c23874d13e wifi: rtw89: wow: Add Basic Rate IE to probe request in scheduled scan mode

---
https://github.com/pkshih/rtw.git


