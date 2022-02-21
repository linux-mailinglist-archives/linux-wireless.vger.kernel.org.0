Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784174BDD25
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 18:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347924AbiBUJJw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 04:09:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347852AbiBUJJA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 04:09:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B901001;
        Mon, 21 Feb 2022 01:01:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFB85B80EB2;
        Mon, 21 Feb 2022 09:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AF6C340E9;
        Mon, 21 Feb 2022 09:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645434079;
        bh=NYiPPmkcgbIB486ZDMgYNzdhISRb4YtBP1UQO5TZvSY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=d5Sj0OtiKgrrERQO/JouabE7GQ36P2igkec36oPi3x+7CwZA2nuzD6yl7hB6LhBO6
         RXeQyqzc33frU6qvqWhLzY0CRps4oyefphBEiWKUNfcE4mGDi2RW64hi+kgjAmGeYi
         s5HTN4JGW0wR6Vty88xEVCo7JXASOTcuyvITIaRmTqFwqgSDmN8Ruv/wMJy/GC2WQT
         +Bogl7q4fHtNtOK+IQNz5x7CDWSUP3Q4RhqNuz9mdaslobBlvIv/lApbrWBKAA8djk
         aRghhwbj2ZmkDFMS3S1tTYvuDQo2A8hXsXabR8+IMaqqIMc0yg6YWSkHxOwEhF3stU
         Uck1HhuUMOH9w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [next] rtw89: core.h: Replace zero-length array with
 flexible-array member
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220216195047.GA904198@embeddedor>
References: <20220216195047.GA904198@embeddedor>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164543407352.995.16373174771394490326.kvalo@kernel.org>
Date:   Mon, 21 Feb 2022 09:01:17 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

2e2f63a19b0a rtw89: core.h: Replace zero-length array with flexible-array member

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220216195047.GA904198@embeddedor/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

