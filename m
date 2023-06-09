Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71B67299EB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 14:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjFIM23 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 08:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbjFIM22 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 08:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F04E3C02
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 05:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8516B61B48
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 12:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0799C433EF;
        Fri,  9 Jun 2023 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686313574;
        bh=sDqla35NPLBYgl0LPzzm4JHUqVVdHhzJ++zG4Cv5Xm0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eEtoTdP4K0F3D0sRvNPo9UU3ja3ErKFH0iXPQYeueJxBwx5a1Rn8L8h3R85zzgTIJ
         9+3tlPmHmGmaRPU87DLa818VcH1SXKSuWXOw+P7vE93+asqPEMitbE01DOnHvsQED/
         QazJhUxfZpF5XglJoNl3F1BzhEmFGE1pf+M7tsfUQphVfuF7qDYvLH3DrAnAgTWxLD
         dr5JuuhWQnDZoUgYHrm2q8KVw6VKRn7n5Xk2Qrvc5k4EGd/UzXBhYulZfv+2pIL61T
         vGc6zz5qO7D9XFOAGNyAhK/D4tuGiz4LyQdIPpHsDLPn2XjzgYd6lQNLHXFwhB49oh
         oAtAfFNB//4eg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Baochen Qiang <quic_bqiang@quicinc.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: fix boot failure with one MSI vector
References: <20230601033840.2997-1-quic_bqiang@quicinc.com>
Date:   Fri, 09 Jun 2023 15:26:10 +0300
In-Reply-To: <20230601033840.2997-1-quic_bqiang@quicinc.com> (Baochen Qiang's
        message of "Thu, 1 Jun 2023 11:38:40 +0800")
Message-ID: <87fs70hlel.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> writes:

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

I'm worried if this breaks WCN6750 support. Manikanta, would able to
test this patch on WCN6750 and let us know if breaks anything?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
