Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC4E616692
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiKBPx6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiKBPxz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:53:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD392BB32
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC6D261A18
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 15:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F62EC433D6;
        Wed,  2 Nov 2022 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667404432;
        bh=giDt3b+ZyHrsaDQ8U7LNdJ82qFVrIpbBLkCjORuwo3k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CDDvlzIcPhZS1ensHRxN66iZdb+Ik82yS3lEf86tw/uzWekYwdUxPMBOTL01iBt5v
         31r2U4DyDGPWSqh3N4YUSPH9FgMBfmuWnmgID80NK/U5ptgTLr2PEYEfPWW5V9K8D8
         8Y8wJu7XYs4o+aWLKJYTIOWRVz2hAKcX2oTKtPQo5ZxRVCy/tSqENiFTZds7qh+RhK
         3SX1iZA7V/+F0mvN9r5XYpj/DwF2D/lk1HnSnCAqdvgD3RHMU/GGZVCmLw+bBSfeou
         yaL4oFfAlJ7/4HZB0wwwQmBth78vaG+1UZs5or7VtSnnaTfWjkwFCwQ1dAMTUdePy5
         tPWlGaLsopWLg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Fix qmi_msg_handler data structure
 initialization
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221021090126.28626-1-quic_rbhattac@quicinc.com>
References: <20221021090126.28626-1-quic_rbhattac@quicinc.com>
To:     Rahul Bhattacharjee <quic_rbhattac@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Rahul Bhattacharjee <quic_rbhattac@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166740442931.20386.6032191659181258004.kvalo@kernel.org>
Date:   Wed,  2 Nov 2022 15:53:51 +0000 (UTC)
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rahul Bhattacharjee <quic_rbhattac@quicinc.com> wrote:

> qmi_msg_handler is required to be null terminated by QMI module.
> There might be a case where a handler for a msg id is not present in the
> handlers array which can lead to infinite loop while searching the handler
> and therefore out of bound access in qmi_invoke_handler().
> Hence update the initialization in qmi_msg_handler data structure.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Rahul Bhattacharjee <quic_rbhattac@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ed3725e15a15 wifi: ath11k: Fix qmi_msg_handler data structure initialization

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221021090126.28626-1-quic_rbhattac@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

