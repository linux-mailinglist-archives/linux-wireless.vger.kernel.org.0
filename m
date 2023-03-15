Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445096BACB4
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 10:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjCOJyS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 05:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjCOJxz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 05:53:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B796C84813
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 02:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48518B81D76
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 09:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CDBC4339C;
        Wed, 15 Mar 2023 09:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678873946;
        bh=gO+kNcJP06bGchN0aij4JahzdlMVCCLyrmTU5rQ5xUM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MxYg+sOyzpeSVSbQfy58BDVzz2mkbbNkRNJNakFMkShLjE6k/+LjLDDpYL+3wworI
         HBj2wrcnVa5pzzPGJYXqXN+kUMrEKqdJ/gJOZ7Q9bztWiXf9/57O5EtQ2kiyj8fn/q
         yEfSP4OcGuCU5eG2yeOxR3CNMRhWmgy2yNFMp9EbkLW38LzRX5WRzhPQpcMJcXRCmk
         ZzS3HRHKkd1D2rxVRLiuxSxVGbxqZDKcr3BbkufjBPJIZYzXcJNIVb/XA3yGgk4fci
         Kkv7jP/9D2qK9nC4spfigaJX/K1ibo18FdxkTt2GnUPs3FwPyznvGisGYF0rYWvb+T
         +0pZQkoRi7tfw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: add counters of register-based H2C/C2H
References: <20230310035943.49020-1-pkshih@realtek.com>
Date:   Wed, 15 Mar 2023 11:52:22 +0200
In-Reply-To: <20230310035943.49020-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 10 Mar 2023 11:59:43 +0800")
Message-ID: <87r0tqmje1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> The register-based H2C/C2H are used to exchange information between driver
> and firmware, but only apply to narrow area because its data size is
> smaller than regular packet-based H2C/C2H.
>
> This kind of H2C/C2H must be paired. To identify if any H2C/C2H is missing,
> update counters to help diagnose this kind of problems.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static inline void
> +rtw89_write8_mask_add(struct rtw89_dev *rtwdev, u32 addr, u32 mask, u8 add)
> +{
> +	u32 shift;
> +	u8 orig, set;
> +	u8 data;
> +
> +	mask &= 0xff;
> +	shift = __ffs(mask);
> +
> +	orig = rtw89_read8(rtwdev, addr);
> +	data = ((orig & mask) >> shift) + add;
> +	set = (orig & ~mask) | ((data << shift) & mask);
> +	rtw89_write8(rtwdev, addr, set);
> +}

This function has a lot of shifting etc which feels like reinventing the
wheel, doesn't linux/bitfield.h contain what you need? For example,
u32_get_bits() and u32_replace_bits()?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
