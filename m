Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC20788430
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 12:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbjHYKAI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbjHYJ7n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 05:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A93D1FD3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 02:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07F1166578
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 09:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB949C433C7;
        Fri, 25 Aug 2023 09:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692957580;
        bh=TYwo3sgXuBSf+cmKIDsJieDFELuO3vPZIXjiS6bhSZI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lHShTL1LU6Dj2wsh8iQYIQZscSqqGyv5JkgAGNS8YVHEhahNNU9YflMrQPLPs1i9Q
         K/3cIjkJ0BVE3E0opGHsto3WgpO0szl7Qgo4EviC9Y58DFMRgUHM3DLg7T53t8fGai
         hyIIOdFOHHnOrkB5zZYW3PA5XPz2kb7ZjJtSm5JK0NdtTjBRMcUKu457rKhbfcqT+r
         uT9YEHnKvFGOc6NxoCKmlXDvJnXRBIrEP7ZSco+/GI6STqaIOb3VTTVU/JMC95+p20
         U21jZF5DEa0ZRqczDhqyEh8p7mphC+qyY+c37XPhy3Okd6JgFB4ypXlmsO5YCmiKdR
         ER/24t/COkVGA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next v2] wifi: wlcore: sdio: Use module_sdio_driver macro
 to
 simplify the code
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230821140345.3140493-1-lizetao1@huawei.com>
References: <20230821140345.3140493-1-lizetao1@huawei.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <lizetao1@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169295757783.1850672.14583683646953333445.kvalo@kernel.org>
Date:   Fri, 25 Aug 2023 09:59:39 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Li Zetao <lizetao1@huawei.com> wrote:

> Use the module_sdio_driver macro to simplify the code, which is the
> same as declaring with module_init() and module_exit().
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Patch applied to wireless-next.git, thanks.

98fdd77d3df7 wifi: wlcore: sdio: Use module_sdio_driver macro to simplify the code

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230821140345.3140493-1-lizetao1@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

