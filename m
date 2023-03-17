Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3486BE1D1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 08:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCQHR6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 03:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQHR5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 03:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B24328E92
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 00:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 211B662189
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 07:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BE3C433D2;
        Fri, 17 Mar 2023 07:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679037475;
        bh=35OonuczJTpDoxcEnTiZvFgoLKy1Mu3hknB/pMK1cFU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YGOkBu47JJ6prcYymZP3QVn0p4A7Jf/tfWqrV4LvV9rRUkCXQlHgam7y3/ZlRqt50
         mLX40B5XcIHJ/dxIHWaqX0gYY8ktDN5k2qaCaLS0spzRuL8CIuxpONvixtNVXOxhWu
         kptuKPOrtqA/mUvNr+EfNJfPbsmV3+pG546/Kv+sypqGym6T2eOevgc77dDziebzHz
         3yFhYNSKkpqnfl+vCWuSxJ49eu/UPdJ80KQLQYcgtzMLgsGCjVi14qhG5Sl8pcv2BR
         aXlP7QyTyon3CRiNq3IV6kavX90bftNs/pGeEHWoUm5nbpQnkEC/rsyOUH6b+PvcnP
         MSYWAPo1D9BOQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: add counters of register-based H2C/C2H
References: <20230310035943.49020-1-pkshih@realtek.com>
        <87r0tqmje1.fsf@kernel.org>
        <485422aa276d49878278592861a103f8@realtek.com>
Date:   Fri, 17 Mar 2023 09:17:50 +0200
In-Reply-To: <485422aa276d49878278592861a103f8@realtek.com> (Ping-Ke Shih's
        message of "Wed, 15 Mar 2023 11:56:03 +0000")
Message-ID: <87ilezn8wx.fsf@kernel.org>
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

>> > +     orig = rtw89_read8(rtwdev, addr);
>> > +     data = ((orig & mask) >> shift) + add;
>> > +     set = (orig & ~mask) | ((data << shift) & mask);
>> > +     rtw89_write8(rtwdev, addr, set);
>> > +}
>> 
>> This function has a lot of shifting etc which feels like reinventing the
>> wheel, doesn't linux/bitfield.h contain what you need? For example,
>> u32_get_bits() and u32_replace_bits()?
>> 
>
> The mask argument of u32_get_bits() and his friends should be const, but our
> usage could be a variable. For now, we have only one use case that the mask is
> definitely const, but I remember it could lead some warning if we don't define
> this as 'static __always_inline'.
>
>
> My original thought to implement this function is 
>
> rtw89_write8_mask_add(struct rtw89_dev *rtwdev, u32 addr, u32 mask, u8 add)
> {
> 	u8 tmp;
>
> 	tmp = rtw89_read8_mask(rtwdev, addr, mask);
> 	tmp += add;
> 	rtw89_write8_mask(rtwdev, addr, mask, tmp);
> }
>
> But, this needs three IO (two reading and one writing IO), so I implement this
> a little odd patch. 
>
>
> I'm thinking I can have another implementation that adds variables to maintain
> counters by driver, and then I only need existing rtw89_write8_mask() to update
> counters instead. Therefore, no need rtw89_write8_mask_add(). I will use this
> method by v2.

Sounds good, thanks!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
