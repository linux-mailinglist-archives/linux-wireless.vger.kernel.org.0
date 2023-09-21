Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109757AA1A1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjIUVEW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjIUVDo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:03:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82EC83F58
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:37:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DA5C116B2;
        Thu, 21 Sep 2023 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695283941;
        bh=T9axprIpl0XduYk3n2EqzXInDwp6YLqpLyjrX8stzrw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=maVjgWzQpzPgDxayY1N1p0/7EJ+tKT+bbOcaL1VNcdxV83qItOQNXXz68oraB3o4j
         Z3GPQXWxLIJHh56KAPiyIG59Clc+WE351I2w6klhy44GMIqMzUkaPhxp4cAWA3jJEy
         dMUWHmouIRsxcATDpaA/sikt23/4TQEhTlzBQ9gDWeTgQDJezUpX7kVm+RpvmskGTc
         WMDj3B6Y0BS/XSdisIP8m7s8K+XFcQLzqPW/ba0tHH2qlHxnts/KWvj6sLUnTHQJH3
         MibcbD23NpF9e3WnOTtzyyk7e4roXRprIIpHSfFAbzevlw7KZ/H8EBCnj1/IReCjZm
         a5TrvxpxLS5Qg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: fix boot failure with one MSI vector
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230907015606.16297-1-quic_bqiang@quicinc.com>
References: <20230907015606.16297-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169528393922.1539628.7842522127045869453.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 08:12:20 +0000 (UTC)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
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
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01160-QCAMSLSWPLZ-1
> 
> Fixes: 5b32b6dd9663 ("ath11k: Remove core PCI references from PCI common code")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

39564b475ac5 wifi: ath11k: fix boot failure with one MSI vector

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230907015606.16297-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

