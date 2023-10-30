Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDB57DBE6D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 18:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjJ3RBP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3RBO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 13:01:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76005A9
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 10:01:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D036C433C7;
        Mon, 30 Oct 2023 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698685271;
        bh=uhht+9KTwyk5xSob1/njGftx8cix5tlAAKpjG3TawZE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=t8DS9JKVcR63N9kyRZcLw1my5sk6Ql1WYdfXRXLbkFlOiVhOuTpXG9ZvqV2++eZ5/
         fCDIpxT6dUA7CrL+zHNYNxQLELEGW0PYhc1JPToFoPJIqLEe3GBdXPfIxxsUeDB4HB
         /9S7Rtbmeai8X1S1fUg2zdmGjOVZ9Kd6fEPuHSGtorfi73KWbnT24Ei0NNvZk44Xl+
         IXqxnMld/KW4SA67yf+fiqLrBYhSFY8DXVgut3NrJwfuCFJEG4/a/qoAqKxW6wTx9Z
         SYRkie6BqBC90CV48MwNwZWtlW2GqvjAXrMuIMlIQ23nrLOQkFCA67x96eZ1ilwAS/
         sNJmBVUVTs8vw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Aaradhana Sahu <quic_aarasahu@quicinc.com>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/4] ath12k: Factory test mode support
References: <20231030082749.17855-1-quic_aarasahu@quicinc.com>
        <37452ae3-3006-41ca-9b31-f0d4bed75e35@quicinc.com>
Date:   Mon, 30 Oct 2023 19:01:08 +0200
In-Reply-To: <37452ae3-3006-41ca-9b31-f0d4bed75e35@quicinc.com> (Jeff
        Johnson's message of "Mon, 30 Oct 2023 08:21:11 -0700")
Message-ID: <878r7kvycr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 10/30/2023 1:27 AM, Aaradhana Sahu wrote:
>
>> Device is booted in factory test mode for calibration.
>> The commands are sent from userspace application, which
>> is sent to firmware using wmi commands. Firmware sends
>> the response to driver as wmi events and driver sends
>> these events to the application via netlink message.
>> Also added changes related to correct pdev id access for
>> fw test cmd.
>> Aaradhana Sahu (3):
>>    wifi: ath: create common testmode_i.h file for ath drivers
>>    wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>>    wifi: ath12k: add factory test mode support
>> Rajat Soni (1):
>>    wifi: ath12k: Fill pdev id for fw test cmd
>>   drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
>>   drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>>   drivers/net/wireless/ath/ath12k/core.c        |  19 +-
>>   drivers/net/wireless/ath/ath12k/core.h        |  13 +
>>   drivers/net/wireless/ath/ath12k/debug.h       |   1 +
>>   drivers/net/wireless/ath/ath12k/dp.c          |   3 +
>>   drivers/net/wireless/ath/ath12k/mac.c         |  13 +-
>>   drivers/net/wireless/ath/ath12k/pci.c         |   1 +
>>   drivers/net/wireless/ath/ath12k/testmode.c    | 413 ++++++++++++++++++
>>   drivers/net/wireless/ath/ath12k/testmode.h    |  42 ++
>>   drivers/net/wireless/ath/ath12k/wmi.c         |  38 +-
>>   drivers/net/wireless/ath/ath12k/wmi.h         |  22 +-
>>   .../wireless/ath/{ath11k => }/testmode_i.h    |  52 +--
>>   13 files changed, 624 insertions(+), 72 deletions(-)
>>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>>   rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (53%)
>> base-commit: 0263687f4441d5a5eab8074d56b4693c8f0acf85
>
> That base-commit is pretty old (tag: ath-202309051328) and your series
> fails to apply to current ath-next, please rebase:

That tag is almost two months old! Aaradhana, what an earth are you
testing with?

> Applying: wifi: ath: create common testmode_i.h file for ath drivers
> Applying: wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
> Applying: wifi: ath12k: add factory test mode support
> Patch failed at 0003 wifi: ath12k: add factory test mode support
>
> In addition, please use

Jeff, did you sent your mail too early? Something seems to be missing in
your mail.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
