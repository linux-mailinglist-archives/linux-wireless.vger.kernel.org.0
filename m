Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796151F9C39
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2020 17:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbgFOPs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Jun 2020 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgFOPsz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Jun 2020 11:48:55 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3385CC061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2020 08:48:55 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a21so16285507oic.8
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2020 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OE4yCeuCZUazZoTJGl+tsn/aFiHWJMeX8KENqGfekps=;
        b=ivD370GgZbIsscSffHpaFCbC2lPKVfUhLGqRpIp8uGy6ZjDXZdRmUkZhcPVyafmBAD
         DPokgGZ+Xpa6EBA4L/uuG8d3CbhTHNJ14ynuzFRcTRZ2vFiMOcChG8J3phGsddWl0vrJ
         sBzZtB6/NyfhrruFXzUFetu+6n7/adkNigbGN/yPEdQadq3riV+PIO6umazrMK2o9R6+
         SIwdDGZy+7Wx1eH84dN1STtKQ9SYIi3SR3P0i+qNGxw0+aTVa0hIQ4leSSDShlbtlXUb
         wqJPHCUyfrqjN/FeUZ3NDmXZLf5hmfAx7YOh06/NE9lpukv1hikzfsodPK50Eao5Me4a
         JS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OE4yCeuCZUazZoTJGl+tsn/aFiHWJMeX8KENqGfekps=;
        b=HjtiO15rFN2Nm1lY0GCtPxWfeG2QD5z1uYG5SrcfDvsRloEMjcAkAqxHXFzjSADBmd
         oK9g3mpA9KHit+vCa0/fHhP5qzzdbW/kFSvfSgbfBpBSyoaHwPKdM+E+I1Lq0uAmHWXy
         +hrM1/S/qc5ppVA4Nvf2InpHkyY1txlERgyzrO5igcFC6WQ0KekdxFt81SND724gCQod
         T/RQ+sWufa6tHBwcxbmPgQpgsbwE+pUYEAJDpZh4YKjXJPW4E9/kqUjNUwAloC+vk2TR
         VrLQpZFsSEiLe/8O2COLXCpE31MrFGRhXzFFDqkSMg6P7RdYWj/byMUChB+3FF4AqqjG
         z/tw==
X-Gm-Message-State: AOAM531H/mFc2KsOjIWeR6m7GqTFOJDMBcsDBTfuOWaPoXsmQFJYdIhq
        BKRkvcaWTxCjYjDegnLyS9SOgAxG
X-Google-Smtp-Source: ABdhPJxrtFTHIBGmTZK/OEbwdJtizP/iZLvhvwiTmT2KwanpTaOS1dReTy83LIYOAFtj0/E4yR4GiQ==
X-Received: by 2002:aca:568b:: with SMTP id k133mr9599900oib.143.1592236134326;
        Mon, 15 Jun 2020 08:48:54 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s67sm3368381oif.0.2020.06.15.08.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 08:48:53 -0700 (PDT)
Subject: Re: rtlwifi/rtl8192ee suffers with very low performance in AP mode
To:     yagoplx <yagocl@protonmail.ch>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <_9i057mDZgqJwU9cZCClK7erB0rE5GPEuQ37f981Y4iTNgXOy043Ha_Mi1tY4Qj4gbmdkpoShkETdtX448tXL_pH5TT9yC02TsEnia_Dmmw=@protonmail.ch>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <1fda990f-a512-1b8a-4f49-d86c01436879@lwfinger.net>
Date:   Mon, 15 Jun 2020 10:48:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <_9i057mDZgqJwU9cZCClK7erB0rE5GPEuQ37f981Y4iTNgXOy043Ha_Mi1tY4Qj4gbmdkpoShkETdtX448tXL_pH5TT9yC02TsEnia_Dmmw=@protonmail.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/14/20 10:30 PM, yagoplx wrote:
> I have been using my home server as wireless router for a while, and this issue has been around with me for a while too. I got the TL-WN881ND v2 from TP-Link as it was the most robust option I could find for sale in my region, and started using it as my home personal usage access point. This is a PCI-E rtl8192ee-cg device.
> 
> 
> However, with the rtlwifi rtl8192ee driver, the AP suffers from tremendously slow performance, especially on download speeds (from the point of view of a client device). This in turn makes this driver's AP unsuitable for anything other than very light browsing. Here are some results:
> (as measured from a very close device in line of sight with a clear airspace)
> 
> 
> Link Power Save ON: download - 105 kB/s, upload - 1194kB/s
> Link Power Save OFF: download - 105 kB/s, upload - 1194kB/s
> reference, ethernet connection feeding the server
> download - 91786 kB/s, upload - 38255 kB/s
> It's always the same speeds... which is very odd. I get very similar results with the default firmware and the "_new" firmware. At this point it feels like I have tried everything under the horizon.
> 
> 
> There is one thing that works to make this card more performant as an AP and it is to use this driver: github.com/lwfinger/rtl8192ee .
> 
> 
> 
> It lets the AP work at about 50Mbps download on the client device, which is half of the wired speed but still less than advertised by the device. However I would like to ditch that driver in favor of the kernel driver, because the kernel driver has features I am interested in that the alternate codebase one doesn't.

Half of the wired speed is probably the maximum that you should expect.

I cannot really speak for Realtek, but I would not expect a lot of current 
development for a 7-year old wifi device. My role in maintaining these drivers 
is to fix crashes, not to improve performance as I do not have any knowledge of 
the chip internals. Your best bet would be to add the new features to the GitHub 
driver. I would be happy to review any such proposed changes and merge them if 
appropriate.

Larry

