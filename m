Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74CF76CB10
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 12:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjHBKjO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 06:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbjHBKik (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 06:38:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C82358B
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 03:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69F4F61900
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 10:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA7EC433C8;
        Wed,  2 Aug 2023 10:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690972509;
        bh=6xCQXW5zOs+xnNeRu11tLJoAU/MVR8K+7sM+K+pXY3Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=t5NccFflXd81WR/aQEKxTogp8aPyL+nYwv3TPpyL1MLZdaW6VPwP+oSuBSdvlkXrt
         +glM8+hmupU3hPaOb8O3DNNnNJE1rTLkeRWwJZ3g7AWS6hEpevZk/n7lK6IYi8r3oF
         AnmtDtxR/LMoFWVKdNi0z/l1CW9BjMPbi3yzulCQnHYJto79n/JQ9BhpItbbYLhAwD
         Qp+Mq7cCXAY8z/9UI1ssYaGZjV8UEW+LdoXS/F5dFb/PzaUfFvIqPNyi9odANeoau/
         N33Nws3AoEOK/yopnhS5itfwgl2wWkO5cWDaDwFbwzjkinbkjJ/i+040UPL2dstoYz
         SgIeE+8YYd35Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmfmac: Fix field-spanning write in
 brcmf_scan_params_v2_to_v1()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230729140500.27892-1-hdegoede@redhat.com>
References: <20230729140500.27892-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Kees Cook <keescook@chromium.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169097250604.345979.80300613431075820.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 10:35:07 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> Using brcmfmac with 6.5-rc3 on a brcmfmac43241b4-sdio triggers
> a backtrace caused by the following field-spanning warning:
> 
> memcpy: detected field-spanning write (size 120) of single field
>   "&params_le->channel_list[0]" at
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1072 (size 2)
> 
> The driver still works after this warning. The warning was introduced by the
> new field-spanning write checks which were enabled recently.
> 
> Fix this by replacing the channel_list[1] declaration at the end of
> the struct with a flexible array declaration.
> 
> Most users of struct brcmf_scan_params_le calculate the size to alloc
> using the size of the non flex-array part of the struct + needed extra
> space, so they do not care about sizeof(struct brcmf_scan_params_le).
> 
> brcmf_notify_escan_complete() however uses the struct on the stack,
> expecting there to be room for at least 1 entry in the channel-list
> to store the special -1 abort channel-id.
> 
> To make this work use an anonymous union with a padding member
> added + the actual channel_list flexible array.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Franky Lin <franky.lin@broadcom.com>

Patch applied to wireless.git, thanks.

16e455a465fc wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v1()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230729140500.27892-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

