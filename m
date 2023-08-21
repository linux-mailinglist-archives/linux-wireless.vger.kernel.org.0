Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33A782993
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjHUMxo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 08:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjHUMxo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 08:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9839CD
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 05:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8911F63541
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 12:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6ADC433C9;
        Mon, 21 Aug 2023 12:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692622422;
        bh=/KCUIxClIx4e8DVZGuBHK0dBzP46U1dOA/9DEWLxrgA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=a0zW1BcvvdGHw4OOAJY0dXe/9Oeo9m/ZImZHrekxBNozKGE4VqC9gxuW6wdWyL6Ey
         caMp82EKuOsmffaXjRug2+YgHLMcqg577LIgvMTTZ4GQJvhMOyePhk4druXc+NNpLm
         Y8sa+chPG36KQBSqpXvx2nItWM2NIMWHpnZ1M/oi+MRz7iBulK+Xm/hBQmbL9B5gZW
         iHvY5w/1ShOonjhcwcMNaIZa2zAfGfLpD/nd46guc335tb/gQPMGs8/8kWQc5mkDUh
         +PS0uD6qCuSeNHkMAoUZOSQKiLPEa0tkb7yq8pNsww4lrPVE4mL0AD+IWApluzdBAg
         EJPgIlBXAG6NQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH net-next] wlcore: sdio: Use module_sdio_driver macro to
 simplify the code
References: <20230815075419.1067635-1-lizetao1@huawei.com>
Date:   Mon, 21 Aug 2023 15:53:39 +0300
In-Reply-To: <20230815075419.1067635-1-lizetao1@huawei.com> (Li Zetao's
        message of "Tue, 15 Aug 2023 15:54:19 +0800")
Message-ID: <87350ck14c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Li Zetao <lizetao1@huawei.com> writes:

> Use the module_sdio_driver macro to simplify the code, which is the
> same as declaring with module_init() and module_exit().
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

wlcore patches go to wireless-next, not net-next.

"wifi:" missing from subject but I can add that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
