Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5482694D71
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 17:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBMQyn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 11:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBMQyl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 11:54:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2679DB75A;
        Mon, 13 Feb 2023 08:54:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3DD4B81619;
        Mon, 13 Feb 2023 16:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA99CC433EF;
        Mon, 13 Feb 2023 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676307249;
        bh=ApUzQnIOnlCLAzVUy9JXCaqzI4pYzY1LlIGz+iu5T+M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lpQXsl7h+RRRYBVFZ1ASnY966cP0lGSDW1J4UxFHhn99K4AjZsfsTQSQjT7NYnHAi
         XzUn2P422lu+YVJPkFWpFX8wnLILd85JxBXqb1gOYnIn0twdWl0j2nCD67RUcVKJ7V
         qGRoahKqkwJ43cECiybv8Xxkc4/PhDlJPoQkEekvssSi+L0ecIpGi2oLoHCf0vuURT
         5kTnDlLE3je2OOXj04oh71kak78oguKtVObXcflYI0tEf3dCj1T9wH5nA27sZ6JKQC
         67MBYZiBpCby9XOrrNVKZ7GUktej2ibmzQ+HhdHhFQKh59qjtIdOVVOkOUbLjAuavv
         xI3wlEJbxLhjw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mwifiex: fix loop iterator in
 mwifiex_update_ampdu_txwinsize()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <Y+ERnaDaZD7RtLvX@kili>
References: <Y+ERnaDaZD7RtLvX@kili>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Chunfan Chen <jeffc@marvell.com>, Cathy Luo <cluo@marvell.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630724602.12830.10531062958911653339.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 16:54:07 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <error27@gmail.com> wrote:

> This code re-uses "i" to be the iterator for both the inside and outside
> loops.  It means the outside loop will exit earlier than intended.
> 
> Fixes: d219b7eb3792 ("mwifiex: handle BT coex event to adjust Rx BA window size")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Patch applied to wireless-next.git, thanks.

3cfb7df24cee wifi: mwifiex: fix loop iterator in mwifiex_update_ampdu_txwinsize()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/Y+ERnaDaZD7RtLvX@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

