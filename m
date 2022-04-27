Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5966951106C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 07:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357827AbiD0FRH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 01:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344747AbiD0FRF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 01:17:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D06A6E39;
        Tue, 26 Apr 2022 22:13:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29E26B824B1;
        Wed, 27 Apr 2022 05:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68845C385A9;
        Wed, 27 Apr 2022 05:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651036432;
        bh=xTF+yKrSWLuvuV03D2dhdn9f/P9hF8bFAdNp1Z38lbw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=L40PUmY8eS9XKJ0DrkX15ae7Jyw+cxpol+DixnLYhrMkGZDLXv6drWamCka/bYuY2
         SCib48ZyLvuyWFUxlcmJBiwdkNq7bQ5CEqsoYxIWrhtDWlwZjwVDJgCMZ3So5q6B2r
         Rx46AvJe7VFdY7D/S9ameshBz3NB2DM/sW+JmZZQCiCSHFY430znzGkWAgvvz92UTA
         NJ3LcsG3q53fqQKYZENCr6x5w6hDtnckqXXJhA1cWWKpMyqvNRSbkXG/XxooPwu98g
         HtsR0AMHE92dy51rZttgIVHFaa5jJe3UclOdhE0LkraEnhnF9BFciHl5q2Upwo0DhY
         IWd5CjyJP+TWw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>, <linux-wireless@vger.kernel.org>,
        <mka@chromium.org>, <ath11k@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 01/12] dt: bindings: net: add bindings of WCN6750 for ath11k
References: <20220406094107.17878-1-quic_mpubbise@quicinc.com>
        <20220406094107.17878-2-quic_mpubbise@quicinc.com>
        <Yk2s+srO9DKP7xW1@robh.at.kernel.org>
        <e2fd6542-38fe-a855-1d8f-65799970727e@quicinc.com>
Date:   Wed, 27 Apr 2022 08:13:47 +0300
In-Reply-To: <e2fd6542-38fe-a855-1d8f-65799970727e@quicinc.com> (Manikanta
        Pubbisetty's message of "Thu, 7 Apr 2022 10:51:37 +0530")
Message-ID: <87zgk7hzw4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> On 4/6/2022 8:38 PM, Rob Herring wrote:
>> On Wed, 06 Apr 2022 15:10:55 +0530, Manikanta Pubbisetty wrote:
>>> WCN6750 is the WLAN chip on Qualcomm Snapdragon SoC SC7280;
>>> Though being a PCIe based solution, it is not attached to
>>> the APSS processor (Application Processor SubSystem), it is
>>> instead attached to another tiny processor called WPSS Q6
>>> processor (Wireless Processor SubSystem) on the SC7280 MSM,
>>> where the WLAN firmware runs, and it is the WLAN firmware
>>> running on the Q6 processor which enumerates WCN6750, as a
>>> result APPS processor would never know such a device being
>>> present in the system and would not detect the WCN6750
>>> hardware unless and otherwise WCN6750 is registered as a
>>> platform device. This is the reason behind adding WCN6750
>>> WLAN node in the device tree.
>>>
>>> Add WCN6750 wireless driver support, its based on ath11k driver.
>>>
>>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>> ---
>>>   .../bindings/net/wireless/qcom,ath11k.yaml    | 361 ++++++++++++------
>>>   1 file changed, 252 insertions(+), 109 deletions(-)
>>>
>>
>>
>> Please add Acked-by/Reviewed-by tags when posting new versions. However,
>> there's no need to repost patches *only* to add the tags. The upstream
>> maintainer will do that for acks received on the version they apply.
>>
>> If a tag was not added on purpose, please state why and what changed.
>>
>
> There are changes in V4 but nothing significant, I have missed adding
> the tag, will make sure to add relevant tags going forward.

I added Rob's reviewed-by to patch 1.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
