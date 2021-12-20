Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E0647B2D8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 19:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbhLTS3c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 13:29:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47012 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhLTS3b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 13:29:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D784DB81059
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 18:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC392C36AEB;
        Mon, 20 Dec 2021 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640024969;
        bh=XzQ14ZCElx219r+i7Dfr8dEqwHhqMpHHYRUqDkwz+F0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Lf6R8KLlo3qcuwJdBweaOmhRhEk5GU1trlmgoD9yU3ZKbtyp0CQun8c2Vu99JzDYl
         XdFVcSS+pYkdRCm+rz67Q6GX9nUryKEtHWhW0uEi6JGsYT6bd5x5ma5FAt6IPomnVd
         6hp7f41wyXI0x/bFewz5N18/iKPufgy1DNu6ImH8/y4IGI5ukNx4bi7PxwP+2FJ59z
         At+zuYoA0gApTuT1gpHDn6HKx24+fEoMZ8VD2duns9FnzX7QtPLMODYZHm1ZCzxBI3
         5VKendNCcfiT6Tx7dIdHDD1K+1OhsiDW6Y8LXx/ivxaUmFyljntE3F0IQaamiRJ2ZT
         KzC4CFbwVOFaQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: add support for hardware rfkill for QCA6390
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211217102334.14907-1-quic_wgong@quicinc.com>
References: <20211217102334.14907-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164002496714.8180.10579865678538990827.kvalo@kernel.org>
Date:   Mon, 20 Dec 2021 18:29:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When hardware rfkill is enabled in the firmware it will report the
> capability via using WMI_SYS_CAP_INFO_RFKILL bit in the WMI_SERVICE_READY
> event to the host. ath11k will check the capability, and if it is enabled then
> ath11k will set the GPIO information to firmware using WMI_PDEV_SET_PARAM. When
> the firmware detects hardware rfkill is enabled by the user, it will report it
> via WMI_RFKILL_STATE_CHANGE_EVENTID. Once ath11k receives the event it will
> send wmi command WMI_PDEV_SET_PARAM to the firmware and also notifies cfg80211.
> 
> This only enable rfkill feature for QCA6390, rfkill_pin is all initialized to 0
> for other chips in ath11k_hw_params.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ec038c6127fa ath11k: add support for hardware rfkill for QCA6390

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211217102334.14907-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

