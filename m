Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F82516AE8
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 08:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352593AbiEBGia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 02:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbiEBGi3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 02:38:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5D327B17
        for <linux-wireless@vger.kernel.org>; Sun,  1 May 2022 23:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35ADCB80EAB
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 06:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F6BC385AC;
        Mon,  2 May 2022 06:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651473298;
        bh=ZDa4o0tLRRjitxOTiX6ANWtObVdaZb1a7nUzK9R0Rd4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hd1fKrC6EK62e3/6mzZUOxDuuRqrXRizboA3XjJPrGXAN2sbOD3ZlSdyjzErXRbUD
         8JBU85UhijtvQioixxgybPH4m/1TJ7ZoScvv2QJ9zaeIrTVmIHbtqatST6HHQHnoUD
         geL3Qd2CQ8gfZCC2MfyAbv/GJrvabotEeW1HZ3gayjlgmNJKA9NuSuuzNyfRgaOowA
         FYJomOgWqL85nX/2WcLT19esDt6Er0x2eQV3zaEQ868mmvOUWfl711k3QjjP21zbvV
         pTmmbc/96NruyzYDS3sLeK9cpwuRF1oB4jG6w+WTAQ8i+FBn27o6e/XN+0/fK1sJSR
         0LS8gyUgqu/iQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 02/16] rtw89: 8852c: rfk: add DACK
References: <20220429071809.32104-1-pkshih@realtek.com>
        <20220429071809.32104-3-pkshih@realtek.com>
Date:   Mon, 02 May 2022 09:34:56 +0300
In-Reply-To: <20220429071809.32104-3-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 29 Apr 2022 15:17:55 +0800")
Message-ID: <875ymocui7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> DACK (digital-to-analog converters calibration) is used to calibrate DAC
> to output analog signals as expected.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static void _dack_reload_by_path(struct rtw89_dev *rtwdev,
> +				 enum rtw89_rf_path path, u8 index)
> +{
> +	struct rtw89_dack_info *dack = &rtwdev->dack;
> +	u32 idx_offset, path_offset;
> +	u32 val32, offset, addr;
> +	u8 i;
> +
> +	idx_offset = (index == 0 ? 0 : 0x14);
> +	path_offset = (path == RF_PATH_A ? 0 : 0x28);
> +	offset = idx_offset + path_offset;
> +
> +	rtw89_rfk_parser(rtwdev, &rtw8852c_dack_reload_defs_tbl);
> +	/* msbk_d: 15/14/13/12 */
> +	val32 = 0x0;
> +	for (i = 0; i < RTW89_DACK_MSBK_NR / 4; i++)
> +		val32 |= dack->msbk_d[path][index][i + 12] << (i * 8);
> +	addr = 0xc200 + offset;
> +	rtw89_phy_write32(rtwdev, addr, val32);
> +	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", addr,
> +		    rtw89_phy_read32_mask(rtwdev, addr, MASKDWORD));
> +	/* msbk_d: 11/10/9/8 */
> +	val32 = 0x0;
> +	for (i = 0; i < RTW89_DACK_MSBK_NR / 4; i++)
> +		val32 |= dack->msbk_d[path][index][i + 8] << (i * 8);
> +	addr = 0xc204 + offset;
> +	rtw89_phy_write32(rtwdev, addr, val32);
> +	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", addr,
> +		    rtw89_phy_read32_mask(rtwdev, addr, MASKDWORD));
> +	/* msbk_d: 7/6/5/4 */
> +	val32 = 0x0;
> +	for (i = 0; i < RTW89_DACK_MSBK_NR / 4; i++)
> +		val32 |= dack->msbk_d[path][index][i + 4] << (i * 8);
> +	addr = 0xc208 + offset;
> +	rtw89_phy_write32(rtwdev, addr, val32);
> +	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", addr,
> +		    rtw89_phy_read32_mask(rtwdev, addr, MASKDWORD));
> +	/* msbk_d: 3/2/1/0 */
> +	val32 = 0x0;
> +	for (i = 0; i < RTW89_DACK_MSBK_NR / 4; i++)
> +		val32 |= dack->msbk_d[path][index][i] << (i * 8);
> +	addr = 0xc20c + offset;
> +	rtw89_phy_write32(rtwdev, addr, val32);
> +	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", addr,
> +		    rtw89_phy_read32_mask(rtwdev, addr, MASKDWORD));
> +	/* dadak_d/biask_d */
> +	val32 = (dack->biask_d[path][index] << 22) |
> +		(dack->dadck_d[path][index] << 14);
> +	addr = 0xc210 + offset;
> +	rtw89_phy_write32(rtwdev, addr, val32);
> +	rtw89_phy_write32_set(rtwdev, addr, BIT(1));
> +}

This function is hard to read. Please add some empty lines to make it
more it readable, preferably before the comments.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
