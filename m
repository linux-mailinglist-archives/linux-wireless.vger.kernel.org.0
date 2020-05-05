Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72E91C6023
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 20:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgEEScr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 14:32:47 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:24358 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728292AbgEEScr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 14:32:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588703567; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=kqcch0uCot+4dXsdXDL01hE7tWa5z9rZFO4hj6Mt8EQ=;
 b=eMfypgiGVUqaMOuDzX8ssGrCeYFVSXL0xiT3QB1UzPJmvteSLeCQYQfyqTDQSAIbQDaRy6sO
 lck3DaV07S4FzNlV7p7iLDmsur3JmP7Llkp9hS72dDkrKpqvL1FMfjmi5kjkHMuGHAf/iNMr
 OxGCs4nFCZB58hCKxlin6H3pJBY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb1b14e.7f2b7a552260-smtp-out-n04;
 Tue, 05 May 2020 18:32:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33B75C432C2; Tue,  5 May 2020 18:32:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5241C433F2;
        Tue,  5 May 2020 18:32:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 05 May 2020 11:32:44 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     Sven Eckelmann <sven@narfation.org>, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        kvalo@codeaurora.org
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
In-Reply-To: <46ab4ffd-b512-de43-40bb-f35989d228b9@tu-ilmenau.de>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
 <f772b7bf0eac31516a4e28719c1938f2@codeaurora.org>
 <2335594.cnkAv9Vaq7@bentobox> <1845755.pTfhzBy2qg@bentobox>
 <46ab4ffd-b512-de43-40bb-f35989d228b9@tu-ilmenau.de>
Message-ID: <0cd75c16a8557a44e9b2c086847941a1@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-05 08:37, Markus Theil wrote:
> On 5/5/20 9:49 AM, Sven Eckelmann wrote:
>> On Tuesday, 5 May 2020 09:01:34 CEST Sven Eckelmann wrote:
>>> On Tuesday, 5 May 2020 01:46:12 CEST Rajkumar Manoharan wrote:
>>> [...]
>>>> IIRC this was fixed a while ago by below patch. Somehow it never 
>>>> landed
>>>> in ath.git.
>>>> Simple one line change is enough.
>>>> 
>>>> https://patchwork.kernel.org/patch/10550707/
>>> Because it doesn't work for everything. Remember that 10.2.4.x 
>>> overflows all
>>> the time (14-30s) because it used only 31 bit for the counters.
>>> 
>>> But feel free to point me to the firmware version which fixed this.
>> See also https://patchwork.kernel.org/patch/9701459/
>> 
>> Kind regards,
>> 	Sven
> 
> This patch already fixes the problem for me. I tested it on QCA988X hw
> with firmware 10.2.4.
> 
> [   10.350919] ath10k_pci 0000:04:00.0: qca988x hw2.0 target 0x4100016c
> chip_id 0x043222ff sub 0000:0000
> [   10.350930] ath10k_pci 0000:04:00.0: kconfig debug 1 debugfs 1
> tracing 1 dfs 0 testmode 0
> [   10.351803] ath10k_pci 0000:04:00.0: firmware ver 10.2.4-1.0-00047
> api 5 features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
> [   10.385617] ath10k_pci 0000:04:00.0: board_file api 1 bmi_id N/A
> crc32 bebc7c08
> [   11.536818] ath10k_pci 0000:04:00.0: htt-ver 2.1 wmi-op 5 htt-op 2
> cal otp max-sta 128 raw 0 hwcrypto 1
> 
> I also did not see the 31 bit overflow after a small amount of seconds.
> 
> Survey data from wlp4s0
>     frequency:            2412 MHz [in use]
>     noise:                -65 dBm
>     channel active time:        5370225 ms
>     channel busy time:        924199 ms
>     channel receive time:        140 ms
>     channel transmit time:        0 ms
> 
Great. Thanks for validating the patch. Venkat will post the patch on 
ToT.

-Rajkumar
