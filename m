Return-Path: <linux-wireless+bounces-7102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1298B9395
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 05:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FB1B20E54
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 03:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1262418054;
	Thu,  2 May 2024 03:07:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B0175BE
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619250; cv=none; b=HM8DIWRTwwUtRTyXdoX6u7F2UNc2XIGcNR6njT8rQTlUlCk0PUqKCWY/9I38FEK2p2nfIXG+XkcrrCeQ5acmcpmZvZM+glgltUmgCERBvTL0ZmkAe/PbPydmP9Qe65amo75vMoUNRH6qrbGAVUi8fk5fRb+BizqVv/hroe+OYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619250; c=relaxed/simple;
	bh=QvojHTVWSWM4PKpOJs3/ihDskqV+3DFUY6Owy8vnWTk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=mm+3uyn+ZgH1SPQDLqiH+g0Tdz9jQUedo3gS1xkDkbBBIm7l4Y3Dwjh/NyjhMLZ5LgnjvY2wnLvOdaISubfSuZSGq8Zcw/IJjBu/zHJBn0QWq7Eq27JuyMgCXQ4rFLDDKHrtfz81fNokZiWuo1lAwFv2ePJw12sGG12toBEAZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44237GOc82055490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44237GOc82055490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 11:07:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 11:07:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 11:07:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>, <pkshih@realtek.com>
CC: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: remove some unused includes
In-Reply-To: <20240426141939.3881678-1-kvalo@kernel.org>
References: <20240426141939.3881678-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ad808377-ffd3-4b8b-b46e-40df73a09e23@RTEXMBS04.realtek.com.tw>
Date: Thu, 2 May 2024 11:07:16 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Kalle Valo <kvalo@kernel.org> wrote:

> I noticed by random that rtl8xxxu includes linux/wireless.h even though it
> doesn't need it. While investigating a bit more I found even more unused
> include files:
> 
> #include <linux/init.h>
> #include <linux/sched.h>
> #include <linux/ethtool.h>
> 
> It looks like that the includes are just copied to every file without checking
> if the file really needs the include. So more includes could be removed but
> that would need more careful analysis per each file.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

a890495b297b wifi: rtl8xxxu: remove some unused includes
028fa281712d wifi: rtl8xxxu: remove rtl8xxxu_ prefix from filenames

---
https://github.com/pkshih/rtw.git


