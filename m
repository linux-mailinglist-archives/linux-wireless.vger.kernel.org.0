Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE9B7B2050
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjI1PCv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjI1PCu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:02:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B371194
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:02:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16123C433C7;
        Thu, 28 Sep 2023 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695913368;
        bh=tsaHVP2mx7ljQj4gqbh8HSWkgBxSGcfcQehBDZTlBcY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LykRHUy0u0cVgoS6993uSGpPsRukfCzMfffkSXgrHN1fnV57PE3PwypUy4B60tL7Q
         KxLCUTNbO8ugzwI42HBXiJI8tDYrCZKYeWxTWNfzK6v6bKRWtKt5cHhjYgU26hd/Dn
         1xzYEGN7+MpNYZJkw11fbg2DFMwQbKnU5oQF7EfIpT79OtnAavaJI5+VqPHz1/YuwS
         +cQF50UrENEgAFang6JAqgiHsufWmUI0dJy5xMvHq10orEBApUcuskJeUDbgn5CScS
         UixESlDAxNx75cj7VwIpLPyWOzDj0Y+kShJUD4cAl6yaMN+a4uzzw5bbB2GOoOB7MD
         kOEdzn92TOB9Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: indicate to mac80211 scan complete with
 aborted
 flag for ATH12K_SCAN_STARTING state
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230905105947.10369-1-quic_wgong@quicinc.com>
References: <20230905105947.10369-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591336483.3019228.4801533515401885948.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:02:46 +0000 (UTC)
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
> 2. run command: echo assert > /sys/kernel/debug/ath12k/wcn7850\ hw2.0/simulate_fw_crash
>    immediately after step 1.
> 
> result:
> scan failed and can not recover even when wlan recovery succeeds:
> command failed: Device or resource busy (-16)
> 
> reason:
> When scan arrives, WMI_START_SCAN_CMDID is sent to the firmware and
> function ath12k_mac_op_hw_scan() returns, then simulate_fw_crash arrives
> and the scan started event does not arrive, and then it starts to do
> recovery of wlan. __ath12k_mac_scan_finish() which is called from
> ath12k_core_halt() is one step of recovery, it will not call
> ieee80211_scan_completed() by logic currently because the scan state is
> ATH12K_SCAN_STARTING. Thus it leads the scan not being completed in
> mac80211, and leads all consecutive scans failing with -EBUSY in
> nl80211_trigger_scan even after wlan recovery success.
> 
> Indicate scan complete with aborted flag to mac80211 for
> ATH12K_SCAN_STARTING to allow recovery from scan failed with "Device or
> resource busy (-16)" after wlan recovery.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

c2ebb1d11ab9 wifi: ath12k: indicate to mac80211 scan complete with aborted flag for ATH12K_SCAN_STARTING state

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230905105947.10369-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

