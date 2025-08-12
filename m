Return-Path: <linux-wireless+bounces-26299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52FFB22097
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 10:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B333B4B42
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E512E1C7E;
	Tue, 12 Aug 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="H7e/lLrk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889242E11C3
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986868; cv=none; b=KhxLZjRAPFo/hbG5jDzJkX+FmG3cRn/Mtgdod0r2vkXFAmV9Cv6j57GvtmqV7pG2xscwDFr9rHteVAgIKStEfRIKZIjR+zE1cZgVNxSJpDYHvokyMIZxKfzxE4FH3wMfw4hpYlE/vwFT4o7mRPIJjHiiNzjhWXKrSRPRMvT67ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986868; c=relaxed/simple;
	bh=1s0sxXsapsIMYvfsiBY4zgygEeOKem6x9wOrs0FNnmU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=OgnBbywk37D98oNv9rfj93VfZiDxFuqOQQPvO3z4b4QRaCyF5jn58PSOAOn90gMTooilZNnSQEgutAa1oOYZbmBvbXD+PUtIMafeo7mx97b+hGErmfqMLXCdByFozkfuBDWkXzoqQvhlwXlrxJiynoK72NUzrRH3+ew4SM+IRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=H7e/lLrk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57C8Kl8O22150077, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754986847; bh=qi2a3QrM6iNCMYY8dW8POlIQ6ITYbEuZRD1W56lyDIA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=H7e/lLrkCWuLIjdNyhA1+irYtpg4Yb/b02gr79TpsRVHygLDXiY7EV6k4p1e4PHth
	 +xF/7vCrK0FqS17aeFFmfzvEOBDtZDgdDfUeuK87vo0hyZSADjWHC0+urHKhuInbFI
	 /wa0zxwsobxsvWSS6Crci8SkpT6rEmtLxJWDtAh4B8Co6inXMKriiooQ3fwcUwD4b2
	 nVQ0AxKSO9h8XkQzzP6z7MYUob2o2SBq6Tod6iFZ54aHJldSH1sO+rXEB12e928loZ
	 jGT4TIlkMT2E0sPEHEAlPUetoixS3b1llI+rPfcTREGeIAqym6G6Ha009eKtBwNB4l
	 QTxJUK1gmNa5w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57C8Kl8O22150077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:20:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 16:20:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Aug
 2025 16:20:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>, <sean.anderson@linux.dev>
Subject: Re: [PATCH rtw-next 1/2] wifi: rtw89: print just once for unknown C2H events
In-Reply-To: <20250804012234.8913-2-pkshih@realtek.com>
References: <20250804012234.8913-1-pkshih@realtek.com> <20250804012234.8913-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <2fb39729-01de-46b2-ac3c-6371658d4f09@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 12 Aug 2025 16:20:41 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> When driver receives new or unknown C2H events, it print out messages
> repeatedly once events are received, like
> 
>   rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support
> 
> To avoid the thousands of messages, use rtw89_info_once() instead. Also,
> print out class/func for unknown (undefined) class.
> 
> Reported-by: Sean Anderson <sean.anderson@linux.dev>
> Closes: https://lore.kernel.org/linux-wireless/20250729204437.164320-1-sean.anderson@linux.dev/
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

7e1c44fe4c2e wifi: rtw89: print just once for unknown C2H events
04a2de8cfc95 wifi: rtw89: add dummy C2H handlers for BCN resend and update done

---
https://github.com/pkshih/rtw.git


