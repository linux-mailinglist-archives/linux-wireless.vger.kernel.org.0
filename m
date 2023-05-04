Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F256F6E92
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjEDPEs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 11:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjEDPEr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 11:04:47 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE722D2
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 08:04:45 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6a60630574aso352871a34.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 May 2023 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683212685; x=1685804685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Df9Rs+y556PqH0cCOQVo5LRYx8Ml+4YD90bupfcijto=;
        b=Ro/ff1t5nvRfhMj5rXDA6aD7N5YKAOdOKW/Mfco7P3r7kIH802LdqyaQP47zVKdFUx
         +YUZnhS7obHcM/n4d/WrNz+Mnd02bKXvXi//opz4cJHg32kXf1aT5QfqQ/yQ6QP7h3vE
         GyZLp625w4eYuSFMK2CFrjRY77gKhqAL47yhoSdhejVxVKmbjZm5fsPGtwqq3h8qSKHo
         2/teYMSE/siuY0SxaQNB4bttOD1tfurSxhIPim7v/WwWQcV9vk5t5njUP0iqjLTl8rYV
         sXL/7IvJBXWzoPhrXMMcP29RvgncrVRiTNbml6xwXTxvT5QHVpj4hi0MnhR4lzkCJcdM
         6u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212685; x=1685804685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Df9Rs+y556PqH0cCOQVo5LRYx8Ml+4YD90bupfcijto=;
        b=FDL5AfLLM5KQT6gWHsAijYPmZZiegfX+RbByKF0mEneLx55e4GefmHKz9LUcRx1aN1
         IFDvPFIaiv8D5xC+HQrLfhLabuiAVs9oi18VD7KAG8TMfjBUV03LCOoK5qCSJ3cCwysi
         2HtONovA13csgvXRy6IG7h2y2uqGJUumlZZBYna1CuzEl8CTQI2Dq6rP8RU0XVe26GHT
         n8r6CJYCYi4TpHAK9zmRVohS9+O8PPhfOA3UUXFzohxvQpYPC2srCqIk4cGhqauWScsS
         rlQlSePgYlLc0Z4YlgjI7ySt1Wjr5Gn+wVNlOUHfy8rIn0LOehMM23wQCysA67K8gPy8
         14dA==
X-Gm-Message-State: AC+VfDxJrKvv1HJX9OONRZFQ5uQwPGgPYRg84el1mI8wv1ie1APRjCVp
        YaJEdx8AP1rXiqyq1dvnY1lObOjOF4E=
X-Google-Smtp-Source: ACHHUZ4OIMeT62LplZ7SDZyzlYchWIFhnlKjqFVBqcZOLyY/za7Ok9nMA0jVO6QLUbAk6uZuPx2xQg==
X-Received: by 2002:a9d:7841:0:b0:6a5:d944:f1c6 with SMTP id c1-20020a9d7841000000b006a5d944f1c6mr94638otm.12.1683212685203;
        Thu, 04 May 2023 08:04:45 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id h8-20020a9d6f88000000b006a143873c6bsm1740691otq.50.2023.05.04.08.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:04:44 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <98f8852a-1710-2792-3196-e74fe614a03d@lwfinger.net>
Date:   Thu, 4 May 2023 10:04:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Slow RTL8822CE 802.11ac PCIe Wireless Network Adapter
Content-Language: en-US
To:     Alexey Kardashevskiy <aik@amd.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <75906666-df37-988a-c448-a6338b8a1cff@amd.com>
 <b7a59145-37b0-eade-3a9e-b565cc75de35@lwfinger.net>
 <4b3f4c5b-cada-bb7c-65f3-936437261b08@amd.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <4b3f4c5b-cada-bb7c-65f3-936437261b08@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/3/23 22:10, Alexey Kardashevskiy wrote:
> My bad, I should have mentioned that I tried this one as well, 
> https://github.com/lwfinger/rtw88/commit/75e2c81 3weeks old, no difference there.
> 
> And it does not look like there was any change related to my problem since then, 
> is it still worth trying the very latest version? Btw reboot is not really 
> required, it is Linux, not Windows, rmmod+modprobe should do 😉 Thanks,

I added a bunch of stuff on April 24-25, so a 3-week old pull would have missed 
some important stuff.

The problem with rmmod+modprobe is that the rtw88_core module is not removed, 
certainly not with a 'sudo modprobe -rv rtw88_8822ce, and it is really easy to 
get a mixed bunch. I get tired of explaining that to a bunch of newbies, thus I 
recommend a reboot. Of course, I do not reboot.

Larry


