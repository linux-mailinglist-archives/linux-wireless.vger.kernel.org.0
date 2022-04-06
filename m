Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18E4F5D44
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 14:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiDFMLL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 08:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiDFMKr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 08:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16591E0E7
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 00:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9626161B0A
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 07:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4205EC385A1;
        Wed,  6 Apr 2022 07:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649231632;
        bh=ZKS3bP+zoQ863hHbXEVIvhh1eH+0Ni6uGvVD21pxl/U=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=uK0zSkFmvXvDtzEvlDP6GSyjE6as1o9beyqCP0GRYttW+xL48/3HeTaeqAXACIMEd
         rORUFSYSYc1jwQynzKO5OE5P5ieQx/BC5hpOw7XizDuoQO/PAid+IGlMoZuh65fw/t
         7/B9PBK9NNZmOWoR3gTAXyod6Nsq2VC3Mjo1g08sNzU31VTNoVa/jDp9V9edXRRTze
         erWk4uKdMC7T65NkoGbaWFGYPRZqAwBEXZslrnVuFS1dBagjhbl7iKF/n4T3Jd96+G
         wNjZsQoPFG8rh9w84foOUZo1yEt3LVuHlcSZBBZS4q1nRo3wWmkKNEIPVP6fHTHONu
         nKWk1oFiqlC2Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] ath11k: mhi: remove state machine
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220401173042.17467-2-kvalo@kernel.org>
References: <20220401173042.17467-2-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164923162903.31835.17335207502754178945.kvalo@kernel.org>
Date:   Wed,  6 Apr 2022 07:53:51 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> State machines are difficult to understand and in this case it's just useless,
> which is shown by the diffstat. So remove it entirely to make the code simpler.
> 
> No functional changes.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

5fe7847bb63b ath11k: mhi: remove state machine
4afe7c40380e ath11k: mhi: add error handling for suspend and resume
7dabaa64c04a ath11k: mhi: remove unnecessary goto from ath11k_mhi_start()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220401173042.17467-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

