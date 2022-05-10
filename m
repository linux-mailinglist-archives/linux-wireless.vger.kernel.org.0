Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB94522141
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 18:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345417AbiEJQfF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 12:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347446AbiEJQfC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 12:35:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4C1A06B
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 09:30:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55BFB617C5
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 16:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EE3C385A6;
        Tue, 10 May 2022 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652200246;
        bh=W2VdkZxWjnWqBdl46V4hOjnDzyqRvWYoxuDOHVw/4FU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TForav3Ysqc2U+gCsk19dfNCxzDkLnl3+KcJzULioU1+Isf2jr2UHH9iNpHzz5EsZ
         T655kzqjqgYzwjQ078c5mvhwrE1kHZe6t/pPKV1HveaM4J4jprce/G2QUBg9BB1DDQ
         cUmvuTtunkM+ECeyDt3MICMn7JYfs1MSC9cf1nuyt0x+oO9doXbjcEIvIjMPAAfEKN
         Q67d/otJUpXpU7Duf3UCeXXtkxbIj/Ud+5ZfJyjrd7nIueJ2kutpi068MRhkfhf84U
         pNdD2Fmlww/hDaFgDtrSIVJ4KUDpsGDNupR03mlM493vN3g/PP+6idXM52pzS3m7Zu
         KX4D67aa3tPQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath11k: Handle keepalive during WoWLAN suspend and
 resume
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220506012540.1579604-1-quic_bqiang@quicinc.com>
References: <20220506012540.1579604-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165220024378.6768.9664084417465134605.kvalo@kernel.org>
Date:   Tue, 10 May 2022 16:30:45 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> With WoWLAN enabled and after sleeping for a rather long time,
> we are seeing that with some APs, it is not able to wake up
> the STA though the correct wake up pattern has been configured.
> This is because the host doesn't send keepalive command to
> firmware, thus firmware will not send any packet to the AP and
> after a specific time the AP kicks out the STA.
> 
> Fix this issue by enabling keepalive before going to suspend
> and disabling it after resume back.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

0f84a156aa3b ath11k: Handle keepalive during WoWLAN suspend and resume

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220506012540.1579604-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

