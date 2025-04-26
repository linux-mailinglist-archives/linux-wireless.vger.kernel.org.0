Return-Path: <linux-wireless+bounces-22096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E72EA9D917
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 09:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE1292519E
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 07:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0C4216E1B;
	Sat, 26 Apr 2025 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="aXqZqM86"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25A1C84C0
	for <linux-wireless@vger.kernel.org>; Sat, 26 Apr 2025 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745652855; cv=none; b=KBo+CMMThaYZv/3NLJhj6t51TZXNxw2KRI9+YOCXZYiVf2J0M0WfD9jM6SHIJiiMoC5PUDSTA8yLSeXXComa/NxN0iWRrsqjWXF4m/2rQWjzUIN8BKuVrf8qBXUm63EEhvORKtACK5YfJE6s6NFAwxYkAEO1dIFCVvFQOA4+ZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745652855; c=relaxed/simple;
	bh=dW99qSS3yJNgdNpafo/vrUi0aKND4w0ZKo9RFbeAr14=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Qvw8Zph3zz59jj9bwMkq/7GYD+CciTsd8PCSq+ZhFGQk7XNsIuN8S7hmo5VcU/k6tplc41L1SOnS8bN7VQ+HfnvPsCWqz4Cd9zPXBUFnpCg8rKK4gJZwM6yt5IwgdZ4rgMNcQZDLc6fjZ9OOa6VUsDdWN9aU8b62RAMjwOathec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=aXqZqM86; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53Q7Y7fpC1290118, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745652847; bh=dW99qSS3yJNgdNpafo/vrUi0aKND4w0ZKo9RFbeAr14=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=aXqZqM86dtZIbkhAqMGZ1a21cp7xUNdx0Y6wt/GGEm6VkKnR+FrxtkJ7YCyrKEnGV
	 NCbHrke7dBe8/TDHtWMuva2RtYgNxVSR8/9+egH0ikiU5AhQiiK2aj6ybp9l5/NlU2
	 9yuXwTGnPtyRhWldaZ+z0LgYGyvA2r7NMwJkswNAQ2/a6vRmZFeQE6cdp+t2K7+JoF
	 M8u7kdVmcOD43EgWM7hd70OZbxYqF9pvmahwi1O0lnQDHMVQwsRjvWYzhhwQQCnUdY
	 RwEMIVYX50np2DoFPLpFlaohqmxfe+lEV2Mvpo++OCvxxrxqHS66408ymWmQXxTZiU
	 3rrTICpcA5aLA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53Q7Y7fpC1290118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 26 Apr 2025 15:34:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 26 Apr 2025 15:34:07 +0800
Received: from [127.0.1.1] (172.16.16.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 26 Apr
 2025 15:34:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 1/4] wifi: rtw89: 8852c: update supported firmware format to 2
In-Reply-To: <20250416081241.36138-2-pkshih@realtek.com>
References: <20250416081241.36138-1-pkshih@realtek.com> <20250416081241.36138-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <df704f25-b1e4-4be0-bc17-7df907d68309@RTEXMBS04.realtek.com.tw>
Date: Sat, 26 Apr 2025 15:34:07 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> After firmware 0.27.125.0, it adds more fields to support firmware secure
> boot. Though current driver has supported the format, old driver can't
> recognize the new format, increase firmware format to 2 to avoid failed
> to load the firmware by old driver.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

603f4c71cc5d wifi: rtw89: 8852c: update supported firmware format to 2
20aac091a15d wifi: rtw89: 8922a: fix TX fail with wrong VCO setting
f64801d6f15e wifi: rtw89: regd: indicate if regd_UK TX power settings follow regd_ETSI
3e03579821ee wifi: rtw89: set pre-calculated antenna matrices for HE trigger frame

---
https://github.com/pkshih/rtw.git


