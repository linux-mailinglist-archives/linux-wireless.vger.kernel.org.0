Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924B1181E45
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 17:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgCKQwN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 12:52:13 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21907 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729584AbgCKQwN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 12:52:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583945532; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=V6oMUyzxc8WJYyiCYNE9NNAPJmSK3tL58ipnbdVKLeM=; b=QVxNi5piclDAkbP4no6haid6RKraVWj2lQPHHuHj0RJSDoF4B/wP1VwdNRG9qJOr21K7Swuk
 Afl6zD9NVudFYLFzZa5PtXKrb+uWefsMsAyJ5FE2ze0FoqYU2ZIXlK1Yymf7pYe+Hu/B/Do6
 o5TMiNThTtUAXimqOGwctNVhoio=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e69173a.7f7359ab2b20-smtp-out-n01;
 Wed, 11 Mar 2020 16:52:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4E154C432C2; Wed, 11 Mar 2020 16:52:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28252C433D2;
        Wed, 11 Mar 2020 16:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28252C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFT] ath10k: add QCA9377 sdio hw_param item
References: <1569507867-19547-1-git-send-email-kvalo@codeaurora.org>
        <7BB79E29-0ACF-45FB-B802-E4B2F5CA0DFE@gmail.com>
        <03d244cd-3205-6c95-c43e-99bc0135b50a@gmail.com>
Date:   Wed, 11 Mar 2020 18:52:05 +0200
In-Reply-To: <03d244cd-3205-6c95-c43e-99bc0135b50a@gmail.com> (Erik
        Stromdahl's message of "Wed, 4 Mar 2020 18:51:57 +0100")
Message-ID: <87imjaomve.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Erik Stromdahl <erik.stromdahl@gmail.com> writes:

> On 3/2/20 12:45 PM, Christian Hewitt wrote:
>>
>>> On 26 Sep 2019, at 6:24 pm, Kalle Valo <kvalo@codeaurora.org> wrote:
>>>
>>> From: Erik Stromdahl <erik.stromdahl@gmail.com>
>>>
>>> Add hardware parameters for QCA9377 sdio devices, it's now properly supported.
>>>
>>> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

[...]

>> Tested and working fine using Linux 5.6-rc3 and SDIO firmware from [1].
>>
>> [ 5.391369] ath10k_sdio mmc2:0001:1: qca9377 hw1.1 sdio target
>> 0x05020001 chip_id 0x00000000 sub 0000:0000
>> [ 5.391379] ath10k_sdio mmc2:0001:1: kconfig debug 0 debugfs 0
>> tracing 0 dfs 0 testmode 0
>> [ 5.391632] ath10k_sdio mmc2:0001:1: firmware ver
>> WLAN.TF.1.1.1-00061-QCATFSWPZ-1 api 5 features ignore-otp crc32
>> 7746e551
>> [ 5.624198] ath10k_sdio mmc2:0001:1: failed to fetch board data for
>> bus=sdio,vendor=0271,device=0701,subsystem-vendor=0000,subsystem-device=0000
>> from ath10k/QCA9377/hw1.0/board-2.bin
>> [    5.624473] ath10k_sdio mmc2:0001:1: board_file api 1 bmi_id N/A crc32 544289f7
>> [ 6.775882] ath10k_sdio mmc2:0001:1: htt-ver 3.32 wmi-op 4 htt-op 3
>> cal otp max-sta 32 raw 0 hwcrypto 1
>> [    6.854066] ath: EEPROM regdomain sanitized
>> [    6.854073] ath: EEPROM regdomain: 0x64
>> [    6.854075] ath: EEPROM indicates we should expect a direct regpair map
>> [    6.854082] ath: Country alpha2 being used: 00
>> [    6.854083] ath: Regpair used: 0x64
>> [    8.444189] ath: EEPROM regdomain: 0x8114
>> [    8.444194] ath: EEPROM indicates we should expect a country code
>> [    8.444196] ath: doing EEPROM country->regdmn map search
>> [    8.444198] ath: country maps to regdmn code: 0x37
>> [    8.444201] ath: Country alpha2 being used: DE
>> [    8.444203] ath: Regpair used: 0x37
>> [    8.444206] ath: regdomain 0x8114 dynamically updated by country element
>>
>> The test device is an Amlogic S905D STB device from O2.cz that I
>> have just submitted a working device-tree for [2].
>>
>> If you need a QCA9377 test device, I have a duplicate/spare of the
>> box and would be happy to post it.
>>
>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>
>> [1] https://github.com/chewitt/qca-firmware
>> [2] https://patchwork.kernel.org/project/linux-amlogic/list/?series=249525
>>
>
> I have received a lot of questions lately about this patch (why it has
> not been integrated).
> It is actually the only missing piece in order to have working QCA9377
> support on mainline.
>
> Unless there is a good reason not to add it, I think it should be integrated.

Thanks for testing, I applied it now.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
