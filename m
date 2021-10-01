Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5089B41F12E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 17:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhJAP2f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 11:28:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40943 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355021AbhJAP2c (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 11:28:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633102008; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=nZwmTIH+rwYrK2k+78zqRK0AMCcc1GmLVbaL6VSS3NI=; b=DnCpMwZHy2FDDPi/+fNcC3oLxILodEj3SobLlnFi3lvE5PkkDiCMIqQRJ+/poKoI2qY3av1L
 ER5CLkaIMdaNhACjjMQdeQieeijCu2H8RPqWb8/nPEtWx+qXlmV8fBo+Us7X8VgRxDZcqKsR
 OtRshbl/pjt+qRpt+FLlh/7GGY8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 615728b4a3e8d3c64040ea84 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 15:26:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 03CCDC43460; Fri,  1 Oct 2021 15:26:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FE56C4338F;
        Fri,  1 Oct 2021 15:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7FE56C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 02/24] rtw89: add BT coexistence files
References: <20210820043538.12424-1-pkshih@realtek.com>
        <20210820043538.12424-3-pkshih@realtek.com>
Date:   Fri, 01 Oct 2021 18:26:37 +0300
In-Reply-To: <20210820043538.12424-3-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 20 Aug 2021 12:35:16 +0800")
Message-ID: <87sfxkix5e.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> BT coexistence uses TDMA-based mechanism to coordinate with WiFi and BT.
> Now, we implement basic coexistence features for wide use cases, such as
> HID and A2DP. More will be supported later.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

A small tip for future drivers, try to remove all the optional features
from the driver as much possible and keep only the absolutely needed
features to get ping working. For example this file was pain to review
and I suspect coex support could have been submitted separately.

But don't change anything for this driver, this comment is for rtw90 :)

> +struct rtw89_btc_fbtc_cysta_cpu {
> +	u8 fver;
> +	u8 rsvd;
> +	u16 cycles;
> +	u16 cycles_a2dp[CXT_FLCTRL_MAX];
> +	u16 a2dpept;
> +	u16 a2dpeptto;
> +	u16 tavg_cycle[CXT_MAX];
> +	u16 tmax_cycle[CXT_MAX];
> +	u16 tmaxdiff_cycle[CXT_MAX];
> +	u16 tavg_a2dp[CXT_FLCTRL_MAX];
> +	u16 tmax_a2dp[CXT_FLCTRL_MAX];
> +	u16 tavg_a2dpept;
> +	u16 tmax_a2dpept;
> +	u16 tavg_lk;
> +	u16 tmax_lk;
> +	u32 slot_cnt[CXST_MAX];
> +	u32 bcn_cnt[CXBCN_MAX];
> +	u32 leakrx_cnt;
> +	u32 collision_cnt;
> +	u32 skip_cnt;
> +	u32 exception;
> +	u32 except_cnt;
> +#if (FCXCYSTA_VER > 1)
> +	u16 tslot_cycle[BTC_CYCLE_SLOT_MAX];
> +#endif
> +};

Please remove the if check, in all cases:

coex.c.789:#if (FCXCYSTA_VER > 1)
coex.c.829:#if (FCXCYSTA_VER > 1)
core.h.1456:#if (FCXCYSTA_VER > 1)

> +	memcpy((void *)pfinfo, (void *)rpt_content, pcinfo->req_len);

Please remove the casts.

> +	memcpy((void *)ptr, chip->mon_reg, n * ulen);

Here too.

> +#define rtw89_btc_wl_rx_gain(rtwdev, level)  do {} while (0)

What's the use of this? Please remove.

> +static void _set_bt_tx_power(struct rtw89_dev *rtwdev, u8 level)
> +{
> +	struct rtw89_btc *btc = &rtwdev->btc;
> +	struct rtw89_btc_bt_info *bt = &btc->cx.bt;
> +	u8 buf = 0;

Nitpicking, but no need to initialise buf here.

> +	switch (bw) {
> +	case RTW89_CHANNEL_WIDTH_20:
> +#ifdef BTC_NON_SHARED_ANT_FREERUN
> +		bw = 48;
> +#else
> +		bw = 20 + chip->afh_guard_ch * 2;
> +#endif

No ifdefs like this. Please remove.

> +#define _set_bt_slot_req(rtwdev) do {} while (0)

I can't see why this is needed, please remove.

> +#define _get_wl_nhm_dbm(rtwdev) do {} while (0)

This too.

> +	/* ======= parse raw info low-Byte2 ======= */
> +	/* ======= parse raw info low-Byte3 ======= */
> +	/* ======= parse raw info high-Byte0 ======= */
> +	/* ======= parse raw info high-Byte1 ======= */

No need to use '=' characters in comments.

> +#define _update_bt_psd(rtwdev, buf, len) do {} while (0)
> +#define _update_offload_runinfo(rtwdev, buf, len) do {} while (0)

And more of these, remove.

> +void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
> +			  u32 len, u8 class, u8 func)
> +{
> +	/* The below is just sample code. Don't use magic number in your release
> +	 * version.
> +	 */
> +	struct rtw89_btc *btc = &rtwdev->btc;
> +	struct rtw89_btc_btf_fwinfo *pfwinfo = &btc->fwinfo;
> +
> +	/* note: 'len' includes header, so 'buf' length is 'len - 8' */
> +	u8 *buf = &skb->data[8];	/* size of C2H header is 8 */
> +
> +	rtw89_debug(rtwdev, RTW89_DBG_BTC,
> +		    "[BTC], %s(): C2H BT len:%d class:%d fun:%d\n",
> +		    __func__, len, class, func);
> +
> +	if (class != 0x12)
> +		return;

A magic number, a proper define would document better what's happening.

> +
> +	switch (func) {
> +	case BTF_EVNT_RPT:
> +	case BTF_EVNT_BUF_OVERFLOW:
> +		pfwinfo->event[func]++;
> +		/* Don't need rtw89_leave_ps_mode() */
> +		btc_fw_event(rtwdev, func, buf, len);
> +		break;
> +	case BTF_EVNT_BT_INFO:
> +		rtw89_debug(rtwdev, RTW89_DBG_BTC,
> +			    "[BTC], handle C2H BT INFO with data %8ph\n", buf);
> +		btc->cx.cnt_bt[BTC_BCNT_INFOUPDATE]++;
> +		rtw89_leave_ps_mode(rtwdev);
> +		_update_bt_info(rtwdev, buf, len);
> +		break;
> +	case BTF_EVNT_BT_SCBD:
> +		rtw89_debug(rtwdev, RTW89_DBG_BTC,
> +			    "[BTC], handle C2H BT SCBD with data %8ph\n", buf);
> +		btc->cx.cnt_bt[BTC_BCNT_SCBDUPDATE]++;
> +		rtw89_leave_ps_mode(rtwdev);
> +		_update_bt_scbd(rtwdev, false);
> +		break;
> +	case BTF_EVNT_BT_PSD:
> +		_update_bt_psd(rtwdev, buf, len);
> +		break;
> +	case BTF_EVNT_BT_REG:
> +		btc->dbg.rb_done = true;
> +		btc->dbg.rb_val = ((buf[3] << 24) | (buf[2] << 16) |
> +				   (buf[1] << 8) | (buf[0]));

So are just changing endian or what? le_to_cpu() etc?

> +#define _get_bt_polt_cnt(rtwdev, phy, polt_cnt) do {} while (0)

And again, remove.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
