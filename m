Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798B770D34B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 07:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjEWFp6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 01:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjEWFp5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 01:45:57 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4D8109
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 22:45:56 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6af549a7fb4so2526035a34.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 22:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684820755; x=1687412755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=syfcj8sbfPE/T4zePcNlTc/5mDLlxLcZoundf+TDlFs=;
        b=BE50XWkHF5p04t5wn3inXVhyYqwlCXQK2dqxd+nH3BZ0O5IuXZS+yoVCXnFjd0v6gl
         +xXVYr0s1oPyfaLYgMaCA/jf971JZJBvVCOdDG+y52GXAofDpMl1gxd2aVFVpJPxUkhE
         l4kk1oEIfZwAk2gS7CsV1IB55hMjgjIvlfOzZjT/pCsj56rbseWEO0rQAyDT5UXAXUhn
         i2QEPSyYLBZslyya1UFBhCv3YMZeTCN5Kbrmiac89zIdxey6LlGp0T/+9KBf8V8gAvqP
         C+plPiPWnFLdW7BHnEqy4jHxKE+mAZbo0pcxZcVJvQPiSfPepHUImdf3MBQtNzFO+hP+
         fzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684820755; x=1687412755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syfcj8sbfPE/T4zePcNlTc/5mDLlxLcZoundf+TDlFs=;
        b=dvOMNW4d2M3Zg6+l8nIKqKsTimty7Z3cyq67LzX56VeeF+FC4Qh2bZkPNTn6kfR0lf
         f+AiQ6NCGF7BDwg+y6H2t2kUX2gUY1f9NY4iJSyI5vEJFqK6mAfS4uZZN5NILGJY+ZMM
         IbgVl+nujhzlIDhmiOCXuKnn7ATxQpm2HnJ/or1P1ZbAa+7/Ay6nzAJsR23hWhumulBX
         NPwmafrey2WjH/ij6YJrDQM0GMSOIQw23Vo26G/4pRSRcwYJtFyreoNGPq+tzFQ2K3NN
         Rt25HcGkE452AtOZ3n+zb3WQyZKbsDeYGMYwH/otGL9qbg3jTKG9Zn8ZZYRG1uK9O4Zk
         TDdw==
X-Gm-Message-State: AC+VfDyZuE0gXqY0h3GGLKAnDZDtl47FDF7th4AFuvNMAAWuQzpAHS0+
        r6df+nCN5oHnmVsW22UbISq4mHlWOQA=
X-Google-Smtp-Source: ACHHUZ4WAnzE2WwoPbyuL0E46NLKPTrqnJhQ+jQFLmtIOLxjxH4KEizreZl6J/bQlUEmnTLfd8KDWw==
X-Received: by 2002:a05:6830:22e1:b0:6af:74d1:4547 with SMTP id t1-20020a05683022e100b006af74d14547mr2537538otc.11.1684820755526;
        Mon, 22 May 2023 22:45:55 -0700 (PDT)
Received: from [192.168.0.159] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id a10-20020a05683012ca00b006af904d9c37sm183331otq.45.2023.05.22.22.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 22:45:55 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <0621f2d1-5316-0a0d-62b5-ba4aa3702fa5@lwfinger.net>
Date:   Tue, 23 May 2023 00:45:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Realtek RTL8832CU compatibility
Content-Language: en-US
To:     Fabrizio del Tin <devotedmystic@gmail.com>
Cc:     linux-wireless@vger.kernel.org, James <bjlockie@lockie.ca>
References: <CAMzNfvPpi9GiFHf0UcBpS8oozg6o_s3wwzOAPJ0FzGy7LaC4pw@mail.gmail.com>
 <777df364-6a1c-4427-ab68-46a9a71fc629@lockie.ca>
 <6f014d1e-7d50-5688-1ffc-88e00c77a61f@lwfinger.net>
 <33FF0DFF-0FBF-4344-95BA-55C2FE740B49@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <33FF0DFF-0FBF-4344-95BA-55C2FE740B49@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/22/23 10:35, Fabrizio del Tin wrote:
> Thank you Larry, that would be great.
> 
> I was just advised to return the dongle, but I still keep it.

The RTW8832CU is a variant of the RTW8852CU. I received a copy of the driver 
from Realtek and fixed it to build on kernels thru 6.4.0. The driver gives 
reasopnable performance (350 Mpps up and down) when connected to the 5G band of 
my ax1500 router. This router does not support the 6G band, thus I cannot say 
whether it would work for that 3rd band.

To get a copy, do the following:

git clone https://github.com/lwfinger/rtw8852cu.git
cd rtw8852cu
make
sudo make install

I suggest that you install the modeswitch package for your distro. That will 
automatically eject the CDROM device and enable the wifi interface.

I will be making improvements in the coming days, but I wanted you to have 
access as soon as possible.

Larry

