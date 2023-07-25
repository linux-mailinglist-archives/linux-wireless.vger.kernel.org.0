Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABB7761D12
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjGYPOZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 11:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjGYPOV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 11:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C165122
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 08:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0038A6178D
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 15:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C7CC433C7;
        Tue, 25 Jul 2023 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690298059;
        bh=5NqUHN8POeHQ67s3sRPpkNi3XB3X9332FMvmg+r3OMM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Dga2iYxhJ0ZR/IOdNnOe38WSBXF+lRUWxOR0ao+XX0oOmqGiaURmFq5ixFql88Nnf
         ZHUwwtmTp8ZC+U/xjhrBg5q7mX50qCwaQ/wHPDJQdXj6oK9nnrmKkEjk6X7317U9uW
         w+BLNZsuoRRYRSoMnqnnaOtRh3Ai9i/Yo09IlcU1J+pk7qzKjwsMfW8cfmHXo1UVQs
         jHScanu7jviwTlDUqvg7RWxFRgyvjNnxFb9jH0bIl+Pazb0GBxBceWWgzasjuMUzmJ
         KI0P3NndgXcD2WTaNF2Ny8rNESe0Q27YEkUK/pJ4tzTTajpZ5e+eLcHsfSaYke5Ij6
         QdQI+PSLWszwA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] [v4] wifi: mwifiex: prefer strscpy() over strlcpy()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230629085115.180499-1-dmantipov@yandex.ru>
References: <20230629085115.180499-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169029805640.3309254.18133689044036043220.kvalo@kernel.org>
Date:   Tue, 25 Jul 2023 15:14:18 +0000 (UTC)
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

> Prefer 'strscpy()' over 'strlcpy()' in 'mwifiex_init_hw_fw()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

2 patches applied to wireless-next.git, thanks.

caf9ead2c7d0 wifi: mwifiex: prefer strscpy() over strlcpy()
dcce94b80a95 wifi: mwifiex: fix fortify warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230629085115.180499-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

