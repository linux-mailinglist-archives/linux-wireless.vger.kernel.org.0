Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C5D782DA5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjHUP5v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 11:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjHUP5v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 11:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939CA1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 08:57:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FEA662195
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 15:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C80BC433C8;
        Mon, 21 Aug 2023 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692633468;
        bh=lQ+eX2BqLsW8b6VEswM/5WYS/ZcnvMuWgJZfx/tdtAU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=I6SbLd4d2eFC6XrNQ4hT8zDrZMAJcUY092cPq30ZiIe3EJCn/iGbs64kgl+Acn++2
         h7hqep6cQWpfJiBojFYjj+gdrlPKBW4/RzkZEKi7n3hTLB3A5oR15334qer8BDgV0U
         GNaAgFvEyOXwiJsl/iWqT5hzNC3b5+J9wHkwJ+MobuE/pT0McqFNs7cJjspR7s5AiY
         rp+vo9pe7j2lHEBDveHyHLpas+5fXYrkuFFYmsa8rJzXKHpyW2/i5YY4s/4fa/9yB0
         nQXN2Vl5fAlBhcL92pI7nBuzlI7Iemh77V7DOjO+WAB8EPY0Gf0OvBiLsq0d5YPtEC
         iQOcDFWr9cveA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: mwifiex: Fix missed return in oob checks failed path
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230810083911.3725248-1-pinkperfect2021@gmail.com>
References: <20230810083911.3725248-1-pinkperfect2021@gmail.com>
To:     Polaris Pi <pinkperfect2021@gmail.com>
Cc:     johannes@sipsolutions.net, briannorris@chromium.org,
        kuba@kernel.org, matthewmwang@chromium.org,
        linux-wireless@vger.kernel.org, pinkperfect2021@gmail.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169263346489.572263.14522357496032655077.kvalo@kernel.org>
Date:   Mon, 21 Aug 2023 15:57:46 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Polaris Pi <pinkperfect2021@gmail.com> wrote:

> Add missed return in mwifiex_uap_queue_bridged_pkt() and
> mwifiex_process_rx_packet().
> 
> Fixes: 119585281617 ("wifi: mwifiex: Fix OOB and integer underflow when rx packets")
> Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
> Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

2785851c627f wifi: mwifiex: Fix missed return in oob checks failed path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230810083911.3725248-1-pinkperfect2021@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

