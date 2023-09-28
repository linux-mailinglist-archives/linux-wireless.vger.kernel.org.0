Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846AC7B2083
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjI1PIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjI1PIO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:08:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E631A5
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:08:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5ECC433C8;
        Thu, 28 Sep 2023 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695913692;
        bh=MIC9UbCOdRiK441GhtK+nFlmChw9LXZtI7u9HMnkp4k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SKrXrbertGeJq1d+qmKgdY4NVAMZ9tQk40r/AgNd+FzkcqU4yf64yPgVD354xnKSE
         VU6yzNt1L+QlyoYTamekMMWsFlyKfJTOfipTmHtBtllY37YV6ka5MgVsfZJymhlGIU
         aLL4yEVp3HIfjvn0K8KlrSAzZ7F1WO9hVydmml9u0daHqLzlZ4qtWKIyr4D2CVw7X0
         MeP3lgSpZxwgpC0pGXVKOaEcQdPUECwONO9HyTRrMwv+OPfj+SODQdn/oaa9pu70AT
         UyQ8Fq5PsIEHqSN6kTIMIwIcoBfusFytjr7HI8w6w66OvwJRyLppWJ45VRSyh14Xr2
         ewVy3ZaNoTIVQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: enable
 IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS
 for WCN7850
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230913105507.17675-1-quic_wgong@quicinc.com>
References: <20230913105507.17675-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591368967.3019228.17079892721310631838.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:08:11 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently mac80211 will send 3 scan request for each scan of WCN7850, they
> are 2.4 GHz/5 GHz/6 GHz band scan. Firmware of WCN7850 will cache the RNR
> IE(Reduced Neighbor Report element) which exist in the beacon of 2.4 GHz/5
> GHz of the AP which is co-located with 6 GHz, and then use the cache to
> scan in 6 GHz band scan if the 6 GHz scan is in the same scan with the 2.4
> GHz/5 GHz band, this will helpful to search more AP of 6 GHz. Also it will
> decrease the time cost of scan because firmware will use dual-band scan
> for the 2.4 GHz/5 GHz, it means the 2.4 GHz and 5 GHz scans are doing
> simultaneously.
> 
> Set the flag IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN7850 since it
> supports 2.4 GHz/5 GHz/6 GHz in a single wiphy/ieee80211_hw.
> 
> This does not impact QCN9274, because it is not single_phy, so does not
> have 2.4 GHz/5 GHz/6 GHz in the same wiphy, then it does not match the
> condition and then IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS will not set for
> QCN9274.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

a1e09eb35476 wifi: ath12k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230913105507.17675-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

