Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE3B41F1F3
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354801AbhJAQQB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 12:16:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57013 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353603AbhJAQQA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 12:16:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633104855; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=LnZLa2xlmD+uJ5Jd/9HHTInTHv9BTIcWznQoJ7jfM6Y=; b=tBfLRY+NznCuOopZRkRM+ADCPGRaO95ayBEWk99wkOtHqbhSbH/UxeZ3OFH2oTUnQnnigqh2
 LhX8ZV30yutrygb/uDkAXJkbjnQji6mt/l2gS6uyFkY5H7mBEQwbx/Yl03tbkm12dUxz+rou
 s+1Dv03DBtaKZ7NGWL0YqtaIobI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 615733c7a5a9bab6e85db5d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 16:13:59
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4B6E9C43460; Fri,  1 Oct 2021 16:13:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DD790C4338F;
        Fri,  1 Oct 2021 16:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org DD790C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 07/24] rtw89: add MAC files
References: <20210820043538.12424-1-pkshih@realtek.com>
        <20210820043538.12424-8-pkshih@realtek.com>
Date:   Fri, 01 Oct 2021 19:13:51 +0300
In-Reply-To: <20210820043538.12424-8-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 20 Aug 2021 12:35:21 +0800")
Message-ID: <87fstkiuyo.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> Provide interfaces to access MAC function blocks including power-on/off
> configuration.
>
> MAC initialization does power-on, and then enable HCI to download firmware.
> The BB, RF, DMAC and CMAC function blocks are enabled, and then configure
> TXRX settings that contains DMAC, CMAC, interrupt mask, and RPQ parameters.
> DMAC is short for data MAC, including data link engine (DLE), HCI function
> control (HFC), MPDU processor, security engine and so on. CMAC is short for
> control MAC, including scheduler, address CAM, RX filter, CCA control,
> TMAC, RMAC, protocol component and so on.
>
> The full MAC initialization is done for normal use case when user does
> network interface up. When device is probing, driver does partial
> initialization to do power-on and download firmware, because we need to
> read hardware capabilities from efuse and firmware.
>
> MAC supports five ports, so we can have five VIFs at most. To control MAC
> port, we control a set of registers, and the most important one among them
> is port_cfg register named R_AX_PORT_CFG_P0. We can turn on/off the port
> function and configure network type (STA or AP mode) by this register.
> The address and BSSID corresponding to this port are given by address
> and BSSID CAM that is set by firmware via H2C command.
>
> Since BT coexistence code needs to access coex registers, some help
> functions are provided to make WiFi-only case work.
>
> To access MAC registers, normally we use rtw89_writeXX/rtw89_readYY, but
> we use rtw89_mac_txpwr_write32_ZZ to access TX power register with proper
> address range checking.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +struct rtw89_hfc_prec_cfg rtw_hfc_preccfg_pcie = {
> +	2, 40, 0, 0, 1, 0, 0, 0
> +};

This should be const.

> +static int rtw89_mac_pwr_seq(struct rtw89_dev *rtwdev,
> +			     const struct rtw89_pwr_cfg * const *cfg_seq)
> +{
> +	u32 idx = 0;
> +	const struct rtw89_pwr_cfg *cfg;
> +	int ret;
> +
> +	do {
> +		cfg = cfg_seq[idx];
> +		if (!cfg)
> +			break;
> +
> +		ret = rtw89_mac_sub_pwr_seq(rtwdev, BIT(rtwdev->hal.cv),
> +					    PWR_INTF_MSK_PCIE, cfg);
> +		if (ret)
> +			return -EBUSY;
> +
> +		idx++;
> +	} while (1);

Never ending loop is a bad idea in kernel, please add either a loop
limit or a time limit.

> +static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
> +{
> +#define PWR_ACT 1
> +	const struct rtw89_chip_info *chip = rtwdev->chip;
> +	const struct rtw89_pwr_cfg * const *cfg_seq;
> +	struct rtw89_hal *hal = &rtwdev->hal;
> +	int ret;
> +	u8 val;
> +
> +	if (on)
> +		cfg_seq = chip->pwr_on_seq;
> +	else
> +		cfg_seq = chip->pwr_off_seq;
> +
> +	if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
> +		__rtw89_leave_ps_mode(rtwdev);
> +
> +	val = rtw89_read8(rtwdev, 0x3F1) & 0x3;

Magic numbers.

> +/* PCIE 64 */
> +struct rtw89_dle_size wde_size0 = {
> +	RTW89_WDE_PG_64, 4095, 1,
> +};
> +
> +/* DLFW */
> +struct rtw89_dle_size wde_size4 = {
> +	RTW89_WDE_PG_64, 0, 4096,
> +};
> +
> +/* PCIE */
> +struct rtw89_dle_size ple_size0 = {
> +	RTW89_PLE_PG_128, 1520, 16,
> +};
> +
> +/* DLFW */
> +struct rtw89_dle_size ple_size4 = {
> +	RTW89_PLE_PG_128, 64, 1472,
> +};
> +
> +/* PCIE 64 */
> +struct rtw89_wde_quota wde_qt0 = {
> +	3792, 196, 0, 107,
> +};
> +
> +/* DLFW */
> +struct rtw89_wde_quota wde_qt4 = {
> +	0, 0, 0, 0,
> +};
> +
> +/* PCIE SCC */
> +struct rtw89_ple_quota ple_qt4 = {
> +	264, 0, 16, 20, 26, 13, 356, 0, 32, 40, 8,
> +};
> +
> +/* PCIE SCC */
> +struct rtw89_ple_quota ple_qt5 = {
> +	264, 0, 32, 20, 64, 13, 1101, 0, 64, 128, 120,
> +};
> +
> +/* DLFW */
> +struct rtw89_ple_quota ple_qt13 = {
> +	0, 0, 16, 48, 0, 0, 0, 0, 0, 0, 0
> +};

These all should be const.

> +static void (*rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
> +					    struct sk_buff *c2h, u32 len) = {
> +	[RTW89_MAC_C2H_FUNC_EFUSE_DUMP] = NULL,
> +	[RTW89_MAC_C2H_FUNC_READ_RSP] = NULL,
> +	[RTW89_MAC_C2H_FUNC_PKT_OFLD_RSP] = NULL,
> +	[RTW89_MAC_C2H_FUNC_BCN_RESEND] = NULL,
> +	[RTW89_MAC_C2H_FUNC_MACID_PAUSE] = rtw89_mac_c2h_macid_pause,
> +};
> +
> +static void (*rtw89_mac_c2h_info_handler[])(struct rtw89_dev *rtwdev,
> +					    struct sk_buff *c2h, u32 len) = {
> +	[RTW89_MAC_C2H_FUNC_REC_ACK] = rtw89_mac_c2h_rec_ack,
> +	[RTW89_MAC_C2H_FUNC_DONE_ACK] = rtw89_mac_c2h_done_ack,
> +	[RTW89_MAC_C2H_FUNC_C2H_LOG] = rtw89_mac_c2h_log,
> +};

const?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
