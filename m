Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4340CB23
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 18:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhIOQvQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhIOQvP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 12:51:15 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F300DC061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 09:49:56 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id p2so5046413oif.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=RpJKnZ1DaSJzdLN4xO5cKcgEj5gLllPPBwNJly5jSv8=;
        b=hMLJwA/ivCPj2fpW6wEAkxUSBC6oz6NMJ6ulFxwKc+S0vsfVk2jyyZYt8ATMXH5n7Q
         134eJrqfMd87Qc4/+JPhkQOJpcPbOSRzgeE6K+brylsH/UZCFE1G0mWLM6vXkSokrQwl
         X0b3l+zYhLRX2kjtQVA03EBFnAehPeOLOl/FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RpJKnZ1DaSJzdLN4xO5cKcgEj5gLllPPBwNJly5jSv8=;
        b=PTWa3Cm0Ef+3u7frtNiL4nTJk+kcJyJpCrdlNAoo/9kj5zMh+6kPivj/iSgqNiAMvG
         ywK5Gmu9RkMKQ4D0wJODrFGlItKuYwzbxDK312k3XPkczdpK8CQnBHThC9gVv4fJp2Kj
         +L/BTkhaIzkhz4jD5222mgljgGBNJbIgabXtQD8cjKbNX9OmhzlOTpw4T5OprQqSiTuC
         UPb0/4iN8NSkzVcTY1S5PG5X9DW1n1+s8gG/xIiRePZHIPjhUsSBWREyTMF8XKqPJq5u
         iJOmr1/Xju6I4Q0TiMyq8z/2UUKe9obKxws9BJ2V7zo6xuvI6g9TBYynO5BWiovlWxT5
         ECvQ==
X-Gm-Message-State: AOAM532bh8TJssGWBTWuV8bgVriXb+WEd8h6GVVRTUm3Nc/fJfKlnpTW
        ULIybdoSmHHhh6yc2GjYNt16LBDoRVBJmA==
X-Google-Smtp-Source: ABdhPJw/SjO+NnLaz9hItgX4Nyh7uEdmEDkbrRGkwJWKy9p41A1DLNUdHc7yjTx09K1MZ+wis9+n4w==
X-Received: by 2002:a05:6808:188f:: with SMTP id bi15mr6178845oib.53.1631724596051;
        Wed, 15 Sep 2021 09:49:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:38c5:675f:205a:1a41:425d:d9d0? ([2600:1700:38c5:675f:205a:1a41:425d:d9d0])
        by smtp.gmail.com with ESMTPSA id be5sm131965oib.10.2021.09.15.09.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:49:55 -0700 (PDT)
Subject: Re: Patch for Atheros QCA6174
To:     Andreas Tepe <andreas.tepe@debitel.net>,
        linux-wireless@vger.kernel.org
References: <dd4aa95d-c7e6-f582-48bd-c7d6f8cdc8b2@debitel.net>
 <839a16ab-7535-c719-2be7-10100c84a738@eero.com>
 <520a5f75-44bb-94b9-d67b-3fe42cdec044@debitel.net>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <332b62fa-0062-e0f4-5e8c-b8ffe61485cc@eero.com>
Date:   Wed, 15 Sep 2021 09:49:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <520a5f75-44bb-94b9-d67b-3fe42cdec044@debitel.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 9/15/21 9:00 AM, Andreas Tepe wrote:
> Hello Peter,
>
> here the patches for kernel linux-5.15-rc1:

For the upstream reviewers, you need to add a root cause analysis(why 
the error happens) and about how your patch fixes the problem. Take a 
read 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html# 
for about submitting patches and follow the instruction, otherwise your 
patch maybe not getting reviewed by the maintainer.

In addition to that, you said

"mentioned multiple times on bugzilla",

hence it'd be good if you add the bugzilla link, so that people 
understand the history.

Peter

