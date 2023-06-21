Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1AC738E28
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjFUSHt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFUSHs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 14:07:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91A0A2
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 11:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E51E61668
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 18:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC770C433C0;
        Wed, 21 Jun 2023 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687370866;
        bh=zgbAhxQ/qSYRlMK08UUKHcB5Wdd1tBSaVQuJQ3yayWw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=B0OADtsafxKwpsglLixabHIZIaQDw5l87BpiTMjfCmKAX+mL2kXC95gCvdyBOnX9B
         ksKsXbuk3q9DS6ryuI702QxAE69GEsupExkjSj+6QZIh+UBFKfybfjtC1Sky55PqDy
         J8fdwvykJJiY6x2naA+sE4tGwpx78BYlbeX0Nysq/XNnvUEEjI5OYn9enosJ9oMNz0
         QIMm3IOmtb3aGMknX3+6XJRuOEpO87vK821sblzREZBqCiWgWzh3WJBRHq8KnWiHvm
         ahbsGi7wawLulx+LmONjbUsGjsXV5AyPoua3P/s4fVLO5cj+0Vgum/sJhLpV4lR5/X
         C6zKp+L2zrwXA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath9k: convert msecs to jiffies where needed
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230613134655.248728-1-dmantipov@yandex.ru>
References: <20230613134655.248728-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168737085986.871827.2294633918349244368.kvalo@kernel.org>
Date:   Wed, 21 Jun 2023 18:07:45 +0000 (UTC)
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

> Since 'ieee80211_queue_delayed_work()' expects timeout in
> jiffies and not milliseconds, 'msecs_to_jiffies()' should
> be used in 'ath_restart_work()' and '__ath9k_flush()'.
> 
> Fixes: d63ffc45c5d3 ("ath9k: rename tx_complete_work to hw_check_work")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2aa083acea9f wifi: ath9k: convert msecs to jiffies where needed

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230613134655.248728-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

