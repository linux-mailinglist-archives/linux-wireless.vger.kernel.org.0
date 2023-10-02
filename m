Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B4F7B5914
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Oct 2023 19:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbjJBQ7f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 12:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbjJBQ7e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 12:59:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC53A9
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 09:59:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9390C433C8;
        Mon,  2 Oct 2023 16:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696265971;
        bh=Zo9c2Ppi/WpONYzKUs6UGR+A1VsQtNmDXzGoZqUCFqg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QGJLEx8C4gdUQrc+7f1dKhMSumXSjzwiMhBppKwQUOImwi773cJVeauJ/z0Myfxcm
         VJPNukKOXPXKZFfzMf1zsn1E0SinzjIYDit1s5PSFf80HctxZccNuIZgfcwK9Km92I
         6zSzeo9Q38OcG4LLBU8mRLr3RX8H75vLKnlD3DK3qwx9k8l+x0NMUXkTUV+QQo0VIb
         wUQ1R6RhOn1Ecdlaj9CZbjEaN92BaxJQpjd009ZLaxYfKUKll+y8SLK32W600lQVzZ
         zh6ZY1Q7ZP93OWb+s1xHXCWsmU3IgrnN7wPCtFatxrOEvd3ap7SqX2idSQ+F6vkI8O
         1OSV6ZS7iK82Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: indicate to mac80211 scan complete with
 aborted
 flag for ATH10K_SCAN_STARTING state
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230626024232.15579-1-quic_wgong@quicinc.com>
References: <20230626024232.15579-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169626596907.3936351.16766976807544333414.kvalo@kernel.org>
Date:   Mon,  2 Oct 2023 16:59:30 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Scan failure can not be recovered from when running a loop of the
> following steps:
> 1. run scan: "iw wlan scan".
> 2. run command: echo soft > /sys/kernel/debug/ieee80211/phy0/ath10k/simulate_fw_crash
>    immediately after step 1.
> 
> result:
> scan failed and can not recover even when wlan recovery succeeds:
> command failed: Device or resource busy (-16)
> 
> reason:
> When scan arrives, WMI_START_SCAN_CMDID is sent to the firmware and
> function ath10k_hw_scan() returns, then simulate_fw_crash arrives
> and the scan started event does not arrive, and then it starts to do
> recovery of wlan. __ath10k_scan_finish() which is called from
> ath10k_halt() is one step of recovery, it will not call
> ieee80211_scan_completed() by logic currently because the scan state is
> ATH10K_SCAN_STARTING. Thus it leads the scan not being completed in
> mac80211, and leads all consecutive scans failing with -EBUSY in
> nl80211_trigger_scan even after wlan recovery success.
> 
> Indicate scan complete with aborted flag to mac80211 for
> ATH10K_SCAN_STARTING to allow recovery from scan failed with "Device or
> resource busy (-16)" after wlan recovery.
> 
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00174
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d876188ab807 wifi: ath10k: indicate to mac80211 scan complete with aborted flag for ATH10K_SCAN_STARTING state

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230626024232.15579-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

