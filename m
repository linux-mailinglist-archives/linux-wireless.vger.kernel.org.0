Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35034ED331
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Mar 2022 07:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiCaFUe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 01:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiCaFUd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 01:20:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA651BE85
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 22:18:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso2511830pjh.3
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 22:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=782J1NpqHfQ8AVUk5Pzhh6DzEhnw9kpRFm8h/Y5WUIc=;
        b=nthXG46NwwkCHx6zh2Eg30uulz24zEsi8hSAXWNIz374V8wiB4UY2ORBIX7HvX1Wpu
         pcSzHyaPRDQRR8HYkt8ADe21yE4lheYxCa78YyQFiWTakTGRwKzZy06UbFuTFXFxxzV/
         S1HAfevtR9U1fyQCsd+fd1TGASnBu60PcB3o/KMe4VgdfU7rnybDTcV/10ddTDTW6CbJ
         19PvIAFXzbU7jI1gVhgy6pUTuVN27YtTo36WO33SB33JXh7MgWEj9te0Uqonf7ev/a/e
         ClhwCDHRDqAcwn5ODQSMMPj6hBA2DD/2ZItP4fAW5eJ0C0oNsak8/NNNdnV/j7ZOoU2I
         0cDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=782J1NpqHfQ8AVUk5Pzhh6DzEhnw9kpRFm8h/Y5WUIc=;
        b=Qr9GNvISMulPbR97iq/Wh/p4Dsdr5OgHB+yRRl6YOSO/66Cq8LBuYV+iwKuVEsQI1n
         Eij/I8zFFbK85maL33Q2dNeKYaiBImGk4KAJppRgL5IpQy8mfKvq2QBDqTkpUKa79M1b
         XzCXylWvJYZAr3JDx/Q5uq8eP05Pzrfi+Vt17w8yDe0xBq8sQ772P6E30csQfLMq8pB0
         8Z/XW8871IrEFUCLtW9Wj143cKGdH4XPPCN+80+lTHYVY/RrSyNJrx5RugyKgGLVCWs3
         Vu1goCwVVZ0A0nwNwERH9TZIJNCrfEZKxiDp7K3TBP1zs17srz7TZ0X4igurccqVif6b
         Og9Q==
X-Gm-Message-State: AOAM5339FxH3gFAyVBj5Nr1PBbZOF4ObO9LZaONoktdT+EM/yA/oR2lz
        /sG4pqj9A64RHPKDEIyG4ak=
X-Google-Smtp-Source: ABdhPJzSTUk77jWjzosGTPDymvmJKPRfy2Ar6iu7oHHKvAMQLNVEvs1ozIZF9nD5aI5BsuZ7FN4SsA==
X-Received: by 2002:a17:902:e851:b0:156:3cbd:22d0 with SMTP id t17-20020a170902e85100b001563cbd22d0mr8703909plg.33.1648703926241;
        Wed, 30 Mar 2022 22:18:46 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm23034896pfw.144.2022.03.30.22.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 22:18:45 -0700 (PDT)
Message-ID: <2aafdeb2-24ea-7b6d-e714-d9b3047f6ced@gmail.com>
Date:   Thu, 31 Mar 2022 12:18:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5.18] ath9k: Properly clear TX status area before
 reporting to mac80211
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <20220330164409.16645-1-toke@toke.dk>
 <8ad2754c-c5bb-7b07-6b3f-5701d0434eee@gmail.com>
In-Reply-To: <8ad2754c-c5bb-7b07-6b3f-5701d0434eee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 31/03/22 12.06, Bagas Sanjaya wrote:
> No regressions and UBSAN warning [1] reported on dmesg.
> 
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> However, there is something missing. I don't see Cc: stable@vger.kernel.org
> trailer in this patch. I think it should, because I reported that this issue
> first occurred on v5.17, then still appeared on v5.17.1.
> 

Oops, missing link for [1].

[1]: https://lore.kernel.org/linux-wireless/87bkxn4kpf.fsf@toke.dk/T/#mc2ef5bbdf51fd4ead05b1115cedd58153675365c

-- 
An old man doll... just what I always wanted! - Clara
