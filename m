Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF19620A6F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 08:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiKHHkm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 02:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiKHHkS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 02:40:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838B0DEC
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 23:40:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 144FBB818B2
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 07:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD30C433D6;
        Tue,  8 Nov 2022 07:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667893199;
        bh=7busSkdDdhRG5coRlD7AuhxL9WnLBEyJ/hQcD/TXlF8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=q0jzYreuwEnxxzoSUJS26rKZxfYarD3mXr3hnVc81A1rSzZfvxn0uRTTClad/iGEs
         2bUke3K31dJgtlrEfKHUHciQBkMUwMS/yzS54cfStWi8sYYloZSP6MOVMwaqlTzS2d
         2oknwah1oJ6O8gDdw2MP3AewOdyF/8QiZito/oiSEQ/L0FABZf9MvQfzpn47EAyzqm
         DcLbBmuEo8v3AEMhm7ek55hqpGkJwUM+Qq5mjZS8Eq21BN7FUenJnRuRKpVm5YGlTD
         1tvq4QxDxApAk4iOyMCfYKkc8rEYZphOdVnBfB63ZTQ2j93IOdXoOv+kHeOYlo5XDm
         uH6BUloXQt4fg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: dump dispatch status via debug port
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221102014300.14091-2-pkshih@realtek.com>
References: <20221102014300.14091-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <leo.li@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166789319663.4985.1252594686122049576.kvalo@kernel.org>
Date:   Tue,  8 Nov 2022 07:39:58 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chia-Yuan Li <leo.li@realtek.com>
> 
> Dispatch is a component to decide packets forward to host, DMAC or
> HAXIDMA. It contains CDT standing for CPU dispatcher, HDT standing
> for host dispatcher, WDE standing for descriptor engine and PLE standing
> for payload engine. STF is one kind of modes, it can be used if packet
> send to hardware and doesn't need release report.
> 
> These debug port information can help to clarify the reason if
> packets stuck in dispatch.
> 
> Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

d6197c9121dd wifi: rtw89: dump dispatch status via debug port
f7333fc2135b wifi: rtw89: update D-MAC and C-MAC dump to diagnose SER

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221102014300.14091-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

