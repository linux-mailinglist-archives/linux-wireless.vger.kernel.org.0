Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969D86DF15A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 12:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDLKAS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 06:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDLKAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 06:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C50065B8
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 03:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AFA063284
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 10:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF989C433D2;
        Wed, 12 Apr 2023 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681293615;
        bh=fK8C2lU5H+Gru/bw6YH75nU6KIJR8dwsXYKM5NXezzc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gI3pR1stBxU5DrujSZxZtZAzlX7oL6Kxa/ksbTQDwejGXJmyjQnpmSRRfYBh3pHJ2
         tyCTNfuSnh0Lewfuj+7sUwZFTc1JAOX1WMDyPvt67CZ32+VRJd4JiDECp1VcGAW2H+
         GSZyGQ2hVlU9HnDS9JuWM+ZwvzzkeUT2U0QRXLqHJOgn3ePeYakFnqIrtOJxvfjmDa
         nultbOstvpKjT0TJoQp5SlyN8sOCctzL62o1cXwPUq4Y3m77rU2NmcbLEr335EyX/s
         wC+7Jlic3BVHa1eKwHgbXDLPZKcihiIUacJt7c2CF9DgIXWGHXBYfbH60cXvkeTd2x
         cyZNpfoQsO3bg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Fix invalid management rx frame length
 issue
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230320133840.30162-1-quic_nmaran@quicinc.com>
References: <20230320133840.30162-1-quic_nmaran@quicinc.com>
To:     Nagarajan Maran <quic_nmaran@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168129361208.14673.5430321799624017931.kvalo@kernel.org>
Date:   Wed, 12 Apr 2023 10:00:13 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nagarajan Maran <quic_nmaran@quicinc.com> wrote:

> The WMI management rx event has multiple arrays of TLVs, however the common
> WMI TLV parser won't handle multiple TLV tags of same type.
> So the multiple array tags of WMI management rx TLV is parsed incorrectly
> and the length calculated becomes wrong when the target sends multiple
> array tags.
> 
> Add separate TLV parser to handle multiple arrays for WMI management rx
> TLV. This fixes invalid length issue when the target sends multiple array
> tags.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Bhagavathi Perumal S <quic_bperumal@quicinc.com>
> Co-developed-by: Nagarajan Maran <quic_nmaran@quicinc.com>
> Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

447b0398a9cd wifi: ath11k: Fix invalid management rx frame length issue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230320133840.30162-1-quic_nmaran@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

