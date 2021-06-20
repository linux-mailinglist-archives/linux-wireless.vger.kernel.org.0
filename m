Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120763AE00B
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jun 2021 21:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhFTTfl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Jun 2021 15:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhFTTfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Jun 2021 15:35:41 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE1BC061574
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jun 2021 12:33:27 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so8920617ote.11
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jun 2021 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F3Jbo1bxOigIkwADGzw1igpxGAGZ3MA+IpwTBWPHAQw=;
        b=LrDTXQ6Weq+s3Dcx2XrwOz46ZSVct55JDobtGDWGyNmTS/yNJE1ZiM6QhKupk6QKke
         vONbE56lc3ljNTKZ2FhtT5GfvCPJtA+wmJyy3CGRz6HWXRsV1VISl5wBAffjHz0SoOX4
         QMwvm23E6NCMnW09bObZoa+oyIAwltW0tXWR4yglUvJNBZkWkV9qXBq3sUndZs78OMhT
         gRtkBXMBU4BWoyrTMsly0ZilQCKOlyOaUlB7ZKt50o0iWOKAQLXArExPObLI2gWLEhLg
         qKIwfkGs88xD2AApz1yFmkTlLDWAq0bxpmDoLX31iYsRYgrDByOzdBLQREmmsFnL+rkZ
         kzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F3Jbo1bxOigIkwADGzw1igpxGAGZ3MA+IpwTBWPHAQw=;
        b=oJNieMMIETDyohEerDPuMoPyDDEJV0sPxqZ/ANWdRX+eI+xuBJCLmLYYgC6vXnc7aA
         RRtwfkUyd7nGYH1pf24YltSHoGdfSMdi61IOpnfeZpjRVEyGfjLOguCIU3C22VlPinIi
         XDP5GVm7y2jvaJZgwIAQ4C6TCc15eIMRN82kwWbb4pXVy79jy1WtuBLtd8dI/VWC/2ld
         cJqIbJcKqEypf8mx/ZmmFStEQnRZwYajltf9EKdMvk64S4nD/uxUHqD92jromCX+g9pR
         nehHmEJ9hM9eH5wXsWzzG63fTEVpbOPY89cL7SEGYtdlCxjCJsMmy3DyiKhRNFyKn4cO
         bECg==
X-Gm-Message-State: AOAM530xg4MaR9Rmvd+trpbpzR4/EXS3rqb36AV71GScRqdL+mM3C7/T
        SbF/4poVxaNkj3j6H9yjlXxNpYnVLTk=
X-Google-Smtp-Source: ABdhPJxbf/WIh2oVKOspNZX5AvN6euFceRJOqfwxWX3bgHEPIRCLi4+JdMGQc3Ca8/JdkdoKsxXyXw==
X-Received: by 2002:a9d:2669:: with SMTP id a96mr17651433otb.127.1624217606256;
        Sun, 20 Jun 2021 12:33:26 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id q18sm956695otf.72.2021.06.20.12.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 12:33:25 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Memory leak in rtw88-pci
To:     Brian Norris <briannorris@chromium.org>
Cc:     =?UTF-8?Q?Klaus_M=c3=bcller?= <kmueller@justmail.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <83a9aeff-ce2c-3442-90fa-7e190acf3dfe@lwfinger.net>
 <1af1e1f4-caa4-323e-0a2a-b3fdf1cac6b8@justmail.de>
 <92a3ff23-2763-44e2-a20e-25190d46d4bd@lwfinger.net>
 <CA+ASDXOY8HRjU6JK8a_Z9KUnXr3w_qXVU7hK56+6c2DQKiyFVg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <75427961-7d9b-d943-f0b0-118ab8645be9@lwfinger.net>
Date:   Sun, 20 Jun 2021 14:33:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+ASDXOY8HRjU6JK8a_Z9KUnXr3w_qXVU7hK56+6c2DQKiyFVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/17/21 5:54 PM, Brian Norris wrote:
> On Sun, Apr 11, 2021 at 12:35 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>> On 4/8/21 11:12 PM, Klaus Müller wrote:
>>> May I kindly bring up this reported problem again? Is there anybody working on
>>> this problem? Or did I miss the already existing fix?
>>
>> A fix has been found. The patched code is available at
>> https://GitHub.com/lwfinger/rtw88.git. Patches are being prepared for
>> wireless-next. From there, they will propagate into the Linux distributions.
> Did you ever submit the second half of that patch?
> https://github.com/lwfinger/rtw88/commit/0eed97166d54cf6fa03e20735b9c208375b8c949
> (modifications to rtw_fw_c2h_cmd_rx_irqsafe())
> 
> We're still seeing leaks here with kmemleak, although I'm using a
> 5.4.y kernel, so maybe don't have all the latest fixes yet.
> 
> NB: I *do* have this: https://git.kernel.org/linus/191f6b08bfef
> as it made it to 5.4.y.

Brian,

I fixed the leaks, but forgot to submit the patch. My repo at 
https://github.com/lafingerrtw88.git has the fixes, and does have any leaks on 
my system. The patch just pushed has the same fixes.

Larry


