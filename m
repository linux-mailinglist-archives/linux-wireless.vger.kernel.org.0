Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454CC20F4E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEPTpX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 15:45:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45664 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfEPTpW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 15:45:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id g57so6839294edc.12
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2019 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4wtJ9bCKrdt1imBtq1IGi5iQGw2buXjsw/YBCMnnZRI=;
        b=QI6RQT0e9V5H6zEYr9q1ShFoIVhGyguDLhGASfDLrP2PU2GT2OEU2DLS/MdnOer8yO
         mgHVtMo2A5pnPwTGiXBl3Lb8ZsJKO2THwjIy9sWBI98gcNI1PtQgM9ZGGIvwufwKKq1v
         +FD0x0olihOkVhw4icinQvNHHR1vIKHfXl8MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wtJ9bCKrdt1imBtq1IGi5iQGw2buXjsw/YBCMnnZRI=;
        b=IKteES3WYjQF1KA3qgN3/LeHWAmsCZnDVRRRVcoGe3mkywmR7bcuP0sgJxazSQwmuG
         6AysMq0IC95jPn63vBJbtORB35TMkA45fg89pFqBLBKv6xY7g7Bd5l4ziEdEvGJvuXrk
         wl2woi9ogp4NcFzAzOa4HqXMg8eceupGbBF6Mxey8FHeRDAjk0emIPmDt4iWc/s4x2Wq
         wPAsJoMNMnfCNQvfCNTDJ7lHcWB6rVBduihOUXfE0H0jGWgeAetBFhjiIYSE2Hk9wkZA
         CXFXdoXRLgwxXPBDtVbF77cGHk0mgQDVugu1Mdo0q6NOYSnsaXK2kbojg41MAk/eqcqG
         qJkg==
X-Gm-Message-State: APjAAAXYirbI/2t2LtjD+ORJwKBrSm7jVI1SXIkJTBVyp2gjSqsUIoxL
        dDdkv09IrfcpzD98M2XSRWZQyw==
X-Google-Smtp-Source: APXvYqy5imwfVIayqnKL229HZ/5prti7CZQoJk9XxMVr29KPa1O5wRae2vK3q0hM4mfAQyziB+9MhA==
X-Received: by 2002:a50:b854:: with SMTP id k20mr52195530ede.224.1558035920987;
        Thu, 16 May 2019 12:45:20 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id m3sm1208773ejc.5.2019.05.16.12.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 12:45:20 -0700 (PDT)
Subject: Re: [PATCH 3/7] brcmsmac: switch source files to using SPDX license
 identifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558008251-13692-4-git-send-email-arend.vanspriel@broadcom.com>
 <20190516173113.GA540@kroah.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <a5d32b2f-a99b-a248-1acd-9de532732e30@broadcom.com>
Date:   Thu, 16 May 2019 21:45:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516173113.GA540@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/16/2019 7:31 PM, Greg Kroah-Hartman wrote:
> On Thu, May 16, 2019 at 02:04:07PM +0200, Arend van Spriel wrote:
>> With ISC license text in place under the LICENSES folder switch
>> to using the SPDX license identifier to refer to the ISC license.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
>> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
>> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> ---
>> Hi Thomas, Greg,
>>
>> The file drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
>> did not have license information nor copyright notice and as such
>> it got included in commit b24413180f56 ("License cleanup: add SPDX
>> GPL-2.0 license identifier to files with no license"). I added you
>> guys as I propose to align this source file with the rest of
>> the driver sources and change it to ISC license and add the missing
>> copyright notice while at it (not sure if that warrants a separate
>> patch).
> 
> A separate patch would be good, to make it explicit that you are
> changing the license of the file.

Ok.

> And ISC, ick, why...  :)

Because the license text in the other driver source files is a 1:1 match 
with the ISC license. Another option could be MIT license which is in 
the preferred folder. Will have to consult our legal department about it 
though.

Thanks,
Arend
