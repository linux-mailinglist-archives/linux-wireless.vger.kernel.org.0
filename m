Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B46A1A2A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 11:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjBXKZG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 05:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjBXKYh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 05:24:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796B939283
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 02:23:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30C226189D
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 10:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D684AC433EF;
        Fri, 24 Feb 2023 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677234230;
        bh=P3K/dE6Hz+oGgt67Eu8N0sVORnlzLCrKHwFeN/XgUoM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fqb5yJfyslps0zydxUXMGobn3NfBAnfb3yI9/Y0mcT0tJNJd1ZfqPx1qDKam+crVY
         RWgxwX4G6ufmq40KHV2sqOQL8ouTUlHi2xj21L0cvtUHcjNjZQA/nCs+pcELzVQgmg
         +gRM0ZRTljQPDEV2k5om7/B5L+ZosTmn+pkO0Z0EB1/eG/kZh7bUolc176/yaN5OMz
         VcbXvfdTVYlXfBdgLMuo7wzEyjUVngtT8tYJ2LmNOhRQcVUdNeOG1I32DqxUSY94Xs
         V4fLRaEJ933U7oza9OK/ES2P6EO5hP9Le4SC7Gf2iEGAPKWRqJ8szJqMMhjewwj8aR
         GoN7IsSJ+FL5Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: remove memset with byte count of 278528
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230222164014.860-1-kvalo@kernel.org>
References: <20230222164014.860-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167723422796.18267.2237295490310604820.kvalo@kernel.org>
Date:   Fri, 24 Feb 2023 10:23:49 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> Sparse warns:
> 
> drivers/net/wireless/ath/ath12k/dp.c:1471:15: warning: memset with byte count of 278528
> 
> There's no need to use memset() here, instead call dma_alloc_coherent() with __GFP_ZERO.
> 
> While at it, remove an extra line before the error handler.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

28013c356296 wifi: ath12k: remove memset with byte count of 278528

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230222164014.860-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

