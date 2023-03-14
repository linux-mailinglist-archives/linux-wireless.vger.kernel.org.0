Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D374E6B9545
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 14:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjCNNEg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 09:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjCNNEO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 09:04:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46D19663C
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 06:00:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o12so61655406edb.9
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678798789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOvlS9sNnIAgMeiZIPQKbYtFPVSiHJBUwPLfTIY6Uq8=;
        b=l/GMyLsSNlEI1ncXHpAGoyfpP8t/0JsG2vUswVrn3T6jLx/ClNO00bRJuRZCHFjnRf
         jp0cp24Y3yimd7t/ajg+yyhdSaQLd0RhmqTuzPnBFVzw/MmN1erFp58bZNVP0f2qzsX7
         LlovXuQ4fYxUoUXbhFvY2lO73attcWOI6UORg+JIO0Xa8RwC6xi28ZFHNHvrH5IH90gg
         9FT72cu7hIkDMv6UYNuJ2PZj2O3KBe9+Qab3XEBUTlYEToPbRmfMIftmSQ3UbLnOphjJ
         I0B9+tjxUmHWN4wm0FtNd2Tcwn8B+aDT4PtKt2IYlSLZha5tAIqIoctoN4iXM+5pKc0/
         kkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678798789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOvlS9sNnIAgMeiZIPQKbYtFPVSiHJBUwPLfTIY6Uq8=;
        b=BDZ3IqmVmr9by+oIiqsP7MWj7tboXgddB2SGEzm8UMcPxNxCBRSDq63G95egoUfcEZ
         /596CjRgSfDYjZiIcqZSr9YO87xQaFWcWJfEfJwMpqCpq9UW+bh6bnivLO1bxzZNk79r
         LHPHSHlseGr1D1Dsm6WkxoXEpyst7kXY9J4ZRmHWaGwDTBO3EKz4aV3aoroCn0rmld7f
         ssX6nuuOYZuobsmxj1sE4bie7WG62UG6+TdqB86eP+VPzuJUS5PsVGlQPc9TBETogGnu
         oVneE7svIpMp/S8xbzenEu3tSQZvED4001n0KChb555YQNk6CQiYV1/ss20fvLHJkVsn
         GfMw==
X-Gm-Message-State: AO0yUKX+Qyou0D5heUE2ViL7/51ERcaIx5I4ioK7bx3+gb0ECsSZO7zc
        QqOMMu3Udx6E1Tj/EUt6Bzveo4XGQxc=
X-Google-Smtp-Source: AK7set8PFmSkHtNOh7s02YAOdDNYllsLU9pj8pSCnyBE/jBVSNveBkc6BoztdE8/F9AuUBqUpsutfA==
X-Received: by 2002:a17:906:6150:b0:8df:8381:52f7 with SMTP id p16-20020a170906615000b008df838152f7mr2368916ejl.17.1678798788783;
        Tue, 14 Mar 2023 05:59:48 -0700 (PDT)
Received: from shift (pd9e2911a.dip0.t-ipconnect.de. [217.226.145.26])
        by smtp.gmail.com with ESMTPSA id y4-20020a170906558400b008bfe95c46c3sm1106256ejp.220.2023.03.14.05.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:59:48 -0700 (PDT)
Received: from localhost ([127.0.0.1])
        by shift with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1pc4Df-0005AQ-2T;
        Tue, 14 Mar 2023 13:59:48 +0100
Message-ID: <97b7f35c-f7c9-1257-ff67-e5b61efe0ce0@gmail.com>
Date:   Tue, 14 Mar 2023 13:59:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PULL linux-firmware] ath10k & ath11k firmware 20230215
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
References: <878rgzuw37.fsf@kernel.org>
 <c9ccbfe1-9535-f46c-756e-4eb19c1afbff@gmail.com> <87a618517g.fsf@kernel.org>
Content-Language: de-DE
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <87a618517g.fsf@kernel.org>
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

On 2/20/23 06:56, Kalle Valo wrote:
> Christian Lamparter <chunkeey@gmail.com> writes:
> 
>> On 2/15/23 10:17, Kalle Valo wrote:
>>> Here's a new pull request for ath10k and ath11k. We have new hardware
>>> IPQ5018 and various updates for existing hardware. Especially many have
>>> requested the firmware update for WCN6855 which seems to fix an
>>> important suspend problem.
>>>
>>> Please let me know if there are any problems.
>>
>> Could you also please include all the QCA9888+IPQ4019 boardfiles updates
>> from last year too?
> 
> I will try to go through them later. The problem here is that I don't
> have much time for ath10k nowadays.

Ok, should I just post the board-2.bin updates to linux-firmware?
I have them ready to go for IPQ4019, QCA9888 and QCA9984.

Cheers,
Christian
