Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6E7273628
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 01:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgIUXEk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 19:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUXEk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 19:04:40 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118FFC061755;
        Mon, 21 Sep 2020 16:04:40 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w12so17141868qki.6;
        Mon, 21 Sep 2020 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=buxecpnwFXQjOdy2o4aC6QJJC2voHeLV76sj9RxzVr0=;
        b=T9rFgBNo0UWnF94bkPIMe1dAJ04AMWR5vKWCv+CA+SF8ztvgW/dfRQqo5jYidlZa0x
         /MLJW240kxK4Na53BdzkLafvC6igwgKRoBYwOYCfpXzx1fEgrn4qDeG2ZOJGm/OhhMft
         gu8ELttcPnBSI03NMUanqKwaFdeOYaxbamB1PW6lohutHoqS+7MoC8hwFlxWzGeuI6u0
         YLrTwvXUtPmsc9aPLqc5rVj8vO28A79tZnqsAzHx+MktaDEBMwYSj/8kGDGavL2STzWv
         IJHSLnN71bsRLM7rKoIUCviIFto6IkA+HeJavP99253UyNJoXs1RH2m4NaOKHFBQJGNn
         DoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=buxecpnwFXQjOdy2o4aC6QJJC2voHeLV76sj9RxzVr0=;
        b=m4tNjMprzKYzeHNrQGXr1LQHGhyXFLTWkcZIBJ7BEORxfBxWKDgdLCQkOTtCluPNVL
         mhBqQDud7gSXZY5u2nC7UUZIx6w9AP9WSoc1KtxrqgIuuNHO2PHIHo4VSUSfg4gsS4Sf
         yc0M/1gdM6K6xp6lYWqDS8I4udzTzq2sj3uGzuCNZGwx8+Xnpf6/2Mx9n5Xve4D+obzq
         leLm6OjSOHjKx7HOrP8mG4d4wlUWtsm3myDm0QNoxKh89ba9I8Or1LG8W1hmpsH4MV67
         l21eGJvnZVnMBm8d3yimZvVIQuzmmIYCdB7M1CAnknVwyiDAIZ/RRHVpcYN6UYzZQhI8
         8DYg==
X-Gm-Message-State: AOAM531DVXdJG8Vm7wIsYju/kPdH8FLP8/Taur6NLwaQtbqTjFBIasAb
        Le5o80KbMbhL7xEnis7e5gg=
X-Google-Smtp-Source: ABdhPJyFGU70pwwEAOnqwQcMZ9oM+i4T70jeGyRyNrU/QnkVxAuaN97VaFZibaOPXz7+SjHnSVGX9g==
X-Received: by 2002:a37:7ac1:: with SMTP id v184mr2307937qkc.146.1600729479226;
        Mon, 21 Sep 2020 16:04:39 -0700 (PDT)
Received: from [192.168.1.181] (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id r21sm11473544qtj.80.2020.09.21.16.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 16:04:38 -0700 (PDT)
Subject: Re: [PATCH] wireless: ath9k: hif_usb: fix race condition between
 usb_get_urb() and usb_kill_anchored_urbs()
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, gregkh@linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, syzkaller-bugs@googlegroups.com,
        syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com
References: <20200911071427.32354-1-brookebasile@gmail.com>
 <20200921130559.005D8C43382@smtp.codeaurora.org>
From:   Brooke Basile <brookebasile@gmail.com>
Message-ID: <22bfd12a-c7ea-f03f-5d44-f94646b083f3@gmail.com>
Date:   Mon, 21 Sep 2020 19:04:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921130559.005D8C43382@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/21/20 9:05 AM, Kalle Valo wrote:
> Brooke Basile <brookebasile@gmail.com> wrote:
> 
>> Calls to usb_kill_anchored_urbs() after usb_kill_urb() on multiprocessor
>> systems create a race condition in which usb_kill_anchored_urbs() deallocates
>> the URB before the completer callback is called in usb_kill_urb(), resulting
>> in a use-after-free.
>> To fix this, add proper lock protection to usb_kill_urb() calls that can
>> possibly run concurrently with usb_kill_anchored_urbs().
>>
>> Reported-by: syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com
>> Link: https://syzkaller.appspot.com/bug?id=cabffad18eb74197f84871802fd2c5117b61febf
>> Signed-off-by: Brooke Basile <brookebasile@gmail.com>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> 
> Patch applied to ath-next branch of ath.git, thanks.
> 
> 03fb92a432ea ath9k: hif_usb: fix race condition between usb_get_urb() and usb_kill_anchored_urbs()
> 

Thank you! :)

Best,
Brooke Basile
