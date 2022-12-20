Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26BE651A35
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 06:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiLTFWG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 00:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiLTFWE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 00:22:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0AE98
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 21:22:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4134B811A0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 05:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97459C433D2;
        Tue, 20 Dec 2022 05:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671513720;
        bh=UWGvh2JUZ0jx1HU4zNMWvYvYZFGyAGXD3NbJ52DBNpM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=S/GuIsI5d4UjVdwLSKXSKbYlbB3JhxI/GeoZIsEtPPqsxAn3UP8/89q9I4vMV83II
         h8qkodCmjdaoPeWEdvpADH/jRSlWoynOqosO9pA1AOyFV2H1Or45YCgRzC5h9H+mny
         YZ78jDyaVjuVa+qztwyFFpuVm6SxHWHlSKBqkG5np9tMtchZ7QFJrabgyI7ECQnI5j
         C5VGH0JmRwgFTEN0R8bolIkrjVkeNx00vdSBkIBSd5SpU4TPItwOEjzY9monhyoTFw
         SjmtaPU9fSI2bg2U3w9eLYwwT54ZlZRxMxpAbAjqxF+Idpa+JyfjKqJb2SyYysd6/l
         qfz2RqsXat2fA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] ath9k: remove most hidden macro dependencies on ah
References: <c8369317-cf84-f0e3-fe8-9b6e22e43a6a@ucalgary.ca>
        <87v8mcd7kh.fsf@toke.dk>
        <df8c4daf-7bec-a877-285a-4f690fdc87c@ucalgary.ca>
Date:   Tue, 20 Dec 2022 07:21:55 +0200
In-Reply-To: <df8c4daf-7bec-a877-285a-4f690fdc87c@ucalgary.ca> (Wenli Looi's
        message of "Mon, 19 Dec 2022 11:12:59 -0800 (PST)")
Message-ID: <87sfhak5u4.fsf@kernel.org>
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

Wenli Looi <wlooi@ucalgary.ca> writes:

> One thing I just noticed is that when compiling with CONFIG_ATH_DEBUG, 
> there is one slight difference in the binary because of this change:
>
> -			"Timeout while waiting for nf to load: AR_PHY_AGC_CONTROL=0x%x\n",
> -			REG_READ(ah, AR_PHY_AGC_CONTROL));
> +			"Timeout while waiting for nf to load: AR_PHY_AGC_CONTROL(ah)=0x%x\n",
> +			REG_READ(ah, AR_PHY_AGC_CONTROL(ah)));

Good catch, I can remove the "(ah)" from the string in the pending
branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
