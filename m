Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9902A759783
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jul 2023 15:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjGSN5Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jul 2023 09:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGSN5U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jul 2023 09:57:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0C019A
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 06:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29FBE616EE
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 13:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0637EC433C7;
        Wed, 19 Jul 2023 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689775038;
        bh=3i1TNvtzjV/rLB4t9sT1TOPqErJ9c7d6swpQaL64DII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBY4tHoIF4jNXlll7zhbgVovGIbMdUYWlQ9dksbJrt8B8xg7bIM1VBBqHme/khXDN
         bP72egkafvyM0rtuNBGTi3VKI5pRfE2yyAlCp0UuCfonAHz9v9O3OcR+2Uhtf8dhek
         CSngyyIaKk6Us9fdgunibRPKNtMJGlpbg/dGqf5w=
Date:   Wed, 19 Jul 2023 15:57:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philippe De Muyter <phdm@macq.eu>
Cc:     linuxlovemin@yonsei.ac.kr, linux-wireless@vger.kernel.org
Subject: Re: linux-stable v4.9.337 brcmfmac compilation error
Message-ID: <2023071917-stoning-cement-2235@gregkh>
References: <20230719064812.GA29927@frolo.corp.macq.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230719064812.GA29927@frolo.corp.macq.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 19, 2023 at 08:48:12AM +0200, Philippe De Muyter wrote:
> Hello,
> 
> compilation of the brcmfmac driver in linux-4.9.y (tag v4.9.337) fails with
> 
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c: In function ‘brcmf_fw_map_chip_to_name’:
>  include/linux/stddef.h:7:14: error: return makes integer from pointer without a cast [-Werror=int-conversion]
>   #define NULL ((void *)0)
>                ^
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:577:10: note: in expansion of macro ‘NULL’
>     return NULL;
>            ^~~~
>  cc1: all warnings being treated as errors
> 
> This is caused by commit 1db036d13e10809943c2dce553e2fa7fc9c6cd80
>  wifi: brcmfmac: Fix potential shift-out-of-bounds in brcmf_fw_alloc_request()
> 
>     [ Upstream commit 81d17f6f3331f03c8eafdacea68ab773426c1e3c ]
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> index 33a7378..6675de1 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> @@ -572,6 +572,11 @@ int brcmf_fw_map_chip_to_name(u32 chip, u32 chiprev,
>         u32 i;
>         char end;
> 
> +       if (chiprev >= BITS_PER_TYPE(u32)) {
> +               brcmf_err("Invalid chip revision %u\n", chiprev);
> +               return NULL;
> +       }
> +
>         for (i = 0; i < table_size; i++) {
>                 if (mapping_table[i].chipid == chip &&
>                     mapping_table[i].revmask & BIT(chiprev))
> 
> The problem is that in the upstream commit, the patch is applied to
> brcmf_fw_alloc_request(), which returns a pointer, while in v4.9.337
> it is applied to brcmf_fw_map_chip_to_name() which returns 'int'.
> 
> Should we simply revert that patch, or rather add the missing
> intermediate patches ?

4.9.y is long end-of-life and not accepting any more patches.  Please
work with your kernel vendor to not be using it anymore as it is
obsolete and known to have unfixed security issues.

sorry,

greg k-h
