Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5ED2A970C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 14:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgKFNgG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 08:36:06 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:17864 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbgKFNgD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 08:36:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604669762; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=xb6MikjZMAW1v1+x0mzPzoPSv6lMzQfzbUDeV4gQfZM=; b=e6TFVWbIp7iicbSNu6MQmNyHG0pAlaRKZ9ZnBVGbS08k8fcxKNpFWYpvXoDDvq3du/OYBA7j
 IYgMOCNzAiULJvQ8e+vhhlu0FwtbzBozDdH78xWghhFBfKnj1+vQvzg1AZKkeAUUWsVV5vMU
 mC9lvoBJEcO+6YI2zg73H9BPOc8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fa5511b18b2aa4b1f1af845 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 13:35:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7A47C433C9; Fri,  6 Nov 2020 13:35:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34F9FC433C6;
        Fri,  6 Nov 2020 13:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34F9FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/41] [Set 4] Rid W=1 warnings in Wireless
References: <20201102112410.1049272-1-lee.jones@linaro.org>
        <87mtzzpxx9.fsf@codeaurora.org> <20201106132807.GH2063125@dell>
Date:   Fri, 06 Nov 2020 15:35:19 +0200
In-Reply-To: <20201106132807.GH2063125@dell> (Lee Jones's message of "Fri, 6
        Nov 2020 13:28:07 +0000")
Message-ID: <87y2jefw14.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> On Mon, 02 Nov 2020, Kalle Valo wrote:
>
>> Lee Jones <lee.jones@linaro.org> writes:
>> 
>> >  [Last batch!]
>> >
>> > This set is part of a larger effort attempting to clean-up W=1
>> > kernel builds, which are currently overwhelmingly riddled with
>> > niggly little warnings.
>> >
>> > Lee Jones (41):
>> >   wil6210: wmi: Correct misnamed function parameter 'ptr_'
>> >   rsi_91x_usb: Fix some basic kernel-doc issues
>> >   rtl8192cu: mac: Fix some missing/ill-documented function parameters
>> >   rsi_91x_usb_ops: Source file headers are not good candidates for
>> >     kernel-doc
>> >   rtl8192cu: trx: Demote clear abuse of kernel-doc format
>> >   brcmfmac: bcmsdh: Fix description for function parameter 'pktlist'
>> >   brcmfmac: pcie: Provide description for missing function parameter
>> >     'devinfo'
>> >   iwlwifi: mvm: rs: Demote non-conformant function documentation headers
>> >   wl1251: cmd: Rename 'len' to 'buf_len' in the documentation
>> >   ath9k: ar9330_1p1_initvals: Remove unused const variable
>> >     'ar9331_common_tx_gain_offset1_1'
>> >   ath9k: ar9340_initvals: Remove unused const variable
>> >     'ar9340Modes_ub124_tx_gain_table_1p0'
>> >   ath9k: ar9485_initvals: Remove unused const variable
>> >     'ar9485_fast_clock_1_1_baseband_postamble'
>> >   ath9k: ar9003_2p2_initvals: Remove unused const variables
>> >   prism54: isl_ioctl: Fix one function header and demote another
>> >   iwlwifi: iwl-eeprom-read: Demote one nonconformant function header
>> >   iwlwifi: iwl-eeprom-parse: Fix 'struct iwl_eeprom_enhanced_txpwr's
>> >     header
>> >   intersil: hostap_hw: Prevent incompatible function type cast
>> >   brcm80211: fweh: Add missing description for 'gfp'
>> >   ath: regd: Provide description for ath_reg_apply_ir_flags's 'reg'
>> >     param
>> >   ath9k: ar5008_phy: Demote half completed function headers
>> >   ath: dfs_pattern_detector: Fix some function kernel-doc headers
>> >   ath: dfs_pri_detector: Demote zero/half completed kernel-doc headers
>> >   iwlwifi: iwl-phy-db: Add missing struct member description for 'trans'
>> >   wl3501_cs: Fix misspelling and provide missing documentation
>> >   rtlwifi: halbtc8723b2ant: Remove a bunch of set but unused variables
>> >   rtlwifi: phy: Remove set but unused variable 'bbvalue'
>> >   rtlwifi: halbtc8821a1ant: Remove set but unused variable
>> >     'wifi_rssi_state'
>> >   rtl8723be: phy: Remove set but unused variable 'lc_cal'
>> >   rtl8188ee: phy: Remove set but unused variable 'reg_ea4'
>> >   rtlwifi: halbtc8821a2ant: Remove a bunch of unused variables
>> >   mwifiex: pcie: Remove a couple of unchecked 'ret's
>> >   rtl8723be: trx: Remove set but unused variable 'cck_highpwr'
>> >   rtlwifi: rtl8821ae: phy: Remove a couple of unused variables
>> >   rtl8821ae: phy: Place braces around empty if() body
>> >   wlcore: spi: Demote a non-compliant function header, fix another
>> >   rtw8822b: Return type is not const
>> >   iwlwifi: fw: dbg: Fix misspelling of 'reg_data' in function header
>> >   realtek: rtw8822c: Remove unused variable 'corr_val'
>> >   ath9k: dynack: Demote non-compliant function header
>> >   iwlwifi: fw: acpi: Demote non-conformant function headers
>> >   realtek: rtw88: pci: Add prototypes for .probe, .remove and .shutdown
>> 
>> The cover letter was not CCed to linux-wireless, adding that. But the
>> patches itself look ok, I see all 41 of them in pathwork:
>> 
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=375401&order=date
>
> What's the plan for these Kalle?
>
> Are you able to take the ones that do not require a respin?

Been busy and I have 200+ patches to dive through. I (or my patchwork
script) will always let you know if I drop any patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
