Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBF879400A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Sep 2023 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbjIFPM4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Sep 2023 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjIFPMz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Sep 2023 11:12:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4AE64
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 08:12:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58642C433C8;
        Wed,  6 Sep 2023 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694013170;
        bh=ff+H75uDTdhbM2dFlEGFYvMNpQvwcLgyYJIPzFO8uuA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Zaxt3vIpZK0oFbeMlXILxWhb7y/cJwp/k1J7R6kHN8PSKAGbtkfl8BSY4y+1k+OK4
         K5NGJzHunNXJV+GHi8Iv7LCn6Nxpn0tGY4BrC+VVNTYpOhmfPYv4CJR+UhgtIcCbrW
         GR+2kNXtF70YB4ZezZFovd3BNBpxgkNuxXmBqWZooONryXdnQuWT80o3DFJ50RVXdl
         /xE7b7ZxCpCCS125FYNViP5FPzTSxjYUiJt+Rn4e6QzUP9e6YeAnkDgKyqFJTFPBNt
         JtS0IyarCH1SUpwvyzAkflnIE2m1oo0raboUx0rBlVCO3kBHYzCcQ2Wv3JyRU5L/uY
         C4UX2cfvAH7kg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix boot failure with one MSI vector
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230601033840.2997-1-quic_bqiang@quicinc.com>
References: <20230601033840.2997-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169401316702.3891753.7206466024669177368.kvalo@kernel.org>
Date:   Wed,  6 Sep 2023 15:12:49 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Commit 5b32b6dd96633 ("ath11k: Remove core PCI references from
> PCI common code") breaks with one MSI vector because it moves
> affinity setting after IRQ request, see below log:
> 
> [ 1417.278835] ath11k_pci 0000:02:00.0: failed to receive control response completion, polling..
> [ 1418.302829] ath11k_pci 0000:02:00.0: Service connect timeout
> [ 1418.302833] ath11k_pci 0000:02:00.0: failed to connect to HTT: -110
> [ 1418.303669] ath11k_pci 0000:02:00.0: failed to start core: -110
> 
> The detail is, if do affinity request after IRQ activated,
> which is done in request_irq(), kernel caches that request and
> returns success directly. Later when a subsequent MHI interrupt is
> fired, kernel will do the real affinity setting work, as a result,
> changs the MSI vector. However at that time host has configured
> old vector to hardware, so host never receives CE or DP interrupts.
> 
> Fix it by setting affinity before registering MHI controller
> where host is, for the first time, doing IRQ request.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Fixes: 5b32b6dd9663 ("ath11k: Remove core PCI references from PCI common code")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Tested-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

Fails to apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/pci.c:888
error: drivers/net/wireless/ath/ath11k/pci.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230601033840.2997-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

