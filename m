Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631EA69F49D
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 13:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjBVMcq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 07:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjBVMcp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 07:32:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC73B0C4
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 04:32:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 383826142F
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 12:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90241C4339B;
        Wed, 22 Feb 2023 12:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677069158;
        bh=z/EqdjpfbeKEbOhDnC6vXpCpqDLvLpV2y8eFwrgm1/M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZisUmt6rY0msrlVuVPWE/cLnfl+9mGFXljgN7MoEDlvU2zTi3AkIH3t+Z+LDCcNOC
         EUhxnReRUtt+avy0QiaUx4vHOiAIGZmfiiswOeHDmRvkfBkswAbG3QcrzHDAzJJXhe
         WR0vTOrisOZe/NX0CiQNGavup1wQlDW1wItpbXTweJi/XFXvqO/CGSzqlRp9LNE+Qf
         iSV29Gm3p1sVkvrSWKcsldZosgF/vD4hvsWwRj+qt4Zo0aozG+bt9/OZw1s9nUaPMA
         LEs5WjTs8PWRwCZE7N1uoDRv8N9uBFwO14xKCA6qLbQYwNKeXA/8LjrXOEwibu5q9N
         KoEIvzrcHuSmw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: rtw89: add tx_wake notify for 8852B
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230220070202.29868-2-pkshih@realtek.com>
References: <20230220070202.29868-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <timlee@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167706915408.20055.11114575754216584018.kvalo@kernel.org>
Date:   Wed, 22 Feb 2023 12:32:37 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> 8852B has the same issue: management frames get stuck when wifi
> chip enters low ps mode, so we alse add notify wake function to
> trigger wifi chip wake before forwarding management frames.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

aa4e05594546 wifi: rtw89: add tx_wake notify for 8852B
31c416e69dbf wifi: rtw89: fw: configure CRASH_TRIGGER feature for 8852B
bb9040b3ff97 wifi: rtw89: adjust channel encoding to common function
4f24d7aa575a wifi: rtw89: 8852b: add channel encoding for hw_scan
357277e1afda wifi: rtw89: 8852b: enable hw_scan support
0d1f7ff19d4f wifi: rtw89: refine FW feature judgement on packet drop

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230220070202.29868-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

