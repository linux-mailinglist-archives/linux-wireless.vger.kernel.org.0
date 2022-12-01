Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A8E63EEB6
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 12:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiLALEP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 06:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiLALDp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 06:03:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC33CA85ED
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 03:03:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 235D4B81EEF
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 11:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE61C433D7;
        Thu,  1 Dec 2022 11:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669892618;
        bh=zHXXHteLsIhjwqABGNE9nd8Q/F8w8jkPcSlQFftwbw0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rbvMbGwnfFcK6qLOH8553N5CIyT596TWDz3oPcQhM4vNjceL8p1RyRisV9NIDNGXA
         uxTRuv88K90PH0YUxY1Fgf8PxwDXf0iFnW6xePHqcR+GhU6OWI5uLdK6TMCWcxa0+5
         Et8hdiPeX/Sdznl29v+zLs7O1asbxwyc2NztJTBD14VCEmCBATJdO4s/1l0ndbZNsk
         f2R5+SyPkPbzHAKCeT+G/42TrsWaUZxn99im+E4lyOfgsUK8uyfWCsnUdq8z0xjNj+
         UIzWXyZo87gGg4tLByHyD5IbBQRKpLPQ2g/AltR5BIcxd13RLuah8RVHgdWLM5Hd6Z
         E/0SgJPn9Snkw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: 8821c: enable BT device recovery mechanism
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221128075653.5221-1-pkshih@realtek.com>
References: <20221128075653.5221-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166989261576.31196.863648948652161658.kvalo@kernel.org>
Date:   Thu,  1 Dec 2022 11:03:37 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8821ce is a combo card, and BT is a USB device that could get card lost
> during stress test, and need WiFi firmware to detect and recover it, so
> driver sends a H2C to enable this mechanism.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

7c57d3dc4381 wifi: rtw88: 8821c: enable BT device recovery mechanism

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221128075653.5221-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

