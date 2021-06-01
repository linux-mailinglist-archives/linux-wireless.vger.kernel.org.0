Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3384E397AAC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 21:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhFAT1a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 15:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFAT13 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 15:27:29 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF827C061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 12:25:46 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so335982oth.8
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 12:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BOQ1GQ+IEkfwFktpRugO9EzPODzzRKWrqGs1OMr1CiA=;
        b=VOtBCloiedT+Zsmv0hBUA6elAiA1unCKvrAZc8wFCjZTBL1wOqNnGR+dUo5uHfGuSw
         3suKwYI2eVaNw2foRCBGBhbO2vGt7a7YDZS1bLIqbusfuiCU1fI6Ah22UA6aMfx2PL39
         AyMOH6WP0AmesyRLlHV5PDsddL9YsVa9iHnf/nENlJtReoo1NDQK0H7m7dY/6RjlfueR
         T5R6CzBhg98G/jCnxihlGXKz138NMno+Pffyl9nasc3dzljd/8xJp4sLB1ol16xoJ3vW
         JQqgjYAB5Ewpk4FO01MYzHfKB5gcOh2F6s8hygj1c+C1GkPyAVDTcOFjwD4lHSlq++7l
         oRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BOQ1GQ+IEkfwFktpRugO9EzPODzzRKWrqGs1OMr1CiA=;
        b=W0jfEzT2+LaxYARE58YLKeJ48f+JUELT1icl2tZqjdIxF1jZjBcLVtS7UNxWfcktnc
         8FBEwLGw9Ji1ypISo5hBj32dgJBkZWFIII/Gfu8FpddwHgAXj1hEa/iI+0mCy+77PKEX
         arDINBx2Isa+97dAXiWvKSz7rUH9kJ3Df+LBjZr8sH5GotSs7BK685k4kipPKhpBYe4y
         ygRR8ZfA87m/EXfNUxJ395AkyI7fb0eQJnTj3gz0nHco3FZSSGh6hhMW5ARgASJFy5Be
         ouBpjn5Ap1Hii4GyWrdZpmYlKOrbmgNJj+78Pt7fPxTNfGGIZR5YKpH7fOOTz+n7m3Q2
         zI8g==
X-Gm-Message-State: AOAM532UGNiC4D+kAmZfA1on0Up3b7nCLKbXOEKVeg0PMsxLlJk062AJ
        nZWkpUvd6i+eWiTaGpSEkWlLeV5fwzY=
X-Google-Smtp-Source: ABdhPJwelbbNGOOhxx9Ss0AtyOZtlUkGbLWAINzcHnXphjcKQ1BtZ0DqbNG5F/GeZijEf3+4Z1L7gw==
X-Received: by 2002:a05:6830:2707:: with SMTP id j7mr12016913otu.171.1622575545859;
        Tue, 01 Jun 2021 12:25:45 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h7sm1655840oib.49.2021.06.01.12.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 12:25:45 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtl8822ce no bluetooh at all
To:     Alfonso <alfonso@el-magnifico.org>, linux-wireless@vger.kernel.org
References: <6d9bc41f-cdfc-2ee5-22ff-72510e084dac@el-magnifico.org>
 <8a315442-db34-e3de-4455-dbc9a2891408@lwfinger.net>
 <6a09991d-9e8e-fa31-ff6f-8b27f11e98f0@el-magnifico.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <28a9944b-f66b-2279-6083-a71585e2f48a@lwfinger.net>
Date:   Tue, 1 Jun 2021 14:25:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <6a09991d-9e8e-fa31-ff6f-8b27f11e98f0@el-magnifico.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/1/21 1:57 PM, Alfonso wrote:
> 
> El 1/6/21 a las 20:08, Larry Finger escribió:
>>
>> Your dmesg and lsmod outputs do not show a BT driver loading. It is a separate 
>> device from the wifi unit.
>>
>> Please reply with the output of 'lsusb'.
> 
> 
> Here you are:
> 
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 002: ID 0408:5365 Quanta Computer, Inc.
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> (I even suspected there is not a working bluetooth chip, but it works when I 
> boot the preinstalled Windows 10)

The above output shows only 2 hubs and a camera (the Quanta device). I see no 
mention of a BT device.

I think you failed to attach the 'lsusb -v' output, but the verbose output is 
not needed.

Larry

