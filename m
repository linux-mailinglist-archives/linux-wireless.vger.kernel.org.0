Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4778536F197
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 23:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhD2VLo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 17:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhD2VLo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 17:11:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31592C06138B
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 14:10:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id b21so6964742plz.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Apr 2021 14:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sBddKF09Rg3ga526W79Hy+LYgZsV21RJu3Uri44rWLM=;
        b=VL9PwxzRM8Q0czajDnqfup5hOgb5IC/pkK3FzQ2rHC5pIUF0OV6s5mv22S5hOEaJcm
         MlyeNtQqC9JXdF+RkrxKAjvTGpZbr/bFgfYi51S3Sr/ZWJa44h59PRtSJZw2tK1FHWxP
         jMrqelqS4/O9kUUN5rjffkvvL4L3FneBkmDS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sBddKF09Rg3ga526W79Hy+LYgZsV21RJu3Uri44rWLM=;
        b=a80zr9Xrnx/sz9e5PknQNsvkAYLqxctiKZHmuc92FHm5+jQadxVcIOTmNPgDntPAOR
         WnhKApUI/YKaQCXXRQ7JyVaOHQO+/hbqzpX4cHeh5gcI0J++/A2gZTaTPcpaQh52/hWb
         TpZZiPND356ZSLv+SqUzLCDzgqxYkf/SZxzRXAKux42Vek7xWqXKnqEiWZZ+Kv1F5yMf
         +JRiRgKv0BJ30Lm+O6Q8jpHNejF62gqNf8KN4S7h46vsr4u+kdUqILS19PUbrpFss0Rr
         LzZyqeDgmAgSSsBTOUhVjTuLK6GiErRdgcIDgOyHeOyPa7DNAfDV/IXe0jljuAVYo8ai
         9E/Q==
X-Gm-Message-State: AOAM533r3A7ewk5xr6oQqd0yZIiML6BoaJzta03s9X8Io1iYsd6yO5sc
        drQwYOaPz0NF1LBJxUKlTIJhdQ==
X-Google-Smtp-Source: ABdhPJxl9rFj3ARsFSS8NXlacn8A6vMcc2bhrfcctyJOUcQHxHDOEoOiXKUGubfWnQThptfEMFzQ9w==
X-Received: by 2002:a17:90a:c717:: with SMTP id o23mr1955406pjt.214.1619730656555;
        Thu, 29 Apr 2021 14:10:56 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4f7:2f75:b0c0:5f85])
        by smtp.gmail.com with ESMTPSA id n203sm3484653pfd.31.2021.04.29.14.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:10:55 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:10:54 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 13/19] rtw89: 8852a: add 8852a specific files
Message-ID: <YIsg3iv6d4L6n9Uk@google.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
 <20210429080149.7068-14-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429080149.7068-14-pkshih@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Apr 29, 2021 at 04:01:43PM +0800, Ping-Ke Shih wrote:
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
> @@ -0,0 +1,2047 @@
...
> +static void rtw8852a_btc_init_cfg(struct rtw89_dev *rtwdev)
> +{
> +	struct rtw89_btc *btc = &rtwdev->btc;
> +	struct rtw89_btc_module *module = &btc->mdinfo;
> +	const struct rtw89_chip_info *chip = rtwdev->chip;
> +	const struct rtw89_mac_ax_coex coex_params = {
> +		.pta_mode = RTW89_MAC_AX_COEX_RTK_MODE,
> +		.direction = RTW89_MAC_AX_COEX_INNER,
> +	};
> +
> +	/* PTA init  */
> +	rtw89_mac_coex_init(rtwdev, &coex_params);
> +
> +	/* set WL Tx response = Hi-Pri */
> +	chip->ops->btc_set_wl_pri(rtwdev, BTC_PRI_MASK_TX_RESP, true);
> +
> +	/* set rf gnt debug off */
> +	rtw89_write_rf(rtwdev, RF_PATH_A, RR_WLSEL, 0xfffff, 0x0);

I fired this up and quickly ran into this:

[ 1746.061015] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:281
[ 1746.061029] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 838, name: wpa_supplicant
[ 1746.061037] CPU: 2 PID: 838 Comm: wpa_supplicant Tainted: G        W         5.10.27 #3
...
[ 1746.061047] Call Trace:
[ 1746.061061]  dump_stack+0x9e/0xe9
[ 1746.061080]  ___might_sleep+0x154/0x16a
[ 1746.061093]  mutex_lock+0x20/0x3c
[ 1746.061106]  rtw8852a_btc_init_cfg+0x60/0x177 [rtw89_core]
[ 1746.061127]  rtw89_btc_ntfy_radio_state+0xb8/0x115 [rtw89_core]
[ 1746.061153]  __iterate_interfaces+0xa9/0x109 [mac80211]
[ 1746.061165]  ? rtw89_leave_lps+0x44/0x44 [rtw89_core]
[ 1746.061175]  ? rtw89_leave_lps+0x44/0x44 [rtw89_core]
[ 1746.061194]  ieee80211_iterate_active_interfaces_atomic+0x33/0x40 [mac80211]
[ 1746.061205]  rtw89_ops_sw_scan_start+0x2e/0x48 [rtw89_core]
[ 1746.061234]  drv_sw_scan_start+0x97/0xf0 [mac80211]
[ 1746.061261]  __ieee80211_start_scan+0x3c7/0x4ae [mac80211]
[ 1746.061284]  ieee80211_request_scan+0x33/0x4f [mac80211]
[ 1746.061307]  rdev_scan+0x72/0xd1 [cfg80211]
[ 1746.061335]  nl80211_trigger_scan+0x610/0x669 [cfg80211]
[ 1746.061349]  genl_rcv_msg+0x3b0/0x3e0
[ 1746.061372]  ? nl80211_update_mesh_config+0x1b7/0x1b7 [cfg80211]
[ 1746.061382]  ? genl_rcv+0x36/0x36
[ 1746.061387]  netlink_rcv_skb+0x89/0xfb
[ 1746.061394]  genl_rcv+0x28/0x36
[ 1746.061400]  netlink_unicast+0x169/0x23b
[ 1746.061408]  netlink_sendmsg+0x379/0x3f1
[ 1746.061416]  sock_sendmsg+0x72/0x76
[ 1746.061423]  ____sys_sendmsg+0x171/0x1ea
[ 1746.061429]  ? copy_msghdr_from_user+0x82/0xaa
[ 1746.061436]  ___sys_sendmsg+0xa0/0xdc
[ 1746.061445]  ? _copy_from_user+0x70/0x9c
[ 1746.061451]  __sys_sendmsg+0x8c/0xc6
[ 1746.061460]  do_syscall_64+0x43/0x55
[ 1746.061467]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

rtw89_write_rf() is holding a mutex (rf_mutex). Judging by its trivial
usage (it's only protecting register reads/writes), it probably could be
a spinlock instead -- although I do note some magic udelay()s in there.

Alternatively, it looks like you'd be safe moving to the non-atomic
ieee80211_iterate_active_interfaces() in rtw89_leave_lps().

Brian

> +	rtw89_write_rf(rtwdev, RF_PATH_B, RR_WLSEL, 0xfffff, 0x0);
> +
> +	/* set WL Tx thru in TRX mask table if GNT_WL = 0 && BT_S1 = ss group */
> +	if (module->ant.type == BTC_ANT_SHARED) {
> +		rtw8852a_set_trx_mask(rtwdev,
> +				      RF_PATH_A, BTC_BT_SS_GROUP, 0x5ff);
> +		rtw8852a_set_trx_mask(rtwdev,
> +				      RF_PATH_B, BTC_BT_SS_GROUP, 0x5ff);
> +	} else { /* set WL Tx stb if GNT_WL = 0 && BT_S1 = ss group for 3-ant */
> +		rtw8852a_set_trx_mask(rtwdev,
> +				      RF_PATH_A, BTC_BT_SS_GROUP, 0x5df);
> +		rtw8852a_set_trx_mask(rtwdev,
> +				      RF_PATH_B, BTC_BT_SS_GROUP, 0x5df);
> +	}
> +
> +	/* set PTA break table */
> +	rtw89_write32(rtwdev, R_BTC_BREAK_TABLE, BTC_BREAK_PARAM);
> +
> +	 /* enable BT counter 0xda40[16,2] = 2b'11 */
> +	rtw89_write32_set(rtwdev,
> +			  R_AX_CSR_MODE, B_AX_BT_CNT_REST | B_AX_STATIS_BT_EN);
> +	rtw89_mac_cfg_ctrl_path(rtwdev, false);
> +	btc->cx.wl.status.map.init_ok = true;
> +}
