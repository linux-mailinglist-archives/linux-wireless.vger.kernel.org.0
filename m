Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4F8603975
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 08:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJSF76 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 01:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJSF7y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 01:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832C823EA9
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 22:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 287396177B
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 05:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C3BC433D6;
        Wed, 19 Oct 2022 05:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666159191;
        bh=VuhwMjTAhQrnq5jF82ZzVfgXI+pEDFHWRwYNuLyJgiA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DlPTXMtzpvQf0ef9YqRFEpylEK4RnQxbFb1NMT6aR7yiZ1kbXHc3bV0YCyTgXs3NY
         8Z0vmCZUsA1fnZ+ISFec/uNVbQ1E/JwfV6pD3+UNk6DVuoutBgWfcSPEk+ikgfi+wx
         dICFIg1qgSv7oV32jqPOjb4S17VOHy0Phy66hn4vKI3wqu2cHlT/McWhSraVG3RJGt
         ZukHN5dwJU+USsDVVycp6O5ATlnrpInhBMM/tfKLzLB8lhp2yAG/2J/RI/GnMeEjWY
         8ksgVVtL2jHBkgf/pSvWdm62u+mTimEg2zh2wAfVOkSvDk2ctBPlMS3k7cP6dMBNvz
         pxocBkrZNp/6w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bcma: support SPROM rev 11
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221011122941.2053705-1-linus.walleij@linaro.org>
References: <20221011122941.2053705-1-linus.walleij@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166615918608.17379.14294027206181072183.kvalo@kernel.org>
Date:   Wed, 19 Oct 2022 05:59:50 +0000 (UTC)
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> wrote:

> Rev 11 works fine for me to set the MAC address of gmac0 and
> gmac1 in the D-Link DWL-8610AP.
> 
> Cc: Rafał Miłecki <zajec5@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied to wireless-next.git, thanks.

80bc5ae9733c bcma: support SPROM rev 11

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221011122941.2053705-1-linus.walleij@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

