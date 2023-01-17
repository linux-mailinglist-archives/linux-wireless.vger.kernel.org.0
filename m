Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB9966DCF9
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 12:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbjAQL4s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 06:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbjAQL4o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 06:56:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DA736B13
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 03:56:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C569F612B7
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 11:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EB2C433EF;
        Tue, 17 Jan 2023 11:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673956601;
        bh=uMTwJm5FbyRiVc4apPUTenb7cdmMLbwyCZ3qBedQA3w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nWJuBV1B6Z5jln5Mf37s+/6xjouVnRNyYgGX0QDn0R3T+zUcN5fLp3KgZaPI9b29+
         +0/SFK2QmoFVmoMEGnx/0vewwoipOXfyZgrKsEZq4FkeID2xsP/txzuIqG6Axhe6y5
         R3+H8KSiW/iHeackZU7+igP8pdB23iXXVTy5QNJsBQ941FfCkxQ9NkQhbcu903gchN
         1QJBlORemaeNu89RCKl9ssRPqEc1PhvL+Q1LRs2m7TwiEmQ4whk2SpWpBCwFA1Xlwa
         FdTE4+N9C4HM4+qW3nwI1AsHobAQoS5KTLnSC2+He/X0KtQfsuUBYesXiTKpFQLDo2
         OAFqqlH/Ye9rw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Add support to configure FTM responder role
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221220044435.10506-1-quic_rajkbhag@quicinc.com>
References: <20221220044435.10506-1-quic_rajkbhag@quicinc.com>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167395659797.22891.14339771925238967315.kvalo@kernel.org>
Date:   Tue, 17 Jan 2023 11:56:39 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> wrote:

> Fine Timing Measurement(FTM) support is used to measure round trip
> time between two nodes.
> 
> Enable FTM responder feature using hw_params on supported device.
> Since FTM functionality is offloaded to firmware, adding the
> interface allows user space to enable or disable FTM responder.
> Also add support for advertising the same in extended capabilities.
> 
> QCA6390, WCN6855 and WCN6750 do not support this feature.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

a27c6a5853eb wifi: ath11k: Add support to configure FTM responder role

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221220044435.10506-1-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

