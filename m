Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577C94C3101
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 17:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiBXQKn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 11:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiBXQKm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 11:10:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837F019E036
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 08:10:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 696776172F
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 16:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0588DC340E9;
        Thu, 24 Feb 2022 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645718972;
        bh=TeWl9DzwJ/5suAnt6eWmsM+Zt6FllQMmmO/5c9Z3eYs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YLSXJYwGDb6V82po5yFSmtu3+1BTUFWNsDu1UaDtDt/AgK2ZDBkV1VvvdWceI6cNs
         HjDEE9QAWfYjYjVURDNmkezu7KBL5HLDxcKOKKsHjMPRVrD7PC2+2SA24DEKvb/jXb
         54HaqJUetS6kgwF51eVXFXBo4wfZCNnn5Wr7O/mCBDTTKo+Z/uGppGhpmED9jfe7w3
         pdyq6wz2y8bV5Bu89PevhvAFy1gvQ5yurp4LJaQyqI2l6SYkOt7UP/xEfJ0H0EdGJR
         TfPF0uhSCPzv2bphsyXEGS62i5MZJ+5OokNNaNXTIRu89SPsPeduaWIRkfUxNcqciY
         2S+epUKU4UaMw==
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
Message-ID: <164571896975.3377.2071823119119025906.kvalo@kernel.org>
Date:   Thu, 24 Feb 2022 16:09:31 +0000 (UTC)
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

The kbuild bot found out that this patch was failing when CONFIG_PM was
disabled, fixed that in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=624c999c214f02004c2f996aa6ce3a17dfbebd18

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1644308006-22784-2-git-send-email-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

