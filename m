Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D424E35D6
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 02:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiCVBBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 21:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiCVBBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 21:01:44 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B59733CA17
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 18:00:17 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w127so18052315oig.10
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 18:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FkWVbVYHckhwWXMaNGJjQTWT8MUI4oCwpDzRXOslxhA=;
        b=mEAm3SMPWhTT/zoqEKDtofp2cj4yUb4Fafw4oBoy1sBbLn0iZ3JiNqQPwjBPfGW8Zd
         +tV8AsZjo4c16tUpDX63boh1WaSqwIfkukYeiAETeOyPubL0CMztsVC0xJzjtawECPv2
         DcfJA/etjQbcYRdP3ADof2j8PVLAX7GMhL5YiM5xCnP6Z20pQQq/fTu3yUv3wM84evsj
         UvFSH7lyTK0y0ZwqWNb002wz0bysWNsCrfFbg48eZikISkTKB1PbVSJXRdwA+wbNuwxg
         TiewQwo6HpWYV0PBCeqLZ3ohn3y6XOwLhgp/pr/79p5zXAfzEvzI7K0aLmA7XoFcbtK6
         NWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FkWVbVYHckhwWXMaNGJjQTWT8MUI4oCwpDzRXOslxhA=;
        b=7w8/SlvJ0Dnyu4w2sbNoqD2zRyRIyClq9AtgB1SvjJYWKWgeZtN/d4dqAIIr+SVjpL
         MfTk0KMipbybCLKSx67ys6409xS57wPTZUe5yJ0kWT4j4UDqdxupF9UIxUWaOk3Ug6ez
         iCYKbyQ/ci+PAvhuV6vgJGDaFn60YmRbJXBmviy+QIPAIT2B5m7pATeP33mTgW8bpX4J
         iilD/iwtbXDJPGaJ5QRvI0Fdmh7R6/RU3ZsxbuhmuecH73B8d0SpKeHt5C5B4BbfEG8B
         HMHGDe4mDFGtYxwrxAWjVzdqsmBmByNMNbNO7KboZY+XcPf9opWrd6pyyxlXL+sZOXo4
         /dKw==
X-Gm-Message-State: AOAM532QqF5GqUo3NQ3caJCbzDN2fd8hoOan09+0DbqaMH9/MtbctMdh
        IPF3fxzo2gLC54BnfZgJoZ8=
X-Google-Smtp-Source: ABdhPJzNESxVnIF8JIBD4sR21n4ZMKveCGl0ybBzIPw6mUC+hSda26cna+YdSINJITA8egp838PeAA==
X-Received: by 2002:a05:6808:f8c:b0:2da:8414:a936 with SMTP id o12-20020a0568080f8c00b002da8414a936mr892344oiw.226.1647910816876;
        Mon, 21 Mar 2022 18:00:16 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::107f? (2603-8090-2005-39b3-0000-0000-0000-107f.res6.spectrum.com. [2603:8090:2005:39b3::107f])
        by smtp.gmail.com with ESMTPSA id e7-20020a9d2a87000000b005af548abe73sm8193942otb.4.2022.03.21.18.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 18:00:16 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <888df231-e9cc-58af-a8a9-35a6882f139c@lwfinger.net>
Date:   Mon, 21 Mar 2022 20:00:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: rtw89: unstable connection
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>,
        Stefan K <shadow_7@gmx.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <2127068.tFZMq15b3B@t460-skr>
 <CAAd0S9A-NpOcDySVMRZf_Avb7iTkodZCKaTdy_32V7MevtBkPA@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAAd0S9A-NpOcDySVMRZf_Avb7iTkodZCKaTdy_32V7MevtBkPA@mail.gmail.com>
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

On 3/21/22 12:42, Christian Lamparter wrote:
> What rtw89 firmware version do you use? I found that the current
> linux-firmware.git firmware v0.13.36.0,
> together with the latest patches (i.e.: "rtw89: add tx_wake notify for
> low ps mode" and later) improved
> the situation... by a lot!
> 
> Do you know if your debian is using Larry's rtw89 repo for its rtw89 driver,
> or are they simply sticking with that is in 5.16? If they just use the
> 5.16 stock, you should
> give wireless-testing.git a try.
> 
> (Note: Your router/AP might also play a role here. In my case, the
> connection was always "OK"
> with unifi ac pro. But not with a Rudgers Advanced Wifi modem.)
> 
> (I had a Lenovo P14 Gen2 AMD and Ubuntu 21.10 for testing.)

The current state of the GitHub repo matches the code in wireless-testing, and 
what will be in kernel 5.18. It also has firmware v0.13.36.0.

Larry

