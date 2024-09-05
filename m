Return-Path: <linux-wireless+bounces-12512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836FE96CC18
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 03:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B602B1C21F14
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 01:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FBD802;
	Thu,  5 Sep 2024 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tZ6pru6K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F66FDC
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 01:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498763; cv=none; b=kpEIQr9hrrEUiY2WW+evqMmEK/gz7/AjVZY10I9bax4on6xcM7gtZsK6HyArOoc6DxU4LI+VGLCxoqCKOwIePxNmefumakOUsL1T6rnmJRcC4o4n9zOq8htaQj00rkVkzOdvVMGOGANc/sexh5P9cZH2WZBQ+VUB/vUmN0jROpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498763; c=relaxed/simple;
	bh=HbN/o9v0BmB1ikZh0X75TVOivDXnRWAMPHfY5VsCg6I=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=YHg5P1LtvC3MQ5lrvthrvxw1nDxyn4MkPmVrmjnpqccv/i0hAlpMsjumwyjwx8F4mjG6szF+YiHkmAtGIDWROilN6Mg4QuXg/GytWmGheNSO62jcL8fWJPlgXHE5luqaaBsX13QRY/qyrqB4uaOMK+1QPUTwR69dUneQsOdSPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tZ6pru6K; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4851CaPW23085434, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725498756; bh=HbN/o9v0BmB1ikZh0X75TVOivDXnRWAMPHfY5VsCg6I=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=tZ6pru6KEETCM8iuoHHN0S89s3rVDgZBdF/ptQuNNcmYURML+pIRSAmo+gpLHTMzn
	 7nrhcd93tebLdI6+M3LVbXx3G1RG7UsxXd6JeQAtT6J3KS8BYKCj1fUbscAQvjkRZl
	 CQiEPRCWHxd8w7cbtM7WNRMl0z2nTIwLFgr2bcSsHEzGoX+l40Xpy/7uWW9O2fABlv
	 o3/KgLnsnNCkBxKhnC8wkvYhWTEly+qAWxwbLP/MmiL0B2QuxY6kxp16WCjpMHjxxX
	 n+ai4xwO8wM9m0SX6mScR1eQ0R1Q4JAJvXvxA3kJXJAsUHeTU8zX4FieciHr4p57/+
	 Aa0L7lQ1SdtWg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4851CaPW23085434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 5 Sep 2024 09:12:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 09:12:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 5 Sep
 2024 09:12:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtw89: adjust DIG threshold to reduce false alarm
In-Reply-To: <20240828055217.10263-2-pkshih@realtek.com>
References: <20240828055217.10263-1-pkshih@realtek.com> <20240828055217.10263-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <11972a61-f9d6-4c72-bc52-20643ded0e7b@RTEXMBS04.realtek.com.tw>
Date: Thu, 5 Sep 2024 09:12:37 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Eric Huang <echuang@realtek.com>
> 
> Use RSSI without subtracting offset as packet detection lower bound and
> set an absolute minimal threshold. It's equivalent to setting a higher
> noise floor, thereby reducing false alarm and improving interference
> endurance.
> 
> Signed-off-by: Eric Huang <echuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

9ecb64ed07ef wifi: rtw89: adjust DIG threshold to reduce false alarm
c9ac071e30ba wifi: rtw89: use frequency domain RSSI

---
https://github.com/pkshih/rtw.git


