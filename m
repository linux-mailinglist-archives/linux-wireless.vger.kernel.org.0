Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4951D897D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 22:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgERUnC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 16:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgERUnC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 16:43:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081DDC061A0C
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2020 13:43:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u188so1008857wmu.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2020 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2+OAMC4f8T8COIY9Oe99/zNWSXXY4klst0LI8Khi3iI=;
        b=RHmJKo3OWoWHHgmoVSvel9TIKRudNnLvNsL3iFCSiMgjKqKcClkOpHFiys2RWFIfoc
         fmLiGlrI+Ve5lMtydmPobFtEq5dg32cfi+q3JQljRZLwJolPxFCwOzqfDuLg7FPx3h0t
         8lCJehwHXF9xRN0e+lKEwS2ScF7oCxGASwjJFCRfO3zi0INDgRurMXdS7ES817zYGDVn
         DCoaPhxhHCjM7e505GbTljsBWwWcNH8VYH1XkbQ05SQGJvLYQYV/Nch3gdb4+VEKOfyE
         MWYzFSx04WwF2lkOboROLDhnMfN/7jWNt6kLD+OvYAibH5v7BbCML+JOaCdIBbJa3EWq
         1CEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2+OAMC4f8T8COIY9Oe99/zNWSXXY4klst0LI8Khi3iI=;
        b=Wp+N2KBYjX31ylF/1nK+q5bvDfroya+t2aLSeI2lqSezd2tveLPBuyiFsPHFCr9B4k
         SA+2Mt4vPoi6pbFvBrokWRbte4vYyrYtAAwBRyTgMA9g2yewBJzXEn4z40KC6ZC4oEDG
         X+r5evpHh2+HoxYIhURghqNeqkSnUqlx19vsyJTix3T9/USfUAYhGg8Y2wFq42iX1eom
         vb/+/wv1YPToWNt3idW7/ir4r11c9cYS2YETQ+BCBD3/TpYzsLZiaeqUsodC768aYVRL
         5/fqoYwitkN5y//mb5exxPc88+2Qxig3zlfdRF5/DtbOANjs51/TWC4Qjin4n9z5trNg
         ip4A==
X-Gm-Message-State: AOAM532ux5KS3T6rLYhymZ12qdbTFjfGcxSjENCHVqZ7CElfUJSBaFPF
        7CTFQ3OjsvuCblB/xITEAm5YO41F
X-Google-Smtp-Source: ABdhPJxRjmW46dOIk4uevB/ewboU3ixzG1+pTwMZ82VSiCsix8rplOc9LGyHv5HNixW/1N4jyHwwfg==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr1304150wmi.86.1589834580500;
        Mon, 18 May 2020 13:43:00 -0700 (PDT)
Received: from [192.168.43.227] ([185.69.144.134])
        by smtp.gmail.com with ESMTPSA id y4sm18401718wro.91.2020.05.18.13.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 13:42:59 -0700 (PDT)
Subject: Re: [PATCH 2/4] staging: vt6656: vnt_beacon_xmit use
 extra_tx_headroom.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
References: <5f00d319-9242-65b2-d100-dcfe9b0e32be@gmail.com>
 <20200518123944.GI2078@kadam>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <fb7a7013-5fbc-d69c-dd20-27ba39462100@gmail.com>
Date:   Mon, 18 May 2020 21:42:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518123944.GI2078@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 18/05/2020 13:39, Dan Carpenter wrote:
> On Sat, May 16, 2020 at 11:39:34AM +0100, Malcolm Priestley wrote:
>> Create room for vnt_tx_short_buf_head in sk_buff and vnt_tx_usb_header.
>>
>> The struct ieee80211_mgmt is not longer in the header and is at
>> the initial skb->data point.
> 
> I feel like the SubmittingPatches guidelines on verb tenses and not
> saying "this patch" or "I" has got everyone so worried that it's like
> playing Taboo.  Do you mean that the struct moved before or after we
> aply *this patch*?
The struct has not moved, before skb->data was copied on to the address 
along with the rest of frame.

So now struct needs to be at skb->data.

>>
>> Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
> 
> I can't understand the point of this patch at all.  Is it a fix or a
> clean up?  If I had to guess from the subjec, I would say it's a
> performance improvement but I don't know.
Well there is a performance improvement as there is only one buffer 
instead of two.

Mainly to bring into line with other drivers in the mac80211 tree there
is no need for a secondary buffer in driver.

Regards

Malcolm

