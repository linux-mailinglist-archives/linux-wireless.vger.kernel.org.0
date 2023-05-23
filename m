Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C433070E344
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbjEWQvp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbjEWQvo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 12:51:44 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F1711A
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 09:51:42 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-199fd7b5789so5507969fac.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684860702; x=1687452702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oKeFvF28IfZh1I2Jpf1Mc74eD+4/tbqudqOBm7SytgU=;
        b=T+0cPdzleRdGEqmjgaAN3FUhplAGaE7oLTEHy9PGVq/COx8hOughZDZqWVCcsoksQe
         5h+kOHMEoPZc05BLjqJ/NjzI3lVHvy/c6exBIghLuway7Nl1mec1Ob/0BaMiQmavwG1E
         3TJMMRhdWjgklHGluS8Ttmh7wN3eEGw+2llVhXI3BtTYoJ/+8l3rwuhgWCk0/rPwEH7r
         JuCuUCAiUTrTFcn6YONE69YXTZq7DHuucgdQblzJYoMzyjV+EUzRWUebMM+gnFrF5HYV
         793RFcFijjMsrvtaG9+TfZQcCwG3rAvXQOHWN8cVIYCMfBiTSY0W623ITA2acB+Dog2y
         SlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860702; x=1687452702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKeFvF28IfZh1I2Jpf1Mc74eD+4/tbqudqOBm7SytgU=;
        b=Z5hl6osbdk933GuBwubQIchvkhCDyTiPUru2WrfXG9tZcFOzEw4uw7zG3oPacWr1p1
         ZULza92e6FqN8gWOnF5N454ZeLYmeMrcG1ncltXv9JwRGvwHtrqE8MabkxOwDd6g0vHr
         WyQRe+KAvDUYly793KEyYqC5EuF2kvAdLlzz9TabUzT2vx31YC2lW9GuptZNR+Ow4ILI
         IFomWZVFEiwhR21fdlWwWL+6NB9xobReNKgkfy6fDz91XcUvcjKl87RTWZTWmXfm7bIL
         hhBtIYXG1ytPCHIk8TDL95PMqekYjxKQIK8awPOkdXYiN/4tzMt7IvNm6AH6NZSzNnji
         1MKg==
X-Gm-Message-State: AC+VfDyXYesvdZSmUP1l1IGB3gUAe5eh27WPYrHmkM2vr2BUPumvhi8B
        X4g11DP14s5iJqVd2e47sxdjLJNCQ6U=
X-Google-Smtp-Source: ACHHUZ633yjsjnzXU3i2fSZNg/ff9X3VRZg+WXgCcXsg7NlZBoyvo9hcY7sjXklTbVIyL9Xnjp6NHw==
X-Received: by 2002:a05:6808:aac:b0:378:c02:bd51 with SMTP id r12-20020a0568080aac00b003780c02bd51mr7440484oij.33.1684860701729;
        Tue, 23 May 2023 09:51:41 -0700 (PDT)
Received: from [192.168.0.159] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id z20-20020a4a4914000000b0054fcc25de1fsm1437249ooa.2.2023.05.23.09.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 09:51:41 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <7058acc1-b7e8-b7b5-0c8c-e83907f1b327@lwfinger.net>
Date:   Tue, 23 May 2023 11:51:40 -0500
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
 <0621f2d1-5316-0a0d-62b5-ba4aa3702fa5@lwfinger.net>
 <CAMzNfvNXqKyvy-88y79WnJ6BumAyGLQEkAcUk-9k3JeDLKeCkw@mail.gmail.com>
 <CAMzNfvMAgpHV=7HXydrtGJCLG+Mjny4NU6pFP1YjdrPt+Mcc-g@mail.gmail.com>
 <CAMzNfvPtmGyXDV9m-whhptH5n3xJL1-ZPNed3yrkXG-DSF==+w@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAMzNfvPtmGyXDV9m-whhptH5n3xJL1-ZPNed3yrkXG-DSF==+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/23/23 08:11, Fabrizio del Tin wrote:
> I found that rtl8852cu should already be in linux-firmware:
> https://www.mail-archive.com/kernel-packages@lists.launchpad.net/msg490319.html
> 
> Maybe it is just matter of adding rtl8832cu as a variant.

Those missing globals were due to missing parts in the version of common.mk that 
you used. That part will be OK now that I pushed the real version.

There is a major difference between firmware and a driver. The former runs in 
the CPU on the chip while the latter runs on the host CPU. At the moment, there 
are no drivers for any of the USB variants of the rtw89 chips.

Larry

