Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3966E43E007
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhJ1Ldd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 07:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1Ldc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 07:33:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E97CC061570
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 04:31:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d3so9566579wrh.8
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v45ZDvsCFAEFClI2WbhlvofL+jPYAH3IJRRv2CmKvZY=;
        b=Dtp5BSb9RfS5Q4eAHJvIgnSeVRI0mFRwjSX9yXn/Sa3FQT1nKdOPINwHjwY5joS6bw
         0eIi4/vNnwD7l/M194kArgX4XYRTK3wGwOk1/3ZY8SmsotdyzNnLbWlWI4AzSVcgaloO
         PpX+Fa/RRGtn/VZkWTNFlLNmlUxUrkeEiUJVmsSBQH92B+XQdfEG9ma8Kq7rKTbsg3ab
         y7p12BmbHUcHzdegTgjCyafL2Wsv8qG15CFQBTX2fM2mtQ8aItp1tqVhC4tSpokqui4o
         Z4t5hevM59e9kflaaCJx2YeTXcQPkVaVppylYPjLxMaNCBR5F7fulQBrJe/+I3ZhOoV+
         S+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v45ZDvsCFAEFClI2WbhlvofL+jPYAH3IJRRv2CmKvZY=;
        b=53hIMDNznPE9/FjF+52aMTRJh75C6JLSxyyMU53OBIgLiDyaCVFFIpak8lW0rubrJ8
         exCnS5oT6j2K0ykJrfVBkt2nBzpMljZ3SlRp3AxsdvoWGhnj9o6RwnbYjKc1gICTWPZx
         aWJ+AXHQZZXl/8BdDUdViFqdPMmGEn+XntSEp7G9k9JbASekFJuTzwQkDsvCr/a4naUO
         GV0gW7EQ1SDl0id3KjSFz8XV+8z1T5SEIFsUJeUHc6HtXAkpuxxDu9LD8TAnOjSJxZrb
         c1LUaSsMHzjxCloIobID4JgR89r/As+V3PpgnAKpzHs5mqp1Z41GrcNXodO7YNVYy2Du
         TXgw==
X-Gm-Message-State: AOAM533wJF2rGS7UD0eGUGZImYbB/zYoygWNZWCtnT8d5+I9Ef+duuJb
        FNNnKftGDyt2nc9KHsoH7e0Gx6NDuDQ=
X-Google-Smtp-Source: ABdhPJw/1GYkx/Y2CbDy7KIVuyoIC0xF5Cv943IL2bvIf/Qr4SjNwh8qFyBBOVkIW6iQCRMTBjqlaQ==
X-Received: by 2002:adf:f8c2:: with SMTP id f2mr5062194wrq.234.1635420664066;
        Thu, 28 Oct 2021 04:31:04 -0700 (PDT)
Received: from debian64.daheim (p5b0d7857.dip0.t-ipconnect.de. [91.13.120.87])
        by smtp.gmail.com with ESMTPSA id m3sm2769475wrx.52.2021.10.28.04.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 04:31:03 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1mg1jk-0006pt-1M;
        Thu, 28 Oct 2021 13:31:03 +0200
Message-ID: <3a8840ea-1499-950b-fb44-7546a32c586f@gmail.com>
Date:   Thu, 28 Oct 2021 13:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] ath10k: fetch (pre-)calibration data via nvmem
 subsystem
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Ansuel Smith <ansuelsmth@gmail.com>
References: <20211016234609.1568317-1-chunkeey@gmail.com>
 <87ee855xwa.fsf@codeaurora.org>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <87ee855xwa.fsf@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 28/10/2021 10:58, Kalle Valo wrote:
> Christian Lamparter <chunkeey@gmail.com> writes:
> 
>> ATH10K chips are used it wide range of routers,
>> accesspoints, range extenders, network appliances.
>> On these embedded devices, calibration data is often
>> stored on the main system's flash and was out of reach
>> for the driver.
>>
>> To bridge this gap, ath10k is getting extended to pull
>> the (pre-)calibration data through nvmem subsystem.
>> To do this, a nvmem-cell containing the information can
>> either be specified in the platform data or via device-tree.
>>
>> Tested with:
>>          Netgear EX6150v2 (IPQ4018 - pre-calibration method)
>>          TP-Link Archer C7 v2 (QCA9880v2 - old calibration method)
>>
>> Cc: Robert Marko <robimarko@gmail.com>
>> Cc: Thibaut VARÈNE <hacks@slashdirt.org>
>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>> ---
>>
>> v1 -> v2:
>> 	- use %zu and %u in the format string for size_t
>>            and u32 types (catched by the "kernel test robot").
>> 	- reworded commit message + successfully tested on QCA9880v2
>>
>> I placed the nvmem code in front of the current "file" method
>> (firmware_request). Reason is that this makes it easier for me
>> to test it. If needed it can be moved to a different place.
> 
> Looks good to me. Before I apply this, I want to mention to that I have
> had a long in my deferred queue related two patchsets:


> https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515.86-1-ansuelsmth@gmail.com/
> https://patchwork.kernel.org/project/linux-wireless/patch/20200927192515.86-2-ansuelsmth@gmail.com/
Oh ok, serves me right for not looking thoroughly googling this first.
Alban Bedel and Ansuel's work made this nvmem all possible. And indeed,
the second patch here looks eerie similar.

Do you want to go with his two patches instead? I'll change mine, so it
just consists of the cal_mode for the older QCA9880v2,QCA9887 and
add the -EPROBE_DEFER handling. This -EPROBE_DEFER only ever comes up
with the Meraki gear. This is because Meraki likes putting the MACs-Values
into SoC-connected AT24 eeproms-chips. Everyone else just have them in a
proper FLASH partition. Though, this's usually nothing more than adding
the following line:

if (ret == -EPROBER_DEFER)
	return ret;

> https://patchwork.kernel.org/project/linux-wireless/patch/20200918181104.98-1-ansuelsmth@gmail.com/
> https://patchwork.kernel.org/project/linux-wireless/patch/20200918181104.98-2-ansuelsmth@gmail.com/

Ansuel's post: https://patchwork.kernel.org/project/linux-wireless/patch/20200918181104.98-2-ansuelsmth@gmail.com/#23639361
 > You are right about nvmem... Problem is that nvmem for mtd is still not
 > supported. I already sent a patch to fix this in the mtd mailing list but
 > I'm waiting for review...
 > If that will be accepted, I can convert this patch to use nvmem api.

The nvmem api is there (which makes these two patches obsolete I think).
Granted: The nvmem can't do all the same cases (From what I know, mtd
partitions splitters and mtdparts through commandline is being worked on.
But we always have userspace + firmware_request as a fallback).

Cheers,
Christian
