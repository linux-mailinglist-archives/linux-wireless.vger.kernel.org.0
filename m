Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDAF762CD3
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 09:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjGZHOJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 03:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjGZHNi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 03:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E75B55A3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 00:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D867A616EC
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 07:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DA0C433C9;
        Wed, 26 Jul 2023 07:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690355389;
        bh=KRM38bje3pE6V7VFqdPRqxOiEF1hnoO0aocWJGZh2dI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=E2X3DWcGDhA0sZ9GhpWG793qHFNJBwhvpneFpgasRHGW87RMfo/0kVSIP+LSVFxp9
         FCAIrSHk05h5fUdJk6yo6AX92ZMPqk30OlFI1i2yTmFFru2BSiaBewW0JBOHRaFOAG
         GeCvX3po2TSW3c7w8ugSNSw+ILzNqpgeRMQj9RALP+AKhj/g3zo+e7020Ucp6f4gEA
         9F2TRvuSRMjXw3JlW1Efgq7xOuCSW3XmXqh/h11G9FZdwHr904IXJIDw0F2ESzbJ9/
         5ycT3UHMZjbzcK2YCEq9/9pFEYNOEKguHS0f3oXhIzsPwCcodf0xz/Lw0e3PvIkmuS
         Y/6uj7+ogl8Xg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Revert "wifi: ath6k: silence false positive
 -Wno-dangling-pointer warning on GCC 12"
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230724100823.2948804-1-kvalo@kernel.org>
References: <20230724100823.2948804-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169035538684.3467307.15180087182094710165.kvalo@kernel.org>
Date:   Wed, 26 Jul 2023 07:09:48 +0000 (UTC)
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

> This reverts commit bd1d129daa3ede265a880e2c6a7f91eab0f4dc62.
> 
> The dangling-pointer warnings were disabled kernel-wide by commit 49beadbd47c2
> ("gcc-12: disable '-Wdangling-pointer' warning for now") for v5.19. So this
> hack in ath6kl is not needed anymore.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Patch applied to wireless.git, thanks.

a1ce186db7f0 Revert "wifi: ath6k: silence false positive -Wno-dangling-pointer warning on GCC 12"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230724100823.2948804-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

