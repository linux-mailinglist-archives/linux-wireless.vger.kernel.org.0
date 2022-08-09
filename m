Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98658D37E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 08:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiHIGBU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 02:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiHIGBF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 02:01:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12829587
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 23:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7785D60F5A
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 06:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EDCC433C1;
        Tue,  9 Aug 2022 06:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660024862;
        bh=J5P7UgcBiACB74XwoIB9P3wjqlscnTg7/iXqLIvHaUA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rhPz0cmQ5qSHLWonSeah4/zlYHJMRMTj/IJvm8IltwRaqm6voGa8pAYuYwrBHHCZ6
         Mg+LG7g6BTsnTgx3R9NHE6hRP7sDS+rtw3G6nXlDYJaoxk1+feQLSs+jXGWn5+5dgx
         XJck9pCmVR5N0cWAaKrHEU1cluBS/NhA3NB4mzD9aZ/gzbrvPhv+yEdd8xwLIeFuB9
         U+/yo9eSyhzQ3XGZV1qKrHsVGesgn1AlVnyg04jAWxk+/+tjPp6Dn5XbD1wNPh6HFP
         kvV/FtCYs0X8Sm7oBD2l7JjhxgtUcWJjNxvgmiS/EJKJY85ic/+DOffIgdebHkxX9c
         pIwuULs46Ft5Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: refine leaving LPS function
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220802123712.16577-1-pkshih@realtek.com>
References: <20220802123712.16577-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166002486028.8958.6537033415855663867.kvalo@kernel.org>
Date:   Tue,  9 Aug 2022 06:01:01 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> It's unnecessary to iterate leaving PS mode.
> So, move it out of the iteration.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

674ece275a8e wifi: rtw89: refine leaving LPS function

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220802123712.16577-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

