Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64812286700
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Oct 2020 20:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgJGS1r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Oct 2020 14:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgJGS1q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Oct 2020 14:27:46 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDBEC061755
        for <linux-wireless@vger.kernel.org>; Wed,  7 Oct 2020 11:27:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id e20so2696161otj.11
        for <linux-wireless@vger.kernel.org>; Wed, 07 Oct 2020 11:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uZ78ytBVgZuBaCTmldYsSlYqWYuxhLcSbC/mJi6n49c=;
        b=e92Hbr/JR+BcaVHJNfLadONh0VRNmAoUac38XEmnfuxO4GRvOZ26adYUyMdDckX6xs
         LF5obcxxguXwRPjl6VECNieo+MPp18myKPR2xzygYoZf7INzOFJNJz/j3fEJOsv47rsW
         y5egSEiDdl8JUabFHZ9l+2gTkZDF3Khgfc45wGtJ1aA8jnOkTkFT1RoC17iGas0v0bzm
         v5o+qZzbG0eAw4OXD8ZDkS5zSyduIeez9jKnQJ6xL52iW057xeEnts+LNK4RdKHAygtM
         W170UWGRMbbDbl9L4S4LdW3Onn9o/51GI6NFYzIH9tjmGY+B39ROz9jHS1oByVG0oaFS
         ZBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uZ78ytBVgZuBaCTmldYsSlYqWYuxhLcSbC/mJi6n49c=;
        b=FbOjBZ+Fkuxk5A8gF1pd4d/bMqekRe+pNXcZ1MSOMdvx0KFFY+q0TKTc+q2Cr3C3UE
         B9tbN46DUyNucf8DBSIofqXiviARwXZCNX7xUu59Y4ps3vweAnNNEwx1plgHWlH3e/Ws
         mz5TVeo9Z4H6wEnl06hWrhzEiuhYaDhyEKd3ANqdLc9hRuXHxWR69jLQ1fqCgUZDWz2E
         kPZhpq7uP2Y/dxQuRjy6xMlNr2ylZzkL9LhbqSrN4Q9k+YrDA+I6wD3p42udp1XGJpUT
         QHw0nr/O4D2i8s/sJGe0nJ5TZvquLu93+MHoVV6KjUp6KJnRv2cZk2ynot1FcDmYm1An
         nRZQ==
X-Gm-Message-State: AOAM530gaMOQzpVNT2peJ9UVmqT88Dw/+/DQVRj+BmHnDI7CWYq1tqzE
        b+KshmzaTsTceHUbWG9cRUsSknSoto4=
X-Google-Smtp-Source: ABdhPJxk5kQUfwxSBYiwV6d1T7HuUWCFfrk8EuUilprLe9xlOrEFx0x86QepKFo1iFBKt6Vpc9zd/A==
X-Received: by 2002:a9d:5a8c:: with SMTP id w12mr2582676oth.332.1602095265388;
        Wed, 07 Oct 2020 11:27:45 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id g124sm2546803oia.58.2020.10.07.11.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 11:27:44 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Error in driver for RTL8821CE
To:     Cristian Llanos <cristian.llanos@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CANBg+yz2az1o9u7RDD6jwXCs=08u7izbmUOnkKJc2tnOQQCdog@mail.gmail.com>
 <97d78a81-b4fb-be83-5cb9-fa69575758c9@lwfinger.net>
 <CANBg+yy17Oj+WwvFRnC6PXJ4WWgwVm+O546F1Ju5xYHzu3kdnw@mail.gmail.com>
 <7b435755-a5e9-4cdb-05e0-c1aeea35bbf1@lwfinger.net>
 <CANBg+yyL5vSRxbL3WSzawS-CjOwE1jFJc0D+kBXFQJJsOMQJ5g@mail.gmail.com>
 <0ff3eede-a283-1f26-6ef5-be78842eb3a7@lwfinger.net>
 <CANBg+yxnetxyaRyeh0g0PRbk09DK_JmhrdX5F8LfH+Y9tHPaWg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <53c925eb-961a-f350-71c3-1f4e66c9ed2c@lwfinger.net>
Date:   Wed, 7 Oct 2020 13:27:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CANBg+yxnetxyaRyeh0g0PRbk09DK_JmhrdX5F8LfH+Y9tHPaWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/7/20 9:14 AM, Cristian Llanos wrote:
> [   21.839511] ath9k 0000:01:00.0: enabling device (0000 -> 0002)
> [   21.839792] ath: phy0: WB335 2-ANT card detected
> [   21.839794] ath: phy0: Set BT/WLAN RX diversity capability
> [   21.848409] ath: phy0: Enable LNA combining

That dmesg does not show any Realtek hardware. The wifi is Atheros using driver 
ath9k!

Please post the output of 'lspci -nn'.

Larry
