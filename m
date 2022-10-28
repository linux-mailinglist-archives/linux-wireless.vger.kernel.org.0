Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849EA6112A0
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Oct 2022 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJ1NZ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 09:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiJ1NZx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 09:25:53 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49BD18CE
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 06:25:51 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n83so6092488oif.11
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9l4Reiul5kWZVTjMF7mcxWAFbYB5wExU6j5u8ZLBeY=;
        b=V492OjIT3SyvrtW1c2m8BLB+vV3EO1M7af82bVmBe1bzPVCikl3m30ZEtceQUCNvJ9
         VZdQlQZjIWPft4blGtQ8gnLqhD1tuSmKyAErvln0FkaGRXFjniKJBqQ6m2iXPdqcvX0q
         4rfNX2Tb13TSNUuzh+nwFkj69FmK4H2r0DzS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9l4Reiul5kWZVTjMF7mcxWAFbYB5wExU6j5u8ZLBeY=;
        b=sf1Cf19brsw+F3qFdSNd6kh4/VdotFLfAtLZyzk454mCw0AK7eu43m0pVTOIKpkoVb
         Fi+zkW6+wfV+wE6ZcjWzu8uiA/74dWjIYFnuZUehubGM3uhG1UlCi4JT1jfVdF68nZ89
         ZTja6NN8XUJDDWczk05rQefKILo1NDOHo4UbcgbYstMZHG2tyoXm3NqnkE7GnOL0pxdT
         Nv+KitBQZhZpoHnrX+wmZLWwr9T3x8698MLMFYOv0s4xPEgVJ3KF68+TuLNz2oTagEez
         emfWO40Wu7ejkBAntRve4OQZ1EMBaDtQhWop+RCj7Kr8JsWK3Jqf+HSvXAGJGq0IFTRc
         bkOg==
X-Gm-Message-State: ACrzQf0qrv6c7WqbbXRKLtzJ++ldpKZ5Tb25Q3nA4TryGQYyO8zCePeD
        IH5nENfs4RLOiwhpeZM+G1Qe6Q==
X-Google-Smtp-Source: AMsMyM7pvtD2TgbyLQhBWfjIZMIk4exBPzSDvFl273JW7wNosiUYumstYOXttpTzwg38jIMG098UPQ==
X-Received: by 2002:a05:6808:642:b0:359:a432:1eca with SMTP id z2-20020a056808064200b00359a4321ecamr8336575oih.220.1666963550572;
        Fri, 28 Oct 2022 06:25:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:9770:4850:4463:87cf:eed2:97cf? ([2600:1700:9770:4850:4463:87cf:eed2:97cf])
        by smtp.gmail.com with ESMTPSA id j17-20020a056808057100b00342ded07a75sm1504889oig.18.2022.10.28.06.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:25:50 -0700 (PDT)
Message-ID: <22be4248-9c5e-e6d3-5e49-e0d87ec52e4b@chromium.org>
Date:   Fri, 28 Oct 2022 06:25:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] wifi: ath11k: Fix qmi_msg_handler data structure
 initialization
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Rahul Bhattacharjee <quic_rbhattac@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20221021090126.28626-1-quic_rbhattac@quicinc.com>
 <11e005c2-2363-d63f-9f3f-3ca811737231@chromium.org>
 <87pmecgrd2.fsf@kernel.org>
Content-Language: en-US
From:   "Joseph S. Barrera III" <joebar@chromium.org>
In-Reply-To: <87pmecgrd2.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/28/22 3:44 AM, Kalle Valo wrote:
> "Joseph S. Barrera III" <joebar@chromium.org> writes:
>> Do you want to add a comma after that last list element?
> 
> I can add that in the pending branch.

I think that would be good.

> I would prefer to have a comment to make it more visible that an empty
> element is needed at the end, but I would add that outside of braces?
> 
> /* end of list */
> {},

Ending a list with {}, is such a common idiom that adding a comment
is kind of just noise. And if you look at other such instances of
ending with an empty element, you'll find no comment, just the {},.
When making changes I prefer to stick to the existing coding style
as much as possible, so in this case I would definitely omit the 
comment. But if you do feel like you need to add a comment, I would
keep it on the same line as the empty element, probably like

   {}, // end of list


