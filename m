Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C4B522B58
	for <lists+linux-wireless@lfdr.de>; Wed, 11 May 2022 06:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiEKElf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 May 2022 00:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242019AbiEKEkT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 May 2022 00:40:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C415BAD6
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 21:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3807CB8211C
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 04:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8BDC385A7;
        Wed, 11 May 2022 04:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652244003;
        bh=ZS/fAwcrCpXQBVPFHmf6V/Lj76XhjZet9YsIxiLTpck=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CMh7Iojp4GupU+fei2sKdsiAzvVX3oSveAZ4KMM+LbC5w+bxqxaEhGdJEuSmmKI93
         XnZ2MpNcx55mIo03vd2Hu0jdzXOcPQ6a5XpQKbLB7m/z+DkKLIOI589Nq2XmaurXp8
         TpdtkK4McAfL9o251gIjwW/OlRjVl5OG+wgoC6U9WZaPl9NQDW17blgH9Xx3QM2qZe
         BrMjKaOmkVdnHAbksCW4HGOjxHpiVNuPTc412XCj7vvFIVV1AN9aeBrLa35swtXZlG
         U7RBHNBq09Yd0RUZolr7YKTSTzeaRIK6XpSdgyp1XyGUnWY9zReEnbZ1EDWIZP2104
         k9llMjI22YSyA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/9] ath9k: add support for QCN550x
References: <20220418071313.882179-1-wlooi@ucalgary.ca>
        <CAKe_nd1-twgutVV8Ls_7Y=q8o6ua9_W9x6q_HvevWsv3uwnh5Q@mail.gmail.com>
Date:   Wed, 11 May 2022 07:39:58 +0300
In-Reply-To: <CAKe_nd1-twgutVV8Ls_7Y=q8o6ua9_W9x6q_HvevWsv3uwnh5Q@mail.gmail.com>
        (Wenli Looi's message of "Tue, 10 May 2022 11:39:11 -0700")
Message-ID: <87lev8y95t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> Thanks Kalle for the comments.
>
> Please let me know if I should resend the patch with the minor changes
> or if there are additional comments.

The patchset is set to 'Changes Requested' in patchwork:

https://patchwork.kernel.org/project/linux-wireless/list/?series=632942&state=*&order=date

This means you need to submit v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
