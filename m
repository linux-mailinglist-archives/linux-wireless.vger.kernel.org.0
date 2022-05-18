Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A642352B336
	for <lists+linux-wireless@lfdr.de>; Wed, 18 May 2022 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiERHMj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 May 2022 03:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiERHMg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 May 2022 03:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F092F3A6
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 00:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D087061208
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 07:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47554C385AA;
        Wed, 18 May 2022 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652857954;
        bh=z/X42d9v4hrwB2VxgYWnDWUJLgsq2SN0xSyewQpjVwA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BIA4JbxGS2lM6e1KdXKIG2aazzoTMU4zUsJqo5i8cNR7hZg4cdM7iG4dBrsYkgah/
         Gn1Q2TePFDprOgthiKDbQEmRzy1DQJnwb67DEcfKlOMyBmCWrKKffkVm+8o0hIUQiI
         KCAK43LWFDQyDXEAkb86h9acIS50CgggPJfpPUdFIR2gY969c7WU7NuJ7nXMScWmyL
         fwm3TpY8yoovb91Xt1csQ0KBOIr/7lPHfm4zIUJ8MtW7qp8PBRAul7r7IXQx4bQqvB
         yD+MkVpcO9yja3cIlydtmAvv0kZjUeRRkeLdU5/uM4GJ/EMCfQsm8rjhb62ytEi+Zr
         v3ubKdLcJHe0A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: update missing mumimo and ofdma stats
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1652152236-12038-1-git-send-email-quic_srirrama@quicinc.com>
References: <1652152236-12038-1-git-send-email-quic_srirrama@quicinc.com>
To:     Sriram R <quic_srirrama@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165285795034.12190.3249589731146996992.kvalo@kernel.org>
Date:   Wed, 18 May 2022 07:12:33 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <quic_srirrama@quicinc.com> wrote:

> Update the missing MU-MIMO/OFDMA info in PDEV RX,
> trigger and schedule stats. i.e HTT stats type 10, 12 and 17
> respectively.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4-01209-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

fdb8fc34a6fb ath11k: update missing MU-MIMO and OFDMA stats

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1652152236-12038-1-git-send-email-quic_srirrama@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

