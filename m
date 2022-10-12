Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5C75FC0D9
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 08:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJLGm4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 02:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiJLGmx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 02:42:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48208B14C9
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 23:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6A2AB8197D
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 06:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D360FC433B5;
        Wed, 12 Oct 2022 06:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665556969;
        bh=eWRIqZc5754gF/uR/0jNt0HIDDxHoz4adOEk71CFKH0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ndvFxoVbREvi5E2yHRNN6UNCnphgieSRUK3c+dG4jLbDstD/JK35otcN4nQF8ZGMo
         rSk61++nP0YfLXdiAkchZA4mau61NNyTKwoINkdmij8JKjw8yKl0RoMXqTgvk/9OoZ
         gRz5QcT6t725aaKbJ540Y/B7FALC1pUYt18eFfAzZYk65YCQaTi/RpMfZa2Ac+/unA
         6dD/NwRShEIWQlEM1sgo5+oqDm43dHVKal5nELtkjfs7fPuijdo7fz1Y1SgU+KJ6k3
         Q2cH/mBkvGkeGLCV2Cld9Q/KE4ypTlxeT8tC+er7zQygpd2F/ZjMZGRNe0jb/9yvbN
         v5Mu/V7LFni7w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Send PME message during wakeup from D3cold
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221010033237.415478-1-quic_bqiang@quicinc.com>
References: <20221010033237.415478-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166555696700.24262.12095664854132294209.kvalo@kernel.org>
Date:   Wed, 12 Oct 2022 06:42:48 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> We are seeing system stuck on some specific platforms due to
> WLAN chip fails to wakeup from D3cold state.
> 
> With this flag, firmware will send PME message during wakeup
> and this issue is gone.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3f9b09ccf7d5 wifi: ath11k: Send PME message during wakeup from D3cold

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221010033237.415478-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

