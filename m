Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9E27B205E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjI1PFI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjI1PFI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:05:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9E51A7
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:05:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083D4C433C8;
        Thu, 28 Sep 2023 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695913505;
        bh=70kQOEUrDVTP7ywr5KzsufrCQtknfZXRqKz7L88PkyY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VL2s/o0bK6r4lu2bu8vm/ROSWfrWcitdFUtt3v1R9J/xU6Uqa4J2iCjaIYEc1x4xv
         y5QtZKaCap0zBqouiLid5wubswI1owrrsajKdCpL6VY9/4sfxbS1SN6ixxELmpwHtR
         HRqEA1Al7EyWrMz0GcCWKE7YRc5NZCFTm1GNTEqvR5bj+/vq4n3I7K8md8WTIrSS3J
         APu9F6kRa5+QYmuB7sse7ils6g6/N2hflyB3DkDC30T9jLSefaMGhKq2YD1x/W4hpn
         vcP7aHvvME5QHkcW09GcUgHkpIk5wTDqH5BaQf8vTf+8/lu+okYUudvakoGSSPl+wJ
         v/jJC6HycK2Bw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: indicate scan complete for scan canceled
 when
 scan running
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230906085746.18968-1-quic_wgong@quicinc.com>
References: <20230906085746.18968-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591350295.3019228.15462824983218170799.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:05:04 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> ath12k prints "Received scan event for unknown vdev" when doing the
> following test:
> 1. trigger scan
> 2. wait 0.2 second
> 3. iw reg set is issued or 11d scan complete event is sent from firmware
> 
> Reason is:
> When iw reg set is issues or the 11d scan complete event is received, the
> new country code will be set to the firmware, and the new regdomain info
> indicated to ath12k, then the new channel list will be sent to the firmware.
> The firmware will cancel the current scan after receiving WMI_SCAN_CHAN_LIST_CMDID
> which is used for the new channel list, and the state of ath12k is
> ATH12K_SCAN_RUNNING, then ath12k_get_ar_on_scan_abort() returns NULL and
> ath12k_scan_event() returns at this point and does not indicate scan
> completion to mac80211.
> 
> Indicate scan completion to mac80211 and get rid of the "Received scan
> event for unknown vdev" print for the above case.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

870c6a72739c wifi: ath12k: indicate scan complete for scan canceled when scan running

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230906085746.18968-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

