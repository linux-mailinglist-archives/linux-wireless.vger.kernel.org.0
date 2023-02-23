Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C286A1383
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 00:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBWXJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 18:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBWXJi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 18:09:38 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A4F1633A
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 15:09:37 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q15so6295265oiw.11
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 15:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgkddxXwmE/f9opzkcdxF9RBH4x0J3gJvFDFD7X4G0I=;
        b=d8p+P6Qf1XxILFG4yLjv9HZ/y7LGD3EfY9ah4oPtEcNZCmerALPqn5c+vUxNEzPb/k
         NNqrTUhnCG+rfVNy31NKRGjFBySLnxrySRxnc+fFko+y/dDezmcuNcCsA3nP0NgEOSgK
         5JCZHqXEPnWSNdlzdB7RgjvZ+0n1czbq9SVGGZ3ymnRK25Hn9JRP1T1V6FzhE7ULovKd
         YwNaGWlj+dtlG55y+qcvRXtRJ90SEqz1qeYPQh2hDWP7RHJTZ7mGkNDq27gKNsgRds02
         kB2j8/PYzrOzBvc2a3Ibp0wdXNfL0gEfyPhJmfGH1aEhA/iIbbQ56+9f6+hRSKptzeSM
         g0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgkddxXwmE/f9opzkcdxF9RBH4x0J3gJvFDFD7X4G0I=;
        b=l0tpdTgpxK8pnCsdzdvVTpWlrQnupDgnZh5JNaWUZ5rs+mqDRmo9vjkol4T0q9WyhO
         sHATM7a+9gHGdY6rSHG/YjNGTx6CpKO5t3MF8H7l1HFjEC1snYu2vKTA+oatEEHXgKYS
         0YUeSsM0u+LV2u7po0gQMu2c+/X7r+ywjNbTX6HAiwITGSE945iIAw9IxfRwzgce95v7
         IcfzYN4e/B7XgWBVqqbqcazBM1iOb4wfH8Ht+4xqmdzaYNi+QpgSrUjhHervdYVJxXqL
         wYj35CBV8azGc3lM223v5phpL7JHS7UjxgCWzZ/KTXM3pOt5jobKqs1oiyhlBxmygg9W
         m/7w==
X-Gm-Message-State: AO0yUKXwCpokGsxbJShG3Cg6iB4+3ecq6bQqdVXKUf9O6PWyAm/SXfZ3
        0AijFOk9Ph6MdJhtPLeb30EapQe+Hwk=
X-Google-Smtp-Source: AK7set9pqO8/TKBM9ubQ4o2hMZL+yDNnVDcvty29d5WUJ2JBnt30WybVm1gdYPSMa/zg8YRcBrpuCA==
X-Received: by 2002:a05:6808:404b:b0:37f:936d:b5d9 with SMTP id cz11-20020a056808404b00b0037f936db5d9mr4902003oib.12.1677193776661;
        Thu, 23 Feb 2023 15:09:36 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id y3-20020acae103000000b00383e12bedebsm1151202oig.9.2023.02.23.15.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 15:09:36 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <93bc48d2-a692-3709-e323-929600f37646@lwfinger.net>
Date:   Thu, 23 Feb 2023 17:09:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] wifi: wext: Eliminate log spamming in
 wireless_warn_cfg80211_wext()
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20230222204945.6716-1-Larry.Finger@lwfinger.net>
 <2564165999cf5319e58aa0898a2866612f8af293.camel@sipsolutions.net>
Content-Language: en-US
In-Reply-To: <2564165999cf5319e58aa0898a2866612f8af293.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/23/23 02:12, Johannes Berg wrote:
> On Wed, 2023-02-22 at 14:49 -0600, Larry Finger wrote:
>> Commit dc09766c755c {"wifi: wireless: warn on most wireless extension
>> usage") introduces a warning when wireless extensions are used with
>> cfg80211 drivers. Although such a warning is desirable, the current
>> implementation overflows the dmesg buffer with thousands of warnings,
>> all of which are the same.
>>
> 
> What are you seeing them from?
> 
> This is rate-limited, so not sure why you're getting so many?
> 
>>   A WARN_ONCE() call is sufficient.
> 
> I think a WARN is inappropriate (it's a userspace 'issue', not an in-
> kernel consistency problem), but I guess we could pr_once().
> 
> But that's not great because it only shows a single application that was
> still using it, not if there are multiple.
> 
> Hmm. Not sure what to do. Let's start with "why are you getting it so
> much". Maybe we can somehow print it less, or try to do per application
> once, or something.

Johannes,

This patch has a magic number, but it does the job:

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 13a72b17248e..22a67172a163 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -637,12 +637,27 @@ void wireless_send_event(struct net_device *      dev,
  EXPORT_SYMBOL(wireless_send_event);

  #ifdef CONFIG_CFG80211_WEXT
+
+#define ARRAY_MAX  15
+static char name_array[ARRAY_MAX][TASK_COMM_LEN];
+static int array_count = 0;
+
  static void wireless_warn_cfg80211_wext(void)
  {
         char name[sizeof(current->comm)];
+       int i;

-       pr_warn_ratelimited("warning: `%s' uses wireless extensions that are 
deprecated for modern drivers; use nl80211\n",
-                           get_task_comm(name, current));
+       get_task_comm(name, current);
+       for (i = 0; i < array_count; i++) {
+               if (!strncmp(name, name_array[i], TASK_COMM_LEN))
+                       return;
+       }
+       /* Found new one - print warning and add to array */
+       strncpy(name_array[array_count], name, TASK_COMM_LEN);
+       if (array_count < ARRAY_MAX)
+               array_count++;
+       pr_warn("warning: `%s' uses wireless extensions that are deprecated for 
modern drivers; use nl80211\n",
+               name);
  }
  #endif

Looking at my log, I do get only one for each application.

finger@localhost:~>dmesg | grep warning | grep nl80211
[    8.826056] warning: `nspr-2' uses wireless extensions that are deprecated 
for modern drivers; use nl80211
[   17.212260] warning: `kded5' uses wireless extensions that are deprecated for 
modern drivers; use nl80211
[   17.252420] warning: `Qt bearer threa' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   22.664380] warning: `akonadi_notes_a' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   23.058001] warning: `akonadi_maildis' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   23.175135] warning: `akonadi_mailmer' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   23.329265] warning: `akonadi_followu' uses wireless extensions that are 
deprecated for modern drivers; use nl80211
[   24.075119] warning: `akonadi_sendlat' uses wireless extensions that are 
deprecated for modern drivers; use nl80211

I have no idea why most, if not all, of those applications even care about 
wireless. As you can see, I get 8 messages in a relatively short time, thus I 
selected 15 as the size of the array.

Larry

