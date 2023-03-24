Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570A16C803D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 15:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCXOsv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 10:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjCXOss (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 10:48:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C872057F
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 07:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0125A62B46
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 14:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C8FC433EF;
        Fri, 24 Mar 2023 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679669293;
        bh=59V+XprMe1CK/peoI3vFhJIIr76W6/AmLfObBg/sjeM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ctDUN9XqTxC+6uAQ+l3dhP49/uqU8qVfj+v/BdGugUoZMF42d1gAVLHZihNESnCuW
         SCN5IH0sQki214HCYV0t7/YbCv3tNUT/mRIW67+tTSaxX4NEse6JvWBuoVdw+ZgvNq
         xomxSMwKzgMHZYCVXjSCh0vhVK/OwU2n5T+mmT0AI4AIcZ91YqUalQfq68S07/2cB6
         wZukIsiPVKb1ik3XmzCItwuzwV9VPK+6KFD2BATyNvnMJzN1HupWwBenilRkvUVqVb
         8B9o5yUH1YO8McGy5n9bPRYlo+gX06s6IiMerHU3Gpns93qanCiLqxs6oweVxmnIut
         yfP3pqn4W+QaQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fill peer meta data during reo_reinject
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230317162056.20353-1-quic_mdharane@quicinc.com>
References: <20230317162056.20353-1-quic_mdharane@quicinc.com>
To:     Manish Dharanenthiran <quic_mdharane@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Manish Dharanenthiran <quic_mdharane@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167966928962.27260.2628983691559791238.kvalo@kernel.org>
Date:   Fri, 24 Mar 2023 14:48:12 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manish Dharanenthiran <quic_mdharane@quicinc.com> wrote:

> Firmware expects physical address in the reo entrance ring when MLO is
> enabled and peer meta data in the queue_addr_lo for the non MLO cases.
> Current implementation fills the physical address for the non MLO cases
> and firmware decodes it differently which leads to SOC CSR region
> access which is not related to firmware/MAC operation.
> 
> Fix this by sending only peer_meta data and destination indication bit
> during non MLO case. This prevents firmware from invalid decoding.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4b50d4205207 wifi: ath12k: fill peer meta data during reo_reinject

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230317162056.20353-1-quic_mdharane@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

