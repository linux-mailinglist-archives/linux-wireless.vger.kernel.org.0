Return-Path: <linux-wireless+bounces-23048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E8DAB9369
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 03:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7271BC3C93
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 01:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0982147EA;
	Fri, 16 May 2025 01:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="o9Lc085v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B62147E3
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357500; cv=none; b=UpDhfjyRjUUcOGIWcZQK6nk8illJDJwRYDuxj+Be6/LP5EhImbw8im+xugv2Wiqj/cSmSNlUAEwvn4t1x+3TQwX7W+f4vFoE+gLIXb8GjsQxcQrIf21VK8a1YcidfYdTED7Ju5sOuLKQqCoExT/RBItfsMdTQPayAls0nPy/Cfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357500; c=relaxed/simple;
	bh=NYDcX+Jb5/tSOSzS3eGFKWLtWq+ZIVqWilyR33u3AFg=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=MBT0G1DTwdR+hLYoc8kHMfAuVPfgD+ZzJHbuocWG1RysfWb3oHIc4OVtXjf9ZOvFhfvQh0yDJLoP2mgciLc5gu6X308SO80PS8e0P7K1gos0pEfRHAOPKmfOfTg7RpBcUj7khKpiHv/ZXutiYStGqsfbdiNsz8aNK9ZAvDoEEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=o9Lc085v; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54G14uJqA076531, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747357496; bh=NYDcX+Jb5/tSOSzS3eGFKWLtWq+ZIVqWilyR33u3AFg=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=o9Lc085vEOxssgGNJ7OWdmeqApULl/Gc3jYXEygpYeie8cz9trEnTJB1IuwvODI1r
	 UQAeSHc/xS+ECMNhTbegionKkFwgl2FhT933XTFxfQZAzs7PqxOXgrb43scUfeQfTD
	 p05j9I2fIH/EyDB37NbWyAxVS7W/MRckZeCtbk2B9+Ft8J762cGcqC01689c/JW3v+
	 3CKRqNHWDZWcx/RYmaFy5OBHEBcusRvFXjNDeiIh1EwvW/Jzc0RozTRrlyGqOeGTxd
	 EltY9R3F1ujdQmf4yPUd5Iu5Fcbdllxd7t918R0HXd2KcemQpq2IkqhHQlGkIEgvt/
	 JVt9z9QR7WN4g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54G14uJqA076531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 09:04:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 May 2025 09:04:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 May
 2025 09:04:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: fix firmware scan delay unit for WiFi 6 chips
In-Reply-To: <20250513125203.6858-1-pkshih@realtek.com>
References: <20250513125203.6858-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <662cecb6-2e8a-4c87-9d8b-dc50c6d1b486@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 May 2025 09:04:56 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> The scan delay unit of firmware command for WiFi 6 chips is
> microsecond, but is wrong set now and lead to abnormal work
> for net-detect. Correct the unit to avoid the error.
> 
> Fixes: e99dd80c8a18 ("wifi: rtw89: wow: add delay option for net-detect")
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

3cc35394fac1 wifi: rtw89: fix firmware scan delay unit for WiFi 6 chips

---
https://github.com/pkshih/rtw.git


