Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053FD69C6D4
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 09:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjBTIgV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 03:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjBTIgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 03:36:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F781555D;
        Mon, 20 Feb 2023 00:36:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51376B80B17;
        Mon, 20 Feb 2023 08:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC1AC433D2;
        Mon, 20 Feb 2023 08:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676882162;
        bh=lote9b8ZjlQAz5KsQvHp/Q5FbH1kp4EcSqoIPKfV4qA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=J8OxOqWN+C3Vx/tq9E3zKsVKnJdWBkwDhKS3MHNedd43jWjegrBhPK5TCj9p94PiN
         JKM+zRKh/+8H9MnLYe9rbwytHgGZqNWDntHli/0aKb6gpnpnEM2Fi1r3s55JkfmVnn
         Loau/Ku5rZl/rF/t1GWOZ1OP6EznbDuIVg/ymR0f+AGmvjz2Mvya6sSyai41nlSlLa
         CcLMCnLW0SgjrlZiZM+0NtOHU8v9KLBeyQ9qVDXqdPF4fbv6ASfGsHB4Zk3Z+WoS5i
         ooBuUK97bvC2K1gI5dUjTmo/AeGSDKz28AfIxrmY4msJpGrvn2T7ZTmlha5YgqWBwQ
         zL3Klfu2Axz/g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: use kfree_skb() instead of kfree()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <Y+4ejiYakhEvEw7c@kili>
References: <Y+4ejiYakhEvEw7c@kili>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Kalle Valo <quic_kvalo@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167688215685.14547.14754982829823195768.kvalo@kernel.org>
Date:   Mon, 20 Feb 2023 08:35:59 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <error27@gmail.com> wrote:

> Sk_buffs are supposed to be freed with kfree_skb().
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8c464d16809f wifi: ath12k: use kfree_skb() instead of kfree()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/Y+4ejiYakhEvEw7c@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

