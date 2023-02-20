Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B958569C6D8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 09:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjBTIg6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 03:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjBTIgx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 03:36:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38615CDC5
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 00:36:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C17E60CF7
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 08:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80690C433D2;
        Mon, 20 Feb 2023 08:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676882199;
        bh=6ah7BdSO+tiUwm6vSd2FwhQJjPrl/h1EVnNH5HO1Zhw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ROHZ0F5P9TL1cGfwqMf9rE0ronn86Z256q4dA0Dbd1TwWfsXTEKlcypktwacDKFK1
         rNHJoJ05rKzfDFMX0DHKLVCXyfzh6gp1vQJKfzPT2xbjJWxkPeeljldIvuj47vgimr
         o+vA32wAhYxYBJ1Hr3HKcwWwEUQM76LKqS0GGd4ohKnlkMjlIGY+d2t1QCpe2vNN56
         nPtTxUwINZKKusEnKfxl+/EJw8tDlV7Fh+I9F9m6i/3QJnpMvtRXRGisfpPsWuloFd
         aSvqS4WboryF9e7LHFEMGHBxf0o/6C2Ixe+YeLOdS+TaAAxtmtELqfl9WNDtOv3nSL
         Y75QED5E38mQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next] wifi: ath11k: fix return value check in
 ath11k_ahb_probe()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230217030031.4021289-1-yangyingliang@huawei.com>
References: <20230217030031.4021289-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <quic_kathirve@quicinc.com>, <quic_srirrama@quicinc.com>,
        <yangyingliang@huawei.com>, <liwei391@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167688219531.14547.9485021806959510839.kvalo@kernel.org>
Date:   Mon, 20 Feb 2023 08:36:37 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> wrote:

> ioremap() returns NULL pointer not PTR_ERR() when it fails,
> so replace the IS_ERR() check with NULL pointer check.
> 
> Fixes: b42b3678c91f ("wifi: ath11k: remap ce register space for IPQ5018")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

342fcde9d914 wifi: ath11k: fix return value check in ath11k_ahb_probe()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230217030031.4021289-1-yangyingliang@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

