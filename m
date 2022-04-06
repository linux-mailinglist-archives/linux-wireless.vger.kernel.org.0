Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB504F5D36
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 14:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiDFMIV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiDFMHm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 08:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACC12317AD
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 00:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 396F361B20
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 07:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C20BC385A9;
        Wed,  6 Apr 2022 07:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649231241;
        bh=hBwgr9bOCH9lRMSadgZ+58sXGgNkXUyYl3h1SjvceNQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=iq+PCSZwHmi9ls88C1bT3A5demcVqYBcyQrdbZZ/DSrITJgowuef1bZTQmfJuaiBf
         303i5VXkYv56G/vFnR4kC/LEsDJrwtnL5FjomYXUBAPIJKEPaZ2l0mvOQ6idHmcxg9
         9lUyf1B/0hXK5oICV/raqU3hpqRy5aKd2B1Hk30nn+x4+JrRpJZzfTVFiGytqYuC9g
         TKhyr5aGSk+KywJRfTLCaLe364nMRdki1W28JQxCsGo5+FTwCNbMnDXbvZgaD9bVQW
         ZWO4MKp9/yceEwbNZIrYc1lAetV9qIof+7E9NIF19gIf3MAAGRW8KjaY8tcMXsZ27N
         PK3igAlDiHVfg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: reduce export symbol number of mac size and quota
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220315015522.11366-1-pkshih@realtek.com>
References: <20220315015522.11366-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164923123903.18336.14764917519189756844.kvalo@kernel.org>
Date:   Wed,  6 Apr 2022 07:47:20 +0000 (UTC)
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

> An export symbol costs about 40 bytes (in x86 with gcc), so use a structure
> containing these small arrays to reduce code size.
> 
>    text	   data	    bss	    dec	    hex	filename
>   34932	   1410	      0	  36342	   8df6	mac.o (before)
>   34276	   1258	      0	  35534	   8ace	mac.o (after)
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

306451188062 rtw89: reduce export symbol number of mac size and quota

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220315015522.11366-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

