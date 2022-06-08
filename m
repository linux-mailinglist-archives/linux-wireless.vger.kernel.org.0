Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39088542935
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiFHISA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 04:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiFHIQS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:16:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9316A51D
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 00:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DA59B81B34
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 07:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8012AC34116;
        Wed,  8 Jun 2022 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654674315;
        bh=kNELa0h/Et3bEDHoAASKJNwjXuAyfY+mJwRl/Z22E0o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=sTXfWZPNE+nLcnCy1JNXuoRi7aBmSAXe1OWlBPuTKnOvhVi1vNFa1KtVhVdaAR2y0
         U/yp74I3+5m6pZcB5oky1D9noylYbVXp/X9WvX8vL0ZtVaz2vg3igaBB28u388wKCg
         Nw4noum9IXLmT54P3cXyamYO1nfj1gE4LRICPkCpB7VXeWoPMG1tVxrhdaZzHSBq7g
         tNDwE+UQqCAHlOnik69nDxZOlDBqcqZy3rfmwmLPFxnwoE9LtQuxY6cZ+jqcUEQF+S
         XgMi03AVVQzPk0sJBjvt3RmzUIDB2pBJsexiy2R36OGPKkxYN0TRfx6UwYd3O3Vt+S
         l5Xcep9qgYwiQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
References: <20220524153716.20450-1-Larry.Finger@lwfinger.net>
        <Yp+hfo5Uual8ZUkR@dev-arch.thelio-3990X>
        <e28ce50b-c1e6-74ae-6f57-5f864ba0c93a@lwfinger.net>
        <45a6b6ea84c74ffeafff1b68c2e1c5e3@realtek.com>
        <aad47f4f-a5bc-e8e2-15d3-2baf2512b661@lwfinger.net>
        <764fc8f115dc411e82938311273d9b51@realtek.com>
Date:   Wed, 08 Jun 2022 10:45:12 +0300
In-Reply-To: <764fc8f115dc411e82938311273d9b51@realtek.com> (Ping-Ke Shih's
        message of "Wed, 8 Jun 2022 01:10:12 +0000")
Message-ID: <87bkv3r43b.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
>> From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry Finger
>> Sent: Wednesday, June 8, 2022 9:03 AM
>> To: Ping-Ke Shih <pkshih@realtek.com>; Nathan Chancellor <nathan@kernel.org>
>> Cc: Kalle Valo <kvalo@kernel.org>; Johannes Berg <johannes@sipsolutions.net>;
>> linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
>> 
>> On 6/7/22 19:25, Ping-Ke Shih wrote:
>> >
>> >
>> > Hi Larry,
>> >
>> > How about keeping rtw8821c_hw_spec const, but move ch_param[3] from
>> > 'struct rtw_chip_info' to 'struct rtw_hal'?
>> >
>> > If you agree this, I can prepare a patch.
>> >
>> 
>> If that fixes the crashes, that is fine with me. The other 3 devices will need
>> the same fix.
>> 
>
> The ch_param[3] is only used by 8821c, so it doesn't affect other devices.
> I will prepare a patch to fix it.

But why didn't the compiler catch this? Is there some evil cast
somewhere which removes the const? We should fix that as well (in a
separate patch).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
