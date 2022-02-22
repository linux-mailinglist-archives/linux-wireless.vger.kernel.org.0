Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F84BFCA3
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 16:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiBVPcH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 10:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiBVPcG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 10:32:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92F56B0A0
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 07:31:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 897AD61605
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 15:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E151C340E8;
        Tue, 22 Feb 2022 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645543900;
        bh=GEKsR8/JGueQT1cTPbmiw4fVZxSfwxSNGioobCTBSBs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=uD0AM4PUInx1nTLs0t76fu90coehUCffLOXZ8Cye0FVGZL8eB7WyOJh54FPbBdRJF
         XJOI1GzPN43TbV+qStHdcVQDcgfOSLl8r3ct34RS8NrofE9MOdd6ucR/rWH+SaMJPX
         Emhm0Dm29GCTqGTaGeeGQuuSjHic1/TZnyPbN2/4nsZze15PCPKL2DC2vIidc0jGiZ
         Tuip1/ubI/zIVmw10tCiKgvIV3F82Cj5tqJEbCUGXs7dLSzwtb+y2yMExj9pPfFwTK
         4NOy2RHhsZ92PgjwZaie2hd834kDSygtaVWcHSJMbRs5pHZUhd1zkE23Kf4vi1D5Jc
         JVBDE3lDf6Amg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: change rtw_info() to proper message level
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220218035527.9835-1-pkshih@realtek.com>
References: <20220218035527.9835-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164554389707.840.893963308765615335.kvalo@kernel.org>
Date:   Tue, 22 Feb 2022 15:31:38 +0000 (UTC)
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

> Larry reported funny log entries [1] when he used rtl8821ce. These
> messages are not harmless, but not useful for users, so change them to
> rtw_dbg() level. By the way, I review all rtw_info() and change others
> to rtw_warn().
> 
> [1] https://lore.kernel.org/linux-wireless/c356d5ae-a7b3-3065-1121-64c446e70333@lwfinger.net/
> 
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

a0061be4e54b rtw88: change rtw_info() to proper message level

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220218035527.9835-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

