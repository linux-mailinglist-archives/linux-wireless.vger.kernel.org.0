Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1135377F1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 12:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiE3JOi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 05:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbiE3JOb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 05:14:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E57A45D
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 02:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E4B9B80C90
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 09:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEEBC385B8;
        Mon, 30 May 2022 09:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653902066;
        bh=KjR61icDN6QbKmYryJwY1TWOwEskA5qT0oWbDqeJJ/I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ccEjEXmCH/xHd6L11foJefz9GwziIDoUtr9vjnTmw7H2FuUB5odY/u4ISHsDkZlm1
         C7k2XZo+qnzJO2AXJgggvT1WRrM3HWOGI61xhqrGGcUCfRebXTAjqJLh4Hmt3Tk07m
         a1TqIsXISP0T8Dh8K+nMv6+xHE5TES1Jn/p/4rZrhquWF6EcjYdtzYe6KKPO6wg2qp
         jA6oPRYp/hqM3IF+t71VrVDn+NW76F/G5iy5CHmWLyoVjRyEEE0mclL1hKPYEYEBLw
         pXDk9HRKaT9YVbNv2frnnfjB2RV08Q5dFKoCcuvPilU0g8TT7Xuq/UNQWlxppGnURD
         0gv3/lXLnIbWw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: iwlwifi: pcie: rename CAUSE macro
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220523220300.682be2029361.I283200b18da589a975a284073dca8ed001ee107a@changeid>
References: <20220523220300.682be2029361.I283200b18da589a975a284073dca8ed001ee107a@changeid>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165390206312.17496.5189595461472657281.kvalo@kernel.org>
Date:   Mon, 30 May 2022 09:14:25 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> At least mips64 has ist own CAUSE macro, so rename ours to
> IWL_CAUSE to fix build issues.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Fixes: c1918196427b ("iwlwifi: pcie: simplify MSI-X cause mapping")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Acked-by: Gregory Greenman <gregory.greenman@intel.com>

Patch applied to wireless.git, thanks.

9c6837311f43 wifi: iwlwifi: pcie: rename CAUSE macro

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220523220300.682be2029361.I283200b18da589a975a284073dca8ed001ee107a@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

