Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF2633980
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 11:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiKVKPO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 05:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiKVKPL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 05:15:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721145A3D
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 02:15:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A209861625
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 10:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED8BC433C1;
        Tue, 22 Nov 2022 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669112110;
        bh=cm1WuMuVMRkxSUBc4QFIRWreoWfyjehtty6mVirHXec=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nyHCwnSEwZDCwv20mPX4jbioX4SZgwTQmVK8bdwF3GEn1MW47hXSpqefaq2AK5Hwr
         1oGoYe7hmhHzAfdFFdwFJjnRuQSF8Ck6DLgu+g+ipZ/9fndOjQdVxmCz3pqNtybNZB
         xL+P34EJMR5Vg21ggtrITWQG0iqiLdkOx11+YJBsJYn/SyyhGJLB9TQgr+kQV+7297
         0pU0pHL8GpVIp63p22848zCRkl1yX2xhOl6Mp+OEyaznyd8mvQX1qpoPKDk7qFkfOt
         Xxc2Jcj9O2+pGfBGeU1GCCvQReCDV3+c1VoFFQ/puul9+v3EnRP28CSaEm90kgx6MS
         /IzGtJlR9jEYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: 8852b: correct TX power controlled by
 BT-coexistence
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221117061832.42057-1-pkshih@realtek.com>
References: <20221117061832.42057-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166911210782.12832.575932282424135909.kvalo@kernel.org>
Date:   Tue, 22 Nov 2022 10:15:09 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> When coexistence mechanism is under free-run mode, it could adjust WiFi
> and BT TX power to avoid interference with each other. For other cases,
> it should keep original TX power from regular predefined tables, so
> set correct values to 255 for these cases.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

79ca91a3c1f1 wifi: rtw89: 8852b: correct TX power controlled by BT-coexistence

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221117061832.42057-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

