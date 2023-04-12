Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFFF6DF59F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 14:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjDLMka (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 08:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjDLMk3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 08:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CA77DA8
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 05:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D47962CCC
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 12:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AC3C433D2;
        Wed, 12 Apr 2023 12:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681303187;
        bh=aBO6ou2uAYpOj2bIXuQpKgI3Z9n091YBEG1E1JTgS8o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CXzA9KY8v/V8KkVQcpz0iBZVLQauiZNibT6eU2UvTJdoBsM3eBUpgouqh8Pkvl/WF
         gM/LXzH2kqAVCr4A5WhRV41aB6fZ1PeBIx+rNmR0LN4kKO/y3nioHBs5ECXsDO6zYo
         SETIFKJznhbM48tOg2oPfVEx2IWVt1WSJPcD/IQH6pTUN5V0gvKOCmXwHDyAGEG+JF
         0PFzKwUpA1HJqNagMqEq7jDjwdQOxHt8K75RVZUKoYBZ+A1LTixX4/p6RwMmF1jSvU
         Rto5wIcE5Be3nCROXu12jDtv+8f+A0OH+UQHy+UNIzj99fA6wUSNf6mGZ6jVtY7Gqy
         AjBw2Z7HR6DSg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 4/7] wifi: rtw88: disallow scan and PS during AP mode
References: <20230401124410.33221-1-pkshih@realtek.com>
        <20230401124410.33221-5-pkshih@realtek.com>
Date:   Wed, 12 Apr 2023 15:39:44 +0300
In-Reply-To: <20230401124410.33221-5-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Sat, 1 Apr 2023 20:44:07 +0800")
Message-ID: <877cuh8eb3.fsf@kernel.org>
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

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Po-Hao Huang <phhuang@realtek.com>
>
> During concurrent operation, the VIF sharing same channel with AP mode
> might scan. Reject those scan requests from driver when there's AP
> currently operating. Also, disallow entering power saving mode.
>
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

How is a station interface useful if it cannot scan at all? IMHO quite
hard limitation.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
