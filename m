Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA64B785679
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 13:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjHWLJr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 07:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjHWLJp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 07:09:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D579E7B
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 04:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 922D764662
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 11:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0029C433C7;
        Wed, 23 Aug 2023 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692788972;
        bh=23rZR4jmO1hyifr9383JMA9axpg8gPtQQ+VkqJ0uvLM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VsfbgYWcxbdUuznmSKKJot7oc6K8i1kg45UhwkHIrHlwHikzh/IT4W3VZe2O7vaHd
         Ew6/29oMiIoMkQW2PWQGBqN2TXQO6SVO6Ivy8oe4Jv+bVeLNGIWJsFJxn11A4FvJ5o
         6y4BUvElI184293kZqeIYLbOA9UQABRlXBUMGREuV0lEfNaCnESj+Xj1TvRHzhgfqj
         HtjqVuwuES6yMVRSOMEtwT1RByKEDd871v9aLdBng6mvqK9Se1px0LsBHjjIvUotAb
         SYfgTpedzF7dRO+KJ5CKRsKTRL+ls5aSO0L41ULKVj3rZrBAU1ZsAv3/tVwuO+U+lP
         oOLJirpLmpdpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] wifi: wfx: Use devm_kmemdup to replace devm_kmalloc
 +
 memcpy
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230810114939.2104013-1-lizetao1@huawei.com>
References: <20230810114939.2104013-1-lizetao1@huawei.com>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     <jerome.pouiller@silabs.com>, <lizetao1@huawei.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169278896989.1133515.14881647207176959313.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 11:09:31 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Li Zetao <lizetao1@huawei.com> wrote:

> Use the helper function devm_kmemdup() rather than duplicating its
> implementation, which helps to enhance code readability.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> Reviewed-by: Jérôme Pouiller <jerome.pouiller@silabs.com>

Patch applied to wireless-next.git, thanks.

eaa8023e9bb3 wifi: wfx: Use devm_kmemdup to replace devm_kmalloc + memcpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230810114939.2104013-1-lizetao1@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

