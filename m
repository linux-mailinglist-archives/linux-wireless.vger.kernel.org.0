Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F7B46CF39
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 09:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbhLHImS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 03:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhLHImR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 03:42:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02380C061574
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 00:38:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0122B81113
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 08:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891EEC00446;
        Wed,  8 Dec 2021 08:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638952723;
        bh=Q567TgICxgp57/1WOkK2zHHTkIEc7Sqbzk/3ECXwHFM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=r3ncYkGSWLGMcbn/brW8cQrNUWtq2WNiq7FoGNUWey2nFKwVlNbX+KQmET42x/Cmy
         QeCW8lk9XGTXuEz2bSF0/Q8oFUQiWItHaAdBfuUASofyPJybMvG2BF1swbjot9ABhg
         MiqaowyrOKqSo9MszcS1JvNLpRFdHgYlXsLiAI565bmc1hgvfxDnr4/VEok/MvAaic
         oKmArtp+68lTOApinAEoV2V6KqDD7Cl7++31sifRHopuyCXXZl0diIpd9as1XtswaS
         3SD4i4YT94ThTYRC6EChVsFbX/Qc03ZbPD1uKLLNQulHMaJNj/c5xHuwrJKF5jGTA/
         fyIXWHgnHqUlQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix scan abort when duration is set for hw scan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211026025902.26621-1-quic_wgong@quicinc.com>
References: <20211026025902.26621-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163895272089.29041.8698612176646139830.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 08:38:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When request scan with duration 120ms on channel 1, it failed with
> scan abort easily. Because scan_timeout is set to 130ms for the scan
> in ath10k_hw_scan(), and timed out before scan complete, so lead
> scan abort.
> 
> failed log of ath10k:
> 2021-04-14T14:43:29.936058Z DEBUG kernel: [67384.594846] ath10k_sdio mmc1:0001:1: wmi tlv start scan
> 2021-04-14T14:43:29.937896Z DEBUG kernel: [67384.595820] ath10k_sdio mmc1:0001:1: scan event started type 1 reason 7 freq 2437 req_id 40961 scan_id 40960 vdev_id 0 state starting (1)
> 2021-04-14T14:43:29.938357Z DEBUG kernel: [67384.596761] ath10k_sdio mmc1:0001:1: scan event bss channel type 4 reason 7 freq 2437 req_id 40961 scan_id 40960 vdev_id 0 state running (2)
> 2021-04-14T14:43:29.992497Z DEBUG kernel: [67384.651013] ath10k_sdio mmc1:0001:1: scan event foreign channel type 8 reason 7 freq 2412 req_id 40961 scan_id 40960 vdev_id 0 state running (2)
> 2021-04-14T14:43:30.063530Z DEBUG kernel: [67384.722139] ath10k_sdio mmc1:0001:1: wmi tlv stop scan
> 2021-04-14T14:43:30.066592Z DEBUG kernel: [67384.724403] ath10k_sdio mmc1:0001:1: scan event completed [cancelled] type 2 reason 1 freq 2412 req_id 40961 scan_id 40960 vdev_id 0 state aborting (3)
> 
> failed log of wpa_supplicant:
> 2021-04-14T14:43:29.981842Z DEBUG wpa_supplicant[887]: wlan0: nl80211: scan request
> 2021-04-14T14:43:29.981988Z DEBUG wpa_supplicant[887]: nl80211: Passive scan requested
> 2021-04-14T14:43:29.982202Z DEBUG wpa_supplicant[887]: nl80211: Add NL80211_SCAN_FLAG_FLUSH
> 2021-04-14T14:43:29.982339Z DEBUG wpa_supplicant[887]: Scan requested (ret=0) - scan timeout 30 seconds
> 2021-04-14T14:43:29.982491Z DEBUG wpa_supplicant[887]: nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN) received for wlan0
> 2021-04-14T14:43:29.982629Z DEBUG wpa_supplicant[887]: wlan0: nl80211: Scan trigger
> 2021-04-14T14:43:29.982779Z DEBUG wpa_supplicant[887]: wlan0: Event SCAN_STARTED (47) received
> 2021-04-14T14:43:29.982920Z DEBUG wpa_supplicant[887]: wlan0: Own scan request started a scan in 0.000175 seconds
> 2021-04-14T14:43:30.082401Z DEBUG wpa_supplicant[887]: nl80211: Drv Event 35 (NL80211_CMD_SCAN_ABORTED) received for wlan0
> 2021-04-14T14:43:30.082704Z DEBUG wpa_supplicant[887]: wlan0: nl80211: Scan aborted
> 2021-04-14T14:43:30.082905Z DEBUG wpa_supplicant[887]: nl80211: Scan included frequencies: 2412
> 2021-04-14T14:43:30.083123Z DEBUG wpa_supplicant[887]: wlan0: Event SCAN_RESULTS (3) received
> 2021-04-14T14:43:30.083310Z DEBUG wpa_supplicant[887]: wlan0: Scan completed in 0.128655 seconds
> 
> This is to increase the scan_timeout with 200ms for this situation,
> then scan will not timed out for this situation.
> 
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

5a10537cbfc5 ath10k: fix scan abort when duration is set for hw scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211026025902.26621-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

