Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02322785684
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 13:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjHWLMd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 07:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjHWLMc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 07:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE90E5A
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 04:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B88D662C04
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 11:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1B7C433C8;
        Wed, 23 Aug 2023 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692789148;
        bh=r1+gfNP5aPbfNkHxjiBHm2t5g7Gc9UPJ27JGnrGYRfY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aVEzOZMsFOaI6EELe4sDSdTv1T/C9HV4bZQIIhdO90pObA+uqnXfLS2V9lxlBI/I8
         4V+DbRMvm/2H3enW6t2JfaqXiB2nOZ4gLLA9rj1+8qKtR2pQxo+ITVhjUDTtFhOvcL
         H0eVqsGFBlqlgvZxbhG4aZabYsva1/Oly7AspJeJwkwFIKFUn9yqclPPtekyS9onHa
         m2Z9bFO/Ks0dXGIGZfoh+dLx/WISkF45shT4mO4i71c4s2+ouBMfXNwU8Ga+aRvTIc
         wSkcK5+ReQMocjAFOQyRZB7Gvb+2AizOVKYpAWyXef9/50OuIl6WkMW4LuDlM0Wjuy
         hvDL8RFpysWmQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: wilc1000: Remove unused declarations
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230819102100.13720-1-yuehaibing@huawei.com>
References: <20230819102100.13720-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>,
        <yuehaibing@huawei.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169278914515.1133515.17439091662378244314.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 11:12:26 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yue Haibing <yuehaibing@huawei.com> wrote:

> Commit 8399918f3056 ("staging: wilc1000: use RCU list to maintain vif interfaces list")
> removed wilc_get_interface() but not its declaration.
> Commit 9bc061e88054 ("staging: wilc1000: added support to dynamically add/remove interfaces")
> declared but never implemented wilc_cfg_alloc() and wilc_netdev_interface().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Patch applied to wireless-next.git, thanks.

c4125bf88341 wifi: wilc1000: Remove unused declarations

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230819102100.13720-1-yuehaibing@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

