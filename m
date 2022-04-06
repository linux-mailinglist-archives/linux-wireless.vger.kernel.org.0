Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01F34F5D50
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiDFMED (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 08:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiDFMCp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 08:02:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0614F2156F3
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 00:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9128161AEA
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 07:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062B7C385A3;
        Wed,  6 Apr 2022 07:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649231115;
        bh=vgqAnGJT8XnrSAocLAe/2YDF+6R9HNTSaG/Mtg4yPPg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MvUc130w6R/evhZnPgxLDQr/Ld9ahk/p139DIFDGEVKOpGMvuQL+O3h2n0eDZGG9C
         QMjaeJO47GaH0o1WIit/vy1AvA/9pDrphNJ2GT+6gPlCqiwWXC1z+yg1TUeV86sFD0
         taojK1QrRYnKXFbu4mzwVwxUa0KKw5w09jXtbIISWosJrlPvVvcEtjIk/bWjyaWGE/
         B6HSzIuXzT/o3Sf0p7B71G8THdvUyj1SrKs4l6HQ7IKXNBlxplt5oHec525l4CFI5v
         t+ZaV++RqCghhgmgcxRFXiCYt22HdFmAAdO/JX9caxKK7St2XBaI0AqJQxCc4o1FmB
         m6d+PumhWMQmg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: change idle mode condition during hw_scan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220318034316.40720-1-pkshih@realtek.com>
References: <20220318034316.40720-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164923111032.18336.5898870461159532440.kvalo@kernel.org>
Date:   Wed,  6 Apr 2022 07:45:13 +0000 (UTC)
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

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Previously we only consider single interface's status, idle mode
> behavior could be unexpected when multiple interfaces is active.
> Change to enter/leave idle mode by mac80211's configuration state.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

29ed2d7606bb rtw88: change idle mode condition during hw_scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220318034316.40720-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

