Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390E148AFB2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 15:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242254AbiAKOj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 09:39:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52880 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242251AbiAKOj0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 09:39:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76976B81B2E
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 14:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3619C36AEB;
        Tue, 11 Jan 2022 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641911963;
        bh=2qpHvcXdKCF1BOvShza4EwfmUXGsmF2U/fuYdTalL8k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=J/EiCWdC2Ni8Z0IeWzKYechwE1bS2sdSFI38Lu1/oE0c7tcRatE0nMGJr0DrEkMMm
         o5E/5YxNWGLtw9L8PO7H8k7IpT7Ji0ihXJqk1l/vn0nxGgqGfjZaXJ+aZrEkJ6yNfC
         r9R4DcIo4Uj4bMvQwOcMVDJK+y7EZWRfvMEE8vyN4ZorViNZcky3dqdb/gIQ45cmUm
         OTBMXp14jrsi79fbLSbS+55ZTXQr6Cxv1X4XhLmNnz+Zlq+E5q5yQsOkHh5y11hDdl
         ZPNB/qSONdpqTxpyE74lk5Y7bAFKfI9g9YH3u4FKFc/uU/uW1SN40cr4wIu4iyaQpv
         /UdyGcDCWaIAA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Refactor the fallback routine when peer create
 fails
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1640244819-21183-1-git-send-email-quic_periyasa@quicinc.com>
References: <1640244819-21183-1-git-send-email-quic_periyasa@quicinc.com>
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164191196101.24158.7054789674667193662.kvalo@kernel.org>
Date:   Tue, 11 Jan 2022 14:39:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> When there is an error in peer create process from
> ath11k_peer_find(), the code attempts to handle a fallback
> for peer create. When this fallback fails, the driver returns
> the fallback return code rather than actual error code
> (-ENOENT). So refactor the fallback routine to return
> the actual error code.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

fbed57d897f6 ath11k: Refactor the fallback routine when peer create fails

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1640244819-21183-1-git-send-email-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

