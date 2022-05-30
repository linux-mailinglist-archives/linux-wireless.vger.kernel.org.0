Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E939553781A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 12:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiE3JgT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 05:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiE3JgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 05:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446170906
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 02:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FD6960FC0
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 09:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04217C385B8;
        Mon, 30 May 2022 09:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653903376;
        bh=GqthqfRo2eR91bxQwvJiFFIaRm2bDtRGSvRVPzBPu68=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VxphTHO2R5YOYcw2+7wr3J1vY1XT72hwBoUaeUZK8ExAhqTN/f2lblO64RTZOxIZD
         fCzmcAKvePRodR9SH/B3kWC7VioAzYXu3jNCS1Ct2Sjzo8s9SuKtGwk5PM28SCh85z
         KN6rgxPoXcEa6ohuy9RZh5t5g5Xxa3vgZbA6UgqcoHqCQ4XR2bfWMUKMNPTrVIrbWc
         1Zm2aPpdltfBjO3OnMKhnViEUKuFDJPjWNY6us0WPtXGni7hViuNBcVufvmk5lGeBe
         Bck4gGp0Ie/wTqEjNGo+k4kbdfjOigBJ5FMCsO1hmNe1Kn6ogCotz+B+OqcmmD/RYZ
         o8iznU2RrS/LA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] rtw89: fix channel inconsistency during hw_scan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220520071731.38563-2-pkshih@realtek.com>
References: <20220520071731.38563-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165390337244.8190.8846980623597465907.kvalo@kernel.org>
Date:   Mon, 30 May 2022 09:36:15 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po Hao Huang <phhuang@realtek.com>
> 
> Previously channel maintained by driver could be different from the
> ones hardware actually is. Restore these variables back to prevent
> unexpected behavior.
> 
> Signed-off-by: Po Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

28000f7baa9c rtw89: fix channel inconsistency during hw_scan
6d7d1fef3f18 rtw89: fix null vif pointer when hw_scan fails
768992eb92ec rtw89: pci: handle hardware watchdog timeout interrupt status
e3d365ff0b6c rtw89: 8852c: rfk: re-calibrate RX DCK once thermal changes a lot
425671f03b4e rtw89: sar: adjust and support SAR on 6GHz band

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220520071731.38563-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

