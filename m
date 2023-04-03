Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801006D45EA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 15:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjDCNgH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCNgG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 09:36:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696B24488
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 06:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 041EB61B8C
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 13:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51FCC433EF;
        Mon,  3 Apr 2023 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680528964;
        bh=m9skB40IMBIthp9n7irxZ/3gIEh4Vodhvj4MSGxeHYE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MBVt5QDAl0OT6dL/KEJbNnhF0eppOX6mI++tCGvztOghdhvIke6E8vDFNyRXt5jRJ
         absXe0SUQOREE8iqqpkCV3cfOtWHIdKJA9V1NirBqtgdrmS0OsS4YTeEIv9DDDt5vM
         tiKHfmklcc37wmGHJFdaS0D6n2biTBB6xblqpLp4duoVJa0NPKu71XConyQVNvlG3O
         KaaQhmjyPm/6omPb4djYSRgEinUl8gDPmbwoThpKan4L8eeKoBXuHo3OScKTmwanX9
         XI+rPT5QmHyYxEX1uBos1XrDY3MG2n5CcccEwiIcZPmb47MprpmLAImVOXuzUtaeRk
         c3RmWjQtTm9hQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw89: coex: Add LPS protocol radio state for
 RTL8852B
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230314020617.28193-2-pkshih@realtek.com>
References: <20230314020617.28193-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168052895936.11825.12327464099363607917.kvalo@kernel.org>
Date:   Mon,  3 Apr 2023 13:36:03 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> This LPS state will not turn off RF, and it can still do some basic
> traffic, only RTL8852B has the state. Coexistence need let Bluetooth
> know WiFi is still alive to prevent some Bluetooth performance issue.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

70a13e5f00e9 wifi: rtw89: coex: Add LPS protocol radio state for RTL8852B
829b3a8b212a wifi: rtw89: coex: Not to enable firmware report when WiFi is power saving
20595db3c068 wifi: rtw89: coex: Update RTL8852B LNA2 hardware parameter
d7904ca8a040 wifi: rtw89: coex: Add report control v5 variation
7527251f7766 wifi: rtw89: coex: Update Wi-Fi Bluetooth coexistence version to 7.0.1

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230314020617.28193-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

