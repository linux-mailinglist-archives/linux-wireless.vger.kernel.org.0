Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736B15AA9DF
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbiIBIYD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiIBIX7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:23:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D4B81C1
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 144E3B82A04
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016A3C43470;
        Fri,  2 Sep 2022 08:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107035;
        bh=ZxwIABXHG3W5neEFouxFE/vUwK95y6d/jEK+Z7OjlIA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KdnWlryag0rRKZZFErDlGggGxPrBPjVK/MAdXbibb0fQQ8ZleIdkQe6Oq2ZI1q25k
         afQWzL1kkGtdS1g6cj/C3N2ODkZTFT5Pk/khHisHeSWBNM39Nhy6LFlWHDN7LcSSUL
         EDP8nr9Ha8FH4fsBoMYcgI+oD8vghffXgTG5ZsFNYViLessKWTma1oBK2ge1cvhj6u
         1X5b/EbrtzIjXkFpqYGy9/dUz15wyCmJ49bwloBmvcjnKIr+PokKKHLcksx1AICtSy
         cFZkiEIl2MXXc9P+q7zQ7yXRJICT+JZt/q7Z+b2b9EMFUeosZoKbLc08WTvabJuKq3
         u+nrjlM3JW2/w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 13/13] wifi: rtw89: early recognize FW feature to decide if chanctx
References: <20220809104952.61355-1-pkshih@realtek.com>
        <20220809104952.61355-14-pkshih@realtek.com>
Date:   Fri, 02 Sep 2022 11:23:51 +0300
In-Reply-To: <20220809104952.61355-14-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Tue, 9 Aug 2022 18:49:52 +0800")
Message-ID: <87pmgeb2w8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
>
> In current flow, FW is asynchronously loaded after alloc_hw(). It defers
> the decision on FW feature map. It makes things difficult for us to decide
> whether to hook chanctx ops, which should be decided while alloc_hw() is
> calling. Still, asynchronous gets its advantages. So, we want to resolve
> this without dropping them.
>
> Based on multi-FW flag, RTW89_MFW_SIG, we can determine runtime FW is
> multi-FW (MFW) or single FW (SFW). Both of them have a quite small chunk
> for header at the head. The difference is that MFW doesn't describe version
> code in its header while SFW does. So, we plan to extend MFW header for
> version code. After that, in both cases, we can determine FW feature map by
> just FW header. And, according to the map, we can decide chanctx.
>
> So, we call request_partial_firmware_into_buf() to request a quite small
> chunk before alloc_hw() to get a early FW feature map without affecting
> things much and only use early map to decide whether to hook chanctx ops.
>
> It means that if non-extended MFW is used at runtime, driver just acts
> without chanctx as before. If extended MFW or SFW, which supports required
> FW features, is used at runtime, driver can hook chanctx ops to mac80211 if
> chip has configured support_chanctx_num > 0.
>
> Besides, key point for now to support single one chanctx is whether HW scan
> is supported at runtime. So, we configure all chip's support_chanctx_num to
> 1, and check if HW scan is supported at runtime via early FW feature map.
>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +	ver_code = buf.mfw_hdr.sig != RTW89_MFW_SIG ?
> +		   RTW89_FW_HDR_VER_CODE(&buf.fw_hdr) :
> +		   RTW89_MFW_HDR_VER_CODE(&buf.mfw_hdr);

Nitpicking, but in this case a proper if statement is preferred over a
'?' operator. You only save one line with the latter.

if (buf.mfw_hdr.sig != RTW89_MFW_SIG)
        ver_code = RTW89_FW_HDR_VER_CODE(&buf.fw_hdr);
else
        ver_code = RTW89_MFW_HDR_VER_CODE(&buf.mfw_hdr);

But no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
