Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7D2A96FF
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 14:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgKFN2M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 08:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgKFN2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 08:28:12 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F6C0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 05:28:11 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so524085wrx.5
        for <linux-wireless@vger.kernel.org>; Fri, 06 Nov 2020 05:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5+nth0sbjRZ6eUfyh8C52hytfXcUZCQJlAKdHn6wg4s=;
        b=eUfPnmmICG8ihptUro5uAdo9H04lDEmTYdNtX4usagRpkionWEPB1kgQrriBynVmvh
         d9mXjhCO/VXZFgrvC9NM8wz1cJgYyEKCEE0HDuaJASuF0TVdgKF7m7ehtkrZsJ1ztpJt
         GtcL0Q4dAeqty8ClDuwNpuUIXk0u49h31PQkpuseMgdFKiMzvCUxwh68CMZsy9SGyON5
         zMkXufG6SJg9h1WkQFWzorlkoxZkw+S4hfsCSu0yzKSgkPdH2m0WmdmwFZAjnWzd1eIn
         LFInAvNp8TJudNc6Q+e1+xM5eyjIXb7wmm3US2JGzdiPRi5NzJum/0JUJAHftIPIuKlW
         /qCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5+nth0sbjRZ6eUfyh8C52hytfXcUZCQJlAKdHn6wg4s=;
        b=MwgaQSLC9ZAdszGWlQdDl0S3AlpgrPkm3FHfxUIcdz9VHtT/pbf+LVJ8vm8gnzdn/q
         FxkbGyBoZG7aeJxmRuUzS0Q18Nuc5OLx/gj27X5lzjlTVcU5Gr+aQCN8aHOYCQdqqniI
         PClxf9JDFdFJAjun5AaXzdci5k6esPZ/UnK0chA1BH3RjOybcQNuXbqP+PyjzNabbfkT
         Ysu8DVZjv1oyywf/Lj8P5qg2X8CBHGwq5vInczSBRaevLGaS+X1kudMT0Y2iDV/raZoy
         PeMTWfLjhzEr6semHbteR9yry2+UdnjKFTqwOPx3iWQE1QT65/b5uZsBGUq56D4W8Q+a
         magA==
X-Gm-Message-State: AOAM531r8nlKSoJPSX8LhMI2BuYz+8WJuTWu6mske8XdU6lNjklgjWem
        76tn9qR+yhkSrXuSFPHYNlQl2w==
X-Google-Smtp-Source: ABdhPJzyr8IURFNi1JY3F+AdU3mMk9mStWbM24vd3HnbzWWLI4WhHVhbRvxOiBfpGJAbkLabg4iKvg==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr2713896wrn.68.1604669290377;
        Fri, 06 Nov 2020 05:28:10 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm2118670wro.43.2020.11.06.05.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 05:28:09 -0800 (PST)
Date:   Fri, 6 Nov 2020 13:28:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/41] [Set 4] Rid W=1 warnings in Wireless
Message-ID: <20201106132807.GH2063125@dell>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
 <87mtzzpxx9.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtzzpxx9.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 02 Nov 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> >  [Last batch!]
> >
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> >
> > Lee Jones (41):
> >   wil6210: wmi: Correct misnamed function parameter 'ptr_'
> >   rsi_91x_usb: Fix some basic kernel-doc issues
> >   rtl8192cu: mac: Fix some missing/ill-documented function parameters
> >   rsi_91x_usb_ops: Source file headers are not good candidates for
> >     kernel-doc
> >   rtl8192cu: trx: Demote clear abuse of kernel-doc format
> >   brcmfmac: bcmsdh: Fix description for function parameter 'pktlist'
> >   brcmfmac: pcie: Provide description for missing function parameter
> >     'devinfo'
> >   iwlwifi: mvm: rs: Demote non-conformant function documentation headers
> >   wl1251: cmd: Rename 'len' to 'buf_len' in the documentation
> >   ath9k: ar9330_1p1_initvals: Remove unused const variable
> >     'ar9331_common_tx_gain_offset1_1'
> >   ath9k: ar9340_initvals: Remove unused const variable
> >     'ar9340Modes_ub124_tx_gain_table_1p0'
> >   ath9k: ar9485_initvals: Remove unused const variable
> >     'ar9485_fast_clock_1_1_baseband_postamble'
> >   ath9k: ar9003_2p2_initvals: Remove unused const variables
> >   prism54: isl_ioctl: Fix one function header and demote another
> >   iwlwifi: iwl-eeprom-read: Demote one nonconformant function header
> >   iwlwifi: iwl-eeprom-parse: Fix 'struct iwl_eeprom_enhanced_txpwr's
> >     header
> >   intersil: hostap_hw: Prevent incompatible function type cast
> >   brcm80211: fweh: Add missing description for 'gfp'
> >   ath: regd: Provide description for ath_reg_apply_ir_flags's 'reg'
> >     param
> >   ath9k: ar5008_phy: Demote half completed function headers
> >   ath: dfs_pattern_detector: Fix some function kernel-doc headers
> >   ath: dfs_pri_detector: Demote zero/half completed kernel-doc headers
> >   iwlwifi: iwl-phy-db: Add missing struct member description for 'trans'
> >   wl3501_cs: Fix misspelling and provide missing documentation
> >   rtlwifi: halbtc8723b2ant: Remove a bunch of set but unused variables
> >   rtlwifi: phy: Remove set but unused variable 'bbvalue'
> >   rtlwifi: halbtc8821a1ant: Remove set but unused variable
> >     'wifi_rssi_state'
> >   rtl8723be: phy: Remove set but unused variable 'lc_cal'
> >   rtl8188ee: phy: Remove set but unused variable 'reg_ea4'
> >   rtlwifi: halbtc8821a2ant: Remove a bunch of unused variables
> >   mwifiex: pcie: Remove a couple of unchecked 'ret's
> >   rtl8723be: trx: Remove set but unused variable 'cck_highpwr'
> >   rtlwifi: rtl8821ae: phy: Remove a couple of unused variables
> >   rtl8821ae: phy: Place braces around empty if() body
> >   wlcore: spi: Demote a non-compliant function header, fix another
> >   rtw8822b: Return type is not const
> >   iwlwifi: fw: dbg: Fix misspelling of 'reg_data' in function header
> >   realtek: rtw8822c: Remove unused variable 'corr_val'
> >   ath9k: dynack: Demote non-compliant function header
> >   iwlwifi: fw: acpi: Demote non-conformant function headers
> >   realtek: rtw88: pci: Add prototypes for .probe, .remove and .shutdown
> 
> The cover letter was not CCed to linux-wireless, adding that. But the
> patches itself look ok, I see all 41 of them in pathwork:
> 
> https://patchwork.kernel.org/project/linux-wireless/list/?series=375401&order=date

What's the plan for these Kalle?

Are you able to take the ones that do not require a respin?  It would
certainly safe a great deal of mailing list churn if I only
re-submitted the ones that required refactoring.

Of course if you require me to re-submit all of them, then I will do so.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
