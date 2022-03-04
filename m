Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4DC4CDF08
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 22:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiCDUtl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 15:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiCDUtk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 15:49:40 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059DF71ED9
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 12:48:51 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so10797037ooi.2
        for <linux-wireless@vger.kernel.org>; Fri, 04 Mar 2022 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V/M6MCOb48PFDNP0AQPS3Wgzf+qc5vzssiZeXZKntfA=;
        b=AfWuNGxD3pYE7q8tW+MhgAU3IuUJ2He0VwZGSxkMTSmZhi1jNHY9o7vOshOkAintH+
         reMYun9FhDdXSwA2Ps8Xd0oS99GQQRUPsm+G85bgWFfAzBLbLZawt24p7wUlpPWsWuQ+
         5z0ycy8ssqDJHOxk3pSBLeXuoXk2nVKXpd7XXh9+SbHyKhsEelRjVfipnufTKoSAjZom
         X6hgbbD8XwEA9toMGV+oq60lmqTTZS/++5wzDVX6gWnAQySy0BuZRCyfyGXvOWqHIjLC
         hdkMWEu1NBsnaXzWDbV0FndfXihJRQb/zDa+XhZJs5PF2W7EdLNGHUYwIMJqHBhPOGD7
         ufGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V/M6MCOb48PFDNP0AQPS3Wgzf+qc5vzssiZeXZKntfA=;
        b=4FjOyNTUaY4eD/+HnG0iFjt0fPXpU9AvOSYtGBPE0B4iUMmRHewM/w+7UmK9jBnLhy
         tstO90IivAzoB4vL8skXVNQjlq3YPai33bPLlScTLxq8ketxV/apT6Vs/7H+TNcwbGCp
         7xJUwDpqmzwZeLX2lKgHlixyM+GgQdGAZCg1oba0j3OJDxM5KyfWFth0rL3MBh1kPQ2j
         nxY1q3z0lCc5uSC9I8IVWZXrXsgJugFSb+DcyI20TuLD+oykOtpa/bG0ZQSIYwFYPJRL
         tuJHsBWxr11D7wH5/NRAvqgje3GvyUNtkQXPiCSqli6FCheAbOZO9JwKjWBKXL5c6pr8
         ccEw==
X-Gm-Message-State: AOAM531USGSwluhZLO1yNuXzufwynZwXwTT4jtkERrpvLpEosKuP+yhX
        QUzvTATdsgQ19ZWuOSnyXjLS4CpkBjc=
X-Google-Smtp-Source: ABdhPJyeE0LTY9eY8+oLTF9EbZ/epJOG2gg2y6owtpZwJiLrC+JpATsqHg2qV9togMZPPMF0228rvg==
X-Received: by 2002:a05:6870:d20d:b0:da:b3f:2b6d with SMTP id g13-20020a056870d20d00b000da0b3f2b6dmr573561oac.268.1646426931144;
        Fri, 04 Mar 2022 12:48:51 -0800 (PST)
Received: from ?IPV6:2603:8090:2005:39b3::1064? (2603-8090-2005-39b3-0000-0000-0000-1064.res6.spectrum.com. [2603:8090:2005:39b3::1064])
        by smtp.gmail.com with ESMTPSA id b7-20020a056870918700b000d16208b7c4sm2744634oaf.15.2022.03.04.12.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 12:48:50 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <8ed18133-4441-101e-d5a8-40a1e2e70bf4@lwfinger.net>
Date:   Fri, 4 Mar 2022 14:48:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Way to enumerate wireless adapters in kernel
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>,
        Linux Wireless List <linux-wireless@vger.kernel.org>
References: <CADnq5_MM8w=U6WqRDbwHrjP4Jpco0bUKEsE5QiTYiYAEK1xtBg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CADnq5_MM8w=U6WqRDbwHrjP4Jpco0bUKEsE5QiTYiYAEK1xtBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/4/22 13:59, Alex Deucher wrote:
> Hi, is there a way to enumerate wireless adapters in the kernel and
> determine what their channel and frequency is?  I'm looking for a way
> to determine this from another component in the kernel so as to avoid
> any potential frequency interface from another device in the kernel.

The command 'iw dev' will list the device name and frequency if the device is 
connected. There is a bit of extraneous output, but it is not difficult to sort 
it outwith something like iw dev | egrep "Interface|channel"

Larry
