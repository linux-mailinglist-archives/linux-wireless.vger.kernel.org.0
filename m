Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D08EA12645F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 15:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLSOPT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 09:15:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36853 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSOPT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 09:15:19 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so5019809edp.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2019 06:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nHgx2GEuIHEI/uw7dADnlN+M0u4j8U8xgIvIMxkGueI=;
        b=d8JpOiP0tPoOdzkKMqIOa4aDPqU3Trcnx82SsD/0blFPTNXLcjluM/W3bj9bBLsbJ8
         VkCdApQu+J2cRgIIla+qdfN+NUd2n3Sbt3EEIwJuh+Autd6TWdvlmjzBGnAz/FYvBAvw
         xAsSe+gwVO4wNN4gl/ls6HgiAyhf67p4Yl1XMFzKg76yvIYru04Tes17/XmuF2jdyRbC
         Oqfwr37L736T2TIpCPcFNQcPc6fiY/gEEmob2n+15V4mnbTwuN3TdQTRn8gzKXsbSTgg
         KxtVBDKhj165Cn8w4J2S4vhrmOhb+ytYbidLHeP/DehkTC52fAYnSUggRDhaaNMdXjMm
         OAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nHgx2GEuIHEI/uw7dADnlN+M0u4j8U8xgIvIMxkGueI=;
        b=gyl+HKipAYZEHjnM76ibVn925fWxj+KR6sNXjl0sAPWkVe/2ges44vXH/X10I7I2YL
         ASLiLYcu1HMxtZefq+O7ua5AIsTFrtCvExNsnzVMME1TyYBCOJj8PV6fYP4tazNbqoIt
         NF3YRGTqkhksCrmA484vuGNMfCOBA1TJdUNRqVC01wLztq9MmwjIbuSfygj3SxwJDgQN
         2U8JuPnFAjuBuBsarFfHgiKWcv7tFV5kb0NVuBX6Y6Lkbtg3PUIInsE6HjNpbUpcec6G
         gBdd4zGkZJSuFXKXvcuJVGDwpex3KTIsKxWv8Uw8p52WhxMpI36xgLV/phaMJyR40aGN
         u1+A==
X-Gm-Message-State: APjAAAXsqx++bUbvn3AuipoYMFQ6Wn7Q1cti+WdpXhckbxsSd8uBXziO
        MxasLDPFLFwZHGfCaFqK2ZSF8D+0AQc=
X-Google-Smtp-Source: APXvYqxOdrfazzV2P3yq0ZqbmGPQjf800n6FOfcjz9xMfQK0Kxmz49naD/kJ4JT4H2T6UTmbPMfKLw==
X-Received: by 2002:a05:6402:c8a:: with SMTP id cm10mr9573746edb.287.1576764917086;
        Thu, 19 Dec 2019 06:15:17 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c19sm447022edu.76.2019.12.19.06.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 06:15:16 -0800 (PST)
Subject: Re: [PATCH 1/2] ath10k: pci: Only dump ATH10K_MEM_REGION_TYPE_IOREG
 when safe
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     akolli@codeaurora.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20191219131539.1003793-1-bryan.odonoghue@linaro.org>
 <20191219131539.1003793-2-bryan.odonoghue@linaro.org>
 <87woas5slt.fsf@kamboji.qca.qualcomm.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <38bf1f75-0554-920a-0f29-354e70cfc077@linaro.org>
Date:   Thu, 19 Dec 2019 14:15:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <87woas5slt.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/12/2019 13:53, Kalle Valo wrote:
> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
> 
>> ath10k_pci_dump_memory_reg() will try to access memory of type
>> ATH10K_MEM_REGION_TYPE_IOREG however, if a hardware restart is in progress
>> this can crash a system.
>>
>> Individual ioread32() time has been observed to jump from 15-20 ticks to >
>> 80k ticks followed by a secure-watchdog bite and a system reset.
>>
>> Work around this corner case by only issuing the read transaction when the
>> driver state is ATH10K_STATE_ON.
>>
>> Fixes: 219cc084c6706 ("ath10k: add memory dump support QCA9984")
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> What ath10k hardware and firmware did you test this on? I can add that
> to the commit log.
> 

HW = QCA9988
FW = ??

Not quite sure how to find the firmware version TBH
