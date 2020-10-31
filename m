Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7F2A18D2
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 17:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgJaQxb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Oct 2020 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgJaQxb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Oct 2020 12:53:31 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBFFC0617A6
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 09:53:31 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id k3so8596506otp.1
        for <linux-wireless@vger.kernel.org>; Sat, 31 Oct 2020 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FpPpqM3wR7Lk9d6bprhXAXIeXGiVzeBSAx9eei2Lq2U=;
        b=EsCzsOE3IcyLy4wVoqwc5RuWFUxUV1A/lC5cWUxWaEAMXUrOvI+EeX8AORv9q1Wr50
         BK8uB3uTTHVyvw3qq+//P5lSmuHRgHQ8dzA8tSOxRPYt15iynCMAwusylOlIYjExPaxs
         AO6yyH9GvpR8ShmpUfoleo7pwrV8Yw+tTC1wg/xyWJ3r4iiO0rx0PunK4hKvjSLmbT4q
         ItlCdEBb1qgR8+A6XEUOsj4VZeL6Hy67L1ZmrW0eyfas4OEoNjjSMtys+RATLCl21N/X
         eEi0Eq+rMVsfuckWVQnEhkgC0L4+2iPbmBKg/mvXgLvM8dGqnPETy6PmYIw+0wrJfdy3
         5+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FpPpqM3wR7Lk9d6bprhXAXIeXGiVzeBSAx9eei2Lq2U=;
        b=b3SUlGIFXUSMZAAmSFyXLVmZMIRPXl8z/FDBOzI0hvCqPXcnPC7K2y7eaA3SlPHT9K
         FquA6PE7MTouwO8WJWqKr1vTrOeoxNb6+6gRJ1M7NHtImHcpvSKPizRDLafJYG1+4/kh
         nXNUUwg0MzdqAWQbgBiKOCjqGOCcuQQgwrSSMUmuU4xWXwBrv/c/f0FbNYkEa7081gpQ
         M8WF06fCHphwhS4DwBPzK1hklm+7GrP5yiaa6MA/KMln4HOze6FlPxzPIyY49b4xhAoi
         DTPPj4Dn0bWuFo0f0lrl7yv5pkN0p9wjELTlTIrqMQaXn/+qaVIX1UFPj0os+M4lSiRF
         d4Gw==
X-Gm-Message-State: AOAM532vUTjv+H0ii5YBNzR1SJVMohnEn/IDMcDixHERctOf44jLigNo
        K+YgX3J7XGJMk6jp3OBNrRnirP/RPjM=
X-Google-Smtp-Source: ABdhPJy+OdrWAvEs+YUDkJRWnRBirbQTL+OAZzY0h5wTUNR3pvdCaVmQizElQSzyYH9aV274w/I13g==
X-Received: by 2002:a9d:538d:: with SMTP id w13mr1619874otg.73.1604163210340;
        Sat, 31 Oct 2020 09:53:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id z8sm2236174otm.45.2020.10.31.09.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 09:53:29 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw_8821ce driver in kernel 5.9.1: wifi module inactive
To:     Michal TOMA <michaltoma@sicoop.com>
Cc:     linux-wireless@vger.kernel.org
References: <6173742.tiux6Xeah1@linux-9g0r.site>
 <2483828.eKyWTE2oqM@linux-9g0r.site>
 <5712da17-6f45-247a-e9ea-a13c6b9b683c@lwfinger.net>
 <9610201.fqzlqthHOd@linux-9g0r.site>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <6ffe480c-643a-30e9-1ca9-6bb99117c43f@lwfinger.net>
Date:   Sat, 31 Oct 2020 11:53:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <9610201.fqzlqthHOd@linux-9g0r.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/31/20 6:30 AM, Michal TOMA wrote:
> On Friday, October 30, 2020 08:30:16 PM Larry Finger wrote:
>> Michal,
>>
>> My rtl8822ce works fine with 5.10.0-rc1 and 5.9.1 from openSUSE TW.
>>
>> Larry
> 
> I didn't try 5.10.0-rc1 yet.
> I suspect some kind of deep sleep mode that seems to survive hard reboot.
> I'm on a laptop where I can't remove the battery and I don't have a double
> boot to Windows to make a test.
> As additionnal context, before kernel 5.9.1, I was using the rtl8821ce driver
> for openSUSE TW which packages the driver from the tomaspinho github repo:
> https://build.opensuse.org/package/view_file/home:Sauerland/rtl8821ce/rtl8821ce.spec?expand=0
> 
> And my wifi was working perfectly fine.
> 
> Since then I tried to blacklist the rtw_8821ce driver and use the rtl8821ce
> driver compiled for 5.9.1 and the behaviour is exactly the same: no wifi
> either when the rtl8821ce is loaded by the kernel.

Use the following to try the 5.10.0-rc1 kernel:

sudo zypper ar http://download.opensuse.org/repositories/Kernel:/HEAD/standard \ 
KOTD
sudo zypper dist-upgrade --allow-vendor-change --from kernel-repo
sudo zypper install kernel-default-5.10.rc1-3.1.g91029f0.x86_64

One warning: This kernel will not work with VirtualBox. There is one 
incompatibility with 5.10 that I still have to solve.

Larry
