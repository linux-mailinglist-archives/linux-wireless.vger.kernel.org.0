Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD653030D
	for <lists+linux-wireless@lfdr.de>; Sun, 22 May 2022 14:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbiEVM2n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 May 2022 08:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbiEVM2m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 May 2022 08:28:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0743CA68
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 05:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BBBF60FC9
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 12:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E51C34115;
        Sun, 22 May 2022 12:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653222520;
        bh=SHwBJAlJbMrb7pFQPgPdo1i0G8FnT0RktAK/BJZwtWU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nQTFxvhnhIAzuCVy4TO4T0TNjLmrRWjlxbGJYLLpT4O6V8ZfH75d7CU+dG5CSMZVq
         4c0DP8qenXbRs/dTAJQsngnbAfN/swegzOaT9hwvxGMdnjFePKpuUjGd49cn1jWAKl
         3fJ+4tyvmpdyevl+xd7UujrjhhuB/zEyxV+8FvhVc8AK0MCUAs7yHa/4ETdbmGFDev
         Z3emTHRCA3FCRLeiI33slY4NSrssSEy/9NM71dVkIWoWZ37JfGonVOghcT+Z/9mxoZ
         9v36iHYoMYntCuDFvJ+MUFF1wRviy0VSiciaxJ6/xXXpaXVo++c5wOWtmi+KOefONd
         mGlwPun84s7aw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix misreported tx bandwidth for 160Mhz
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <cd2735a40da7f4fcc5323e3fca3775e7b5402ece.camel@freebox.fr>
References: <cd2735a40da7f4fcc5323e3fca3775e7b5402ece.camel@freebox.fr>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165322251769.774.13199637884291132797.kvalo@kernel.org>
Date:   Sun, 22 May 2022 12:28:39 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maxime Bizon <mbizon@freebox.fr> wrote:

> Because of this missing switch case, 160Mhz transmit was reported as
> 20Mhz, leading to wrong airtime calculation and AQL limiting max
> throughput.
> 
> Tested-on: QCA9984 hw2.0 PCI 10.4-3.10-00047
> 
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

75a7062e533e ath10k: fix misreported tx bandwidth for 160Mhz

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/cd2735a40da7f4fcc5323e3fca3775e7b5402ece.camel@freebox.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

