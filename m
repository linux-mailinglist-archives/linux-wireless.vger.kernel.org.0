Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D458046E398
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 08:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhLIIDS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 03:03:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34096 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhLIIDS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 03:03:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE216B81FBA
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 07:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9670FC004DD;
        Thu,  9 Dec 2021 07:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639036783;
        bh=WoVjR0nqruLg03DuWhldQrEKuCL7rIAtNryVwyrBO0o=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ryz6krmdj+ukdYATa90s8QvYciG7Vffj9Gc2yOehBgxg6D1SQ0vVJtIJPnsrCuyXd
         eXZ9jhiIpdJ5YtpKFfoK0xV4hFsSnZOG8LQXZ0fptHcUn7ufs6rI5ty0TdzmsqijDS
         hSWYAwjiybKsIX68iZt/ITd7I7PMJXQ5VDg++jPW73u9C7PA5zQclvdXkuGFgwGR8b
         vXxnaI9QiOPmB49az1Rj9sdiM5EL7o+I6G4a+pqTCGeVPGYiLOhYdhC1LPHmate64n
         LkdEpyPEjMMP6xV4iHT0w/zjIp+dSRy6cH+N4ntvXRKUVUqV+x0RQlc4PVPUvSGH4B
         panvsj76fMXfQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for
 WCN6855
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211129101309.2931-1-quic_wgong@quicinc.com>
References: <20211129101309.2931-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163903678099.20904.5958994960625549105.kvalo@kernel.org>
Date:   Thu,  9 Dec 2021 07:59:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently mac80211 will send 3 scan request for each scan of WCN6855,
> they are 2.4 GHz/5 GHz/6 GHz band scan. Firmware of WCN6855 will
> cache the RNR IE(Reduced Neighbor Report element) which exist in the
> beacon of 2.4 GHz/5 GHz of the AP which is co-located with 6 GHz,
> and then use the cache to scan in 6 GHz band scan if the 6 GHz scan
> is in the same scan with the 2.4 GHz/5 GHz band, this will helpful to
> search more AP of 6 GHz. Also it will decrease the time cost of scan
> because firmware will use dual-band scan for the 2.4 GHz/5 GHz, it
> means the 2.4 GHz and 5 GHz scans are doing simultaneously.
> 
> Set the flag IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855 since
> it supports 2.4 GHz/5 GHz/6 GHz and it is single pdev which means
> all the 2.4 GHz/5 GHz/6 GHz exist in the same wiphy/ieee80211_hw.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Tested-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9f6da09a5f6a ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211129101309.2931-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

