Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312EE782DD2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 18:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbjHUQGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 12:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjHUQGP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 12:06:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47744186;
        Mon, 21 Aug 2023 09:05:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF90C614B8;
        Mon, 21 Aug 2023 16:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292A1C433C7;
        Mon, 21 Aug 2023 16:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692633958;
        bh=DjEcc6PbcNIOqnCtc2X9VmSONvXMV/e+tgBh9dcI5CQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=XdDtHTOGTsx+gYtmiLfB3v2oIqXvq1btsiXqbPUxSrSMc88V/WOlt39ZyfB18DFQT
         roiN5nWNVF5DbaWYr2QGYudLZCyI1MgK50tPl/D0jWOA8Bw/M20+CUX3/o5zpKlfx6
         4OU8jDOu8yOv2BKb3UM/q9cGi2I5+XaDaTT6KbKxen7vEyG9RUrJEC9GwR1opUBlaS
         ubNe9mNhEJQwj3XwYOrPqHITLxMsg0Ny/7H5fJ4VDq3iFgftQshkS2HdbFu3xQ5k1D
         OCxAdtgrLAOsxi12oibhCCBZO/8ZfptEvqrg8BXh3n/R5ov5Qww03DYrYn1gDMF4wh
         9gHXf0h0Y+wcQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Timlee <timlee@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: fix a width vs precision bug
References: <0700c7b9-bfd3-4aa6-82bf-5bf3c74644e1@moroto.mountain>
        <63f8219b49604fc9805319c391ee44bf@realtek.com>
Date:   Mon, 21 Aug 2023 19:05:55 +0300
In-Reply-To: <63f8219b49604fc9805319c391ee44bf@realtek.com> (Ping-Ke Shih's
        message of "Tue, 8 Aug 2023 08:30:35 +0000")
Message-ID: <87wmxoidng.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

>> -----Original Message-----
>> From: Dan Carpenter <dan.carpenter@linaro.org>
>> Sent: Tuesday, August 8, 2023 1:36 PM
>> To: Timlee <timlee@realtek.com>
>> Cc: Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo
>> <kvalo@kernel.org>; linux-wireless@vger.kernel.org;
>> kernel-janitors@vger.kernel.org
>> Subject: [PATCH] wifi: rtw89: fix a width vs precision bug
>> 
>> The "buf" is skb->data that comes from the firmware.  We want to print
>> "len" number of bytes.  But there is a missing period so the "len"
>> variable is used for formatting (width) instead of limiting the output
>> (precision).
>> 
>> Fixes: cad2bd8a136c ("wifi: rtw89: support firmware log with formatted text")
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> Thanks for the fix. 
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Weird, Ping's reply didn't go to patchwork:

https://patchwork.kernel.org/project/linux-wireless/patch/0700c7b9-bfd3-4aa6-82bf-5bf3c74644e1@moroto.mountain/

But I do see it on the list:

https://lore.kernel.org/all/63f8219b49604fc9805319c391ee44bf@realtek.com/

Crossing fingers that this was just a random anomaly in patchwork and
it's not losing more email.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
