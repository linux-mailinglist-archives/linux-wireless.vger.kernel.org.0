Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9055747B0DB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 17:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhLTQHp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 11:07:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46340 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhLTQHo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 11:07:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AB33B80EED
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 16:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF9BC36AE2;
        Mon, 20 Dec 2021 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640016462;
        bh=yz3yDG/V9AQ7BBwH1yVisQfmMp7BYpv9o0z4GgiFEPU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eOuHpIc6GBrTYry9O317l7gn+8Y7hRv6hdI/I6i1o7hvcLmO7fTSFhki2ao0ZnW3I
         tH6yBa6khlYdU001tbZ5Oa7+85NStXkvSHK4w3x8CIKhPcK3fVLLCiW4wvC4S5a4SP
         zAE9XmEL2iHPbGztxz6T5rOtVlwKmGtMYCITDQG04zMQxCiE+rGwjlpAj7/7X05AVs
         pRdCjOpnHmfH1346rnHB+jHsv/QTfeRBehjg609owkYnFX+qeLa4LVPLCeY5mAkyE/
         wGQPIeMiS4t+9F/Ey/aHai6yvS7yuXGqs1ACEbecB9ZsE+8tMBPcM1hnpwm7AhadI4
         LGZBUd4TN2E1g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: add signal report to mac80211 for QCA6390 and
 WCN6855
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211216070535.31732-1-quic_wgong@quicinc.com>
References: <20211216070535.31732-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164001645932.2023.9214611467801746397.kvalo@kernel.org>
Date:   Mon, 20 Dec 2021 16:07:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> IEEE80211_HW_USES_RSS is set in ath11k, then the device uses RSS and
> thus requires parallel RX which implies using per-CPU station statistics
> in sta_get_last_rx_stats() of mac80211. Currently signal is only set in
> ath11k_mgmt_rx_event(), and not set for RX data packet, then it show
> signal as 0 for iw command easily.
> 
> Change to get signal from firmware and report to mac80211.
> 
> For QCA6390 and WCN6855, the rssi value is already in dbm unit, so
> don't need to convert it again.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

c3b39553fc77 ath11k: add signal report to mac80211 for QCA6390 and WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211216070535.31732-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

