Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE102516AEC
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 08:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358122AbiEBGmo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 02:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbiEBGmm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 02:42:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4112A728
        for <linux-wireless@vger.kernel.org>; Sun,  1 May 2022 23:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91909B80EAB
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 06:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AC0C385AC;
        Mon,  2 May 2022 06:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651473552;
        bh=PMUNX+b1H734eSJccp3q2/8Fm0BVGS0pC121IUXZEbU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=afvwJkQRsxyZ+lrZDn3X5Ld6CPkAFpjgykGm8HOt4WXMf4PjMqHLCTR5+3bfwVBIP
         /b7kuL0KLRsS4cDYXDyC+V9pA3vCQE+buTnTS6dVVTK+03cUBMUISaM/2OmNcM5nr3
         JE3cgnhZ9jOX4szPTZk8pM3U2APai/a57ndiPUQ/o4riK8z8DBJx6B0NhwIcV0+q9Y
         KX1wknEC/HrIbWdrKCkAq7QkzF6zrJ7cLG48jN4FqqehRrrutPG6X62ZM6KT3Wjp6+
         tYBajkV1cWcUVWNe5WCHN1I4K4vXqVp/E1ZMx7czenH8k4ag3thsfo+8wyaG4EVjd2
         kq+0Utywiqk7w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 04/16] rtw89: 8852c: rfk: add TSSI
References: <20220429071809.32104-1-pkshih@realtek.com>
        <20220429071809.32104-5-pkshih@realtek.com>
Date:   Mon, 02 May 2022 09:39:07 +0300
In-Reply-To: <20220429071809.32104-5-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 29 Apr 2022 15:17:57 +0800")
Message-ID: <871qxccub8.fsf@kernel.org>
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

> TSSI is transmitter signal strength indication, which is a close-loop
> hardware circuit to feedback actual transmitting power as a reference for
> next transmission.
>
> When we setup channel to connect an AP, it does full calibration. When
> switching bands or channels, it needs to reset hardware status to prevent
> use wrong feedback of previous transmission.
>
> To do TX power compensation reflecting current temperature, it loads tables
> of compensation values into registers according to channel and band group.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
> +				 enum rtw89_rf_path path)
> +{
> +#define __get_val(ptr, idx)				\
> +({							\
> +	s8 *__ptr = (ptr);				\
> +	u8 __idx = (idx), __i, __v;			\
> +	u32 __val = 0;					\
> +	for (__i = 0; __i < 4; __i++) {			\
> +		__v = (__ptr[__idx + __i]);		\
> +		__val |= (__v << (8 * __i));		\
> +	}						\
> +	__val;						\
> +})

The convention is to use upper case for macros. And maybe __get_val() is
too generic name, RTW89_GET_VAL() or something like that?

> +static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
> +				  enum rtw89_phy_idx phy)
> +{
> +#define __DE_MASK 0x003ff000
> +	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
> +	static const u32 r_cck_long[RF_PATH_NUM_8852C] = {0x5858, 0x7858};
> +	static const u32 r_cck_short[RF_PATH_NUM_8852C] = {0x5860, 0x7860};
> +	static const u32 r_mcs_20m[RF_PATH_NUM_8852C] = {0x5838, 0x7838};
> +	static const u32 r_mcs_40m[RF_PATH_NUM_8852C] = {0x5840, 0x7840};
> +	static const u32 r_mcs_80m[RF_PATH_NUM_8852C] = {0x5848, 0x7848};
> +	static const u32 r_mcs_80m_80m[RF_PATH_NUM_8852C] = {0x5850, 0x7850};
> +	static const u32 r_mcs_5m[RF_PATH_NUM_8852C] = {0x5828, 0x7828};
> +	static const u32 r_mcs_10m[RF_PATH_NUM_8852C] = {0x5830, 0x7830};
> +	u8 ch = rtwdev->hal.current_channel;
> +	u8 gidx;
> +	s8 ofdm_de;
> +	s8 trim_de;
> +	s32 val;
> +	u32 i, path = RF_PATH_A, path_max = RF_PATH_NUM_8852C;
> +
> +	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI][TRIM]: phy=%d ch=%d\n",
> +		    phy, ch);
> +
> +	if (rtwdev->dbcc_en) {
> +		if (phy == RTW89_PHY_0) {
> +			path = RF_PATH_A;
> +			path_max = RF_PATH_B;
> +		} else if (phy == RTW89_PHY_1) {
> +			path = RF_PATH_B;
> +			path_max = RF_PATH_NUM_8852C;
> +		}
> +	}
> +
> +	for (i = path; i < path_max; i++) {
> +		gidx = _tssi_get_cck_group(rtwdev, ch);
> +		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
> +		val = tssi_info->tssi_cck[i][gidx] + trim_de;
> +
> +		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
> +			    "[TSSI][TRIM]: path=%d cck[%d]=0x%x trim=0x%x\n",
> +			    i, gidx, tssi_info->tssi_cck[i][gidx], trim_de);
> +
> +		rtw89_phy_write32_mask(rtwdev, r_cck_long[i], __DE_MASK, val);
> +		rtw89_phy_write32_mask(rtwdev, r_cck_short[i], __DE_MASK, val);
> +
> +		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
> +			    "[TSSI] Set TSSI CCK DE 0x%x[21:12]=0x%x\n",
> +			    r_cck_long[i],
> +			    rtw89_phy_read32_mask(rtwdev, r_cck_long[i],
> +						  __DE_MASK));
> +
> +		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i);
> +		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
> +		val = ofdm_de + trim_de;
> +
> +		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
> +			    "[TSSI][TRIM]: path=%d mcs=0x%x trim=0x%x\n",
> +			    i, ofdm_de, trim_de);
> +
> +		rtw89_phy_write32_mask(rtwdev, r_mcs_20m[i], __DE_MASK, val);
> +		rtw89_phy_write32_mask(rtwdev, r_mcs_40m[i], __DE_MASK, val);
> +		rtw89_phy_write32_mask(rtwdev, r_mcs_80m[i], __DE_MASK, val);
> +		rtw89_phy_write32_mask(rtwdev, r_mcs_80m_80m[i], __DE_MASK, val);
> +		rtw89_phy_write32_mask(rtwdev, r_mcs_5m[i], __DE_MASK, val);
> +		rtw89_phy_write32_mask(rtwdev, r_mcs_10m[i], __DE_MASK, val);
> +
> +		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
> +			    "[TSSI] Set TSSI MCS DE 0x%x[21:12]=0x%x\n",
> +			    r_mcs_20m[i],
> +			    rtw89_phy_read32_mask(rtwdev, r_mcs_20m[i],
> +						  __DE_MASK));
> +	}
> +#undef __DE_MASK
> +}

That __DE_MASK is odd and even more so when undeffing it. I would create
a proper name for it and also group all such register and mask
definitions to the beginning of the .c file.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
