Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EAB4B0C84
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 12:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbiBJLjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 06:39:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiBJLjU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 06:39:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9911019
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 03:39:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0035561D02
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75CCC004E1;
        Thu, 10 Feb 2022 11:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644493161;
        bh=EeIa8X3/BEq9686ub9eq26xWgWXw4Ny1RcXApBLAiHE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PiFnVzQtpdt9/FNq5RtABJiN+4VdbE6ZJBGMNo9AOxZyxeweHjWoX9R0/i2S0GHq/
         AbJvHjkAtPmkSTHdX9svLV1qkESEZaL66e/GuB0ab2SNBYweSXp55Y/WYm9cyfnmVW
         3+NETiSEgdgtFLW61lboblgzCSHzJACZtOr3CUkV1aU7sKwsuYi1LVOSx5YjZOidWZ
         nO6i/Y82UU1lWJwbkm8BpLGcBDB/OvKVKPR5CMWDMNRhh2VL+K2fY/TSY5vyrIzNiu
         ytmKKGWtawwTg4tNi+aXidF14rHDXBx8XarfySJLptFsij71CErG+x/b9NPckDgnbR
         NA4Q8zk2LTmzw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/6] ath11k: Add basic WoW functionalities
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1644308006-22784-2-git-send-email-quic_cjhuang@quicinc.com>
References: <1644308006-22784-2-git-send-email-quic_cjhuang@quicinc.com>
To:     Carl Huang <quic_cjhuang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164449315590.9031.11345020274622525440.kvalo@kernel.org>
Date:   Thu, 10 Feb 2022 11:39:20 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <quic_cjhuang@quicinc.com> wrote:

> Implement basic WoW functionalities such as magic-packet, disconnect
> and pattern. The logic is very similar to ath10k.
> 
> When WoW is configured, ath11k_core_suspend and ath11k_core_resume
> are skipped as WoW configuration and hif suspend/resume are done in
> ath11k_wow_op_suspend() and ath11k_wow_op_resume().
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This patch failed to compile:

drivers/net/wireless/ath/ath11k/mac.c:7242:5: error: no previous prototype for 'ath11k_mac_flush_tx_complete' [-Werror=missing-prototypes]

Fixed in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1644308006-22784-2-git-send-email-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

