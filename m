Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1148F7C6DC9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 14:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347211AbjJLMRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 08:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343908AbjJLMRB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 08:17:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D2B7
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 05:17:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A85C433C7;
        Thu, 12 Oct 2023 12:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697113020;
        bh=un9r1J+wb3IxjUD97AY6S9Fr1vVQfxEvKE/st9YxWPM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BJwwO9/oRy/HlpUsoJ6yYdYQ3FS6LZt7Kaq0jNuyltm0kP1CyRcWnW7tCZQXylWdk
         HDQUbO5braRIcfMDcFMfoE5cedErBDwdILGJ8JGhHOJpzNNGbGxL+Fs+Sd0oU7xxu1
         6RWtEtPd4anaB9PTflu/3DvirWssBHro3MX1UFi6WKod53YxZflYqV+wzMN49AZI0U
         J+KaXsikahzUxrmUwxyqWp87iZa/RWkAXbv7tgOAK1qie6SpCNo3/doNd0W2b6RAKK
         krHXYopxNmibK5xbFMSGZxG+/7VJjWxks1K07kUjwx9ZNOVkjDYbvEfGYcz22A//ke
         hAuZib8bS7m9w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: coex: add annotation __counted_by() for
 struct rtw89_btc_btf_set_slot_table
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231011063725.25276-1-pkshih@realtek.com>
References: <20231011063725.25276-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <keescook@chromium.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169711301771.2932680.1214330921072528204.kvalo@kernel.org>
Date:   Thu, 12 Oct 2023 12:16:59 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Use struct_size() and flex_array_size() helpers to calculate proper sizes
> for allocation and memcpy().
> 
> Don't change logic at all, and result is identical as before.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

2 patches applied to wireless-next.git, thanks.

07202dc12b53 wifi: rtw89: coex: add annotation __counted_by() for struct rtw89_btc_btf_set_slot_table
618071ae0f7e wifi: rtw89: coex: add annotation __counted_by() to struct rtw89_btc_btf_set_mon_reg

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231011063725.25276-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

