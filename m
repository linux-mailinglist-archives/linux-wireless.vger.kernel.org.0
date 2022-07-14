Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C9F5746AF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jul 2022 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiGNI0n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jul 2022 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiGNI0l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jul 2022 04:26:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077FF3AB36
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jul 2022 01:26:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c3so299038pfb.13
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jul 2022 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=+ljiopVAcm6QExRVXWo1dE+qDNeRyQgTM9QHO1UnTkc=;
        b=CtsBv3eQYR/8FqtJs/BFBDxdN/zbhHohBaf5+P33uB0drUwoNiB9u6kKivdlROnVMD
         x8jy/98zmMDQQfrYhd6184EEZGpZMqbRQHfJMWsCRUZLmgJkpP81LOoURvceATsqZxqU
         bMjdIVRK9abmjxqYtm34uxHzosDOK0WF2/7gEKGDPIFZ8K9x8CYEBUWzRs0JQrIMQDr4
         MklBfB1Y774vMeceg7XWrigy4IPbDlStBWHEnxhSf8pqt8Wr2DjqP4rGomC2VEgX1esc
         7XzyfqY8pe9zWg8/TU3AD5a5CkBr9N66UDU0xyZLNOHpdsvyFa635gTPzuC2SRByAShE
         ejEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+ljiopVAcm6QExRVXWo1dE+qDNeRyQgTM9QHO1UnTkc=;
        b=VPMpqVkZSSg/36SHXHMQzkwK3IdtrqReogmDSkvkH9S62p4hDHe4i5G4iTQTsmdw3R
         3edK72Xta0TWlK/wiu6AH24d04+uCdyCuzzG4TpKfGewjMO0tA9jNHgirmCzSXpwRGF/
         FfvIv0g/So2C1E3TybGRhyVCxPDi0XR+P/XlQfNszuhvdXTeO/Yw3mr4b/V8A9jwwxA3
         7G1BLy91dQm3YhAFLtWBEuuLs/jkvvZ2KwexTjVe8RywuL9UudZO3bAEOKE0gagLlmDf
         cJXT9C9Xh4hrfD9NsgBV8TcVN7GLDq0/VUn/62D6XzEr12/AB1xH+j6zakMYTzRgNpMx
         dbRQ==
X-Gm-Message-State: AJIora/AMidNUW6ku/AK69ygT5bVPCYT5JVhQq9OA6LHESYsoPtABBZM
        bMfPTUsrUxL0kJy2IacYY0JPpjXo2vo2t+4h
X-Google-Smtp-Source: AGRyM1tlQbKZhfK/gyGS9I0AKgfnR75RRXCGEfiWoo4HN0T7kAo4UHKMnAKRfUbH1MlmRSHwMTcI5w==
X-Received: by 2002:a63:5c42:0:b0:412:b2e9:97e4 with SMTP id n2-20020a635c42000000b00412b2e997e4mr6975263pgm.36.1657787200517;
        Thu, 14 Jul 2022 01:26:40 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id g21-20020aa796b5000000b005289cade5b0sm989786pfk.124.2022.07.14.01.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:26:39 -0700 (PDT)
Message-ID: <e9ecb9c8-cb5b-d727-38d6-ef5a0bf81cef@gmail.com>
Date:   Thu, 14 Jul 2022 10:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/76] wifi: more MLO work
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20220713094502.163926-1-johannes@sipsolutions.net>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/13/2022 11:43 AM, Johannes Berg wrote:
> Hi,
> 
> So our MLO work is progressing. Internally, I have limited support
> for MLO connections now (over hwsim), but that's at least another
> 25 patches on top of this series.
> 
> But would be good to get things out first anyway. I'm tempted to
> just apply this (after net-next merges wireless-next and we will
> merge back) though - even if we have more fixes to it later.

Just for my own patch submit process. What is the reason I am seeing the 
"wifi:" prefix being used with patches on linux-wireless list? Is there 
other wireless tech used, eg. "bt:" or so?

Regards,
Arend
