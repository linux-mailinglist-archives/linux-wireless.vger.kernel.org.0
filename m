Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC5272DC4E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 10:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbjFMIXa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 04:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbjFMIX2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 04:23:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD4B126
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 01:23:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC6FE60EFC
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 08:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38038C433D2;
        Tue, 13 Jun 2023 08:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686644607;
        bh=YZn6aZMRUoNN+2U/WmirBvC+cUcO4KaiQjVh4B+C0lU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PMt9XpXeijEE06eV6MT09r4SvUY0gqBJvG7VWP9B4JI3XiIE4s7zsx/IoAAXw5ebl
         jLLfSk6UyV2LUd5sGmlp5kS9Pxi+qUkIjpnA6b880yFjfRWchcIIMulFR15NubUBTG
         e29sleIe7wUZd1UPTdxF4blgZorXzLlAPOzT1glh846Q33qTIED8r0EPntki9DRH0i
         8+eqIKNnuk6nNUVBWfuCTj75O4YYk+1lMwgk2mzLzJeTFNnzzBoL2Ztn52YiyojQ+p
         gcbnJLH3w7sGMgIYtnmMsiQS22Q1YcUkmIBvR8V7AOpoYB+YYv8WA2SsOcoUYWoPOx
         F8KL9vtJ1KVsQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] [v3] wifi: rtw89: cleanup rtw89_iqk_info and related
 code
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230608082457.36020-2-dmantipov@yandex.ru>
References: <20230608082457.36020-2-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168664460436.24637.2320483612539806164.kvalo@kernel.org>
Date:   Tue, 13 Jun 2023 08:23:26 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Drop useless '_iqk_track()' and 'rtw8852a_iqk_track()' (they
> just change 'thermal_rek_en' field which is set but unused
> and so removed as well) functions, set but unused 'kcount'
> field of 'struct rtw89_iqk_info', convert 'thermal' to local
> variables where appropriate (it doesn't need to have longer
> storage duration because it is actually used for debugging
> purposes only), fix typos.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

In the future please fix typos in a separate patch. One logical change per patch, please.

No need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230608082457.36020-2-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

