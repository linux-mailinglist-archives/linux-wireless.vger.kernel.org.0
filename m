Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A384675EE65
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjGXIyQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 04:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjGXIyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 04:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86658E3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 01:54:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23F7F60F14
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 08:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E36C433C7;
        Mon, 24 Jul 2023 08:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690188852;
        bh=+BM74+Fz5d1PX0nu6qHKRZHh4FDuj1PbHqsKjMC2FPc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ccGm22+8gcQlbOMXmommE66ASk5iGRxJTEszTdOkj0aW/PIMBO2/nUb7AZXyKqQbF
         oKwLpI7SroaKgr5aK0vVFauzPbTDV6+0AauAv3cks0c8q3thAdPs9iEEwl5/ItqY9D
         Pxm9IRv1mtztvue3SjbGqonntedA2jQFyE2xmVoIr0ufXjV8bQOeFmvuG13aXHyv4k
         vLQw1asfRfTnAo06JOxZ3MHQHmnQUD3oqDctptL53TSbf1DVuBi2yyjQA/sCVbeuT6
         ckYCEufffDQOALK4YBrK0AJm+BiOeeSO/hsgQ8IsFdCq+VN5MBoMHifV2/kzqM5e6Y
         qzp9+eN2jxiUw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Doug Brown <doug@schmorgal.com>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/4] wifi: libertas: add missing calls to
 cancel_work_sync()
References: <20230724084457.64995-1-dmantipov@yandex.ru>
Date:   Mon, 24 Jul 2023 11:54:09 +0300
In-Reply-To: <20230724084457.64995-1-dmantipov@yandex.ru> (Dmitry Antipov's
        message of "Mon, 24 Jul 2023 11:44:40 +0300")
Message-ID: <87cz0h3d1q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Add missing 'cancel_work_sync()' in 'if_sdio_remove()'
> and on error handling path in 'if_sdio_probe()'.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

How have you tested these patches?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
