Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6080E64C90A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 13:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbiLNM2k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 07:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbiLNM2L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 07:28:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBF2A2
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 04:24:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1C1AB81691
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 12:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAF4C433D2;
        Wed, 14 Dec 2022 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671020696;
        bh=jl1Lwy6DFXwoCZqgNLZrGSyNcyESVx87elI8vyGiHuU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fVz5BY7A/NWMNh3ixH1nL7lSN/4kl2rGeP+pqcFMFsTWDp1r5UPsqq4CeTIyu+YPf
         qpyWAxpTuAE6NvwCALH91q0qS1v9dIqj+5a3vq8rY2e8NPfFegiPgr1WHKfvMlwVBc
         lF9I6bY4zaLJMXCDvr4Z7KXCMXreC9WnU96Rlk+YG1ers/ojMamLDU7uV+0Xapalpn
         J9YiNdkD4OrkAAbsSVW8dZMP1J3wNKjlm/lbf1LFVOvZg/9AJNg9yOcXJEempWEUkZ
         YEJ8dU0vaiZqw4K139Cy48IbVhzd9I95cL6X2749+dGOz17To3JgCEkVrSpKB8xiB0
         FdPy2GHCbEzVA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: consider ER SU as a TX capability
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221209012110.7242-1-pkshih@realtek.com>
References: <20221209012110.7242-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167102069415.7997.5422007837897296718.kvalo@kernel.org>
Date:   Wed, 14 Dec 2022 12:24:55 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> ER (Extended Range) SU is to have a larger coverage. We set this as a RA
> capability, and then firmware can choose ER SU to transmit packets to
> reception at cell edge. For 8852C, it needs to fill this capability in
> TXWD, so update rtw89_build_txwd_info0_v1().
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

25ed1a172298 wifi: rtw89: consider ER SU as a TX capability

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221209012110.7242-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

