Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB726E7C6E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 16:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjDSOXm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 10:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjDSOXO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 10:23:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56084118ED
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 07:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC75463AB7
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 14:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DA8C433EF;
        Wed, 19 Apr 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914180;
        bh=HAbRNwbjEx5nsjR3xWymJ4ejFkh2h+WBog4VXc/zlk8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=r56CNY2wZUag8AyEI2WxriXna9jDYMdsjsmggvj1wkLPDK7hCStdOmJj/5JQoU5x/
         +bIwC14g0/lHyedxKlJ79m8ViBgk5m419OTTrntCUM/Ujn5ITsuUPNDuKnvUzSj4up
         pywirmyPCtX9aD1qeNiR0SyU4IdnCY/f7T3sY3QrU3QEhqdlAAUb34+x4Fq6akpvJ2
         QHtv/d/waHm5JN7WodU3WjRxPJ0Val7ln0Gn4qpBjVaDPUjLsFu62+08AgOu/vqrdJ
         G8p/+pnLyKoO8lDzx6Er4KEX5SRCpHDcaTFaBbWcmdzfFou3D/kGTM7p1SF0tpJCw4
         mwP/rKel4Wg/w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath11k: fix double free of peer rx_tid during
 reo
 cmd failure
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230403182420.23375-2-quic_hprem@quicinc.com>
References: <20230403182420.23375-2-quic_hprem@quicinc.com>
To:     Harshitha Prem <quic_hprem@quicinc.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168191417708.18451.17418807268052315291.kvalo@kernel.org>
Date:   Wed, 19 Apr 2023 14:22:58 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Harshitha Prem <quic_hprem@quicinc.com> wrote:

> Peer rx_tid is locally copied thrice during peer_rx_tid_cleanup to
> send REO_CMD_UPDATE_RX_QUEUE followed by REO_CMD_FLUSH_CACHE to flush
> all aged REO descriptors from HW cache.
> 
> When sending REO_CMD_FLUSH_CACHE fails, we do dma unmap of already
> mapped rx_tid->vaddr and free it. This is not checked during
> reo_cmd_list_cleanup() and dp_reo_cmd_free() before trying to free and
> unmap again.
> 
> Fix this by setting rx_tid->vaddr NULL in rx tid delete and also
> wherever freeing it to check in reo_cmd_list_cleanup() and
> reo_cmd_free() before trying to free again.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

93a91f40c25c wifi: ath11k: fix double free of peer rx_tid during reo cmd failure
a8ae833657a4 wifi: ath11k: Prevent REO cmd failures
20487cc3ff36 wifi: ath11k: add peer mac information in failure cases

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230403182420.23375-2-quic_hprem@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

