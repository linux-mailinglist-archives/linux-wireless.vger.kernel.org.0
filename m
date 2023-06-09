Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C8729BA7
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 15:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjFINcz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 09:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjFINcy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 09:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5562A3
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 06:32:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50C5D61148
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 13:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AE4C433EF;
        Fri,  9 Jun 2023 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686317572;
        bh=WD1Ur85G/JkD3hVnsGbmyDe3nGLBZlleJ8E5RPUG/lE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CguK+VEmiDE3jCdXAnFGucO0hr4RaokR/pDyCqb568waQsf9DJAPzz2IPZf1pGDCc
         8l8u+DnEww/ghavAk0Lf3MvSz+a3aZFdcR1UAj7v4rQQAYZrs9/zHiwMJDLDegFdgA
         kQSCFJPaGW/7wg/eT+p7J5PJjV5rK1U2oNguqf0wcu/8Tk0fuagZ3dKWaLCYpDvaQi
         H0TWwLAceasUqvfsCn9Vw2suTCteSZnbeyrv+24q+jxTf8Y0RdIDwx5yQSwDTWrEbr
         iOfdlpn6QrC8Tx0MbrpqdcaTa36qdTUVeWtonOOhKz5+xF14SGcuOfZ+AIfcQPVhCH
         x5HDh2jF9j4JQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: ath12k: Use msdu_end to check MCBC
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230529081609.34567-1-quic_bqiang@quicinc.com>
References: <20230529081609.34567-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168631757013.7235.1908290827588270825.kvalo@kernel.org>
Date:   Fri,  9 Jun 2023 13:32:51 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> We are seeing a very low TCP throughput testing with some specific
> tools. This is because for sub-frames of an AMSDU, MCBC flag in
> mpdu_start may be not valid, and as a result those frames would be
> dropped by kernel.
> 
> Add a new helper to get it from msdu_end. Also clean up original
> helper since it is not needed any more.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8f04852e90cb wifi: ath12k: Use msdu_end to check MCBC

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230529081609.34567-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

