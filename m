Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B171E605EDF
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 13:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJTLa1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Oct 2022 07:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiJTLaY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Oct 2022 07:30:24 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C2181CB2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 04:30:23 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id p11so1280748qvr.12
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qN3HTjgbcHe8l52a9+YwD4sqPZ+GTntqrsXcQeRIg2s=;
        b=Hi8HFcY0IpNX8PT2Ggv8nHfDL6o7cueAPW+WM30v/8aDCyXC/EFBuLo/2oCd7CNNSQ
         noli9Tv4dblPF5RhGtBmkf76FdSoh8K67/6gF9zWurHflnt3rvwllsG7RWd8AsLpSd74
         9EPWd7tmXVq91YKhKR3zfiilpZtZp8QiyUwgJdev2SMc4Ly11m31GtH8EsD6Uj8e4MP2
         LdsqS8ijWWe38l13fK+t62tohSEI9zcs6tKp6nwa8DxRzYiunK1zIYUp/REk4b2EmFtG
         UqLb3cIaxGTLTWsP882sZFG+KnHYIexoJnUCos70JsRWwSTX9sWlNlGlx1P7LubaC7Gv
         ZiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qN3HTjgbcHe8l52a9+YwD4sqPZ+GTntqrsXcQeRIg2s=;
        b=eHEG540E77whHwMC+rUgvWOWpzHEQPC/MSkmB9QGIHmtlbDxXKaAId+2VTfzMKb0sw
         Uy2+n598/ybU9hELFvA8JQbvd6XIFDESQXenM588zwM+YWYscE9C3ijR/SApLkp5SzGk
         iwZIL1srwcsqtWmArkMGg5O91CZNqEyA/rBQoiYEh+s43u79qMTsVA8s08z+wPh7TfbM
         22W6MPd2K0/A7jVJZi9rxpooa42jf+F6/QBW4QiNzsehoe6tv93wAZhI8LWesoTOoGbu
         /3G/8gk/A2bkrkPV1rpVMV/FzWgf0SxzjSa95EyzEGN2/TFANtHg4NK35mksXMLiAB59
         fs8Q==
X-Gm-Message-State: ACrzQf0qyTZqcWGoZ7kIsRG/eY5IgzFHNPo+IqWzw6Ju576DDL9CKn94
        8bfw3vnfb8eQVJ2hyUary1lfaL3DHGvv3efV
X-Google-Smtp-Source: AMsMyM56ZKd5TaIIAZw0nIUad5IkM1cANqbOlkPwJZ9sdrNrVCmG71mxpN6hpaJEwc+Cm931b2z2AA==
X-Received: by 2002:a0c:f58e:0:b0:4b6:97f6:8d6c with SMTP id k14-20020a0cf58e000000b004b697f68d6cmr4880963qvm.27.1666265422584;
        Thu, 20 Oct 2022 04:30:22 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id q21-20020a37f715000000b006cebda00630sm7042431qkj.60.2022.10.20.04.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 04:30:22 -0700 (PDT)
Message-ID: <18b9e591-3495-5cb6-53cd-f8c11bc0a71d@gmail.com>
Date:   Thu, 20 Oct 2022 13:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] brcmfmac: Fixes potential buffer overflow in
 'brcmf_fweh_event_worker'
Content-Language: en-US
From:   Arend Van Spriel <aspriel@gmail.com>
To:     Dokyung Song <dokyung.song@gmail.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Cc:     Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
References: <20221020104954.GA461052@laguna>
 <1cbd1d8e-8dc5-052b-118a-0c546d5edad6@gmail.com>
In-Reply-To: <1cbd1d8e-8dc5-052b-118a-0c546d5edad6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The working email address this time (I hope).

On 10/20/2022 1:29 PM, Arend Van Spriel wrote:
> + Kalle
> 
> On 10/20/2022 12:49 PM, Dokyung Song wrote:
>> This patch fixes an intra-object buffer overflow in brcmfmac that occurs
>> when the device provides a 'bsscfgidx' equal to or greater than the
>> buffer size. The patch adds a check that leads to a safe failure if that
>> is the case.
> 
> Thanks for the updated patch. The subject for all linux-wireless patches 
> should begin with 'wifi:'. Sorry for noticing it not earlier. Maybe 
> Kalle can correct it when applying the patch.
> 
> Regards,
> Arend
