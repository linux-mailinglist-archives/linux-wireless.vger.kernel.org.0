Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917C176B7BF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjHAOho (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjHAOhn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:37:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E26119B7
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A5F8615D1
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 14:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05D7C433C8;
        Tue,  1 Aug 2023 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690900661;
        bh=ByzTWcVKXLJtIAbqyHlDwzS3V8FLwybmVR+af1z8ffw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Co3XNM2y4yclA/W70g+7GNkzb6xDcsG2GZp7dO0oYWpm4HnKN9bf7X9+oeKFSj7AH
         HVCWPm/T1j6HdSAv4yqsDCF2SMRPINuX8tMGAwLbHKzmplLfj5HaZGQirgtNOdZBao
         iJPOGPAlkgrIkh77QsGJ32alTe85N3gDbddQDEKdNbfuSJt2ZfXTxk3SGY96EfC+6i
         dgosZJnUtIIFoboeIw3+yDvdkeXcg9mNw2+VZkWtHKyutv6pTG+1qPBukzAxh6nm+d
         +6uKlOKZ9lQzA4vxDZX3JqSodzXAluybleqKh0ARmKVlsKdUoqKyDl3tbVIBoh64AN
         jvYwq9X9bd0hw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: Fix field-spanning write in
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
Message-ID: <169090065747.212423.9892152660352726427.kvalo@kernel.org>
Date:   Tue,  1 Aug 2023 14:37:39 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> Using brcmfmac with 6.5-rc3 on a brcmfmac43241b4-sdio triggers
> a backtrace caused by the following field-spanning error:
> 
> memcpy: detected field-spanning write (size 120) of single field
>   "&params_le->channel_list[0]" at
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1072 (size 2)
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

Does the driver still work even if this warning is printed? I'm wondering
should I take this to wireless or wireless-next. Also a review from Broadcom
would be really good.

What about a Fixes tag? 

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230729140500.27892-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

