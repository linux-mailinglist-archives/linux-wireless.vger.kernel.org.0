Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A806B523004
	for <lists+linux-wireless@lfdr.de>; Wed, 11 May 2022 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiEKJzz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 May 2022 05:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbiEKJy6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 May 2022 05:54:58 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA1C16A253
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 02:54:40 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1652262879; bh=VKWCcJLOHT41GgeUdbBcTcp8vWh2RnSvUPQ0RMYQq6A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Rnod7s8cmguUZ5Y+gbmtqiN522x1ksuW0pM39bynqJ6QiuS00KWSiB+NfliU3VGjF
         cNKaiQMtigfsrhlAtp7LECgYoRmHGzvja7oNfygTtC8sMq//B5n9ZWVwS5J8s3AyBC
         lTk+aoFH3FXjlhlncyAs7xPNsFuMR/dDX5zG7LC/+qBW7CCOW20hFxtPbA78DlgSCo
         f2K5++dpnuFhYxTCpXkgc2ZX57mr4VZZbRtO47eZG3ZjyGqyFe1gmV6QORY6Nql+Pq
         sP2mSrcWRLmN29EydHmfODBfYcl7igA9ixQo7dxddA2aupvIVaxlE0Mvu7EVVlo8X6
         /BF33X6imu/bw==
To:     Kalle Valo <kvalo@kernel.org>, Wenli Looi <wlooi@ucalgary.ca>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/9] ath9k: add support for QCN550x
In-Reply-To: <87lev8y95t.fsf@kernel.org>
References: <20220418071313.882179-1-wlooi@ucalgary.ca>
 <CAKe_nd1-twgutVV8Ls_7Y=q8o6ua9_W9x6q_HvevWsv3uwnh5Q@mail.gmail.com>
 <87lev8y95t.fsf@kernel.org>
Date:   Wed, 11 May 2022 11:54:39 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87lev8wg0w.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Wenli Looi <wlooi@ucalgary.ca> writes:
>
>> Thanks Kalle for the comments.
>>
>> Please let me know if I should resend the patch with the minor changes
>> or if there are additional comments.
>
> The patchset is set to 'Changes Requested' in patchwork:
>
> https://patchwork.kernel.org/project/linux-wireless/list/?series=632942&state=*&order=date
>
> This means you need to submit v2.

Yes, please resubmit with Kalle's comments addressed :)

-Toke
