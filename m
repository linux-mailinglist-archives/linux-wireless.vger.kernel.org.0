Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D08662926
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 15:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjAIOzn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 09:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAIOzi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 09:55:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935C0D53
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 06:55:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48BF0B80DFD
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 14:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FCBC433F0;
        Mon,  9 Jan 2023 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673276134;
        bh=NW7yo89rJfyNvfdSVQITonIS5Fm1TxvlFiB+mP7asfc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kq3nEbU3SKEhhOZSUFCL36MzlqbOD7eqZ8fjzJpybgeraGsUmqXAFyZAfefD7U63v
         TLKJjcNhx0iNH9GHccE+ycxaYK7R/D/49HltxifMLyKbIkhp4O/Yt2sj1svwWXkmoq
         1VSDyh5adR7xrH8gfWjAr3ECtdgQlkbmPCSoFb77ODYuLUemWpdOVHp5tGSzHzGD13
         KMRA/BZYPIsXx7O/3hT4dkN+duK5iWY4r36PmI0UbMFY+9LEgSwV1iYLGI6lk3jSyD
         UMR83VtXn9kiuxqTxCdTlIt26qNMDcKn0cP8mOn3Pryp79I7VJ2A6ubJJvkTkvkB4F
         oX1IIVMCPRLqw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jaewan Kim <jaewan@google.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] iw: info: fix bug reading preambles and bandwidths
References: <20221220134733.2309329-1-jaewan@google.com>
        <20221227010034.1399587-1-jaewan@google.com>
Date:   Mon, 09 Jan 2023 16:55:32 +0200
In-Reply-To: <20221227010034.1399587-1-jaewan@google.com> (Jaewan Kim's
        message of "Tue, 27 Dec 2022 10:00:34 +0900")
Message-ID: <87tu0zhi57.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jaewan Kim <jaewan@google.com> writes:

> Preambles and bandwidths values are considered as bit shifts
> when they're are used for capabilities.
>
> Signed-off-by: Jaewan Kim <jaewan@google.com>
> Reviewed-by: Kalle Valo <kvalo@kernel.org>

I didn't provide you a Reviewed-by tag[1] during my review, please don't
create such tags yourself. For example, in this case I didn't review the
patch in detail so I'm not comfortable giving you my Reviewed-by tag.

The general idea is that you only copy paste the tag when someone gives
you one, you don't create them on your own. I think Reported-by is only
exception but there might be others.

[1] https://lore.kernel.org/linux-wireless/87ili3kfdr.fsf@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
