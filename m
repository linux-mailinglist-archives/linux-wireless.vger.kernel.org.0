Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63701C5B8E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgEEPha (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 11:37:30 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:36766 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbgEEPh3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 11:37:29 -0400
Received: from [192.168.178.34] (unknown [87.147.56.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id A9725580248;
        Tue,  5 May 2020 17:37:27 +0200 (CEST)
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
To:     Sven Eckelmann <sven@narfation.org>, ath11k@lists.infradead.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        kvalo@codeaurora.org
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
 <f772b7bf0eac31516a4e28719c1938f2@codeaurora.org>
 <2335594.cnkAv9Vaq7@bentobox> <1845755.pTfhzBy2qg@bentobox>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Message-ID: <46ab4ffd-b512-de43-40bb-f35989d228b9@tu-ilmenau.de>
Date:   Tue, 5 May 2020 17:37:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1845755.pTfhzBy2qg@bentobox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/5/20 9:49 AM, Sven Eckelmann wrote:
> On Tuesday, 5 May 2020 09:01:34 CEST Sven Eckelmann wrote:
>> On Tuesday, 5 May 2020 01:46:12 CEST Rajkumar Manoharan wrote:
>> [...]
>>> IIRC this was fixed a while ago by below patch. Somehow it never landed 
>>> in ath.git.
>>> Simple one line change is enough.
>>>
>>> https://patchwork.kernel.org/patch/10550707/
>> Because it doesn't work for everything. Remember that 10.2.4.x overflows all 
>> the time (14-30s) because it used only 31 bit for the counters.
>>
>> But feel free to point me to the firmware version which fixed this.
> See also https://patchwork.kernel.org/patch/9701459/
>
> Kind regards,
> 	Sven

This patch already fixes the problem for me. I tested it on QCA988X hw
with firmware 10.2.4.

[   10.350919] ath10k_pci 0000:04:00.0: qca988x hw2.0 target 0x4100016c
chip_id 0x043222ff sub 0000:0000
[   10.350930] ath10k_pci 0000:04:00.0: kconfig debug 1 debugfs 1
tracing 1 dfs 0 testmode 0
[   10.351803] ath10k_pci 0000:04:00.0: firmware ver 10.2.4-1.0-00047
api 5 features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
[   10.385617] ath10k_pci 0000:04:00.0: board_file api 1 bmi_id N/A
crc32 bebc7c08
[   11.536818] ath10k_pci 0000:04:00.0: htt-ver 2.1 wmi-op 5 htt-op 2
cal otp max-sta 128 raw 0 hwcrypto 1

I also did not see the 31 bit overflow after a small amount of seconds.

Survey data from wlp4s0
    frequency:            2412 MHz [in use]
    noise:                -65 dBm
    channel active time:        5370225 ms
    channel busy time:        924199 ms
    channel receive time:        140 ms
    channel transmit time:        0 ms

Kind regards,
Markus

