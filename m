Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605A64F5E8A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiDFMzq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiDFMzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 08:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76229242210
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 01:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FC1B61380
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 08:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7798C385A3;
        Wed,  6 Apr 2022 08:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649235352;
        bh=fXZvs6vYjWTNHT9R1PIT+7hIuq9A798VPEVJby2p3gM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=k1ic5Ndi5/r8TTpdCV+SFcfPy7CWNeTwSx8V22CNJmB8p2d9rL5cnOhXpushg6UnW
         WelhQyToDwFZbmGJPfYAb04ExERYO12z8SXLsfv1nRm7+8q4mTVMzJKMPVtCSronc7
         G96XR26CWiAu4yRnWXppqZqLMXq4KJ9XkYHVDW1qdve9CFami0Z7qNb3piTJtHno+4
         jHDPmAU3hUvzZ9zD5fgXMOVI7CsZ+3cyugelApJgsKXfyqJvmxKTXaiBpYkk+j7l+w
         TpRFuafuybRT4BxEQOKohmsemUzPTPYp7s83q69FG7qVkxAFCarCylHGIMVhNtcnId
         vcI4SyCAuwzvg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/16] rtw89: pci: add register definition to
 rtw89_pci_info
 to generalize pci code
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220325060055.58482-2-pkshih@realtek.com>
References: <20220325060055.58482-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164923534731.20183.10742726398102120626.kvalo@kernel.org>
Date:   Wed,  6 Apr 2022 08:55:51 +0000 (UTC)
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

> The PCI code of 8852AE and 8852CE are different, but the flow and register
> names are similar. To reuse the code, add a struct to define register or
> value accordingly. We also use chip id to control the slightly different
> flow.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

16 patches applied to wireless-next.git, thanks.

740c431c22fe rtw89: pci: add register definition to rtw89_pci_info to generalize pci code
b9467e94b1f2 rtw89: pci: add pci attributes to configure operating mode
1e3f20554815 rtw89: pci: refine pci pre_init function
0db862fb025c rtw89: pci: add LTR setting for v1 chip
bab9e2391786 rtw89: pci: set address info registers depends on chips
22a66e7c3abe rtw89: pci: add deglitch setting
e1e7a574b20f rtw89: pci: add L1 settings
a7d82a7aae65 rtw89: extend dmac_pre_init to support 8852C
cf7b8b808811 rtw89: update STA scheduler parameters for v1 chip
61ebeecb3d67 rtw89: add chip_ops::{enable,disable}_bb_rf to support v1 chip
5cb5562d2a21 rtw89: Turn on CR protection of CMAC
b61adeed5409 rtw89: 8852c: update security engine setting
c49154ff8bcb rtw89: update scheduler setting
19cb94273f40 rtw89: initialize NAV control
75fd91aa92f9 rtw89: update TMAC parameters
9fb4862e913c rtw89: update ptcl_init

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220325060055.58482-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

