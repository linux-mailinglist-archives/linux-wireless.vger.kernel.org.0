Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF064C41A9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Feb 2022 10:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiBYJmb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Feb 2022 04:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiBYJma (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Feb 2022 04:42:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0D11029D3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 01:41:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C8E960A66
        for <linux-wireless@vger.kernel.org>; Fri, 25 Feb 2022 09:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9F8C340E7;
        Fri, 25 Feb 2022 09:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645782117;
        bh=bIlCTlz83TTK8aucYAIC9gYbOY977JXUM454EFrB2kg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XJQultAyy4VGByhc9eSrGML9kIhvNvJOL87dwHVrtVZ9vANnWvqQms1ejWH6wovW9
         7eL29AzygTLP/FQ3iA84p+GuSHSz0eQLjQAlT/3NIewIQODr2XQqw/swilbosqFzMJ
         weVmX2ZlcjZ1Zq27SMohjqeiolVpOsK/osDi3wFVBUAsfewolKdz53hSIbWnBY6U9/
         mHrFb0qp5kMoPvwAraTL5YbWJrTed0oSyZZ/KSw3JSPYDR8B0M8+24VL419IZigcFm
         fCrma4TWldsTxjBM4LjNxDZsv9Jx/SVJsNy6zAorqKeEsb5vUsE5+gww0BGFJ4//zA
         iH16NHjkGhAzQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: fix HE PHY bandwidth capability
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220222195524.1e3cc6f7e4c3.I72ea8a9cad5eff93bcb3a0912727d03605ddb6e6@changeid>
References: <20220222195524.1e3cc6f7e4c3.I72ea8a9cad5eff93bcb3a0912727d03605ddb6e6@changeid>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164578211449.10760.1840557196877659549.kvalo@kernel.org>
Date:   Fri, 25 Feb 2022 09:41:56 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Bit 0 is reserved on 5/6 GHz and bit 1 is reserved on 2.4 GHz,
> so the driver should only set the non-reserved bits according
> to band.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply:

Recorded preimage for 'drivers/net/wireless/realtek/rtw89/core.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: rtw89: fix HE PHY bandwidth capability
Using index info to reconstruct a base tree...
M	drivers/net/wireless/realtek/rtw89/core.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/realtek/rtw89/core.c
CONFLICT (content): Merge conflict in drivers/net/wireless/realtek/rtw89/core.c
Patch failed at 0001 rtw89: fix HE PHY bandwidth capability

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220222195524.1e3cc6f7e4c3.I72ea8a9cad5eff93bcb3a0912727d03605ddb6e6@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

