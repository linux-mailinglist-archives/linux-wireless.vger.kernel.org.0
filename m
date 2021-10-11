Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E487B428E10
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhJKNf6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 09:35:58 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57086
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235763AbhJKNf5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 09:35:57 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7C99E3FFE3
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633959236;
        bh=TCIb7WK8/iuKN7T7OPw+tlF5ym+d4BoIMWwoVr8feEY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=I9lrQ1ogb5QKIiWjO2gLgdLkMoqZJFvwk6E5RCH6C5MTgncjZ4nxTpY5VSjjn691X
         UseTJKEk/e/m0c0N6iKjMthQrIGMs2tKw/ONq2bUbvBzSLUqEL2UD6UOIPgytlftNY
         A0peelE760VGjyu4ySWJRWKZGtW1xMNpE6Bmg82H1Co7JAL+1iRttKYY3mUDLKA6gj
         1A25aCnEXgEchUI67fmb9ZrYXQACV1mwli1yPqWWaLMAY0OHBvfCv5zUUBf0MxEkQY
         CffJQG1EpaM4fMfW1MWb48hH79rmsfvhLGP5gdsZr/t5g6rUcgd5zEAb+NSV2T3fQ9
         qwICKuNbH9mRQ==
Received: by mail-ed1-f69.google.com with SMTP id c8-20020a50d648000000b003daa53c7518so15857520edj.21
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 06:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TCIb7WK8/iuKN7T7OPw+tlF5ym+d4BoIMWwoVr8feEY=;
        b=1tnKncloqs8xX2PX4WtvQPerZnhe3+ETXgY7xS95GzArdBLGUglxc/fX/Kv5vsgudu
         P8NTbdbrLOSokmja302vLbbIoCgWu9lgAj+Sue+yy/Zp7j3UDCkKX6Ggmn/7x7dGKC++
         3MiSFqEIVoBkQF+NTMtAvSdYJJGBcHR4fFlD4F0O6yX9hxvqSS+p4+fRoK36U+QZhmXz
         l7H2BdECUXGao9r62nl2To7n1bLUzDsbNxJ3fIvWeJyOEmL87agrLRfFqZyzl4mWD0z1
         2GSCRVUl8zUG5nEq/HrViGnIwnU+DPA3CfDk2Lj2JMsA/7k5CBvG+NLbD1ZWireYr5BY
         WEQw==
X-Gm-Message-State: AOAM531b+lZtEqhpxJ0x94+f7ZkMjLnuJ4UpM4JBk/J/6IBRBXtufeT0
        oqDXLd6ay+mSJJl37fHSj90r/5y8yyFpxdh0gNeb5snnF2CxIBa5fhHuNxmsAmcSwsnNRYMXOO1
        X0Rw406UKSH6lH+4USw2GZ8vXojM1LA/VLBhfVKH17uH0
X-Received: by 2002:a05:6402:4387:: with SMTP id o7mr18183365edc.77.1633959235874;
        Mon, 11 Oct 2021 06:33:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLeTGK5Vyvc9ZBIZQgzot5W/MsVUfLcPkJ81E15XqTbR6u2CWcacsANyKJM9MNvAiDHxYWfg==
X-Received: by 2002:a05:6402:4387:: with SMTP id o7mr18183346edc.77.1633959235736;
        Mon, 11 Oct 2021 06:33:55 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g17sm4242831edv.72.2021.10.11.06.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 06:33:54 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 0/7] nfc: minor printk cleanup
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>, k.opasiak@samsung.com,
        mgreer@animalcreek.com, linux-nfc@lists.01.org,
        netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org
References: <20211007133021.32704-1-krzysztof.kozlowski@canonical.com>
 <20211008.111646.1874039740182175606.davem@davemloft.net>
 <CA+Eumj5k9K9DUsPifDchNixj0QG5WrTJX+dzADmAgYSFe49+4g@mail.gmail.com>
 <CA+Eumj65krM_LhEgbBe2hxAZhYZLmuo3zMoVcq6zp9xKa+n_Jg@mail.gmail.com>
 <20211011060352.730763fe@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ccff3781-60e1-8ff2-043b-80dc6e3ad355@canonical.com>
Date:   Mon, 11 Oct 2021 15:33:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011060352.730763fe@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/10/2021 15:03, Jakub Kicinski wrote:
> On Sun, 10 Oct 2021 13:36:59 +0200 Krzysztof Kozlowski wrote:
>> On Fri, 8 Oct 2021 at 12:18, Krzysztof Kozlowski wrote:
>>> On Fri, 8 Oct 2021 at 12:17, David Miller <davem@davemloft.net> wrote:  
>>>> Please CC: netdev for nfc patches otherwise they will not get tracked
>>>> and applied.  
>>>
>>> netdev@vger.kernel.org is here. Which address I missed?  
>>
>> The patchset reached patchwork:
>> https://patchwork.kernel.org/project/netdevbpf/list/?series=559153&state=*
>> although for some reason it is marked as "changes requested". Are
>> there any other changes needed except Joe's comment for one patch?
> 
> I think it was just Joe's comment, nothing else here looks
> objectionable.
> 

OK, I'll send a v3 with fixed SPDX.

Best regards,
Krzysztof
