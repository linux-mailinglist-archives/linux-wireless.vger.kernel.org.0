Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865FC6714AF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 08:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjARHOf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 02:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjARHNw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 02:13:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98F77178F
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 22:38:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDA7C61695
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 06:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD53C433D2;
        Wed, 18 Jan 2023 06:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674023889;
        bh=sZu0lvoVCkS8gPjQX1ay7P2qeBFzV+Gmb3UiMDc51SM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=athbuIHBM7CpRurICTeuepoll6rm+Kds5KeXpfPStDFCHerKjiJ9L1zDlrlIZmHz6
         FajpqFfrW/5r13Ay03F8IHipgkjc8te0XmknFwrqHVlRwo08mIio1rGJSOo+kgAenf
         90ECiOt2YdgytaTKQPD2xChfE7xs08a41FSy0yASY2d65I/eI5qnc3kNWjESSDXsto
         GxwzUrPsnyR0WdoRuP9/DhyNxIrWtsaG6m7vKpMRJ1tD7okMmkRN1n/5+8gzw1e+P8
         aERIWs7ImFLTF4BvQeCKVxTeHmYYwu3MywOxIglVF1xLJIrprOqkxLp39AvkItbwOL
         bIm7Ep5yXjoag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: ath12k: Fix uninitilized variable clang
 warnings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221221105529.19345-2-quic_tmariyap@quicinc.com>
References: <20221221105529.19345-2-quic_tmariyap@quicinc.com>
To:     Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167402388648.24104.6725503653020144748.kvalo@kernel.org>
Date:   Wed, 18 Jan 2023 06:38:08 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thiraviyam Mariyappan <quic_tmariyap@quicinc.com> wrote:

> Fix uninitilized variable warnings spotted during clang compilation.
> 
> Warnings:
> drivers/net/wireless/ath/ath12k/mac.c:1076:8: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> drivers/net/wireless/ath/ath12k/dbring.c:272:7: warning: variable 'ring' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
> drivers/net/wireless/ath/ath12k/dp_rx.c:2690:34: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-03171-QCAHKSWPL_SILICONZ-1
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

d1335f0dc18f wifi: ath12k: Fix uninitilized variable clang warnings
b57f03200853 wifi: ath12k: hal_rx: Use memset_startat() for clearing queue descriptors
80166c42434c wifi: ath12k: dp_mon: Fix out of bounds clang warning
2ee25c257d17 wifi: ath12k: dp_mon: Fix uninitialized warning related to the pktlog

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221221105529.19345-2-quic_tmariyap@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

