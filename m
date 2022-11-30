Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3183E63D998
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 16:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiK3Pjc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 10:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiK3Pjb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 10:39:31 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC31E2982A
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 07:39:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ml11so17391363ejb.6
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 07:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yv68dC+omUbJhtVUz5ee4LFj4C2P6W98UoUe1ScQ0S4=;
        b=W++awdsOdw9UZY/yfVKW/ZzPh42Cy0XBPkN3I6EPJwFbwNLFY1q1C1iPIPw2L8hH9B
         jqILP5Czf7IvDdiXQ0My60h9jR6mKIFCpM91H9DRCaPr4H43Lgb+FbnLxIisk8wlpfJ2
         aT1QmyDORZ11T/tIiVf+oGipSvUlMkb1mVL/vc82nFS3NH8g6fQf9nkFq3c6lwMsVSBW
         0AS7w2uI3ZHVd/XNX65xmITeCVVNYBPhHEaflTqaewb2hC8LahjUyuljSYlyDbGrKAFn
         G2gSiQ8DsDnXsx97ZOqKbbArrgpaTay89R97AuB8Ps+YjmmgDvunqBgDEaEr7vstph+E
         rwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yv68dC+omUbJhtVUz5ee4LFj4C2P6W98UoUe1ScQ0S4=;
        b=UUveKao2MTuTCkDk44jtUx/GQ5iePRVtGM82j1GRw7PjkpMEJVyVjFzRA4f2CMCtUN
         MYeWaG1z3h1vcWlzJnoy7bqhm2CH+/hh8MPSjYYcALyPfPCdRrixWvRRYqvjCogXj97w
         8abrQy9a45igOf7YDjFUQ3+Qne8iLt3dPghgkhD3FCMrN1LG8ItG7f6sXFSkLskQRu6n
         pxDSOL1uxEehfbdYzgAC/kotcc0SBcJZJJIxAGRwTs7hGgb+wz5NubdTWcqj7zAdvisN
         MxbqxONSjkkrxRIT0xgk0p4m+gn3TG6pwDB0ocaTaQhgRWFv0TH8YjKrcx7dhmbMSU/W
         VEcA==
X-Gm-Message-State: ANoB5plepURjaleCNHiptgv9EdZdf/xjgI02yVd9CL08ricmUKMu8HFR
        77+dba8VfhHxEAnltMqiJ+c=
X-Google-Smtp-Source: AA0mqf7WT24rXr6VLRiSD0rpunMmEcRWFIR68B0SMrg5spkJnwLhbig2X3UR603G/9yWz5SnH9QdYg==
X-Received: by 2002:a17:906:b0cd:b0:78d:8c6b:397b with SMTP id bk13-20020a170906b0cd00b0078d8c6b397bmr38321535ejb.364.1669822768430;
        Wed, 30 Nov 2022 07:39:28 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906310600b00738795e7d9bsm771884ejx.2.2022.11.30.07.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:39:27 -0800 (PST)
Message-ID: <f932f4c4-c846-fca2-b1c0-807efcee370c@gmail.com>
Date:   Wed, 30 Nov 2022 17:39:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 3/3] wifi: rtl8xxxu: Introduce
 rtl8xxxu_update_ra_report
Content-Language: en-US
To:     JunASAKA <JunASAKA@zzy040330.moe>
Cc:     Jes.Sorensen@gmail.com, linux-wireless@vger.kernel.org,
        pkshih@realtek.com
References: <6321862a-3362-95b9-bbd1-be0d5fb97f7f@gmail.com>
 <20221130134721.116982-1-JunASAKA@zzy040330.moe>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20221130134721.116982-1-JunASAKA@zzy040330.moe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/11/2022 15:47, JunASAKA wrote:
> Hi,
> I am trying to merge this patch into the linux source tree (Mr. Torvalds' updated source tree) and find a confliection in patch 3/3.
> I think you should move the rcu_read_unlock() that originally located in line 4657 to line 4682(right after the if-else section)
> to make this patch work normally.
> 
> Jun ASAKA.

This patch set is meant to be applied on top of the wireless-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
That tree contains a commit which is not yet found in other trees:
7927afb5e27b ("wifi: rtl8xxxu: Fix use after rcu_read_unlock in rtl8xxxu_bss_info_changed")
