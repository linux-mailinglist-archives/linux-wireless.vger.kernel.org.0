Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDEF70E1BC
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjEWQ2W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 12:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjEWQ2V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 12:28:21 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907A9C2
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 09:28:16 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-19a2d231ef1so3762810fac.2
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684859295; x=1687451295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0EplKN220qWwMJe0myxhtKgWW1y38pH2nxBIMbaRuXY=;
        b=dtNB5Cln138Ahv+EEVYfNUH0fMuPGTmGdLS3n+CJypjF+7YsnbWHW59UgT8M6ds82O
         ei/crV0NsWZE7MbNL3F4GxTCb9Ezpsm4b1YUg7nAUWLVexqgTHZPEESijOowX1lpEfxR
         Hr5/IzxhF3aowmbIlyDa5eJhYMfmkOXtEAAnZrbi0huy8ESl6pU9vo00Sw6OQQYkfqPm
         h4sV0xzCLZ4kzt8uPFdOwwe5BJczPF5T7uwaGcESyzz5U1MS4eBygAhc5KdD/E3JYMdK
         HGVVwCQUi6GCznaiJ0NHMtUt/YSwalXAvIO0FFiqnfWhkXKNPkuALbMc/QFaF0c4wU4V
         d1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684859295; x=1687451295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EplKN220qWwMJe0myxhtKgWW1y38pH2nxBIMbaRuXY=;
        b=eeUI3MuS1Si0833//yIRhJvu3WvjXR5pdFbkcqcfsXKBfn3v45k7wtqQazMYIkvzN0
         wHZF9WI0EsIfLjF8jxy/NqHt/Fh+krHi7BP4BVpV8JjdYjzOwlWWtqqOiNYIbPpwqZNj
         Qsv/k5VeKpCYTNWoGG3JMK1BeQP9GSYYQotgZGeHeCMuyfN/6SogU2FMC73ElMFThltT
         xTj6NYW4QKGvUZ9IL41ae3fr/3JcACYwcVM85/AQg+TutMKEOPLblq4mk+nYlA29QJVt
         kv3mQF7VBVeKwT743FgKL5DoJTAgqYp0DCXFqyLJ7t4vB5G1CccAwHZJMOBw4zx9IURa
         kgBA==
X-Gm-Message-State: AC+VfDwqeG52I9ghy6VZWZM2US5voFFKWgtHse1/9pDbiGgZQgSfC03A
        DJE8DdFTjxOelR9vdGC79lCFb0mBj0w=
X-Google-Smtp-Source: ACHHUZ5vT0PtUUceFGGmrlXioXn+w2KcdWNuRMRGobleg7nKEfsOGvJzA8HRlAuM8T3ATTDA9uMW5g==
X-Received: by 2002:a05:6870:87c1:b0:195:fd22:ab00 with SMTP id s1-20020a05687087c100b00195fd22ab00mr8341109oam.54.1684859295651;
        Tue, 23 May 2023 09:28:15 -0700 (PDT)
Received: from [192.168.0.159] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id w2-20020a056870948200b001718e65a5d0sm3702523oal.57.2023.05.23.09.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 09:28:15 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <bef49f90-ee01-4ca5-b8b5-dd43e2eb8791@lwfinger.net>
Date:   Tue, 23 May 2023 11:28:13 -0500
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
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAMzNfvNXqKyvy-88y79WnJ6BumAyGLQEkAcUk-9k3JeDLKeCkw@mail.gmail.com>
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

On 5/23/23 02:16, Fabrizio del Tin wrote:
> Hello Larry,
> great news really!
> 
> Actually, the file common.mk is missing, so it fails.

I just pushed that file now.

Larry


