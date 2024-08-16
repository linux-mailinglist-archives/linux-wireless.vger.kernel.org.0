Return-Path: <linux-wireless+bounces-11548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8D1954825
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 13:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FF51C219EA
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 11:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9426D54BD4;
	Fri, 16 Aug 2024 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="lo8VYYfU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D71114D703
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808395; cv=none; b=dlTpMcE8ma7AZTJvbPJOxSeGVRYveCcm8rN2xKxDtOcWf9vwLcfU8cQxoa01g3ueDSFQbVEqZbZIWmTkjjoAiEeqrKPQZQ2MDfLDbBGIeQMxUKD682eVO3+FnWBdBZgLAlQK/Cl+QEpmklYKkKTmvl6mU1ZWUdI0ZO/hgLowADU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808395; c=relaxed/simple;
	bh=1p7km2wNdiaAXDOXRxWgUaMg9WVsnF6gzieIdCFqdvg=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=j6otgMAMWJQZYKuh1y59+Z04lTmHq4VTivBq82IVbZL95C8qGbRSR2cWVDCGPHfsh34b1zQgLqJm8T5KAeZ0pm8clVa9z6H6jVFL20b/PLYqZaugmTVQgQiih/+5CqhkrFiBCvdanXnsQQB2QuYcttSRCW49vdG44L+WN2pIi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=lo8VYYfU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47GBdpYfB980431, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723808391; bh=1p7km2wNdiaAXDOXRxWgUaMg9WVsnF6gzieIdCFqdvg=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=lo8VYYfUjFLlnqp6kJqvViW6SDR16c3l5Mt/Rb5/RV+yicdtoK/PxuPVEuyi2F0g9
	 nqaLVYducnfSV9uRBKNWUQw4oMNAQHEASXW+4untxofv0NHXzYePVpBuZmO2744Sxk
	 0nMAAsXkq17Mqiy8hKqGNHuFj+TuBmhyxBfVdrU1TxvUk+7vrKkygF9GgJyKYiaBxg
	 6MpZqVx3FWTLwKd15QLdgdMC9tQ9LKGTPi6a/Y1qDpgi76xHqYmDncFlOvo0h1h64o
	 Za60bP+LdNE7a7pr7FoTWJUtZ7ZZNo8AInvM+HYyRNnK+r998KeQMchbGj2GqCpGl6
	 BYAdPA7sT28sg==
Received: from mail.realtek.com (smtpsrv.realtek.com[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47GBdpYfB980431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 19:39:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 19:39:51 +0800
Received: from [127.0.1.1] (172.16.21.174) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 Aug
 2024 19:39:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: Re: [PATCH 6/6] wifi: rtw89: debugfs: support multiple adapters debugging
In-Reply-To: <20240809072012.84152-7-pkshih@realtek.com>
References: <20240809072012.84152-1-pkshih@realtek.com> <20240809072012.84152-7-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <f6ee0408-55b0-4732-9033-58266f68c50f@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 Aug 2024 19:39:50 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The rtw89 uses debugfs to access registers and driver states. To get
> a range of registers, the range value is set and stored to a variable, and
> get the set of register values by the stored range. However, the variable
> is a static global variable, which multiple adapters will be a problem,
> so move the variable to adapter context rtw89_dev.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Smatch reported:

   drivers/net/wireless/realtek/rtw89/debug.c:3959 rtw89_debugfs_init()
   parse error: turning off implications after 60 seconds

Set patchset state to Changes Requested

[6/6] wifi: rtw89: debugfs: support multiple adapters debugging

---
https://github.com/pkshih/rtw.git


