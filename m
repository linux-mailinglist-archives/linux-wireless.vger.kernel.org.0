Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4A6C8047
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 15:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjCXOtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjCXOtK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 10:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A3822797
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 07:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99B9262972
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 14:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1C6C433D2;
        Fri, 24 Mar 2023 14:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679669344;
        bh=MANfTqFiGj84M3too4SLDUu3WWV9uomOPjQ4Z8QKHq0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FSoigjj3B7w1mdxO0XH+Bgh87X+RIhDEJMkjxgC1wVJijS6MlLZCihDbPCAu/k9QA
         qBcmO8d1WnEhHQmbCcClboNAdFke2y3eC+seXmr3hn8sIzxFdY65ipSB8Q9ZydX/eY
         vl2YIrG5E1thTFmPbZbjSZCpziiZ4VoI/wKEaT2Y4kJbI6IPlYicnPjV9sJBbq3Mbi
         PacRpiGSE89n6Uf9ldlacTHwhMOFTu4nCQmTSwsSPNGQPEMUizQQPDxFEJFyXFd+d7
         +u8k3sMvUZzsYidfnyzmEit4bKjPk1ru7BU9Ktw+K/tUc7csU9qXhMHRCLfZMypldM
         97KUZpNKfQ8Tg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix incorrect handling of AMSDU frames
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230320090400.30027-1-quic_hprem@quicinc.com>
References: <20230320090400.30027-1-quic_hprem@quicinc.com>
To:     Harshitha Prem <quic_hprem@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167966934129.27260.16769299047349911111.kvalo@kernel.org>
Date:   Fri, 24 Mar 2023 14:49:02 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Harshitha Prem <quic_hprem@quicinc.com> wrote:

> When a data traffic with size greater than 1500 is initiated,
> say size 65500, it is sent as a set of AMSDUs (3 MSDUs)
> in a MPDU.
> 
> These AMSDUs are incorrectly classified as multicast
> and peer id gets changed, except for first msdu,
> because of mcast_bcast bit derived from rx_desc
> for every msdu received.
> 
> The mcast_bcast bit in rx_desc is only valid for
> first msdu. Hence, add changes to derive mcast_bcast
> only if it is a first msdu.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

392b6b76fd39 wifi: ath12k: fix incorrect handling of AMSDU frames

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230320090400.30027-1-quic_hprem@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

