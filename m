Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE396ED1A4
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjDXPpA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 11:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjDXPo6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 11:44:58 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B77A8B
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 08:44:56 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-187b70ab997so25192932fac.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682351095; x=1684943095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YGkdGYkDdeg2BrZbnQt1lSYUo+/tsjqL79bQ/PID5NE=;
        b=VqMCD6I/BPB1E/vwv8V9xjkWYKsv2h73Pt28R3ZQ0hFLTFdfw3seRWsVKDk0ZJOxAm
         nNaEjPkru5CyubIpDSiEh0RnX3I+EYw8eK3lZd5IPf72t4B6ESpmgiLhnO7EyGDzfT5/
         rFJ4sohE1xIm6NI0xSK3trYbe050s0iLEOa8nyQjjWEpLgrkbWHf05ca8Cd6KDkRLAKS
         eEMmUxHJoKnbsTzw36/p0Hh20VMYVpYYv8gysPg9E+oxjRVGvHiHhAds/4UsXlutnJt5
         mW+/7Byp98cA/KyS43FD1+oygTsCrSQREz7yIVTS0uIXDZNCo1jcj0d6+5Oy/imPOEIj
         x9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682351095; x=1684943095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGkdGYkDdeg2BrZbnQt1lSYUo+/tsjqL79bQ/PID5NE=;
        b=Xw1PhO4wEAFWeQbDjczTWt5s+64bNNsy1BpkytU8xef0CXwCVibSFPpWqXTMWtKdjP
         uTp3grr/f3ztxqN0JNcMxamxJK60QDvgQov3gDQfH2tJ9xYo5POR144MZURZyQfYllpx
         79EH8LhanxCHhRz617hdYk+zABmvN00I9bRozZ6qb5ZD7e2TAmICbw8gNt1Xy+H+OQ9b
         8mtqnxTIXtFH1yo2PN0TEz1OB75Xlx1q2ihAzknsrtj0jDn8F42vwlCBMJCn8560C1Lw
         KWNNJF0VXoczJDQOyD4gZaHVJv/9fqymNHIamRoNIlNf+Cl7uv0NSYx9rtzWCV94FIxn
         OD7Q==
X-Gm-Message-State: AAQBX9cwziqlUbpNwFsxkeGRzL+NtqbhKCMdOSuce49f4C1X8kHcVuRd
        tKKuMY5fXaANydzhNpJmEilQIUqRUS8=
X-Google-Smtp-Source: AKy350YLFvFfqJzIuaBRf5KiPLJKiwSUsqJ5gItLz8nbmWRzcf+Ub3Z4yFa773bvx7S6KovJpds7+w==
X-Received: by 2002:a54:4010:0:b0:38e:8e5a:6b53 with SMTP id x16-20020a544010000000b0038e8e5a6b53mr6309700oie.24.1682351094772;
        Mon, 24 Apr 2023 08:44:54 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id o189-20020acabec6000000b0038c2e1bdf2asm1261398oif.36.2023.04.24.08.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 08:44:54 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <2a9d4092-cfcb-a683-90d4-a6d18e854adf@lwfinger.net>
Date:   Mon, 24 Apr 2023 10:44:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Problems with HP BIOS
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <5c753c2b-ca3e-50d8-8829-9c350d35b9f5@lwfinger.net>
 <7b5f33cb7c704e3696674a5cebe9dd8a@realtek.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <7b5f33cb7c704e3696674a5cebe9dd8a@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/23/23 21:09, Ping-Ke Shih wrote:
> We have similar fix recently, and have sent a patch:
> https://lore.kernel.org/linux-wireless/20230421015357.13940-1-pkshih@realtek.com/T/#u
> 
> Could you or the user give it a try?
> 

Ping-Ke,

I had that patch in my "pending" list, but was waiting for it to appear in 
wireless-next. I added it to the GitHub repo, pushed the change, and alerted the 
several people with the problem. I will let you know the results.

Thanks,

Larry

