Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1866C46E73E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 12:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhLILJt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 06:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbhLILJt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 06:09:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD111C061746
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 03:06:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B89BB82453
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 11:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6FDC341C3;
        Thu,  9 Dec 2021 11:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639047973;
        bh=MtbrJuyMH2PmWEP5GeqbESrHoEZ5mauR6hgeJ2PPU84=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=i/hb1Ux3dN/E3dn3+Ysr4wRLuWA/E11ePd4T+2hEoCdGjG5OzDP9ZWx9pafta1faK
         eXSlKWmlh9m48yCplOaX7zZQ2mOHTnKLEjpisR++dZuO/zjgGDoe7hq/reRR91DLcu
         tkcBB4SOfZu6FPN5ct9A75Ma2wEdmRsmyCAkNfD3heRVQdYdm0S9GRnEGthHb1R83T
         g0YiKuTwKzcJuMNS62LlpY3cRRtlGQChy0SUDJ949drUN7MfuxssD4iqFvKIeb7h/u
         kMpYL2q/e9kG3BFUKOAgzeKKa5sVfQn5mL7c74Weiic7000/JTKS84FngUV6+JQaj0
         W9kP/MnzZctDw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: add support of firmware logging for WCN6855
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211206094834.2060080-1-quic_chengwan@quicinc.com>
References: <20211206094834.2060080-1-quic_chengwan@quicinc.com>
To:     Cheng Wang <quic_chengwan@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_chengwan@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163904796954.31611.17209414120082546553.kvalo@kernel.org>
Date:   Thu,  9 Dec 2021 11:06:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cheng Wang <quic_chengwan@quicinc.com> wrote:

> Host enables WMI firmware logging feature via QMI message.
> Host receives firmware logging messages on WMI_DIAG_EVENTID, then
> sends logging messages to user space via event tracing infrastructure.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Cheng Wang <quic_chengwan@quicinc.com>

Fails to apply, please rebase. And remember to use ath.git master branch
as the baseline and --base switch.

error: patch failed: drivers/net/wireless/ath/ath11k/core.c:71
error: drivers/net/wireless/ath/ath11k/core.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/hw.h:163
error: drivers/net/wireless/ath/ath11k/hw.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/qmi.c:1545
error: drivers/net/wireless/ath/ath11k/qmi.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/trace.h:105
error: drivers/net/wireless/ath/ath11k/trace.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/wmi.c:7077
error: drivers/net/wireless/ath/ath11k/wmi.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211206094834.2060080-1-quic_chengwan@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

