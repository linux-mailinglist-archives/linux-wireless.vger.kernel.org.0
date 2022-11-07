Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8A661F33E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 13:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiKGMaj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 07:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiKGM27 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 07:28:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119E160EC
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 04:28:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0B7F61019
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 12:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A70C433B5;
        Mon,  7 Nov 2022 12:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667824136;
        bh=mQKv/pwV9ps17DU1KAbpzLy+iOIcLm1QLMufHtZgmJA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iOXQcZ/fqwVHchViY01v39Wbg2VJSkWVUq5nnARpRL6zaYmaeLTy+ziEeetOicqcv
         3w285P4DnP1OWcj74WprHbNgaV2V/p2B7gycsI59O+Zq4J7O2L1I/veAE6o9baz+Yr
         BCOBre5W0+LuK711pIpamMktZnf68FvgEAhoM6oVC/CeqIjLOG/BdC/bHMHiL+2ljy
         h3orFHAG/xBrvQ0uTLxS+aBmxTWckGwniLJEa17FYHyXI3e1RuYY/czMbmx1YBylk9
         mYm1EIBYb5+6XevZ41cVIv3aRBTtB53LXIa8NtX+mgowJThW6EASpcoQgkTU1kwPvW
         icZlA1v4XSExw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: use FIELD_PREP to fill MAC quota value
References: <20221103072420.15161-1-pkshih@realtek.com>
Date:   Mon, 07 Nov 2022 14:28:47 +0200
In-Reply-To: <20221103072420.15161-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Thu, 3 Nov 2022 15:24:20 +0800")
Message-ID: <87zgd3t0cg.fsf@kernel.org>
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

> Coverity reported shift 16 bits could cause sign extension and might get
> an unexpected value. Since the input values are predefined and no this
> kind of case, original code is safe so far. But, still changing them to
> use FIELD_PREP() will be more clear and prevent mistakes in the future.
>
> The original message of Coverity is:
>   Suspicious implicit sign extension: "max_cfg->cma0_dma" with type "u16"
>   (16 bits, unsigned) is promoted in "max_cfg->cma0_dma << 16" to type
>   "int" (32 bits, signed), then sign-extended to type "unsigned long"
>   (64 bits, unsigned).  If "max_cfg->cma0_dma << 16" is greater than
>   0x7FFFFFFF, the upper bits of the result will all be 1."
>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527095 ("Integer handling issues")
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/mac.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index bb49033b587d2..11081dfdfb172 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -1487,10 +1487,8 @@ static int dle_mix_cfg(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg
>  #define INVALID_QT_WCPU U16_MAX
>  #define SET_QUOTA_VAL(_min_x, _max_x, _module, _idx)			\
>  	do {								\
> -		val = ((_min_x) &					\
> -		       B_AX_ ## _module ## _MIN_SIZE_MASK) |		\
> -		      (((_max_x) << 16) &				\
> -		       B_AX_ ## _module ## _MAX_SIZE_MASK);		\
> +		val = FIELD_PREP(B_AX_ ## _module ## _MIN_SIZE_MASK, _min_x) | \
> +		      FIELD_PREP(B_AX_ ## _module ## _MAX_SIZE_MASK, _max_x);  \

BTW in wireless nowadays the preference is to use u32_encode_bits() & co
instead of FIELD_PREP(). Not an issue for this patch, just wanted to
mention anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
