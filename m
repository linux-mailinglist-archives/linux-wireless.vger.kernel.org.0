Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F51F667206
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 13:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjALMW3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Jan 2023 07:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjALMW2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Jan 2023 07:22:28 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61170CE
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 04:22:25 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qk9so44346212ejc.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jan 2023 04:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0CjIJiFjf9T3NbSRC+V7hvnl0N7fcGsUN/2LjKkxSk=;
        b=CbTqgf0GIB7Y6OZZGeb+I++9rhZjWMBkK/x2WZy5BJvmb8C7AaRwKKKGCfd9avQNrz
         bJdlSz9vFFezkzfK2ZOHGb7GM3JK2wIdZSNZSXMX/KbP+o5/2HURH9z3u/smZSbDiq/D
         MlrlmMABM2BfE3c9RCd2NOpDOBQN5L3c6yegOX3KtA0KM+LHTUfrG0Da5gmupt73DMr/
         Ak5G+KLxdCV9GfJhhqwi0LiLAdYZialbk+omz0xWpApZsgXQQDCbvFuPtogpV5qdacFO
         4yBWh5378P7mdM6aaV9kgNhe/u+n1YOrKh6eQvWnsCumWP2YX5v9hoP8HbCP2EsIgNT+
         n0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0CjIJiFjf9T3NbSRC+V7hvnl0N7fcGsUN/2LjKkxSk=;
        b=VV5dSiTq2vsEGxBzYdZhXeBUFFATOHGgoAEhxnibMgBAlhvxeLT3D4ZPZwW3PkvsqW
         9pgGGWZTp0zRHFcJ851E6Qzxh3YTZMf34zXdyqI2f0YnWkolWwa450/SOtlAqbEAWxGW
         eUfl1Dqsa7Vm21/EUB/3j1m+2XhgTp0Hr3X20lHuId1yx58vXm8FUG7Z5O+LEk7oUd1J
         Uoz2NIvY5SySbyFFtKDq0Ce7iWxYmyvNy2nPG2DXr3O4DWNVuUP4Rj4VA4Ca5nOus2hd
         DUg1LeeRejYGJEh6MeIoARXXro/iAEPEShoqCC7/GInNoVyfzDxiLA7QfdK2aJxFCkjf
         UeVQ==
X-Gm-Message-State: AFqh2kombRoQ1ZZ8M2uEpecQGMOoJ8RjADxhewxJoud/INaQaNA2Xka+
        h9GfHppkjD4SOYEUGB9X5dsrmxrWZajqfdrT
X-Google-Smtp-Source: AMrXdXvIk2w+t2RNk+Uo1IB30ZCU4mOJ89nt9m+QFWzoxLGxYGDouxVaQEKtA8TN3LScxcOiR8smew==
X-Received: by 2002:a17:907:8e87:b0:84c:a863:ebe6 with SMTP id tx7-20020a1709078e8700b0084ca863ebe6mr40481006ejc.43.1673526143880;
        Thu, 12 Jan 2023 04:22:23 -0800 (PST)
Received: from [10.1.0.196] (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063ca900b007c073be0127sm7366963ejh.202.2023.01.12.04.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 04:22:23 -0800 (PST)
Message-ID: <bc23d967-bbe6-5b38-fced-2bdf7a80d486@mind.be>
Date:   Thu, 12 Jan 2023 13:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/1] iw: add support for retrieving keys
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20220822074318.291949-2-raphael.melotte@mind.be>
 <20230102111213.77129-1-raphael.melotte@mind.be>
 <9d6ec2ca03f6625809ccca6006f2ce842f9fe20a.camel@sipsolutions.net>
Content-Language: en-US
From:   =?UTF-8?B?UmFwaGHDq2wgTcOpbG90dGU=?= <raphael.melotte@mind.be>
In-Reply-To: <9d6ec2ca03f6625809ccca6006f2ce842f9fe20a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/12/23 11:05, Johannes Berg wrote:
> On Mon, 2023-01-02 at 12:12 +0100, Raphaël Mélotte wrote:
> This is odd now - if you have &end you should check that strtoul()
> actually consumed all the input etc.? Otherwise might as well just use
> atoi(), but I'd prefer with the checks.

Indeed..

> maybe add that before the argv/argc (and maybe break line in there) -
> first I got concerned if argv/argc was used in that nla_put_u32().

Okay, I'll do that in a v3.

Thanks!

Raphaël
