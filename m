Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2270E69777D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 08:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjBOHjx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 02:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjBOHjq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 02:39:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E10132524
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 23:39:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27FD661A78
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 07:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA024C433EF;
        Wed, 15 Feb 2023 07:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676446784;
        bh=zL1XO0kwqCNterp460yAU3O80FPSgyu/gM/1jbfU4/4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=grHiZKkYgU++WTBu5mQC0BcyM8jSKiknVdZuTpK2IVF0PNZa9zxJPq0jKBohKNQkc
         mongLu1G21FK9bYiUueLA810JCje9H+gENue6BceHUqQTl6rHWjMbT+VHM9U/wsG2u
         e/szphlkyGS09wmDRrMgvmSqUWT/rb71qixQ7ffAzp7EPRC17X1Jd85EPhAxjmH11a
         R1tgfGjvAuWeR7ilG3MWUvLe/Hwr+oV+8IjF445RnIO/+WT2vo4VRUtSh//ZP3+Cl7
         qNycpFhc75yYvhD5DKBRNyMtUcVcHCAjfcxHwXkyHEnEQb8qreylSgGMLkNh4R2BtT
         PFMZlqOA+N92A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: move H2C of del_pkt_offload before polling FW status ready
References: <20230214114314.5268-1-pkshih@realtek.com>
Date:   Wed, 15 Feb 2023 09:39:40 +0200
In-Reply-To: <20230214114314.5268-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Tue, 14 Feb 2023 19:43:14 +0800")
Message-ID: <87cz6bv0lf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Chin-Yen Lee <timlee@realtek.com>
>
> The H2C of del_pkt_offload must be called before polling FW status
> ready, otherwise the following downloading normal FW will fail.
>
> Fixes: 5c12bb66b79d ("wifi: rtw89: refine packet offload flow")
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> Hi Kalle,
>
> We found a bug existing in commit 5c12bb66b79d that was merged yesterday.
> Since merge window is next week, is it possible to merge this patch for
> kernel 6.3?

Ok, I'll queue this to v6.3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
