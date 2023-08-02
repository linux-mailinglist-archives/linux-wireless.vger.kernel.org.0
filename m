Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106276D433
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 18:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjHBQvD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjHBQu5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 12:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01512D64
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 09:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81B7761908
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 16:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93B7C433C8;
        Wed,  2 Aug 2023 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995008;
        bh=GP/jX1Sc2orjtaHf4DKQ/zYrR37BmaILJD+asVNRSZg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DLJx4or7kB3H3YokiF8M4w01H51xQW096s4egFvcfnAUehYGWZxUgslORjx5OedwO
         FoUuAjZDXCm3n5jUsaNPbKztxY2j5qICLK1xYWsaJUgTZf9dUyriuudrhLFBTQNzQv
         53+Z5YwjC+mEEbamFWaHOFOgBGPAsZPuZeqy/synm03OR22+veECXeeX/rBlApaHHL
         /ghQsInHSViYJT8co0mfp43zok1g+Tg9UFM+yB1x8110+DfPx6WYVh56xJn0mkTeQl
         iLRdQIaas7x8+CD1mHpUKmKW5fiMs61q81jtvKD1yxSu/0O04bMEOUxhIoqDxwcEdE
         u4T14VCXWdF4g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath11k: Split coldboot calibration hw_param
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230726141032.3061-2-quic_rajkbhag@quicinc.com>
References: <20230726141032.3061-2-quic_rajkbhag@quicinc.com>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Seevalamuthu Mariappan <quic_seevalam@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169099500560.463701.10291421829844281060.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 16:50:07 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> wrote:

> QCN9074 enables coldboot calibration only in Factory Test Mode (FTM).
> Hence, split cold_boot_calib to two hw_params for mission and FTM
> mode.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Seevalamuthu Mariappan <quic_seevalam@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

011e5a3052a2 wifi: ath11k: Split coldboot calibration hw_param
bdfc967bf5fc wifi: ath11k: Add coldboot calibration support for QCN9074
13329d0cb721 wifi: ath11k: Remove cal_done check during probe

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230726141032.3061-2-quic_rajkbhag@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

