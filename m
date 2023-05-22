Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5737170C268
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjEVPbm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 11:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjEVPbk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 11:31:40 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A40FA1
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 08:31:39 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-38eb2984c82so2083366b6e.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684769499; x=1687361499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rirIJ0oPf7dKvMcuSdiFYHXM3msoOJCcy3omFuyhtFE=;
        b=BfDC/6oBRzdCsVJLLdJ08+nyaTjrmUoo8lV2Ul2pvzrXBG7LTqjpmkjG6+7qgLrzRt
         XySoYBF4NCk8kZ/7atIPCQO4vyezg7QbDxdGntPtxQvtFj3aQIOKmUAxWeNHTL4cvaBt
         xPPfaDR8kMFN26P9x4bqke7MrlyxhTbHab0YuzjnR8dJHXnzx5MFkSSg7/cgxGeGXmjA
         6IobcSRg7qgwZNq7cwhmd6t9TrB7xQLJLtSxJxxpZjXQC9q8T6m4M/4VjpjnKt1wdlIr
         k5v/YkukjGx+9izt5eCnALZdQH4VqZHCxu71UjXhBSD5cN/AmgcaKWWVabwu5im8Tajl
         NSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684769499; x=1687361499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rirIJ0oPf7dKvMcuSdiFYHXM3msoOJCcy3omFuyhtFE=;
        b=gpXI4wOpZm/VUW2UKFn8ibVE9lA+1zhzWXrletLlC4zqc5yTxIkwkzHYR81Tz5UFZO
         1G61Jcc5ByXcomd4srueUtjmX2ow/QYwKyyFprtivdT/3IkpoEEeuD2pJtYiQO30RulZ
         RtWVfurH1rqQ6bkKTkBC/b3BAjdX5pcmLn7jGfXJQyH63UoqtAQYgjJXlhYjJLQGxyOb
         rIyOTxLz1QdKdWHdcYsfVciL7kwGFyfppZ0iB6THYd3DH6wkZq7YLgjVSoVAzllxUaKV
         BudAXouJSyIKqhj1WZkZegNi838q0dIjHJRuaGl1WsCuDtsLSi93EzD43X+qfpdDuymh
         hWeg==
X-Gm-Message-State: AC+VfDy360md3NGg7e8tFSzAMrZ4kkxA8ZE2uyhoZl11p3KF68egFfaf
        HjbQGWwSiTo0/Xd2mxJdfEAk1lZhtRU=
X-Google-Smtp-Source: ACHHUZ647+k6wXFLPBbwWDjCYVqCmYf9DrU63Q0gHCl0U8XltW+bFNVjZAwAf5/zZ4NiQRcbUsXgQQ==
X-Received: by 2002:a54:4698:0:b0:397:f439:d416 with SMTP id k24-20020a544698000000b00397f439d416mr3067219oic.35.1684769498642;
        Mon, 22 May 2023 08:31:38 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id y83-20020acae156000000b0037832f60518sm2842176oig.14.2023.05.22.08.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 08:31:38 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6f014d1e-7d50-5688-1ffc-88e00c77a61f@lwfinger.net>
Date:   Mon, 22 May 2023 10:31:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Realtek RTL8832CU compatibility
Content-Language: en-US
To:     Fabrizio del Tin <devotedmystic@gmail.com>
Cc:     linux-wireless@vger.kernel.org, James <bjlockie@lockie.ca>
References: <CAMzNfvPpi9GiFHf0UcBpS8oozg6o_s3wwzOAPJ0FzGy7LaC4pw@mail.gmail.com>
 <777df364-6a1c-4427-ab68-46a9a71fc629@lockie.ca>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <777df364-6a1c-4427-ab68-46a9a71fc629@lockie.ca>
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

On 5/18/23 11:02, James wrote:
> Ask here: https://github.com/morrownr/USB-WiFi
> 
> May 18, 2023 11:05:50 Fabrizio del Tin <devotedmystic@gmail.com>:
> 
>> Hello,
>> I got a recent RTL8832CU
>> (https://es.aliexpress.com/item/1005005544770386.html?spm=a2g0o.productlist.main.1.78ff96c6qceFKn&algo_pvid=9ee2eb8d-9883-4709-90f5-0dc6d98c40da&algo_exp_id=9ee2eb8d-9883-4709-90f5-0dc6d98c40da-0&pdp_npi=3%40dis%21EUR%2161.26%2130.62%21%21%21%21%21%402145277316844042289821012d07b5%2112000033481930568%21sea%21IT%211918944861&curPageLogUid=OMcZ7AW58cDB).
>> It's a very affordable tri band usb wifi 6 card, which is sold as AXE3000.
>>
>> I tested it on Arch Linux, kernel 6.3.2, to no avail.
>>
>> Once inserted, it gives:
>> 0bda:1a2b Realtek Semiconductor Corp. RTL8188GU 802.11n WLAN Adapter
>> (Driver CDROM Mode)
>>
>> After an eject cdrom, it gives:
>> 0bda:c832 Realtek Semiconductor Corp. 802.11ax WLAN Adapter
>>
>> I wonder if there will be any plan to make a Linux driver for it. The
>> only tri band in kernel solution seems to be the Netgear A8000, which
>> is widely available, but very expensive. The ALFA AWUS036AXML cannot
>> be found in my country. And there is no other option.

Fabrizio,

I have acquired one of the AX3000 or Realtek 8832CU devices. I installed it on a 
Windows VM using the driver on the initial cdrom.

I have written to my contact at Realtek to see if I can get a copy of the Linux 
driver. If I can, I will upload it to a GitHub repo.

I will let you know what happens.

Larry


