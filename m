Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955F04B18FC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 00:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345085AbiBJXEF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 18:04:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244406AbiBJXEE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 18:04:04 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE98D55BB
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 15:04:04 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 4so7657907oil.11
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 15:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to;
        bh=vB0sKaiCA4GfUJCy/+YDgbNa43ZkKqgitArgf10NsQU=;
        b=LhpKljVvZLojzjDM3K2LHGTYwxa0umgd6I2amnjw4PMaKVh6qsWNkl71yC5xrdjf6K
         aOq8f1tgY3oUCVBkcP3m5ZTbHNNh7aE8DNz50rckOjTZKcLytsHqw5UhhbBT78GL+CHD
         4UyxQJL0Ray5pou9xzJahEEZYnZ8kuZu0sblr0lN9cxoUut+RNXbgmd81jtu1VpvVjmX
         ZEtzp3DGziF5tYCH1lEJHPwABaax2Vyq8v1PjrdnEQau+0n1T+RGjU6iDFvURjEWDVf1
         7rUH99Ceiw5C5rFc8yRW4VVNQ0XeWOCwQk0Qgc3lXJpQRynHvKptPONgFTs2+iJ/VYDk
         3d4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:cc:from:in-reply-to;
        bh=vB0sKaiCA4GfUJCy/+YDgbNa43ZkKqgitArgf10NsQU=;
        b=jzBKrP9+CJqQK3Xh55yb3gR0rLyDgfIP6ahAw65C8fnPt6QamrxUwYDWUFShUZxT6z
         G4wftxN5TjkPWpNhF46r/aaAZXTBoe9uZ1H8oh9hDEfjA6+53jw1115oOomXcYHjCX6y
         22m5TFLUajvmgI8+HLcodU06gjJLSEe5geSftY/4HwgPQ+/fBTQxx9BINAIv9YutFjcw
         zpCmHXwzvawtfZynkz87NoSv+U+twAXUIagOjtMYY3oIg03iD0rBux1Oo8HG6nwRNhqa
         LD78Hj6+Cyooj3xM12fjPPwJuJy33Oj4AicBW3vMI6eTsYWWcos2TP3tMTnJ/045KSa+
         l7GQ==
X-Gm-Message-State: AOAM532SswpdA3sHqc0L99zEriEfuF3LOuejdDplaXhEj/gFHQ8IiYp+
        6dyluVlgYJBMzw9zFH+2qjoix5NjjTs=
X-Google-Smtp-Source: ABdhPJwwC9epBcXFCgC2C4WJYz5xBmox3Ew3/3HhSpGR761pHhmHWk/lFdj5SBulJKFvWnbdFrg+pA==
X-Received: by 2002:aca:dfd5:: with SMTP id w204mr2129761oig.264.1644534244186;
        Thu, 10 Feb 2022 15:04:04 -0800 (PST)
Received: from [10.62.118.101] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id eq37sm10333200oab.19.2022.02.10.15.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 15:04:03 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Content-Type: multipart/mixed; boundary="------------NWR6P18wOlnzDpPPzdkmTpdC"
Message-ID: <9fdc6313-46df-e5ab-30a4-7fcbdffe69f7@lwfinger.net>
Date:   Thu, 10 Feb 2022 17:04:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Possible bug in cfg80211
Content-Language: en-US
To:     Maxim Klimenko Sergievich <klimenkomaximsergievich@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
References: <CAEqd1ZZucLqJMEktzmnCKzwXXkswzqJNf_yr2HZV20LcWtiR6A@mail.gmail.com>
 <ba50e373-59d8-d544-e7f9-3fe2a3336056@lwfinger.net>
 <CAEqd1ZZkSDMkKm-TJz69iihWDd0Afu54nerc0gTqZfAV35mv9w@mail.gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAEqd1ZZkSDMkKm-TJz69iihWDd0Afu54nerc0gTqZfAV35mv9w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------NWR6P18wOlnzDpPPzdkmTpdC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/10/22 15:29, Maxim Klimenko Sergievich wrote:

Maxim,

I was able to duplicate your logged warnings by loading cfg80211 with the option 
"bss_entries_limit=1". The attached patch fixes the problem for me. Could you 
please test on your system?

If it is OK for you, I will submit it to wireless-drivers-next with you noted as 
the reporter and tester.

Thanks,

Larry
--------------NWR6P18wOlnzDpPPzdkmTpdC
Content-Type: text/x-patch; charset=UTF-8; name="patch_scan.patch"
Content-Disposition: attachment; filename="patch_scan.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC93aXJlbGVzcy9zY2FuLmMgYi9uZXQvd2lyZWxlc3Mvc2Nhbi5j
CmluZGV4IGI4ODg1MjJmMTMzYi4uZDVmNmZiNWUxMDdjIDEwMDY0NAotLS0gYS9uZXQvd2ly
ZWxlc3Mvc2Nhbi5jCisrKyBiL25ldC93aXJlbGVzcy9zY2FuLmMKQEAgLTQ3NCw3ICs0NzQs
OSBAQCBzdGF0aWMgYm9vbCBjZmc4MDIxMV9ic3NfZXhwaXJlX29sZGVzdChzdHJ1Y3QgY2Zn
ODAyMTFfcmVnaXN0ZXJlZF9kZXZpY2UgKnJkZXYpCiAJCW9sZGVzdCA9IGJzczsKIAl9CiAK
LQlpZiAoV0FSTl9PTighb2xkZXN0KSkKKwlpZiAocmRldi0+YnNzX2VudHJpZXMgPT0gMSkK
KwkJcmV0dXJuIGZhbHNlOworCWlmIChXQVJOX09OX09OQ0UoIW9sZGVzdCkpCiAJCXJldHVy
biBmYWxzZTsKIAogCS8qCg==

--------------NWR6P18wOlnzDpPPzdkmTpdC--
