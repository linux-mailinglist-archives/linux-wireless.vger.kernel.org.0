Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6490C5A6887
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 18:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiH3QiV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 12:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiH3QiT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 12:38:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFC4CAC61;
        Tue, 30 Aug 2022 09:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9951DB80EF4;
        Tue, 30 Aug 2022 16:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67354C433D6;
        Tue, 30 Aug 2022 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661877496;
        bh=l6Ijb5CZrq/hNZ9h8BEpX+pDfB1XQ2FIg2W13QV2XcE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fKdF40woI76Z9I7fji+DoicpVgPYSxQHkEKtA3rd7ahwg89WG4QR59spBlKfnTf8p
         7xFpwL0hYxIX3ojD1QuNcGw3hiT5PhzgHILsAbahHD+e32TPWs0JXwsfnkrIoTB0BU
         LDEch6hKIbFqONRSitKP+l2Q8xv0Y3fSrOGr5tbBIGZ5t8vibv7RmmohukueEOG3IT
         l2HqRGjih5YthBWe71Rcn0xSPQ9Qb0+u6bIc9vLdW1Rngc8aSirXsG1Qm/yM0m4+yX
         qtYuWmQsSLclAUubqDK+/b+vRfGUZZFuAb8AJyEcxMVs9W02IrtQBKD1mfO4FRFSWu
         t9dwxTW03GgYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6.0] wifi: iwlegacy: 4965: corrected fix for potential
 off-by-one overflow in il4965_rs_fill_link_cmd()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220815073737.GA999388@wp.pl>
References: <20220815073737.GA999388@wp.pl>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Sasha Levin <sashal@kernel.org>, linux-wireless@vger.kernel.org,
        stable-commits@vger.kernel.org, aleksei.kodanev@bell-sw.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166187749223.28049.15180175263763470653.kvalo@kernel.org>
Date:   Tue, 30 Aug 2022 16:38:14 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <stf_xl@wp.pl> wrote:

> This reverts commit a8eb8e6f7159c7c20c0ddac428bde3d110890aa7 as
> it can cause invalid link quality command sent to the firmware
> and address the off-by-one issue by fixing condition of while loop.
> 
> Cc: stable@vger.kernel.org
> Fixes: a8eb8e6f7159 ("wifi: iwlegacy: 4965: fix potential off-by-one overflow in il4965_rs_fill_link_cmd()")
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless.git, thanks.

6d0ef7241553 wifi: iwlegacy: 4965: corrected fix for potential off-by-one overflow in il4965_rs_fill_link_cmd()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220815073737.GA999388@wp.pl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

