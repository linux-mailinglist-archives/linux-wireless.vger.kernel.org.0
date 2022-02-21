Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61D24BDF32
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355435AbiBUK62 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 05:58:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346958AbiBUK6B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 05:58:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF853122C
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 02:27:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AE3460FFA
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 10:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AF5C340E9;
        Mon, 21 Feb 2022 10:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645439275;
        bh=QoDql9tYlW8GV7mtDaOUYo+Yma7AQ017sPcM/GxlMJc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JuNAu8JeTu7SVX6ztbfjj4TDCDbK7pXAQFqTtd+Ml2pdELEdzqlUDbRYrryf3O0HO
         CqDVDHEGIkGvQcsqSmtauodhGzYKSzJlSZ9oN1GQYyMb7d0J62ZSDqjie+aElnygJG
         Rt3hlzfeUx9NnHbHpCaH0Unm5ospKh5Tm+Ubr3VBY1RNbgNPmMb7EN5QGrkba5dJmP
         uiJBwNBZgLw+3leKM+xl1yfILrsb4y55Ntr3EQtTZWhRzspO3vzZUArJX15oNVmDOI
         6ntiowre9fUDty1AF+EVEgIuYgBGOR6qRRf6EJxV7EzeDMZbAd9dNOKLD98hlgU2RA
         c2A6RSI5Z3HzQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2] ath11k: Invalidate cached reo ring entry before
 accessing
 it
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1645000354-32558-1-git-send-email-quic_ramess@quicinc.com>
References: <1645000354-32558-1-git-send-email-quic_ramess@quicinc.com>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164543927154.26423.3128388488663976690.kvalo@kernel.org>
Date:   Mon, 21 Feb 2022 10:27:54 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rameshkumar Sundaram <quic_ramess@quicinc.com> wrote:

> REO2SW ring descriptor is currently allocated in cacheable memory.
> While reaping reo ring entries on second trial after updating head
> pointer, first entry is not invalidated before accessing it.
> 
> This results in host reaping and using cached descriptor which is
> already overwritten in memory by DMA device (HW).
> Since the contents of descriptor(buffer id, peer info and other information
> bits) are outdated host throws errors like below while parsing corresponding
> MSDU's and drops them.
> 
> [347712.048904] ath11k_pci 0004:01:00.0: msdu_done bit in attention is not set
> [349173.355503] ath11k_pci 0004:01:00.0: frame rx with invalid buf_id 962
> 
> Move the try_again: label above  ath11k_hal_srng_access_begin()
> so that first entry will be invalidated and prefetched.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 6452f0a3d565 ("ath11k: allocate dst ring descriptors from cacheable memory")
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f2180ccb52b5 ath11k: Invalidate cached reo ring entry before accessing it

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1645000354-32558-1-git-send-email-quic_ramess@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

