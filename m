Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8862E5AB344
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbiIBOTc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbiIBOTP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:19:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550EFA6C5D
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7331B82A99
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 12:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5B1C433D7;
        Fri,  2 Sep 2022 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662122967;
        bh=AZvZJ0jjzWJfltJK4ejkskk2BjBVpGVq9U3dhyhrP5o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TZRfdlq79lFLOc38iSKpu6WCPb/sdeTDTuz8vjp6wkTYLvO3dVYDnJqpXbfP31Wqy
         cUXe2CqYB2sf7XpnIjK0TDhBF21CYsuX8NBaSZiioAO9F1mOtNSQ007KKOJ2x9Sypx
         ArblIQosACIxEA5ZiK3myJutrer707e5V1hwNoMUt4ISn6vdfr155ZSab0C+n/+QwY
         TijMnFh3dMHwnbALiWEvARCgioc7d2BaSvus8crpevVtGlrDA5dT7dXwF9kaGklbxo
         czPqN3o4KKzxazRCe1fJjA9Xy6uFMvaFhcgEKhBFe1hZXhIx4icVIapNyI9xWYs/rq
         HSCK3y2UTaqKg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/3] ath11k: Add multi TX ring support for WCN6750
References: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
        <20220720135113.15755-3-quic_mpubbise@quicinc.com>
Date:   Fri, 02 Sep 2022 15:49:24 +0300
In-Reply-To: <20220720135113.15755-3-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Wed, 20 Jul 2022 19:21:12 +0530")
Message-ID: <878rn2aqln.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Currently in the case of WCN6750, only one TCL ring is used for TX,
> this is limiting the TX throughput in 160 MHz case, enabling multiple
> TCL rings on WCN6750 has shown an improvement of nearly 300 Mbps in
> the case of TCP TX, therefore add the support of multi TX ring for
> WCN6750.
>
> Currently TCL ring is selected based on CPU ID, this logic cannot be
> applied for WCN6750 as there is chance of out of order TX of packets
> and to avoid this, choose TCL ring based on flow hash so that packets
> of the same flow will end up on same TCL ring. For the same reason,
> TCL ring retry logic is also not applicable for WCN6750.
>
> Also the mapping of TCL, WBM & RBM IDs for WCN6750 is different from
> existing devices. Create a new TCM/WBM/RBM mapping for WCN6750.
>
> Change does not impact existing ath11k devices.

It would also nice to document _why_ it doesn't impact existing (or do
you mean "other"?) devices.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
