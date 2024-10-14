Return-Path: <linux-wireless+bounces-13943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF5A99D6A5
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C122A1F220A3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 18:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1726F1C6895;
	Mon, 14 Oct 2024 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXY2EjFl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF21C304A;
	Mon, 14 Oct 2024 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931162; cv=none; b=mpfFfOu79WlVQbVfJXRTeQz6oNQpFgU1z7OhaF2dAddUkvrK76RM0tI73+2rY+8RdjWL0535IsruaMdVi1riOMgLhNXJoquX1f30ZDj3dbsExxW0tR/PDU42tHRmYsbm+vqjZVg+pNp8VR3MA6MLApjN43U0QGErlf9PfNmFjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931162; c=relaxed/simple;
	bh=bNpe9cGfuFuN6XB+KYQ51+s+Hd11yBzJgAeFEbeoD6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CioI9y/EorTANKcQtiZbN2fRvDpya8DpyUun9EhuUK8u8XoKOJx175QUw4X8DFD98QyMicHlPsM7Kons2xmfRJ1khz5uUUXd/p7HMd66hOv5A5TpQ0M75qrP3295o12Kr+8SVvxkRnQcs/G7i3Jcll5GOOHjZpKOKgioApRr6Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXY2EjFl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a01810fffso248884866b.3;
        Mon, 14 Oct 2024 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728931158; x=1729535958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0r76MqNhjQHMwaWhdIiFLyHSJMjIu1KOA2CjoqqtSM4=;
        b=OXY2EjFlzksb4rZ1/h4TyMe84zB3/BOs+N1XOniemroGr32udFgIsFAdKlpQlqtW56
         cq5gMs6edRwjKnCDJR7hQd1Mraz/rGFeDF+GLBL+M3wzbRHxFgSaLmdu3gOthkTTAgYH
         5NR3FCIBrhkVNLFeG2YUjUTJBDOMCJQpUdXvd+mv3Ktk2I2Jbv+k11LG0ZmJAhsZnLxn
         IUcm0zspxsxunSOyXT6Nwy+K+q748e7mxSZoFBMmDj02jwNPJVLuFHZHSMZD944v1uiY
         2BsYI50rHL57m4H4FgkmGfw3AoG7HTPk9zEqau7mxphIwN+vkPu4IeLLw8nXbM+ISfBO
         nfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728931158; x=1729535958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0r76MqNhjQHMwaWhdIiFLyHSJMjIu1KOA2CjoqqtSM4=;
        b=uLvnamltNihLkMzCcEoMM5n0/8yK5p8nwzskfxsOafAcd09ol7DoOlN8etLTBdgi70
         cQXqzFeQ78bN0KP4u1fVJ7TMDSSC5Fq3EwPC+JiineHraTKpBHZ1bMWOoKnTvv1rKzg5
         IBWv4e3kha8Q1aX49GZDL/A7QZSHs41B8ZWdf0T96LN5KvzWXYB0/oLD34DXaLtb44b5
         tyltUaODnJtyq1hsrQHmMVCI1mdFUUe4wQAOWXrFPTkZWXFctavde1SI2l0ROnuNzrrz
         bmn8yQzc20L5rGCGD2USaAF0CbzdwY7aUP3NslFB6m3sDvB+KRMNaTQ9Hs+/8wr7sAsg
         sogg==
X-Forwarded-Encrypted: i=1; AJvYcCVqpinzsiDGvJHRD5PvTg4TaTOiBlJ8DislyLfuxcO6KehYhoD/2OBm54CwbO4a9RYdUPcXD3GSvo7HsVqYYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1LiDQBZe3C+UiBOd5nPzbgNBpNML5ESF2o8MACvysz5tzi4TU
	FA2oHd1XlVaEx+cO5GY5fFfV5PxgyqBx9LIF5fPdpQXX8JdPWeNS
X-Google-Smtp-Source: AGHT+IFhhSROBO9GfBivL9KwataGn4/0YIUxuXdkFCm1rEekyN3xQH7THl7pb75iTikmddIrLHixIA==
X-Received: by 2002:a17:906:da83:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-a99e3e437f4mr874605066b.43.1728931158353;
        Mon, 14 Oct 2024 11:39:18 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a16989a01sm126620866b.116.2024.10.14.11.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 11:39:17 -0700 (PDT)
Message-ID: <a02e3e0b-8a9b-47d5-87cf-2c957a474daa@gmail.com>
Date: Mon, 14 Oct 2024 20:39:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ipw2100 ipw2200 ps3_gelic rtl8712 --- Are we ready for wext
 cleanup?
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
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
References: <a7eb3db4-ad0d-451a-9106-90d481bd3231@gmail.com>
 <87iktv58tn.fsf@kernel.org>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <87iktv58tn.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.10.24 11:32, Kalle Valo wrote:
> Philipp Hortmann <philipp.g.hortmann@gmail.com> writes:
> 
>> origin of this question was the following patch series from Arnd Bergmann
>> [PATCH 00/10] Remove obsolete and orphaned wifi drivers
>> https://lore.kernel.org/linux-staging/20231023131953.2876682-1-arnd@kernel.org/
>>
>> Here the remaining files that use iw_handler_def:
>> drivers/net/ethernet/toshiba/ps3_gelic_wireless.c:static const struct
>> iw_handler_def gelic_wl_wext_handler_def = {
>> drivers/net/wireless/intel/ipw2x00/ipw2100.c:static const struct
>> iw_handler_def ipw2100_wx_handler_def;
>> drivers/net/wireless/intel/ipw2x00/ipw2100.c:static const struct
>> iw_handler_def ipw2100_wx_handler_def = {
>> drivers/net/wireless/intel/ipw2x00/ipw2200.c:static const struct
>> iw_handler_def ipw_wx_handler_def = {
>> drivers/staging/rtl8712/os_intfs.c:     pnetdev->wireless_handlers =
>> (struct iw_handler_def *)
>> drivers/staging/rtl8712/rtl871x_ioctl.h:extern struct iw_handler_def
>> r871x_handlers_def;
>> drivers/staging/rtl8712/rtl871x_ioctl_linux.c:struct iw_handler_def
>> r871x_handlers_def = {
>>
>>
>> In this Email Greg writes over rtl8192e:
>> https://lore.kernel.org/linux-staging/2024100810-payback-suds-8c15@gregkh/
>> "...
>> No staging driver should ever get in the way of api changes elsewhere in
>> the kernel, that's one of the rules of this part of the tree.  So from
>> my opinion, it's fine to delete it now.  It can always come back in a
>> new way later on.
>> ..."
>>
>> So it should not be an issue to remove rtl8712.
>>
>> Stefan Lippers-Hollmann was one year ago still using the ipw2200.
>> https://lore.kernel.org/linux-staging/20231024014302.0a0b79b0@mir/
>>
>> Here my opinion why I think we should reconsider this:
>>
>> I really like to use old hardware. One of my computers is from trash
>> and the other one is bought for 50€ three years ago. But non of my
>> hardware is from before 2012. Do we as a community really need to
>> support hardware from 2003 in kernel 6.13 for WLAN that evolved so
>> rapidly? I do not think so.
>>
>> People around me are complaining that the 2,4GHz WLAN is difficult to
>> use because so many devices are using it. Such slow devices consume a
>> lot of time to send and receive the data and block therefore other
>> devices.
>>
>> The longterm kernels will still support this hardware for years.
>>
>> Please explain to our very high value resources (Maintainers,
>> Developers with wext and mac80211 expierience) that you cannot find
>> any other solution that is within technical possibility and budget
>> (USB WLAN Stick or exchange of WLAN module) and that they need to
>> invest their time for maintenance.
>> Here the example of invested time from Johannes Berg:
>> https://lore.kernel.org/all/20241007213525.8b2d52b60531.I6a27aaf30bded9a0977f07f47fba2bd31a3b3330@changeid/
>>
>> I cannot ask the Linux kernel community to support my test hardware
>> just because I bought it some time ago. Rather, I have to show that I
>> use it for private or business purposes on a regular basis and that I
>> cannot easily change.
>>
>> Using this hardware is security wise not state of the art as WPA3 is
>> not supported. We put so much effort into security. Why not here?
> 
> I didn't quite get what you are saying here, are you proposing that we
> should remove ancient drivers faster?
> 

Hi Kalle,

I propose to delete the last three drivers that are using wireless 
extension:
ps3_gelic_wireless
ipw2x00
rtl8712

Thanks for your response.

Bye Philipp



