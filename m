Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6844F7BF2E5
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 08:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442242AbjJJGUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 02:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442239AbjJJGUH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 02:20:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF119F
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 23:20:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D082C433C8;
        Tue, 10 Oct 2023 06:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696918805;
        bh=tEjb3tygbFrbzwTr8nuR+/GyWE+EBX9oxbRMtyI4isg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eEtxA/f3QPLOm8FqpLsUBxXmW8LXPeo6qF9nTb01MBH6cowfID3Ykvlz7Xv+eDmJH
         Hdr4DqL8wbglsQ8Gb6Jg6IsijsZbdhrbvx46pZ3TJCKnpkb4FjkuMNLmdjxVdPeNh4
         BDeuFx1RM6AAMWvh4idvUFN2kS5PXbM55iPCnK3Qv6fUGJmBCTkQG+EvN4r1Zh/Xv5
         1p5KGn5d5BdOsHGUoCDtsMUzBH1vHiaM+S3ysNgGBzLssq3m6TckOejM5jUYqfqa5U
         aPdWDdCnR0bXWHfxZGHjfKf6JJsLw9zqP1erSwu5JQKg3ZKGhgZKGlIqVsLUSPb/jk
         8OENSgSuOp24g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] wifi: radiotap: add bandwidth definition of EHT
 U-SIG
References: <20231010021006.6061-1-pkshih@realtek.com>
        <20231010021006.6061-6-pkshih@realtek.com>
Date:   Tue, 10 Oct 2023 09:20:03 +0300
In-Reply-To: <20231010021006.6061-6-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Tue, 10 Oct 2023 10:10:05 +0800")
Message-ID: <8734yj578s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

> Define EHT U-SIG bandwidth used by radiotap according to Table 36-28
> "U-SIG field of an EHT MU PPDU" in 802.11be (D3.0).
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2:
>   - correct commit message about the source of bandwidth definition
>     of EHT U-SIG suggested by Johannes
> ---
>  include/net/ieee80211_radiotap.h | 6 ++++++
>  1 file changed, 6 insertions(+)

This is nitpicking but in general it's good to have the patches touching
files outside of drivers/net/wireless in the beginning of the patchset
to make them more visible. No need to resend because of this, just a
small tip.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
