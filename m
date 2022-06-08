Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA02542A2C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiFHJAh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 05:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiFHI7O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C6A3F3A57
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 01:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01FF96159E
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 08:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9E2C3411E;
        Wed,  8 Jun 2022 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654676357;
        bh=zpm7uxvBsWJE1tU+qeB6zg+UGt82gdSLolzqIx3w+G0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GFRyTl1QkwsC6VvNCCOhckTKVZWucKftsgm6gvlMUYg9KhsrEFldX+qCP6gDFrVmI
         WdpnuB6y05ugEuennjGNVlz6L11C0fY7dI83kX52m5a02TAhTtJA1mr3UgOLnzzl+j
         G1f8cXvca09xD2hkB2RWEo3RirCaVBHTA3wXDH2Qj2SjcRrx2ZRtPIqV6gtJBPuoaV
         3Uv9pFPUy2S0nPTnYZnuwmGGEHT3CKEQct87Q1GIeaxvOHsEVPtG9oATafR6rVzt1q
         6e7YlGA8eE3aZWOLbvO8d4PpUZw6haqy4ntKsKST6AM+Fx69VamskMinXaf0H0B1RE
         3VYyhyIixrgbQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix recently introduced checkpatch warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220606142957.23721-1-kvalo@kernel.org>
References: <20220606142957.23721-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165467635481.2601.7190623758576823593.kvalo@kernel.org>
Date:   Wed,  8 Jun 2022 08:19:16 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> I updated my checkpatch and saw new warnings:
> 
> drivers/net/wireless/ath/ath10k/qmi.c:593: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> drivers/net/wireless/ath/ath10k/qmi.c:598: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> drivers/net/wireless/ath/ath10k/htt_rx.c:3565: Integer promotion: Using 'h' in '%04hx' is unnecessary
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

cc2609eda698 ath10k: fix recently introduced checkpatch warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220606142957.23721-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

