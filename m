Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C635AA9F9
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiIBIaI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiIBIaG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:30:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323CB192A9
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D83BEB82A04
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2102C433D6;
        Fri,  2 Sep 2022 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107403;
        bh=zhli7w8rhxSS264Fa1fdFcP/pOPT+s1SO3kMB9rBw4M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NBR/Mls56Nec11r78fgv76c0w5xqV9CYUhpmiH3eIg5iDSfQNM3lwCBVFP4q5uTt0
         hkllHd1vXja3PGW9EX+kADjYvUxcn9mxAhswIZAIXQnfweHG0Y1uKKGPpu7yPS3ymp
         tbyLphUMuzt1OK/9VGFBm69fbncZrxNwoBc9oZvFCtJb5hL0BT/xlTOqaLOHsnrE2C
         qAYsBjHPKwBojtJinlCZqY30hODGVzrTLzH0EuJk8ljZpOkRqHU4lm9qdKaXjHyBtE
         FSbdlG5Fmgt0TQgaqLQMASmP7l9xGy7IwejZOxpq7qNKiXK1npQgOQcNY99Y04Z5F/
         iIyDGLJibpJ4Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 01/13] wifi: rtw89: rewrite decision on channel by
 entity
 state
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220809104952.61355-2-pkshih@realtek.com>
References: <20220809104952.61355-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166210740092.24345.17985593816400617386.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 08:30:02 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> We need to invoke the callback of the changed band at the first
> set_channel() after every power-off. Originally, we forced the
> channel to be 0 when doing power-off, and then determined things
> by comparing channel with 0.
> 
> However, deciding on such things by channel might be confusing.
> It's also confusing to use this kind of decision when we consider
> multiple channels in the follow-up patches. So, another flag,
> entity_active, is added ahead to HAL to deal with this.
> 
> Besides, we also need to check if entity is active when we set
> TX power.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

13 patches applied to wireless-next.git, thanks.

967439c7a2a6 wifi: rtw89: rewrite decision on channel by entity state
3e5831cac1e6 wifi: rtw89: introduce rtw89_chan for channel stuffs
cbb145b98b63 wifi: rtw89: re-arrange channel related stuffs under HAL
bb8152b386c3 wifi: rtw89: create rtw89_chan centrally to avoid breakage
07ef5f2fa3f3 wifi: rtw89: txpwr: concentrate channel related control to top
010d0051f7ec wifi: rtw89: rfk: concentrate parameter control while set_channel()
ce57e55c0b70 wifi: rtw89: concentrate parameter control for setting channel callback
494399b2130c wifi: rtw89: concentrate chandef setting to stack callback
a88b6cc483ab wifi: rtw89: initialize entity and configure default chandef
7cf674ffc852 wifi: rtw89: introduce entity mode and its recalculated prototype
84b50f4187fc wifi: rtw89: add skeleton of mac80211 chanctx ops support
7fc06a071cd5 wifi: rtw89: declare support for mac80211 chanctx ops by chip
deebea35d699 wifi: rtw89: early recognize FW feature to decide if chanctx

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220809104952.61355-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

