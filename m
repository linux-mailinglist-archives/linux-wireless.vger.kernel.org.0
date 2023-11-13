Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9B7EA1D3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 18:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjKMR2L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 12:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMR2J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 12:28:09 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE90D44
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 09:28:07 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7788f727dd7so291174685a.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 09:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699896483; x=1700501283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EarQGfQ0KH88cQ3Er8HRbPWgpdJJF153yZq1brBck8=;
        b=Q37SZxAsyMjJldFXLKJBy+TmDTYnbUBVWjp5wCKT1hNs8wAEQd2jISkMPjvPPwxSyu
         uGb/cBMtwu8PdYEnMmlBbgKpnkFybgx4wJUvOiUZY6yBan6a7JGC3d3SEH5nffDmJ7SJ
         C0jxn6Rj/dHx23zpztm9T9KGLcuZfl1Gb2/HXSdAwgu1CaKnIrG07o3rWVXDi2VkLIAo
         E+iNxeqygSfNadKKupeNDGZVrDScCIgStysp+unTtTi/SJnc/WpYgZOtqYpTJvGL5WEz
         1QGhSWYwI4g0l2Nu1O9Oasf36efJjVo5SHofk9nOnrmCDJg3Oq2aIRRfX507lq7PLJvd
         YOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699896483; x=1700501283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EarQGfQ0KH88cQ3Er8HRbPWgpdJJF153yZq1brBck8=;
        b=EfH/i6yhPtFMvBDli2hVjgZRdK4o6Gyr3M3srBaTMZEdnsUgUb45pPsUxHXoijosfm
         gWaPr9HP42ZtEtb7IjS6GGacTZDA2fnZ1bg4yV6Of0I5QZ8ZbJZFptZTyCl8Td1m6IQ6
         iS46TtOkWlBaySaNOk2lAXEINlMyFTFzD9bj+O3+sV8KFfhxYv/GxVyNzJLXLxiPyJI4
         WfqUkMxjoXZY4k8cTsxaN9ICm6iOdeGPo4+8vANDs9fAMK2RlygZk0dJoocc8sQVlIJz
         IdkKbYSdRVU81fvPz2+jUPuCIEj3rsNMHf87L89fvSQotvhvHXckm1FEhlSGgSOd7YOm
         TY9g==
X-Gm-Message-State: AOJu0YyzVggDppw7NS9Rrly7ci+Z5fGD9sDywtrBysG7at5p8N/ZY634
        6pkkrgeOfhj2dIyXXI8Jwzk=
X-Google-Smtp-Source: AGHT+IGE/1eojiQegF8+4bmXQZtU4gDC72j33RpKCrCxQ3JV49iP+/bv8GL7uB/H8f5EDgdMA8pWkw==
X-Received: by 2002:a05:620a:1789:b0:76e:f62e:45cc with SMTP id ay9-20020a05620a178900b0076ef62e45ccmr8904193qkb.32.1699896483510;
        Mon, 13 Nov 2023 09:28:03 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id qk6-20020a05620a888600b0077a02b8b504sm2011839qkn.52.2023.11.13.09.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 09:28:02 -0800 (PST)
Message-ID: <2033c16c-4d9a-4592-bb81-7a9ad7821576@gmail.com>
Date:   Mon, 13 Nov 2023 09:27:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: add support to allow broadcast action from
 RX
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20231017165306.118779-1-prestwoj@gmail.com>
 <169989062657.3473659.188127753057713210.kvalo@kernel.org>
From:   James Prestwood <prestwoj@gmail.com>
In-Reply-To: <169989062657.3473659.188127753057713210.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 11/13/23 7:50 AM, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> wrote:
> 
>> Advertise support for multicast frame registration and update the RX
>> filter with FIF_MCAST_ACTION to allow broadcast action frames to be
>> received. Broadcast action frames are needed for the Device
>> Provisioning Protocol (DPP) for Presence and PKEX Exchange requests.
>>
>> Signed-off-by: James Prestwood <prestwoj@gmail.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> On what hardware and firmware did you test with this? As there's so many
> different combinations in ath10k we use Tested-on tag to document that.
> 
> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#tested-on_tag
> 
> As ath10k hardware and firmware can work very differently from each other I'm
> suspicious if this feature really work in all of them.

I only tested on a QCA6174 (and I'll add Tested-on for that). This makes 
sense and maybe enabling unconditionally for all ath10k hardware is the 
wrong way to go about it.

Since I don't have the ability to test every hardware combination 
hopefully someone from atheros can chime in. Is there some 
firmware/driver value that can be queried which tells me if broadcast RX 
is supported? Or if not is checking ar->hw_rev == ATH10K_HW_QCA6174 good 
enough? Or are there sub-variants that may or may not support this?

Thanks
James
