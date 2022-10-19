Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47DC60397A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 08:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJSGCl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 02:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJSGCk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 02:02:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ED35B521
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 23:02:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A3EA6177C
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 06:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBD9C43470;
        Wed, 19 Oct 2022 06:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666159358;
        bh=yxFjeEd3jIQ1vhqmtlMwsIENDILGuWSBEJNKRlO8RN0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=t8wlFck9XTJdvIhg/OXjgYKyq/GjQLi27tDLHsl0VJLzM5oLRkJxbrfyvP/whsdy6
         uZhy3JnU665vHHFkL11IVRBNVfwz+XVSw73JM4L+qgImRT8cKvc7Y0lPPiysCLxjeo
         tyS9jXPKthDtj/w2reuI8yvqQHwgbGz3VTE2q0YklO7cqAh0weV0fH7wmtqZuyZ+gT
         hwldDrnNZwYKCfFhG5v6jOJWhyZreDa9QMNBeeoQOnKhHmsUZGW3SEtWqo6DmzHou/
         bRcdjNsHTcZl+ATtVZKKtGUuFqk7PJp2q3PJq4n3P2EQgP7fg5slN/FJHBWqVom+tQ
         uSKE5VfI3YVMA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: bcma: gpio: Convert to immutable gpio irqchip
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221012192348.2234478-1-linus.walleij@linaro.org>
References: <20221012192348.2234478-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166615935526.17379.6128218694843967614.kvalo@kernel.org>
Date:   Wed, 19 Oct 2022 06:02:36 +0000 (UTC)
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> wrote:

> This switches the BCMA gpio irqchip to be immutable. The GPIO subsystem plays
> tricks on the irqchip structures, and we're fixing it one driver at a time. See
> merge commit 4bde53ab3370 ("Merge branch irq/gpio-immutable into
> irq/irqchip-next") for all the details.
> 
> Tested on the D-Link DWL-6810AP.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Rafał Miłecki <zajec5@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>

Patch applied to wireless-next.git, thanks.

55549d6a3052 bcma: gpio: Convert to immutable gpio irqchip

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221012192348.2234478-1-linus.walleij@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

