Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B3B48AFDC
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbiAKOsA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 09:48:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43598 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbiAKOr7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 09:47:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FCE46167E
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jan 2022 14:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BADC36AEB;
        Tue, 11 Jan 2022 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641912478;
        bh=JProxxHbLeb6RR/bZ7wwigyGt5oeXzxAhYMtPoVWmdo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EFUTng+wYtOqYRaRDIrsBj2a7K5caRMWKynQ+YUyYAT5XDAubt0kyq8JsAiNDLFr/
         Nxa+YtDNPd/jYjkB1jAm0iTwes91PnBywsH5oku04iYPPPkfFHvcWBG1I430ViZYmU
         so/i/4ERGiVo6rNiZE2ZH2SiF8+D/E43liJqWit1W0gzmTVpRhyzO7wuiKgGArF8rs
         caymH9jwvDdBjGNyXDctw8hXyKnNLSyGtL+l5RoSk4cfyHIRuxZhJdy8RXx/ZrQ1h0
         Op2a7tVB/IYeAWi2g0uBOwfObf3y6BtqZHVbwbep7oJQAuxxCN4w0AMX+EF+mG2pZq
         3bvG3QRAZAUWg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Reconfigure hardware rate for WCN6855 after vdev
 is
 started
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211223103728.85022-1-quic_bqiang@quicinc.com>
References: <20211223103728.85022-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164191247608.9547.17482352957965001303.kvalo@kernel.org>
Date:   Tue, 11 Jan 2022 14:47:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> There is an issue that WCN6855 tries to connect to an AP using
> a hardware rate of 1Mb/s , even though the AP has announced
> expected rates as [24, 36, 48, 54] in Probe Response frame.
> 
> The reason is that WCN6855 firmware clears hardware rate info
> of management frames when vdev starts and uses 1Mb/s as default.
> To solve it, reconfigure the rate after vdev is started.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Failed to apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/core.h:587
error: drivers/net/wireless/ath/ath11k/core.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211223103728.85022-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

