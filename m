Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213C020F50
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 21:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfEPTsF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 15:48:05 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42807 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfEPTsF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 15:48:05 -0400
Received: by mail-ed1-f54.google.com with SMTP id l25so6875381eda.9
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2019 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7BcZufcPSEpqc805Y0v0Pyi0qibUQi4HpJsgg2Ly3lM=;
        b=Dc7DGW7gFlIR0h6wNiPysgB95qTNqmrleG8yY10+P8GCMAklThvklYUPphrFvHDKS5
         DTdI42DfiUTirdXT8CFFbmgn9/Wlwt08XkuBZ/i1o45EtLB8ZkHY3WhA7JQvt9MHfUY7
         GkW15ngzI6B+Bxm6+0RreoT6IMtgp804qxqiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7BcZufcPSEpqc805Y0v0Pyi0qibUQi4HpJsgg2Ly3lM=;
        b=HKuUSvSS1UPif5CGkvNH+WHkoVjx+XUiwEl0C3CNeGW8qlCDmDmwj+Ef817BNERSq3
         RFIDnMnJcMe3en+aIkzAnBXRLdAvvfxQglG8+6yYw6UIhbphGWvNNclbUNVCPF5dwVXO
         1tfNmHkLVenj+L+lAmukemTU0+MGQWUyVHWyIymfhkk5MkOrpSOoksG++i8WntHTqWEs
         mFs9qM6seZNM/ERNnN6Wb3l9nKHQrQSL6AmiT9F6o75+klPqC99dNFR6Slc/lw4Ou8RS
         Gu9EH26FlYORyGjp9EU/MVlfpMTJtr8ziEHP9foIvx4Tv3VvwzYXj59wROwQ0MSz3LqL
         Diwg==
X-Gm-Message-State: APjAAAWlT2CDFlS75D9Es9SOrGa0gpIDSq6x8Gu6QnMqlfFB2uDAQ2JC
        4l+G1wxkc556KQ4OEtaZvp1EWTqd4EruWSQr9DNX++jTif05RsPcRahFYH1af4QOXbvNGUwu55m
        2+WH5eUbIqzg3Sjx0giWCerYrOh4Ia8UsPiTaRU98KeGfzC6+3ilVJQrAat71jdEbUcvXSd1bVS
        MOlKO2Ez2cBA8I/w==
X-Google-Smtp-Source: APXvYqyMr4J7GGKLKWte6Io6Uj0cjtux6Mcx6UA8tsi65o5LtdNbt8a5A7PDnuOadwJXHh6I+BlibQ==
X-Received: by 2002:a50:9858:: with SMTP id h24mr5155905edb.147.1558036083033;
        Thu, 16 May 2019 12:48:03 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id 44sm2136201eds.90.2019.05.16.12.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 12:48:02 -0700 (PDT)
Subject: Re: SPDX identifier
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <b04655c7-5a6e-b510-5fcf-30ecca489882@broadcom.com>
 <alpine.DEB.2.21.1905162015460.3196@nanos.tec.linutronix.de>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <7cc73717-def2-effa-f0d9-4512b8501955@broadcom.com>
Date:   Thu, 16 May 2019 21:48:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905162015460.3196@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/16/2019 8:17 PM, Thomas Gleixner wrote:
> Arend,
> 
> On Thu, 16 May 2019, Arend Van Spriel wrote:
> 
>> Hi Kalle, Thomas,
>>
>> I added SPDX tags in brcm80211 driver sources. Although it is a no-brainer I
>> decided to run checkpatch for the changes and quirky stuff started to happen.
>> For all files I added:
>>
>> // SPDX-License-Identifier
>>
>> but checkpatch started complaining I should use /* ... */ instead of //.
>>
>> WARNING: Improper SPDX comment style for
>> 'drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h', please use
>> '/*' instead
>> #29: FILE: drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h:1:
>> +// SPDX-License-Identifier: ISC
>>
>> So I edited all patches and ran again. And again it started complaining.
>>
>> WARNING: Improper SPDX comment style for
>> 'drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.c', please use '//'
>> instead
>>
>> So now I am in a bonkers state. It seems for header files we want /* */ and
>> for c files we want //. For real?
> 
> See Documentation. This is historical because the older binutils choked on
> '//' comments. Not longer an issue as we moved to more modern binutils by
> now. So we can fixup the documentation and allow // style for headers as well.

Right. I was pointed at the documentation already. I will ignore the 
warning for my series and stick with // style for both.

Thanks,
Arend
