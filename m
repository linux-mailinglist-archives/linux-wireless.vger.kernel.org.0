Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFF94BFC9C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 16:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiBVPb0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 10:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiBVPbZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 10:31:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB372163049
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 07:31:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 575BCB81AB1
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 15:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027F0C340E8;
        Tue, 22 Feb 2022 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645543858;
        bh=2LoJTw01F3sd+JyxWga0X2sSdSu5p6LF8Z4qkGE1Ezs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nd1E9nNPevuOIlrW32orLZOvow7M3qMBketl0gWK/26S8kbbMUIPF3PAoC6f1NDge
         Q0GHo1cK1LWtVOL7gmVqvlq9IG+NVfP0yLEZMdRd7ao7BxROq4pbUZ3pZyY9jgOI5y
         KXRxtU97yggKL06vNOMgGGVLnXlN0eejjeiB9IUbwOf0QnsqRZSitIzC2bpaQFFj5v
         PU7Q3MghljXGtS3OsZCwlnBUt7+BFwEokiE/e1Y9oB+OFNR33pduR5XYF7YeXl5Aro
         Wy7TBK1IpLUB6ZC2QHMhDQtjAEqNrQpv0Qx5WO/N+JaiuhDQwzc9Ua8yvkjdTGLuLU
         6t5+WJdSIeJJg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: Limit the CFO boundaries of x'tal value
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220218034537.9338-1-pkshih@realtek.com>
References: <20220218034537.9338-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <chiuyitang@realtek.com>,
        <yuanhan1020@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164554385532.840.4155733945124042315.kvalo@kernel.org>
Date:   Tue, 22 Feb 2022 15:30:56 +0000 (UTC)
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

> From: Yi-Tang Chiu <chiuyitang@realtek.com>
> 
> Set the boundaries of x'tal value to avoid extremely adjusted results,
> causing severely unexpected CFO.
> 
> Signed-off-by: Yi-Tang Chiu <chiuyitang@realtek.com>
> Signed-off-by: Yuan-Han Zhang <yuanhan1020@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

a9e06f2e65c8 rtw89: Limit the CFO boundaries of x'tal value

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220218034537.9338-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

