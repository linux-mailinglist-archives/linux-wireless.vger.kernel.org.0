Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83A25621EA
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jun 2022 20:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbiF3SUA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jun 2022 14:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiF3ST7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jun 2022 14:19:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A25341986
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 11:19:59 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 9so99740pgd.7
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jun 2022 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hIe8ELBWtzA9iSb7MlDm3AQrKq90HJ5GRww4LOpK7K4=;
        b=YJSyEKgGQFPFqyVvR/yrU/5SoEQnf75Clj1aEYOaJ0vpHGANhnsRD3pFPVLHT+AxP+
         9DutenL7sVo1U7tx84BYaVDpZtBfPjJ1Xmj2UzpRKTt/uWaUWJg2MKe1Fj36GxA/oEIU
         fsGmhXiZPhxUeCGKOh0B3hOGmmlN7FE4qzUXT2nuxMn0iFrY5oAYUMQE1EaHSoeznhwT
         M+htQYa1PMkMCwMGQa0LgojpxE3XoIVZEFR3jto0SreFzWW4myS2Lj7rUCDWB5TPFgG8
         aYQ4dh05+Kl3w03R5/vo/cae3BZjBfsN4/BfnlDdJvmMvo2vzhjKGZJ7rfGKMV1u8bWE
         bnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hIe8ELBWtzA9iSb7MlDm3AQrKq90HJ5GRww4LOpK7K4=;
        b=kpSHvY2vUx7UIaYhhKvuwZZ2eilakw5yMPSHG02C2uoP0pYn9Yl9tfHmCvqtwt96/J
         rDjZFNa2GhrZLJTYD2lrhamCiUrSdMJqsDUa6xlRT/MVJxOVDXC3ANPp/ByIWzEGHYHQ
         WqoD5eLb/0mj7dVm3raSDblMqCAflPbIs115ydS+gDkgERtcK4Mcz+DUgX6/+Z9gRXYb
         4DgoGRfAbifijQJibmYroWAY4kzJidYQYTUshAHP7H+nzsZfUvpu2Ut3ON6kReLOWEcq
         bSawGbYv0LU9sUfKUUszTrF4KDgOGKEXi+cg1kG8hI0mJFdi7TLrleLz7FAMxdwDmqyg
         ChdA==
X-Gm-Message-State: AJIora/XY0DuNBvbGrhVb1osudELYKYa5yB1RHfntxcTBFM4G2epRUME
        LcvR4jZ+C2UbmAPNZm+UaRI=
X-Google-Smtp-Source: AGRyM1udXSQguTVW4LxJlZoBgtfGBUym38q3gHjQ2wnwnsK0oYDKCoMDPWL8oa7jloNKnIIYW6VADA==
X-Received: by 2002:a05:6a00:88e:b0:528:1d40:cc20 with SMTP id q14-20020a056a00088e00b005281d40cc20mr2535326pfj.64.1656613198768;
        Thu, 30 Jun 2022 11:19:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id on16-20020a17090b1d1000b001eaec814132sm2805425pjb.3.2022.06.30.11.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:19:58 -0700 (PDT)
Message-ID: <b214600a-cf03-5677-2e87-4e5201488dcb@gmail.com>
Date:   Thu, 30 Jun 2022 11:19:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] cfg80211: Allow P2P client interface to indicate
 successful 4way handshake by port authorization
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        Jithu Jance <jithu.jance@broadcom.com>
References: <ef25cb49fcb921df2e5d99e574f65e8a009cc52c.1655905440.git.vinayak.yadawad@broadcom.com>
 <87a69vpen5.fsf@kernel.org>
 <CAMLe8U9R=TktuhY_baVyexKsvArw70wyT-k_=LLpkXASK0M9kw@mail.gmail.com>
 <87v8sioe40.fsf@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <87v8sioe40.fsf@kernel.org>
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

On 6/29/22 23:32, Kalle Valo wrote:
> Vinayak Yadawad <vinayak.yadawad@broadcom.com> writes:
> 
>>>> These kind of disclaimers do not belong to public lists.
>> This disclosure got added by mistake, I will resend the patch again if needed without the disclaimer footer.
> 
> Also please don't top post or use HTML in emails, it's best to ditch
> Outlook when sending emails to upstream lists. More information in the
> wiki link below.
> 

This submission ought to be more correct, even if it somehow ended up 
with the same Message-Id:

https://lore.kernel.org/linux-wireless/ef25cb49fcb921df2e5d99e574f65e8a009cc52c.1655905440.git.vinayak.yadawad@broadcom.com/#r
-- 
Florian
