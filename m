Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975724BF861
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 13:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiBVMyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 07:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiBVMye (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 07:54:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E188A12866D
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 04:54:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DC5660EF5
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 12:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D136C340E8;
        Tue, 22 Feb 2022 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645534447;
        bh=dXqjlHx6NRP390GNabsxU/VYrxNeR5w2ee/4YEFhFXg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=X524N/88RQi3c52hfEdysK4op/XXXW091N4iSZvD/2Opjp5f7J+lFwZm+dJesTHxt
         GKhH+cbAlirv07Thaj/ZSXxTHuG2V332Io1FG/KscLO5IIfJ+6HTZ40HHAMHysTyh7
         bUf0iiLN3qqX+xkYvCXk4OyWL63RH7H3rassHQSuWwCFU35wxfE2cL8SuR0XLpNUHo
         1Zg6Mu7nhEiOzy0t+w4dSnSSHqiitNHyBDDxQzSBVBs+xlSagFktW1JXh9tpjxFylF
         WHttAhiC3aqn97h740D14jZSgSAjc1SD2Xgi3qV4NPrbhb+4X/GHL7Ixjvbit6SjTT
         Y4qhhHpLBzxbw==
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
Message-ID: <164553444424.23898.1586617399462118980.kvalo@kernel.org>
Date:   Tue, 22 Feb 2022 12:54:06 +0000 (UTC)
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

This patchset adds new warnings:

drivers/net/wireless/ath/ath11k/mac.c:7284:5: warning: no previous prototype for 'ath11k_mac_flush_tx_complete' [-Wmissing-prototypes]
drivers/net/wireless/ath/ath11k/mac.c:7284:5: warning: symbol 'ath11k_mac_flush_tx_complete' was not declared. Should it be static?
drivers/net/wireless/ath/ath11k/mac.c:8218:34: warning: cast to restricted __be64
drivers/net/wireless/ath/ath11k/wow.c:409: line length of 98 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wow.c:527: line length of 96 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wow.c:528: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath11k/mac.c:8111: line length of 96 exceeds 90 columns
drivers/net/wireless/ath/ath11k/mac.c:8168: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath11k/mac.c:8188: line length of 92 exceeds 90 columns

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1644308006-22784-2-git-send-email-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

