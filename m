Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50DD25F6EE
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 11:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgIGJ43 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 05:56:29 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:47772
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728233AbgIGJ41 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 05:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599472586;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=EKtUKPB3gmnM0BbeYvDZjSYUc0HismSLiDOG12Akloc=;
        b=S1enhPdk+4HQ9VskhNVxCTy3B7wN2XqJ3Emrqq8sPZ/KzGmRNul2qP4kPEGRPyUH
        6+VrqgukQOmjBlJ6AwwPpcQL/Gk8NRgLEIr4tIx8i3Ranh6+JdZtEHY5A/yGhvx3vVs
        Jtxm24V5zy2drGVm1xZmfdd7+okB2KgMAYXZRr6U=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599472586;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=EKtUKPB3gmnM0BbeYvDZjSYUc0HismSLiDOG12Akloc=;
        b=emEEd/3mgW6MyuQCV3Nn2LItioAWkzP6kMDWReKuwndQ60NwfwfxgyyTviiflvXR
        dB91jYJb7apKNsufzCEN9QRJTkS8FWLjXaaF2XE//AgSl7BGqpxF/In8Oc+0vvEgIMD
        yVqTX+mFLGTYvzCndsiGy8yWEUNaEs6K31Co9FU0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13529C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     akolli@codeaurora.org
Cc:     Julian Calaby <julian.calaby@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v3 2/3] ath11k: copy ce service configs to hw_params
References: <1592458104-2961-1-git-send-email-akolli@codeaurora.org>
        <1592458104-2961-3-git-send-email-akolli@codeaurora.org>
        <CAGRGNgV74fCD1gb=rXEe1BMN5+5stYeX3W6eKc4-do76TBmFqA@mail.gmail.com>
        <34ed705f28b40fab493b8c888138e6a7@codeaurora.org>
Date:   Mon, 7 Sep 2020 09:56:25 +0000
In-Reply-To: <34ed705f28b40fab493b8c888138e6a7@codeaurora.org>
        (akolli@codeaurora.org's message of "Fri, 19 Jun 2020 21:54:42 +0530")
Message-ID: <0101017467feccbe-322cfbf1-f151-4ebe-aa6a-f6cd8791178d-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

akolli@codeaurora.org writes:

> On 2020-06-19 04:40, Julian Calaby wrote:
>>
>> On Thu, Jun 18, 2020 at 3:31 PM Anilkumar Kolli
>> <akolli@codeaurora.org> wrote:
>>>
>>> @@ -950,6 +950,16 @@ static int ath11k_ahb_probe(struct
>>> platform_device *pdev)
>>>                 goto err_hal_srng_deinit;
>>>         }
>>>
>>> +       ret = ath11k_init_hw_params(ab);
>>> +       if (ret) {
>>> +               ath11k_err(ab, "failed to get hw params %d\n", ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +       ab->hw_params.svc_to_ce_map_len =
>>> +
>>> ARRAY_SIZE(target_service_to_ce_map_wlan_ipq8074);
>>> +       ab->hw_params.svc_to_ce_map =
>>> target_service_to_ce_map_wlan_ipq8074;
>>
>> I think you misunderstood my point about this, the point wasn't to
>> copy the svc map to hw_params, but define it in hw_params:
>>
>> +       {
>> +               .hw_rev = ATH11K_HW_IPQ6018,
>> +               .name = "ipq6018 hw1.0",
>> +               .fw = {
>> +                       .dir = "IPQ6018/hw1.0",
>> +                       .board_size = 256 * 1024,
>> +                       .cal_size = 256 * 1024,
>> +               },
>> +               .max_radios = 2,
>> +               .bdf_addr = 0x4ABC0000,
>> +               .hw_ops = &ipq6018_ops,
>> +               .svc_to_ce_map_len =
>> ARRAY_SIZE(target_service_to_ce_map_wlan_ipq6018,
>> +               .svc_to_ce_map = target_service_to_ce_map_wlan_ipq6018,
>> +       },
>>
>> That completely eliminates special case code based on the hardware ID
>> in the driver.
>>
> The static array of structures target_service_to_ce_map_wlan_ipq6018[]
> is defined in ahb.c and hw_params are initialised in core.c, this will
> not work. no?

You could move the map arrays to hw.c, as an example see how
ath11k_hw_ring_mask_ipq8074 is implemented. That way we don't need any
new hw_rev checks.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
