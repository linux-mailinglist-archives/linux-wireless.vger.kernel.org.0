Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA15F48B798
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 20:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbiAKTqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 14:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiAKTqH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 14:46:07 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D353C061751
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 11:46:07 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id h30so109923ila.12
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 11:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetfuse-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=m976ZOOfMhMYP97/OdAcDhlMaDfdLKB2SzSP79pG6rU=;
        b=Ifh952qNWH/v7QHzjjr+UkhcmbE8oThNA+/hfkXMpfqJdYrXBidv0a9+fajrrpAsCO
         Mu0/vEe1PT/rg0LfQI7sl+tJxIqowzdcnP8c+v1MdZTNF8rOycO7Uvf0tXifkfS9j8FW
         iW51ShC/a4ZAY76wfHzxHLaIjD7a+MBwkTck8AvP4Qa5MshuLxjvGSZh4r1nH3GnDa8D
         9aTcvs7s7p4iiv5DB3n2YYF9yQE/Mt3ier2bjRES3mnTAiTFMbA+e/5/hBasW7eXkHEi
         lftdPngBgZpiBkrEJcCH0OIUXugN0srklU7sVUlFwHwXzn13jGGeEPg6CHGA3lyVb9gO
         qp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m976ZOOfMhMYP97/OdAcDhlMaDfdLKB2SzSP79pG6rU=;
        b=S/PXmlXTq+qaBC9WrQ/XkbvnF8zucfax1qFT73S0w2yXo3Oudj3Ie4OuDlBcIRRMAE
         EjkkktDp7gJ4s1cJGQglU7MCf7vbSlF0Z6m+J1AEHPlHNKxyiBWAam7IlXGP8F0jAyGw
         6dmmUVdL4gAzLBP+eVW1pZs0bR2hrPUoKjIlhC/S9Jm17aDSxFBZIQtaV+C6GJPCG+u+
         3GaoQBgzZcg/Xe5PH0yZFeXKcc/U6/dHWosOYnPI/bC9hvG4OPGKPzbLMm1ZWrvFWxq2
         KjBMv0Z7hpc1nroc7vAnrVX09cL2zdYVsNcUwJsc4eGvtOnHmYNoEe81lRzL31+3c/Na
         nkKQ==
X-Gm-Message-State: AOAM5306ncximP6L67tzgCx3R7L8A9YVPbmkmScDVz63b153AWvaW631
        rTu2SAOXxrQ3IMsmL44M6rZ1wHuacMr+Bg==
X-Google-Smtp-Source: ABdhPJysshWlktfuU0b3wQF3JPvuMgWIrb9HU3eVShPilmklu/AhKCJZaimyCT6VEpkQtn0csyMuFg==
X-Received: by 2002:a05:6e02:1c2f:: with SMTP id m15mr3186081ilh.206.1641930366539;
        Tue, 11 Jan 2022 11:46:06 -0800 (PST)
Received: from [192.168.1.15] (174-082-179-210.res.spectrum.com. [174.82.179.210])
        by smtp.gmail.com with ESMTPSA id o21sm6885077iov.48.2022.01.11.11.46.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 11:46:06 -0800 (PST)
Message-ID: <60724ae6-e8e2-183d-575a-0186e45c3fae@jetfuse.net>
Date:   Tue, 11 Jan 2022 13:46:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: iwlwifi: AX201 not using 2 receive streams
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
References: <3cb11500-6828-6ded-bebc-cdb6e1f97bc0@jetfuse.net>
 <521b0dba-5866-ff34-da5a-479bc95cc9d9@candelatech.com>
From:   Brandon Nielsen <nielsenb@jetfuse.net>
In-Reply-To: <521b0dba-5866-ff34-da5a-479bc95cc9d9@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/8/22 3:22 PM, Ben Greear wrote:
> On 1/8/22 12:50 PM, Brandon Nielsen wrote:
>> I have a system with Intel AX201 not using 2 spatial streams in the RX 
>> (download) direction. TX (upload) functions as expected. I'm seeing 
>> similar behavior with an AX200 system. I'm seeing the same behavior on 
>> 5.15.12 as I am with 5.16.0-rc8 so I didn't mark it as a regression. 
>> Windows works as expected.
>>
>> I have opened bug 215465[0] with some more detail.
>>
>> [0] - https://bugzilla.kernel.org/show_bug.cgi?id=215465
>>
> 
> We saw something similar with ax210, but only on 6E, in kernel 5.15.7+.  
> On 5Ghz, it worked 2x2 as expected.
> On a 5.15.0-rc something, it worked OK for us.
> 
> We verified same firmware is used in both cases, but have not fully 
> bisected the problem yet but we are
> working on it.  In case you find the problem patch before us, please let 
> me know!
> 
> Thanks,
> Ben
> 

I'm still seeing this as far back as 5.11.12, so I'm not convinced this 
is a regression. At least for the 5 GHz / 802.11ac case.
