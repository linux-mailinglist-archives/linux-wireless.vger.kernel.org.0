Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59977F1D01
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2019 18:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbfKFR5w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 12:57:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37262 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732497AbfKFR5w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 12:57:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9CF0F609EF; Wed,  6 Nov 2019 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573063070;
        bh=RBX36QqqmWZLX7PMyFZMVMiWEGHfkNl0d+o2bQBPXSo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OmCoZbkaZLgZYKdI2l1diyOBx5CErta0AbB/zdGI4ajxUHr4JQQpoHEpZmXIjXZUo
         7++x4RQ8xUXniAsbkXMpqN4HGlrvIw3RQVfGE2LfU3DYb3Elo4cDkHzWTLVU6bRYtF
         YSTIgs02Ae6dnTLVqGbW5rvv1Pte12qirKxzu63Q=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECE6F601D4;
        Wed,  6 Nov 2019 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573063069;
        bh=RBX36QqqmWZLX7PMyFZMVMiWEGHfkNl0d+o2bQBPXSo=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ag113AdlSpuDf2itwmMxEy6Wd5d+6VqoiY5S5QGwea2+SGnxhVDAb607lIKRZ3gZl
         b8n5SDCEYjtK5DaZTESv6QjUysKBRzUWdrJcfZ1SQRizToV5z1K88NJb9XjtB7sK0U
         XJvLKBlFRl2oNvd5LuFvHnSYc8zk12haKjDIwBWI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECE6F601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: fix memory leak in rtl92c_set_fw_rsvdpagepkt()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191105021838.4302-1-pkshih@realtek.com>
References: <20191105021838.4302-1-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <wahrenst@gmx.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191106175750.9CF0F609EF@smtp.codeaurora.org>
Date:   Wed,  6 Nov 2019 17:57:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> This leak was found by testing the EDIMAX EW-7612 on Raspberry Pi 3B+ with
> Linux 5.4-rc5 (multi_v7_defconfig + rtlwifi + kmemleak) and noticed a
> single memory leak during probe:
> 
> unreferenced object 0xec13ee40 (size 176):
>   comm "kworker/u8:1", pid 36, jiffies 4294939321 (age 5580.790s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<fc1bbb3e>] __netdev_alloc_skb+0x9c/0x164
>     [<863dfa6e>] rtl92c_set_fw_rsvdpagepkt+0x254/0x340 [rtl8192c_common]
>     [<9572be0d>] rtl92cu_set_hw_reg+0xf48/0xfa4 [rtl8192cu]
>     [<116df4d8>] rtl_op_bss_info_changed+0x234/0x96c [rtlwifi]
>     [<8933575f>] ieee80211_bss_info_change_notify+0xb8/0x264 [mac80211]
>     [<d4061e86>] ieee80211_assoc_success+0x934/0x1798 [mac80211]
>     [<e55adb56>] ieee80211_rx_mgmt_assoc_resp+0x174/0x314 [mac80211]
>     [<5974629e>] ieee80211_sta_rx_queued_mgmt+0x3f4/0x7f0 [mac80211]
>     [<d91091c6>] ieee80211_iface_work+0x208/0x318 [mac80211]
>     [<ac5fcae4>] process_one_work+0x22c/0x564
>     [<f5e6d3b6>] worker_thread+0x44/0x5d8
>     [<82c7b073>] kthread+0x150/0x154
>     [<b43e1b7d>] ret_from_fork+0x14/0x2c
>     [<794dff30>] 0x0
> 
> It is because 8192cu doesn't implement usb_cmd_send_packet(), and this
> patch just frees the skb within the function to resolve memleak problem
> by now. Since 8192cu doesn't turn on fwctrl_lps that needs to download
> command packet for firmware via the function, applying this patch doesn't
> affect driver behavior.
> 
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

5174f1e41074 rtlwifi: fix memory leak in rtl92c_set_fw_rsvdpagepkt()

-- 
https://patchwork.kernel.org/patch/11226861/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

