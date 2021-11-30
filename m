Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C7C4629EE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 02:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbhK3Brf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 20:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhK3Bre (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 20:47:34 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC4CC061574
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 17:44:15 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id n66so38166161oia.9
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 17:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dYgle2TQqxBMfBcYS/e9DdFKIsZGVDynNtyyjpWOejc=;
        b=MsNr3jwSotek5GpaxTkTUJGiztrP8Rfv8wrTz7JeFXW7vS+DScrrAy1UTMVIi6KmtK
         0QSLE0BmpHgc7hPEUnzj7JyxwLOW8rXJyhgq1svuZQgPjOjDY5QbkDS1C7dOrF82KnwU
         bNGZx9lqVPQKAf6QGkXfC77fVbsR2KlBbPkFwc37e31LJTRoDEVsTpYCUvl0V9O6MJj6
         frAJqxN1bmbNKIAQKWKp3XQBxyaRjglcIJCPB1VqznFkUKUmdNSdEhKpDZF5omquQAUa
         3FcXyLrAQs23qz/Xne1rlsF6Q1Sgs3u9p210yxAGrVaLBLBK0LBVkukbeZiHqk3GQbi9
         JVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dYgle2TQqxBMfBcYS/e9DdFKIsZGVDynNtyyjpWOejc=;
        b=JPx1uVkHKJX7aBgGNMAMCiLvZlVs84QdtZwObOIiQQp+wh22FVpEXgk3npmocs1vWS
         +Nxgyi6zdel9G02CYZqT0mxqv1rcI56jZYTJC5MuTRU1YDgTENzMFPQhq/+wx9LpRu9x
         yqGNsgYVDe9G0S5diadwS1qkiWFL5ARWFgcdczzdRFLOyHztm6SqqWhjyKIirjpGQcLO
         hZ3u53QwaJOgEmnMoGJCj2GEuDi4tuZT+/aYW03z/M0aq4FVMbpzdAOtJAckJW4Z84V1
         S7vQO1TFYzTmZyxdjv+voDFC7x8od8Pafqc7zdLXkcWxLmDXivYToLHW/imjCji+JHW5
         lctQ==
X-Gm-Message-State: AOAM532j1yykxe965zJ9eqfemMub1E/5NwsLbpUx0iuzR3T9ePvGOJb7
        8o5aRU7gjgxThGal66wI+Om9Ko7wN2g+M2Y+
X-Google-Smtp-Source: ABdhPJxZaqtu0dVdQaXXNbV+qvzuO0sSsLReV/BeULea6L0K5HQ/UL0vrCUS8FE31PgBDn4ikeHqqw==
X-Received: by 2002:aca:2408:: with SMTP id n8mr1589569oic.124.1638236654852;
        Mon, 29 Nov 2021 17:44:14 -0800 (PST)
Received: from [10.62.118.101] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id bj8sm3580560oib.51.2021.11.29.17.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 17:44:14 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <5fff6faf-87a0-673e-0fda-853eb0391797@lwfinger.net>
Date:   Mon, 29 Nov 2021 19:44:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: USB for rtw89 driver?
Content-Language: en-US
To:     James <bjlockie@lockie.ca>
Cc:     linux-wireless@vger.kernel.org
References: <5bdf4393-273f-2ad2-40e0-556ec7dc6817@lockie.ca>
 <867f4b97151745d5a5fa0daa5ebcdbd2@realtek.com>
 <3fef8020-a496-41e3-8974-4d16ff4551b6@lockie.ca>
 <917dde5b-36c7-a079-6dc1-7441a2f90745@lwfinger.net>
 <dac5960c-44f0-300e-d3d7-6ae23c3ae64f@lockie.ca>
 <5e815a38-eb5c-7dac-7243-1d734c1acd3f@lockie.ca>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <5e815a38-eb5c-7dac-7243-1d734c1acd3f@lockie.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/29/21 17:37, James wrote:
> Does anyone know what this is?
> The releasenotes pdf says it came from Realtek.
> 
> https://github.com/shiqishao/RTL8852AU_WiFi_linux_v1.15.0.1-0-g487ee886.20210714
> 
> What are the roadblocks to getting USB support in the kernel driver?
> 
> Is it possible to have a USB part of the driver that uses the kernel part of the 
> driver?
> 

The file structure indicates that it is a variation of the USB driver from the 
Realtek group. As such, it will have all the flaws of that family of drivers.

I have previously estimated that it would take about 6 months of work to get 
such a driver into shape to be submitted into staging. The approach taken in 
https://github.com/neojou/rtw89-usb will take a lot less time; however, without 
the cooperation of Realtek, it will take a lot of USB dumps to compare the 
communication with the chip to discover what differences there are between the 
PCI and USB versions, other than the obvious base platform data flow.

Have you tried either the shiqishao or the neojou driver? If you are willing to 
provide me with a device, I could probably give you some help getting the neojou 
driver into kernel shape.

Larry

