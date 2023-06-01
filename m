Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0B7192AE
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 07:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjFAFsb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 01:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjFAFrl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 01:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D015193
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 22:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28EF66410B
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 05:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FCCC433EF;
        Thu,  1 Jun 2023 05:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685598400;
        bh=XWzczwSVD81gIENTfEhJ4epaujBLX/EjJGMZiLS1eJ0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ex8oWCDtVzR6fdxs3TkWYUA6TdR0kDrTNt+speRSf0rKIXqYPn3dZeMcBT71qs3rz
         9SA5XadAMgI55S37eCOVa46WiIJdAuISmOVta+l+tz6KyzmivtyFao9x2xhW6z5pa2
         Kj3WqRd8qoEKqwgJISDo3zLeAp5gTPKNmgKQ7C6ISr9pEqjDv1GWa5OGgWW2kHOv6v
         w7CBKbPYCe1cxgpIEm05z2wonhNYHAee3suBIhIUmYLUWttUq2Z0WDpv10f/5x9FUf
         NL7xP65tSfoxduXTGxC7i2eds8KRV1Z1MObAZ+rjv+Zix9NannXedaA1lePHR3dxYZ
         JsgKJlrI2R3ew==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Dmitriy Antipov <Dmitriy.Antipov@softline.com>
Subject: Re: [PATCH] wifi: rtlwifi: remove unused timer and related code
References: <20230531143001.674220-1-dmantipov@yandex.ru>
        <20230601042352.7746-1-dmantipov@yandex.ru>
        <6c9982b9f48e41c4ba4f3528cb5489fd@realtek.com>
Date:   Thu, 01 Jun 2023 08:46:34 +0300
In-Reply-To: <6c9982b9f48e41c4ba4f3528cb5489fd@realtek.com> (Ping-Ke Shih's
        message of "Thu, 1 Jun 2023 05:10:36 +0000")
Message-ID: <87leh3ka4l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Dmitry Antipov <dmantipov@yandex.ru>
>> Sent: Thursday, June 1, 2023 12:24 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
>> Dmitry Antipov <dmantipov@yandex.ru>;
>> Dmitriy Antipov <Dmitriy.Antipov@softline.com>
>> Subject: [PATCH] wifi: rtlwifi: remove unused timer and related code
>
> Should increase version number such as v2, v3, ... for newer one.

And also always include a changelog, see the wiki link below for more.

> Checkpatch warns this patch:
>
> 	ERROR: Missing Signed-off-by: line by nominal patch author
> 'Dmitry Antipov <dmantipov@yandex.ru>'

Yeah, From and s-o-b need to always match.

> Maybe, you can adjust your s-o-b to e-mail address of "From".

It's also possible to add a second From field to the body of the
message. Here's an example how I do it when I use kernel.org to submit
my patches:

https://patchwork.kernel.org/project/linux-wireless/patch/20230530141813.29333-3-kvalo@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
