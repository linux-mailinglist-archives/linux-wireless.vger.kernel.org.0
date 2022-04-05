Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F044F33D1
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Apr 2022 15:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiDEIZQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Apr 2022 04:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbiDEIT7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Apr 2022 04:19:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4101BB916
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 01:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA46FB81A32
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 08:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FB8C385A0;
        Tue,  5 Apr 2022 08:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649146291;
        bh=lfSf3YuaNH30TPILlbBPZ1DPyWyyk4WrXjhN08cVlWw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GJK1ClGYOw/fBj4KN+e8VWpptZeAC2Uo/c0NOoed/ZDSetUpLU3OKHq55lbO3H9d1
         Y+fsjzxdSfbGdeMMYrs//amTWJBbFwcXmDqYi7K1p0CUz87cZocQMmE1xTLTsQRQz1
         cEcaAP8Mf210oeBctoXvq79vpa5OP7HZW1PVHNQP7deSFhZx1SaMYBt4EfHWvj6lS0
         LUOvGUiGrcTjsOzifGr0Lt47+BHU143fgWa1Stmf+UktWXCC3Xza+Q+YOnUzELM0zn
         YjpsI3xX4sHNFOJUbHdmrlpRXiCmvJor33gzkBIrxWFb0yEu2mcQZeHxmQIgkj/zEl
         4JeTR9Y3pX81Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Remove unnecessary delay in ath11k_core_suspend
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220331002105.1162099-1-quic_bqiang@quicinc.com>
References: <20220331002105.1162099-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164914628848.12306.8288528929953544140.kvalo@kernel.org>
Date:   Tue,  5 Apr 2022 08:11:30 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> The intended delay in ath11k_core_suspend is introduced in commit
> d1b0c33850d2 ("ath11k: implement suspend for QCA6390 PCI devices"),
> now with ath11k_mac_wait_tx_complete added in commit ba9177fcef21
> ("ath11k: Add basic WoW functionalities"), that delay is not
> necessary now, so remove it.
> 
> This is found in code review.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02431-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2dd398dee7aa ath11k: Remove unnecessary delay in ath11k_core_suspend

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220331002105.1162099-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

