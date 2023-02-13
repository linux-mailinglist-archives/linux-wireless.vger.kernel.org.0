Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C7E694D57
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 17:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBMQwV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 11:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjBMQwU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 11:52:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC291C583
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 08:52:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C03E611B7
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 16:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D49EC433EF;
        Mon, 13 Feb 2023 16:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676307138;
        bh=+exsfScg4sZ1s265b6yksH7mMACX7Q3kLLTOk1p8JHM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=o7D022Pxj+W0HKm7/yaARlv2SwP7oJRJn2ro8Q3Qye6WWYHK13Djl+ykINTFnvhDM
         6mE8AqVZxcn1gUIUrT7T2BTodvksBrqs2HQcynhzqFE7HoFO6v5iL5gW35jAn933Om
         E07uzH8FnW5FQQiBn/EhAIE/fSNIkYb8lVMum0DmXjmo0LZo6+JEyxAx/R5iQi6NZ1
         WRZVU01/lihiXkWBEukiBmqRfvUkuF5qYmgyIweSTYNHPN2b8I8cUuRl0nrRJR9GnC
         ZXTK14FsGmW3/za63k84R22Sam6CvoORN3yWZ9LirSA5jUj3FF46hyJlpUpYBRLKoS
         R7Txgh+gHM8xA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: mwifiex: Add missing compatible string for
 SD8787
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <320de5005ff3b8fd76be2d2b859fd021689c3681.1674827105.git.lukas@wunner.de>
References: <320de5005ff3b8fd76be2d2b859fd021689c3681.1674827105.git.lukas@wunner.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
        Matt Ranostay <mranostay@ti.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630713513.12830.902378238800058289.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 16:52:16 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lukas Wunner <lukas@wunner.de> wrote:

> Commit e3fffc1f0b47 ("devicetree: document new marvell-8xxx and
> pwrseq-sd8787 options") documented a compatible string for SD8787 in
> the devicetree bindings, but neglected to add it to the mwifiex driver.
> 
> Fixes: e3fffc1f0b47 ("devicetree: document new marvell-8xxx and pwrseq-sd8787 options")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.11+
> Cc: Matt Ranostay <mranostay@ti.com>

3 patches applied to wireless-next.git, thanks.

36dd7a4c6226 wifi: mwifiex: Add missing compatible string for SD8787
bba047f15851 wifi: mwifiex: Support SD8978 chipset
7715d79553de wifi: mwifiex: Support firmware hotfix version in GET_HW_SPEC responses

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/320de5005ff3b8fd76be2d2b859fd021689c3681.1674827105.git.lukas@wunner.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

