Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234255B596F
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiILLkW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiILLkT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 07:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B498C357DE
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 04:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0086D611D3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 11:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C6FC433D6;
        Mon, 12 Sep 2022 11:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662982816;
        bh=S4OhC2HDSTsiZbAZ2nDPGgpbsY8WRVi5Y07tSo3mmhc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tap0LcANcWtXEr7eSXZoF50ZZO64yy93tBV3w71YhvhVYkowmI0gqBppjk29k6kXo
         Angc7c2MJEd/8c2l+PMP1e8v3/A/6TZXrGIFCcxGB723kEWfguby50nZA7j8HL/RBF
         sb0TyjFVxc4U0z1TzIoefkx85uzbRSijFs20KfJMLkCDE6OzmKMiG9M//2H9D+Alwp
         LI3BxPnOIRpevbzgkuA9/4Frau/xcyMMQPVIVqPiZ//1uhT6SDaaS/MwsuEMdnSGxN
         Xxwx8d80kD2A36u/cw52UkEwYRqwgZjdLHimVw/pLEzU5DmMVUyKIVcbFLqmqLtNhI
         Cw9H3EQNYfMCQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/7] wifi: rtw89: coex: Parsing Wi-Fi firmware error
 message
 from reports
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220905092539.51926-5-pkshih@realtek.com>
References: <20220905092539.51926-5-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166298281165.4036.7697625257561971254.kvalo@kernel.org>
Date:   Mon, 12 Sep 2022 11:40:15 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> Parsing firmware error message from original version and v1 reports.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Why? How does this patch help or improve anything? The commit log doesn't answer that.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220905092539.51926-5-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

