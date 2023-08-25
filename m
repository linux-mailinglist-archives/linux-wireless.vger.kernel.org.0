Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57D788435
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 12:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbjHYKAl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240765AbjHYKAh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 06:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2E82106
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 03:00:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CEEF64D58
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 10:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FDCC433C8;
        Fri, 25 Aug 2023 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692957634;
        bh=NlJEoUDiLOj2R8N+CsSnvr2CsNGd9IvbYJ8CFvIoZQE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rcnTa2XOqrSic0xJnKkBx6+7jOm2zOAfWAQ0lILYMJnNIWBPhCOeKdXvMvnhNzJbb
         /jZc+PLlY8M7hWWQQclOK5JYkZKCWbiNRxPFSw4odGkF6wmYqSn1m+JX9NJJ98jQTk
         C6bgwcSdq0f8YEiL+eW2cJyQdPhtDRAIXtphGQkdtKa0GarvHrfZpjbX5CwGGnw56N
         FtGE8Eju24C+kbldEVZE5/fJFF0Tn12uvVX8EuO10s2jVgDlKHamRyfJasfS2bQcSX
         MrCkoF8u5XbiXiegbL6qOBpkef7xOIkVasJeie4Y4KGE7cyFC0UV9mqYHC8tYVYBiz
         NbnX10MmY6GQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: Fix clang -Wimplicit-fallthrough in
 rtw89_query_sar()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230822-rtw89-tas-clang-implicit-fallthrough-v1-1-5cb73f0fa976@kernel.org>
References: <20230822-rtw89-tas-clang-implicit-fallthrough-v1-1-5cb73f0fa976@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     pkshih@realtek.com, ndesaulniers@google.com, trix@redhat.com,
        damon.chen@realtek.com, linux-wireless@vger.kernel.org,
        patches@lists.linux.dev, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169295763062.1850672.8467746571200324221.kvalo@kernel.org>
Date:   Fri, 25 Aug 2023 10:00:32 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> wrote:

> clang warns (or errors with CONFIG_WERROR=y):
> 
>   drivers/net/wireless/realtek/rtw89/sar.c:216:3: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>     216 |                 case RTW89_TAS_STATE_DPR_FORBID:
>         |                 ^
>   drivers/net/wireless/realtek/rtw89/sar.c:216:3: note: insert 'break;' to avoid fall-through
>     216 |                 case RTW89_TAS_STATE_DPR_FORBID:
>         |                 ^
>         |                 break;
>   1 error generated.
> 
> Clang is a little more pedantic than GCC, which does not warn when
> falling through to a case that is just break or return. Clang's version
> is more in line with the kernel's own stance in deprecated.rst, which
> states that all switch/case blocks must end in either break,
> fallthrough, continue, goto, or return. Add the missing break to silence
> the warning.
> 
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1921
> Fixes: eb2624f55ad1 ("wifi: rtw89: Introduce Time Averaged SAR (TAS) feature")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

78d84f35d2c3 wifi: rtw89: Fix clang -Wimplicit-fallthrough in rtw89_query_sar()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230822-rtw89-tas-clang-implicit-fallthrough-v1-1-5cb73f0fa976@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

