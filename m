Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614BA5FEC72
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 12:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJNKUg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJNKUf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 06:20:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7405A74BBD
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 03:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31769B82295
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 10:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44928C433C1;
        Fri, 14 Oct 2022 10:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665742831;
        bh=WBVoWqIHhpDdtti5MAm2b0aWm+iB4vH4iE+u6/FFPls=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZklRrSttenpi3PUHVECpfdgfmVNHVAVH1GxyVMbxlKK/3JEKjgcYLWx+kX3I0bpn/
         eekboG99HdR/lDgXAwzJfp88HwMuNujy6iCGkdu6aA3a0QZXSW0V54nyqakrSmtHpa
         I062VSjw/Z4BK9atW7oXKIXOJh3z5b2AvRWD+iBOtS3Da5hAYIBm1PYqcmyYTGRiUe
         LMv7fM6rAD/q51KdzbeSFSTBB5UYaRcG+AesblzrUKHb/rftj9QQda+olGtWYlfc/i
         nzDonGHQrEy0BdHBkJ3FZSuI5WyxMmo1GEddT3EM+1lY+tMQLWT+lxhedIEiIQgyl7
         7pZyvlsvDAgdg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/4] wifi: rtw89: 8852b: add RF calibration part 2 and enable 8852BE
References: <20221014060237.29050-1-pkshih@realtek.com>
Date:   Fri, 14 Oct 2022 13:20:26 +0300
In-Reply-To: <20221014060237.29050-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 14 Oct 2022 14:02:33 +0800")
Message-ID: <87ilkmn1ud.fsf@kernel.org>
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

Ping-Ke Shih <pkshih@realtek.com> writes:

> After this patchset, 8852BE is ready, so add 8852BE to Kconfig and
> Makefile. With firmware v0.27.32.0, STA, AP and monitor can work well. 

Awesome! From my point of view adding 8852BE support went really
smoothly, thanks for that. Very much appreciated.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
