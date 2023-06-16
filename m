Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FFD732B7B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 11:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245010AbjFPJ2N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbjFPJ16 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 05:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C63593
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 02:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F76060B7C
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 09:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BE0C433C0;
        Fri, 16 Jun 2023 09:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686907604;
        bh=f0yF5bPQchvMClybiUh/Ke/ATMPmH3xPVr/y9W0vu2c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=H2SMsv+778tc9o7cr5aSTVFwvIXrbKoUdlVRcmsNQqyliiHrBvqSSu6z4MdVg2rLJ
         UUJL0aRcBy4O4aKBa45qrHa5JQaTnOVBXTQVeIBHJK7STucBdkDABn35OERT4gSl9u
         bnrLu6w+uovMZoznVnV6PNfLtHwoFSiNMpcFx8E/FbMElCB7JeEBmyqrPncvxF2IIz
         P6PZikaxlhAk+TxkCD4DGUaArFsqMHGr+/ZrgAr+jZgiyi7mM0S/2Vu4GDUDsSPsUl
         YVRKXBzbr5SRYs0riyVR7sPkdXxcM/apK88C8JTZ+GybvXqbCJaLxDuuMd93H5Ks6d
         00qCouM2wkk+g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: brcmfmac: fix gnu_printf warnings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230613140918.389690-2-kvalo@kernel.org>
References: <20230613140918.389690-2-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168690759952.25190.8801233374493424091.kvalo@kernel.org>
Date:   Fri, 16 Jun 2023 09:26:43 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> With GCC 13.1 and W=1 brcmfmac has warnings like this:
> 
> ./include/trace/perf.h:26:16: warning: function 'perf_trace_brcmf_dbg' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
> 
> Add a workaround which disables -Wsuggest-attribute=format in tracepoint.h. I
> see similar workarounds in other drivers as well.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

4 patches applied to wireless-next.git, thanks.

56714e5f1255 wifi: brcmfmac: fix gnu_printf warnings
4b6ec74ec476 wifi: brcmsmac: fix gnu_printf warnings
5ea0c3130900 wifi: hostap: fix stringop-truncations GCC warning
707a13c7e488 wifi: ray_cs: fix stringop-truncation GCC warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230613140918.389690-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

