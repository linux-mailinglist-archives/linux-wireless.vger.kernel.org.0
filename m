Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12282664C9A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 20:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjAJTfe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 14:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjAJTf0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 14:35:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D73355660
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 11:35:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id az7so12890634wrb.5
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 11:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W24t1awpfKB6ptxeY9TlNfgzwEwkCjaMQOvWbmqbT58=;
        b=kORZaBLpDatAoNPlGskCQ8mg+EYXm+S31KKByi2e00YCZitmdPiOHo6Kr+g8y5SN6W
         uhJTEspGLyzuirEW5ym7lnhrb5GfQKyKWFngCvdSxZtVcw3wWdxn7GoWHIC4TeI8Joqd
         AdMzx+2pqM5L+2ZCTP6ZR6QSDJiUskPbWHH+MDYp+bsvm0PrCx+vt+iA+BpefakcwsvM
         +H8nY7sVgaWRnGrUh8W2BZq5JOe1tR/JIwjt2IZXDZk2XVtdZX1Ini9GonoVhPw7SMZv
         V+od0PMF9axaqqXfH09Y84XTHbLzl5ps3dYx+/yDL5/fgraHyrFtUGnbiIpI2djQD9ag
         taLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W24t1awpfKB6ptxeY9TlNfgzwEwkCjaMQOvWbmqbT58=;
        b=ySfnAwQVg9ke/YjRhX63snh1H36dRntnTHU2iP+TNuaB/tt7wFYEKOwkeeoX6occuG
         I9ePmzoN3AIy7xQ0qYta31tWzmIp74S+W/crDf98MW6PpF5KLK15TCtiUS83yu0LyfqC
         WwSG46D2i3gIwK/2vxdUbVJgKmQAbqlheOVSTtW+f3S4aGqgtEn3W8LW1s5lCa7FdBvT
         sd1TGezfs1QaHwx3l/O2zWtR5Zyt1RRukvUBZJEKOD6+/nM90sUyUJQStjVU75W8SKtO
         JLhLcfzFNmSTXtxwTWW3acDP4nauqFum9PyUpCJ8+nYhaj7+Vq8ViaWsz7Suls8UWlS+
         JKhQ==
X-Gm-Message-State: AFqh2krm8SfcD1Mqgq4+NIuPIc6aLUqFn+byC7x5cBOwOkAHr/5w9ADD
        o7Zy30zYftKczXdNBrNDIS8Rzg==
X-Google-Smtp-Source: AMrXdXt0ppqWzXs7iXoPKHx68lESAtM8EYIoOvNlvARbzlOQnBDHSBCcqzN0lr9nxr7oS8Igv0d6Og==
X-Received: by 2002:adf:e6ce:0:b0:293:1089:d6a with SMTP id y14-20020adfe6ce000000b0029310890d6amr24950195wrm.39.1673379323138;
        Tue, 10 Jan 2023 11:35:23 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id az20-20020a05600c601400b003d96bdddd3dsm16454705wmb.15.2023.01.10.11.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 11:35:22 -0800 (PST)
Message-ID: <aace6523-0941-903e-6b80-399dc1cfc751@nexus-software.ie>
Date:   Tue, 10 Jan 2023 19:35:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: ieee80211_handle_wake_tx_queue and dynamic ps regression
Content-Language: en-US
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, johannes.berg@intel.com,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
References: <19015168-c747-17b7-f0ae-9d2ee27d221c@linaro.org>
 <06f76774-1b2e-f563-7128-7d5b9547dfe9@linaro.org>
 <cf5e9339-2511-1135-71da-a8342b264414@linaro.org>
 <205fb221-f7ad-8f03-2c16-54dcbf5ecaf9@wetzel-home.de>
 <53b23ee9-a333-120e-8b58-cfa3a9bdaefc@wetzel-home.de>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <53b23ee9-a333-120e-8b58-cfa3a9bdaefc@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/01/2023 15:43, Alexander Wetzel wrote:
>>
> 
> Looks like the the commit 
> https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
> has a good chance to solve the issue:
> 
> 1) Queues are stopped due to PS
> 2) Then there is a TX attempt. But due to the (PS) queue stop
>     wake_tx_push_queue() aborts the queue run
> 3) Then we hit the bug the patch fixes: The queue is not marked to
>     have pending packets and thus packets on it are not transmitted.
> 
> Packets get only send when you happen to try tx when the queue is 
> operational. (And then you will get all the packets sitting in the queue.)
> 
> Does that make sense? And more crucial, is the patch fixing that for you?

Ok works for me.

Good job.

---
bod
