Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE412A2E87
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 16:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKBPnd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 10:43:33 -0500
Received: from z5.mailgun.us ([104.130.96.5]:26017 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgKBPnc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 10:43:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604331810; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=X6sUojaWNycTrfbp3CsmOA74M4M7b93vLHJQol2uZqg=; b=soqOOZSeVXObGraf7gIzemkXfpqva7rgB1rGZ4PfQ8UtVraWOwRZGcjx6bUHuAjYe8uCA79I
 SJ0/ZGm8I7iOO1qNT3RBR0FhUgXlXnB0SdYFDRpZdszJk7ceRym/TO/R01y33Ayn1ORBP45Z
 8lJ9AbHI37vQh60vS9J2l6atKIw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fa02906d981633da313740e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Nov 2020 15:43:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18758C433CB; Mon,  2 Nov 2020 15:43:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93753C433C8;
        Mon,  2 Nov 2020 15:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93753C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/41] [Set 4] Rid W=1 warnings in Wireless
References: <20201102112410.1049272-1-lee.jones@linaro.org>
Date:   Mon, 02 Nov 2020 17:42:58 +0200
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org> (Lee Jones's
        message of "Mon, 2 Nov 2020 11:23:29 +0000")
Message-ID: <87mtzzpxx9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

>  [Last batch!]
>
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
>
> Lee Jones (41):
>   wil6210: wmi: Correct misnamed function parameter 'ptr_'
>   rsi_91x_usb: Fix some basic kernel-doc issues
>   rtl8192cu: mac: Fix some missing/ill-documented function parameters
>   rsi_91x_usb_ops: Source file headers are not good candidates for
>     kernel-doc
>   rtl8192cu: trx: Demote clear abuse of kernel-doc format
>   brcmfmac: bcmsdh: Fix description for function parameter 'pktlist'
>   brcmfmac: pcie: Provide description for missing function parameter
>     'devinfo'
>   iwlwifi: mvm: rs: Demote non-conformant function documentation headers
>   wl1251: cmd: Rename 'len' to 'buf_len' in the documentation
>   ath9k: ar9330_1p1_initvals: Remove unused const variable
>     'ar9331_common_tx_gain_offset1_1'
>   ath9k: ar9340_initvals: Remove unused const variable
>     'ar9340Modes_ub124_tx_gain_table_1p0'
>   ath9k: ar9485_initvals: Remove unused const variable
>     'ar9485_fast_clock_1_1_baseband_postamble'
>   ath9k: ar9003_2p2_initvals: Remove unused const variables
>   prism54: isl_ioctl: Fix one function header and demote another
>   iwlwifi: iwl-eeprom-read: Demote one nonconformant function header
>   iwlwifi: iwl-eeprom-parse: Fix 'struct iwl_eeprom_enhanced_txpwr's
>     header
>   intersil: hostap_hw: Prevent incompatible function type cast
>   brcm80211: fweh: Add missing description for 'gfp'
>   ath: regd: Provide description for ath_reg_apply_ir_flags's 'reg'
>     param
>   ath9k: ar5008_phy: Demote half completed function headers
>   ath: dfs_pattern_detector: Fix some function kernel-doc headers
>   ath: dfs_pri_detector: Demote zero/half completed kernel-doc headers
>   iwlwifi: iwl-phy-db: Add missing struct member description for 'trans'
>   wl3501_cs: Fix misspelling and provide missing documentation
>   rtlwifi: halbtc8723b2ant: Remove a bunch of set but unused variables
>   rtlwifi: phy: Remove set but unused variable 'bbvalue'
>   rtlwifi: halbtc8821a1ant: Remove set but unused variable
>     'wifi_rssi_state'
>   rtl8723be: phy: Remove set but unused variable 'lc_cal'
>   rtl8188ee: phy: Remove set but unused variable 'reg_ea4'
>   rtlwifi: halbtc8821a2ant: Remove a bunch of unused variables
>   mwifiex: pcie: Remove a couple of unchecked 'ret's
>   rtl8723be: trx: Remove set but unused variable 'cck_highpwr'
>   rtlwifi: rtl8821ae: phy: Remove a couple of unused variables
>   rtl8821ae: phy: Place braces around empty if() body
>   wlcore: spi: Demote a non-compliant function header, fix another
>   rtw8822b: Return type is not const
>   iwlwifi: fw: dbg: Fix misspelling of 'reg_data' in function header
>   realtek: rtw8822c: Remove unused variable 'corr_val'
>   ath9k: dynack: Demote non-compliant function header
>   iwlwifi: fw: acpi: Demote non-conformant function headers
>   realtek: rtw88: pci: Add prototypes for .probe, .remove and .shutdown

The cover letter was not CCed to linux-wireless, adding that. But the
patches itself look ok, I see all 41 of them in pathwork:

https://patchwork.kernel.org/project/linux-wireless/list/?series=375401&order=date

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
