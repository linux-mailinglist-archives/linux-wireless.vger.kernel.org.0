Return-Path: <linux-wireless+bounces-13210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6683986A64
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 03:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EC9283CDE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 01:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7CD132103;
	Thu, 26 Sep 2024 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZLr+wUB5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E2D2C18C
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 01:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727313886; cv=none; b=lsusuZFiVIrPtzHneOIYpTZMoUuoiLYqPbzDF2pMDd5XR5vgM+sQoQyffDDu7CMI+StiHjdMFmxdITVkTwdQJG8POWnghe8xsXzA/PyFo5WT3JcMzxSjo5GgTwAAHZxL5+M45JlbJoxDLqSQEEXPS/fAOtA4kT0B30k/f5tgXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727313886; c=relaxed/simple;
	bh=0Ti+olumngvqiD6Vdfi87YmJRP5sjzvghk7LYHz0Yh0=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=cQSOGmRZTFrQmbqpTs1u5ga0zWHxJwClwUBRrkWv51+3Zl2SMJDHsY90Sq+iVwi0JVqfmgnoTddoJo4DcX1kWAgVEPBOwwLLIu9Dllo2xgdZ9wj6uNhU5EvoVlmA3ESvMpQvbfYmuZIzJBykySRRgnbnDkvT9OrvFbh7Xb9wFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZLr+wUB5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48Q1OfjD61201941, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727313881; bh=0Ti+olumngvqiD6Vdfi87YmJRP5sjzvghk7LYHz0Yh0=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=ZLr+wUB5qYkLC6qBLB0C0sUgMkTN2F7LWajDq0pUCcizoWDsh97ALZrk4IprMDVln
	 ygVQa7nA4+YH6pM6TmEg2NoEcebdcjZ0CB7a9lg9KzBUsLPk59dd1E3YcpWIjfKz7l
	 CbB/msNqKPiiY3TQ5gEtyfdNDAa0U1bGpV4mUJuzP4+sxHT11UCzWZSEBicgvRR00y
	 OJCiO7VUuOFERAEd15k3AdjLr/pRCzurhTr1S/53vScZ3K1Updir+Auu5KjnrMP90Z
	 UR9mQo4cYg91+GRig2RE4E6KvYmcp5CgzowZdak9GA2zl/4XXfqb4A8YuX1ZjJGGTv
	 RFcmWXdB8UD7A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48Q1OfjD61201941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 09:24:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 09:24:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 26 Sep
 2024 09:24:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/3] wifi: rtw89: check return value of ieee80211_probereq_get() for RNR
In-Reply-To: <20240919081216.28505-2-pkshih@realtek.com>
References: <20240919081216.28505-1-pkshih@realtek.com> <20240919081216.28505-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <4465a629-3e87-4c30-b9be-a3b425dcf0fd@RTEXMBS04.realtek.com.tw>
Date: Thu, 26 Sep 2024 09:24:40 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The return value of ieee80211_probereq_get() might be NULL, so check it
> before using to avoid NULL pointer access.
> 
> Addresses-Coverity-ID: 1529805 ("Dereference null return value")
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

630d5d8f2bf6 wifi: rtw89: check return value of ieee80211_probereq_get() for RNR
6cdfb5659624 wifi: rtw89: coex: initialize local .dbcc_2g_phy in _set_btg_ctrl()
7bf2f8fe4237 wifi: rtw89: 8852c: rfk: remove unnecessary assignment of return value of _dpk_dgain_read()

---
https://github.com/pkshih/rtw.git


