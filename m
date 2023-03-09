Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC436B2826
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 16:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCIPEl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Mar 2023 10:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCIPEZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Mar 2023 10:04:25 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360C85A6D6
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 07:02:11 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id x19-20020a4a3953000000b00525191358b6so314108oog.12
        for <linux-wireless@vger.kernel.org>; Thu, 09 Mar 2023 07:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678374130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0suVm0gGQkpNA6EcQHFIjUZD/y9CdJOWV19GEB0++yA=;
        b=GZodWyN85pfRb+20J+xw4Qu3tRRSXYpDkJjfkzuZp3I7FbkBxz2WUIuWWdNLopkOUc
         8zuC3s1jGpLWKOdXQbN5SfOarFDziB+rflmQT4uUnOlXJnDZtmB2oa/g5lqdPXxjjwWq
         ICtC/fDSm5+06iKVb+tr6M6t2PWf/FUsZ8xraGxtb5I3p9IrkX2gEH6g9nl9UyqsXlAr
         4wMaK+2fMbItS7UI9eDul5L1BpBKLb6jBBEirWxclPm1P7+zFWQEyOHTX9js3ykMY7In
         Xd2Wb19qJY8Sd6AlIvMyIuvU0oQ7KmhNO+nSW5Oh+F2vTHbaePsC3tqLLKXs5CbA2bqA
         aQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0suVm0gGQkpNA6EcQHFIjUZD/y9CdJOWV19GEB0++yA=;
        b=gI5pCDYq/TPn+DpFXuG6oOoPB2UOrPlXCX81FJoI1KPbv0y7oQvW9Fl7tQVthjx8o6
         bIw/PVj88MQyRwUwNMaXaRrDyQ5HUb6IXjiisIgtMoG8OC69EEz1Dj27A4+luxnkUJok
         uhcjRySsSkFDbXyfeoIkD9CM10AC9q3nDnLMKghI9EDOzbKZ+U41ufqvu/1EeIzY0yII
         aOrLlzAiqG1eIclS64E3f6CJQ4xg2j03tyGkYjII6tebyuJKOVw0+/HVXj79FSBahplD
         jn+iagbbUbkye18jfqtt4cgr0pudZm4ZyWMcy5EaRa5wi2p2NrC+1VtdEUWf08v68ofP
         wiOg==
X-Gm-Message-State: AO0yUKVKEVGZFtdmNU6wISJGx3GpWopJetKy/0sAeOoIoqkfo1+UBWKn
        PVbUBd7UBYejosZJN1qmD8k=
X-Google-Smtp-Source: AK7set+rz3V64H5AiUaIuolBXbkb4hYLbFAAqNI5jlUFVHfpwWkotNDfyJ4CCry2RknfNig0t6n+VA==
X-Received: by 2002:a4a:88ac:0:b0:51a:48f4:75de with SMTP id j41-20020a4a88ac000000b0051a48f475demr1126735ooa.0.1678374129737;
        Thu, 09 Mar 2023 07:02:09 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id n15-20020a4a848f000000b004f9cd1e42d3sm7249648oog.26.2023.03.09.07.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 07:02:09 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <eb4e2847-a0a3-5edc-dc3e-63e6d4d8bf28@lwfinger.net>
Date:   Thu, 9 Mar 2023 09:02:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Performance of rtw88_8822bu
Content-Language: en-US
To:     Dan Williams <dcbw@redhat.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <93d565e1-3a23-69f3-bedd-b71eb601bceb@lwfinger.net>
 <20230306091845.GC27249@pengutronix.de>
 <20230306125944.GD27249@pengutronix.de>
 <6ed1239f8c404dcb9d571771c230b69b@realtek.com>
 <2064a549-ef7a-98bf-cc24-a25b8571877f@lwfinger.net>
 <1f01b1ff59d7412aa7eafdce022d7635@realtek.com>
 <6e14212a414067c970b8d2d0bf6eb8df5319a972.camel@redhat.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <6e14212a414067c970b8d2d0bf6eb8df5319a972.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/8/23 10:43, Dan Williams wrote:
> On Wed, 2023-03-08 at 00:36 +0000, Ping-Ke Shih wrote:
>>
>> I think NM triggers scan operation when turning it on. Then, driver
>> switches channels
>> between AP and scan channels with flushing queue that causes timeout.
>> The cause is
>> still hard to transmit packets out, so TX buffer gets jammed.
> 
> Yes, (at least historically) nm-applet requests that NM perform a scan
> when you interact with it, on the theory that when you open the WiFi
> network menu you probably want to see recent scan results. Similar to
> MacOS's AirPort menu.
> 
> Most drivers handle that OK with intermittent traffic, but it will
> cause disruption if for high throughput and/or latency-sensitive
> traffic.
> 
> Dan
> 
>>
>> If you enlarge the retry count or timeout value of
>> __rtw_mac_flush_prio_queue(),
>> the timeout flushing could be disappear. Also, if we can implement
>> rtwdev->hci.ops->flush_queues for USB, the flushing log can be
>> reduced.

Dan: Thanks for confirming that a scan trigger was the likely cause of the 
problem. I verified that by adding a WARN_ONCE() after the warning was printed. 
The first part of the traceback was:
rtw_ops_flush
__ieee89211_flush_queues
ieee80211_offchannel_stop_vifs
__ieee80211_start_scan
__ieee80211_request_scan
rdev_scan
nl80211_trigger_scan

Ping-Ke: Increasing the time waiting for the queue to flush did not help. I 
increased the loop count from 5 to 50, and the sleep time from 20 to 200 msec. I 
also tested exiting as soon as "avail" was greater than zero. I also tested 
unlocking the mutex before the msleep() and relocking it afterward. Nothing 
changed the behavior. It appears that something else is locking the queue 
clearing, and that no amount of delay will help.

I will be trying to write a USB version of the flush queues routine based on the 
PCI code.

Sasha: I agree that no load is required to trigger the problem.

There are no simple problems!

Larry

