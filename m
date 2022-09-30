Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A6E5F1189
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 20:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiI3SXN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 14:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiI3SW6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 14:22:58 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2A124763
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 11:22:56 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id j188so5587249oih.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=MjqoKoFaBPfKtmocAOdmMAAFO/9NLmUcIQd15GCGGHY=;
        b=U+ctUpyOKcGOXiBrNpALIXCF06eAzB+TCMJNUEkdOg6XGeLcD6o9qrj8Tdg3OZ5Ep+
         FvUvRmk1sv6kDmgc951AB/tKyM7UWppFRh/L9dM6sIhmhlj7TLWekQXRDPvjKk6+ohhp
         ECYQ/+V7la57GeBeoUeJstqZUYig5w4Q21TmCYgqvX7VUx+CQn0F6iJEd1NDWYBVUY7G
         KUgv+EMH3eXdmTL94sYWQn4pAOr9i3CfUwzpwsMa5cwB72CMkVppb8R7QEdeOYLmzzni
         o6MwX1+PA+2A370rbJxBOOTmvd9JLoMwBZBLmOvwLWoBu1CM2XjKhzNsSfdMJqo/9Kgg
         wm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=MjqoKoFaBPfKtmocAOdmMAAFO/9NLmUcIQd15GCGGHY=;
        b=IlY0w2RAIM/9X7an4nReBMJfeSp0S87bqi8BatEUbyKiFqrbP7mTOlyfOTfBE7t+6X
         o2aAw9KYB7bwd6AHg8OLSaYYdyJwVUu4G/qBfqjC2GAZEvbCy+nLXo6YtNjJ5BxraNWD
         ECJ598EtsMoqPckro8yY6iptGqJbNejnsxmrMuunChjZSxgn2D8fJzupM1uB1JGND4F2
         0OdZm+gECyyjPo5JMMkCQRpWChsNuoPvwNzYSyiqRyzyOXMmPBvBRonqifKbqgwr7/NN
         w0dI8mBFABz5F0sAS7xXjZB7PjTCOIpV8q9z6F+OeQuR7+F5UdXCxhmFeEXA7X7K6RL+
         nOdQ==
X-Gm-Message-State: ACrzQf1nWRj3H9DBnWetmK+9J+YRHZ1rSoIfELnkbRJoM2etEDRZu6uT
        o/oGJjhjSvPzOI5Cmd+0Zs1mNqyXbO8=
X-Google-Smtp-Source: AMsMyM6ENwPl1NK4gTa2yclAIS+77m1ZMAGGwIP3g3S41GkYLyEkEIlMiupostf20F9PFVFaP4MKvw==
X-Received: by 2002:a05:6808:20a5:b0:34f:63a5:a63b with SMTP id s37-20020a05680820a500b0034f63a5a63bmr4379382oiw.236.1664562175752;
        Fri, 30 Sep 2022 11:22:55 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l8-20020a9d7348000000b006393ea22c1csm711259otk.16.2022.09.30.11.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 11:22:55 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <bcb91ab3-2f78-d212-f0d0-a76c3d9559e0@lwfinger.net>
Date:   Fri, 30 Sep 2022 13:22:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: wifi driver
Content-Language: en-US
To:     =?UTF-8?Q?Oliv=c3=a9r_Koncs=c3=a1r?= <kolynetg@gmail.com>,
        linux-wireless@vger.kernel.org
References: <5D8A56A3-4169-4FA6-8E54-85F6F018A378@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <5D8A56A3-4169-4FA6-8E54-85F6F018A378@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/30/22 10:54, Olivér Koncsár wrote:
> hi
> 
> can you please help me with getting wifi work on rtl. i have lenovo legion 5 notebook.
> bit urgent i would highly appreciate.
> i tried to wget the rtl89 but it timed out.
> thanks!

You need to do a 'git clone https://github.com/lwfinger/rtw89.git', the 'cd 
rtw89', 'make' and 'sudo make install'. You will probably need to install git 
and the kernel headers from your distro. Once you have cloned the repo, file 
README.md will give instructions on how to install the headers for a number of 
distros.

Larry


