Return-Path: <linux-wireless+bounces-19526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E1FA47577
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 06:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0A016FECD
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 05:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9D921D599;
	Thu, 27 Feb 2025 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WwwNQj5p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD821506C
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635546; cv=none; b=hP6mQO3hMoxJIhSQOknWaGQqNRtFg53w+iVGnP1zlWrRxvFTHU1pPhnv0gGe1d2lBq5jTlCTNprZJJnPW14L5NXzPQnjhgauflpYCoY0qAKgIWQNA/i/BNzZ9sHxLx3+qrf9x9jfnT1ecWRr9kJIt09jzR4WSKK9rn7mj5ZGVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635546; c=relaxed/simple;
	bh=XcYP0rJAy5lytvLNCMcmSJLIxLeVbEB3qxMf4kuNcUI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Uookw4R0TeePedJ1Rzot6+RDZAQcbo005jE0Y0bn7PPJk4mI0htlH/nFfVOvVe7/6zD7FuwaIX8a0G6HEgEl1uAARExi7rAFthqK8Gwso6mtNrWodoscRc6tGGRWmdMCt7CsBsuOIv5v7f5liiU9LiLXOb+d8S80ZRXwOFRi1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WwwNQj5p; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51R5qK0H11300107, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740635540; bh=XcYP0rJAy5lytvLNCMcmSJLIxLeVbEB3qxMf4kuNcUI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=WwwNQj5pYIrHz0SYj105gWZsRv0UVPxsjKWoTiECeXZxa5V2vtUID3QhapVU6fB1q
	 FgWR3V08S1Ox7e3M4kkbpzDX8/w1JG8W5wjvlpMZ4qVml8Ie+/0wFaOox3EvJ6W082
	 JUYGCxlw+/acOK6p4+XqrKBt7Qem4OLwYiSeRsj1WY+9UzLPyuKAE6SxbJHdylqpQg
	 ztsLZS92a3/l6kqwmu/gZucaGYCKUNnu69JrabO2x9l3pk6QSQJb3dwD+PgYF+S7oT
	 GgCoi2j2dyjsddQsCCWd6iO5jwZd3iqm2UWATgblaG0SP1yKPV52Y7gkNrjtG4eQ97
	 vfqg1ZeFEbbKQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51R5qK0H11300107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 13:52:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 13:52:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Feb
 2025 13:52:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: add support for HW TKIP crypto
In-Reply-To: <20250220062344.15836-1-pkshih@realtek.com>
References: <20250220062344.15836-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <5f1fdd70-8d08-47fb-937f-a7ee2441894e@RTEXMBS04.realtek.com.tw>
Date: Thu, 27 Feb 2025 13:52:20 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> For 8852BTE, 8852CE, and 8922AE, TKIP encryption and decryption
> will be handled by hardware. All other chips will retain their
> existing software-based encryption and decryption.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

9e9877bd82a8 wifi: rtw89: add support for HW TKIP crypto

---
https://github.com/pkshih/rtw.git


