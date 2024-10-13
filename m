Return-Path: <linux-wireless+bounces-13930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC52899BBAC
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Oct 2024 22:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348F01F21650
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Oct 2024 20:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B2614B972;
	Sun, 13 Oct 2024 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cShxu2Fb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79214A619;
	Sun, 13 Oct 2024 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851333; cv=none; b=sXgSAHIGRNp8xQWifD/50fyIpvmuGQ2Q///3wGBSt61fYK0P8Dvuwrzsy5tX1ZG0kG2VJVgEnW+npDnzchGGjy3UgYaSkNWTEzckujq99BI7hAKRJzxDO/RedrUJTL640AA4780ou8GR0Jujx/co39OCoBQJ6HqVY5OdEl+y7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851333; c=relaxed/simple;
	bh=B14erMBGVuq9kG+SORUOBD0xFZqGRijfqMUyrsc3wOA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=fLVqcYobBnEQnhkNSZNxSDSNcdAyHr8DiJd5BLWQC4eb7v8y4fcra1ABB/eGReo0YDGKhCHwBSDxCOfFSG29WnMfam2pS+F0XSIPL2gWttpemgFn04l8oINBxwDCwLKmDpkg6sqZSeiTpSzXxsUcoURhdvgEfyurk6jNg7iRrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cShxu2Fb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a999521d0c3so604820166b.1;
        Sun, 13 Oct 2024 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728851330; x=1729456130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wRWCdVZVlOXVVV3K+TnOo4abj1WCau4sw4RIKpf2YQ=;
        b=cShxu2FbXj2xhKH5gCqtitsy8u5PdnnZrMIv5EWuVU61A9/qsT3JgxCJNWgxEfkuTl
         0I+irojyVzwfUZFtY1gzSDHp8nSpBKKdcp0eS0MQum+GgCQ+uNtzb0InKoWtiefziidb
         hqux6Lj8fNmq9QMh0Ov7WZWr7NN8PUCusQfWfGnNwtI7W7Gmql1D7dAG38GdaWdg8WPH
         KTuehP10V5VFUzy7bKrrfuA+UUtoO035YeUXAXo3PHpF2Nuvym0X529Cn5s/jcRZIqGt
         jTs5EgjhxcDvuGHM1w7aAUvSGLzt2akYkA3Jys7apjxYhSP+ab1qOb9mPzwNNNgSLVcg
         wybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728851330; x=1729456130;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3wRWCdVZVlOXVVV3K+TnOo4abj1WCau4sw4RIKpf2YQ=;
        b=r5M7Z8pv0DELi05QoNDVZ1cEP1iY3DjtVrkr7VFcgd15TZ1Uzaaqfu7vfnMfTDgZGN
         mhd6vMsBbu9L74NSbLGF/zAZsDMD2MyqycQB5XS4ou8N3YWNESvgoznAfynl9rDHsKaW
         S8QkVdyLkEOvk8LYpjHLUdp3/emUnt6JUwITMfBUfyYszTM5ektHtTxDJxyZJjZrvsgK
         /vCFwv12z4kSCCWF6SfWrHK6Ar5JvenDLxGejQRKqkglszrqrttqsjHzvl244aMiNd8A
         1nQkp7jZafwfQio0LU8D8xke6W1KDxofxEBm3P56F2J7mTpkjX9vV/MPD739cNHVXPhK
         uMgA==
X-Forwarded-Encrypted: i=1; AJvYcCXKrOXwF36I1mg2PNZ5fyjnHnHdWhg0qwsSEK91LMSVLXqAVhDVmHmmQGVvFnZ1qcmDENED5l+AnDhRgEQR2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YytuDaRg5VGq5PENKlXn784h9HGJz+Qry8xScyy6sVorwKyBpdP
	fb93M0/R1hAqVWEMcs35rghEi/KRQBohEChzrJ/Jk4sOCRMydxNW6fxprP5+
X-Google-Smtp-Source: AGHT+IFs8k6ARM1XBsiAlApkPDu0TO2sAvbk/FEu1+/7bODbqmT00VImgLMaitpFuy+TrqJfC18XtQ==
X-Received: by 2002:a17:907:86ab:b0:a99:f887:ec09 with SMTP id a640c23a62f3a-a99f887ee29mr376832566b.35.1728851330052;
        Sun, 13 Oct 2024 13:28:50 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a06169967sm114645266b.97.2024.10.13.13.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 13:28:49 -0700 (PDT)
Message-ID: <a7eb3db4-ad0d-451a-9106-90d481bd3231@gmail.com>
Date: Sun, 13 Oct 2024 22:28:48 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [RFC] ipw2100 ipw2200 ps3_gelic rtl8712 --- Are we ready for wext
 cleanup?
To: linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Geoff Levand
 <geoff@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Pavel Machek <pavel@ucw.cz>,
 Stanislaw Gruszka <stf_xl@wp.pl>,
 Gregory Greenman <gregory.greenman@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

origin of this question was the following patch series from Arnd Bergmann
[PATCH 00/10] Remove obsolete and orphaned wifi drivers
https://lore.kernel.org/linux-staging/20231023131953.2876682-1-arnd@kernel.org/

Here the remaining files that use iw_handler_def:
drivers/net/ethernet/toshiba/ps3_gelic_wireless.c:static const struct 
iw_handler_def gelic_wl_wext_handler_def = {
drivers/net/wireless/intel/ipw2x00/ipw2100.c:static const struct 
iw_handler_def ipw2100_wx_handler_def;
drivers/net/wireless/intel/ipw2x00/ipw2100.c:static const struct 
iw_handler_def ipw2100_wx_handler_def = {
drivers/net/wireless/intel/ipw2x00/ipw2200.c:static const struct 
iw_handler_def ipw_wx_handler_def = {
drivers/staging/rtl8712/os_intfs.c:     pnetdev->wireless_handlers = 
(struct iw_handler_def *)
drivers/staging/rtl8712/rtl871x_ioctl.h:extern struct iw_handler_def 
r871x_handlers_def;
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:struct iw_handler_def 
r871x_handlers_def = {


In this Email Greg writes over rtl8192e:
https://lore.kernel.org/linux-staging/2024100810-payback-suds-8c15@gregkh/
"...
No staging driver should ever get in the way of api changes elsewhere in
the kernel, that's one of the rules of this part of the tree.  So from
my opinion, it's fine to delete it now.  It can always come back in a
new way later on.
..."

So it should not be an issue to remove rtl8712.

Stefan Lippers-Hollmann was one year ago still using the ipw2200.
https://lore.kernel.org/linux-staging/20231024014302.0a0b79b0@mir/

Here my opinion why I think we should reconsider this:

I really like to use old hardware. One of my computers is from trash and 
the other one is bought for 50€ three years ago. But non of my hardware 
is from before 2012. Do we as a community really need to support 
hardware from 2003 in kernel 6.13 for WLAN that evolved so rapidly? I do 
not think so.

People around me are complaining that the 2,4GHz WLAN is difficult to 
use because so many devices are using it. Such slow devices consume a 
lot of time to send and receive the data and block therefore other devices.

The longterm kernels will still support this hardware for years.

Please explain to our very high value resources (Maintainers, Developers 
with wext and mac80211 expierience) that you cannot find any other 
solution that is within technical possibility and budget (USB WLAN Stick 
or exchange of WLAN module) and that they need to invest their time for 
maintenance.
Here the example of invested time from Johannes Berg:
https://lore.kernel.org/all/20241007213525.8b2d52b60531.I6a27aaf30bded9a0977f07f47fba2bd31a3b3330@changeid/

I cannot ask the Linux kernel community to support my test hardware just 
because I bought it some time ago. Rather, I have to show that I use it 
for private or business purposes on a regular basis and that I cannot 
easily change.

Using this hardware is security wise not state of the art as WPA3 is not 
supported. We put so much effort into security. Why not here?

Thanks for your response.

Bye Philipp








