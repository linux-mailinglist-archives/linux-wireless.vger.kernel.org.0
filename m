Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444B1785681
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 13:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjHWLL4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 07:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjHWLLz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 07:11:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9A3CEF
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 04:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A5E262707
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 11:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF7EC433C8;
        Wed, 23 Aug 2023 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692789112;
        bh=8vHk0tpRBR5bgIX0w5RaScu5RRfiXsdFyM2JjEzp3Nw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dVOypVtzaqNpEQcZpvvBpqhuElqYok07B6vaBJhgB3DtVKujUJ4EnM4v5aF2R/pkO
         wmVepaAWX7VHEHFt9AWaVpAoFpmpTFxVh2ovRalKekNjz6992pD8OGSp2lhEMcqYpr
         q72UOxm7c1BYh/icFcUTdkbkO9yt7bINeUIYAwCCNBP571UIBp+E2lmED3aQ1+wsaK
         FFoaPJauMRtTsD3fh/06UZWlRbLyZUzZRAlXzlZTQHaPmCvNhytLQ3uqWGFFBqHddM
         RpiBsms/q9DY0VCDeB/FwKj7TQ/xarnTULvyaMCDnKluKbS0qEyax/0UbQX2H7gL6c
         OwAfhPEK4icCg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] [v2] wifi: mwifiex: avoid possible NULL skb pointer
 dereference
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230814095041.16416-1-dmantipov@yandex.ru>
References: <20230814095041.16416-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169278910933.1133515.16503452502996769734.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 11:11:51 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'mwifiex_handle_uap_rx_forward()', always check the value
> returned by 'skb_copy()' to avoid potential NULL pointer
> dereference in 'mwifiex_uap_queue_bridged_pkt()', and drop
> original skb in case of copying failure.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 838e4f449297 ("mwifiex: improve uAP RX handling")
> Acked-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Patch applied to wireless-next.git, thanks.

35a7a1ce7c7d wifi: mwifiex: avoid possible NULL skb pointer dereference

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230814095041.16416-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

