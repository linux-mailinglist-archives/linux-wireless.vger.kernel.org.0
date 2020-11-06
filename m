Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7292C2A97B6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 15:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKFOfI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 09:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFOfI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 09:35:08 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B6DC0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 06:35:06 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so1638450wmm.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Nov 2020 06:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tOCh5yJFjZpYm41GVEBbdLweCAfd0jNEzcgUGYl00Dc=;
        b=Y8+KZn7zbFrfa3E7v7qfWM5TZtc1WCYEmGJLeH7On8PXxsKMtKtTf2/aDECqJiyb2Q
         sMPS7oW0mNc3e3uzwItbuUMNlFPfbBz9sBHY6jQQYecmjRiD3uN57NTAE/LoGete6221
         wWL4cZcWCN4pHHpU6CDt04JCyV0nt6326swkDcO2DGM0Dqk1/XHBNa3a5tS3VVtXC9vQ
         bRHLhm6nvq+kn+fK5yW1hRLLIynJ8quveHgBnX6FZleKjEPnmbrOvdZ1ZAMFnOYx+L0e
         ECEp95jOXeUalK4I2kg3v2v7yAuuSH21jmIQQJTEpwwB9/A9GC0G8+O9vPA+dhHmBagh
         N6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tOCh5yJFjZpYm41GVEBbdLweCAfd0jNEzcgUGYl00Dc=;
        b=ElgUBmIoGQl/nphtiifhP5zB9NMq2ThkN14l2Vowicz3sv2Ec3Fj1H0oEvvsCkSHUy
         q0N5OuE+9WXRhfP2KDO8VnBUM2y+8DADHo+nd+/BFCqRcFR9VPx0q9SVB3b8nxnNxsUL
         XyOzeRLHdAFVN8JVY4CdhFpmkJR2BBLcm9JL1v+otKBOOJEvi7LT4WLfdTOUh5yV+lPx
         Hq8xRWPtjoCaO8a9y9stAoZUlUIYljp1MaubsNGvZXQm05+Pok0PyNGR+J9wjaTh2eAV
         cfvCUgYICAqFfz40ugLUx/ESJGc8snixTNRoFUuhEv7UYLyEsorTLy5eii4g06PVnc9/
         lEcA==
X-Gm-Message-State: AOAM533nexfy0fvSpnM5AENA+s/w2+Z3ZNVv4AGZVahyN9HZJytpxLMF
        mxmvflfD7ee1HNNf/Lxh/Vq9Hw==
X-Google-Smtp-Source: ABdhPJwVsPBv9pqhXt9J0w3mzHUSYxiEvz2mW/ynhm37kZgxuW9YuHCYtH7V7K4k0hyPUxOiaXFgsg==
X-Received: by 2002:a1c:b487:: with SMTP id d129mr2957244wmf.38.1604673305292;
        Fri, 06 Nov 2020 06:35:05 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id r10sm2611848wmg.16.2020.11.06.06.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 06:35:04 -0800 (PST)
Date:   Fri, 6 Nov 2020 14:35:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 00/41] [Set 4] Rid W=1 warnings in Wireless
Message-ID: <20201106143502.GL2063125@dell>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
 <87mtzzpxx9.fsf@codeaurora.org>
 <20201106132807.GH2063125@dell>
 <87y2jefw14.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2jefw14.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 06 Nov 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > On Mon, 02 Nov 2020, Kalle Valo wrote:
> >
> >> Lee Jones <lee.jones@linaro.org> writes:
> >> 
> >> >  [Last batch!]
> >> >
> >> > This set is part of a larger effort attempting to clean-up W=1
> >> > kernel builds, which are currently overwhelmingly riddled with
> >> > niggly little warnings.
> >> >
> >> > Lee Jones (41):
> >> >   wil6210: wmi: Correct misnamed function parameter 'ptr_'
> >> >   rsi_91x_usb: Fix some basic kernel-doc issues
> >> >   rtl8192cu: mac: Fix some missing/ill-documented function parameters
> >> >   rsi_91x_usb_ops: Source file headers are not good candidates for
> >> >     kernel-doc
> >> >   rtl8192cu: trx: Demote clear abuse of kernel-doc format
> >> >   brcmfmac: bcmsdh: Fix description for function parameter 'pktlist'
> >> >   brcmfmac: pcie: Provide description for missing function parameter
> >> >     'devinfo'
> >> >   iwlwifi: mvm: rs: Demote non-conformant function documentation headers
> >> >   wl1251: cmd: Rename 'len' to 'buf_len' in the documentation
> >> >   ath9k: ar9330_1p1_initvals: Remove unused const variable
> >> >     'ar9331_common_tx_gain_offset1_1'
> >> >   ath9k: ar9340_initvals: Remove unused const variable
> >> >     'ar9340Modes_ub124_tx_gain_table_1p0'
> >> >   ath9k: ar9485_initvals: Remove unused const variable
> >> >     'ar9485_fast_clock_1_1_baseband_postamble'
> >> >   ath9k: ar9003_2p2_initvals: Remove unused const variables
> >> >   prism54: isl_ioctl: Fix one function header and demote another
> >> >   iwlwifi: iwl-eeprom-read: Demote one nonconformant function header
> >> >   iwlwifi: iwl-eeprom-parse: Fix 'struct iwl_eeprom_enhanced_txpwr's
> >> >     header
> >> >   intersil: hostap_hw: Prevent incompatible function type cast
> >> >   brcm80211: fweh: Add missing description for 'gfp'
> >> >   ath: regd: Provide description for ath_reg_apply_ir_flags's 'reg'
> >> >     param
> >> >   ath9k: ar5008_phy: Demote half completed function headers
> >> >   ath: dfs_pattern_detector: Fix some function kernel-doc headers
> >> >   ath: dfs_pri_detector: Demote zero/half completed kernel-doc headers
> >> >   iwlwifi: iwl-phy-db: Add missing struct member description for 'trans'
> >> >   wl3501_cs: Fix misspelling and provide missing documentation
> >> >   rtlwifi: halbtc8723b2ant: Remove a bunch of set but unused variables
> >> >   rtlwifi: phy: Remove set but unused variable 'bbvalue'
> >> >   rtlwifi: halbtc8821a1ant: Remove set but unused variable
> >> >     'wifi_rssi_state'
> >> >   rtl8723be: phy: Remove set but unused variable 'lc_cal'
> >> >   rtl8188ee: phy: Remove set but unused variable 'reg_ea4'
> >> >   rtlwifi: halbtc8821a2ant: Remove a bunch of unused variables
> >> >   mwifiex: pcie: Remove a couple of unchecked 'ret's
> >> >   rtl8723be: trx: Remove set but unused variable 'cck_highpwr'
> >> >   rtlwifi: rtl8821ae: phy: Remove a couple of unused variables
> >> >   rtl8821ae: phy: Place braces around empty if() body
> >> >   wlcore: spi: Demote a non-compliant function header, fix another
> >> >   rtw8822b: Return type is not const
> >> >   iwlwifi: fw: dbg: Fix misspelling of 'reg_data' in function header
> >> >   realtek: rtw8822c: Remove unused variable 'corr_val'
> >> >   ath9k: dynack: Demote non-compliant function header
> >> >   iwlwifi: fw: acpi: Demote non-conformant function headers
> >> >   realtek: rtw88: pci: Add prototypes for .probe, .remove and .shutdown
> >> 
> >> The cover letter was not CCed to linux-wireless, adding that. But the
> >> patches itself look ok, I see all 41 of them in pathwork:
> >> 
> >> https://patchwork.kernel.org/project/linux-wireless/list/?series=375401&order=date
> >
> > What's the plan for these Kalle?
> >
> > Are you able to take the ones that do not require a respin?
> 
> Been busy and I have 200+ patches to dive through. I (or my patchwork
> script) will always let you know if I drop any patches.

Okay, so plan to pluck from that set.

That is ideal.  Thanks for responding.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
