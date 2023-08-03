Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AED576E79C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 14:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjHCMDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 08:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHCMDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 08:03:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B54134
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 05:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34A856157A
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 12:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD121C433C7;
        Thu,  3 Aug 2023 12:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691064179;
        bh=I8UCYUZFyi+ibsXyJOB/KatTvPq/qE0LZRv7VjhfnOs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mUdNgzcE8MA+dPM0atYUsZvkjop8TR32QyEll8xM9P5tgzkU+QXyvl1ADEzWY7Alq
         CZc9GlZmDYMcQPmhwC2Sf5sMpQ0RlZE9RkPOVgmDieTL+9Y5JgI1GJdfQSh9X4J9i+
         7IwLnmNVcY6BVCs3QioYidKWUE7hLqUy3+8tFEnvsacCYwznnwfjOo+pey6GHd8TFf
         3kXRDHjhHe1xgnqzXXpZrghzjMN7OQgbbj72v4PiRhJUR3/uW+xNF+pocbEVl70vas
         y/WK4h6kVKdomor+MOMMiErgP2Nj7HBcxGDhcs1ucrzDTL5BHVCOQ/ppg7h8A7Y+I/
         GOioQNpDI79uw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: regd: update regulatory map to R64-R42
References: <20230803105430.6985-1-pkshih@realtek.com>
Date:   Thu, 03 Aug 2023 15:02:56 +0300
In-Reply-To: <20230803105430.6985-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Thu, 3 Aug 2023 18:54:30 +0800")
Message-ID: <87il9wtjtb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
>
> Update notes:

No need to have that sentence.

> sync Realtek Regulatory R42 and Realtek Channel Plan R64

R42 and R64 tells nothing to the community. A some kind of summary would
be nice.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
