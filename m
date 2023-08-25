Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1527880B5
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 09:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbjHYHNZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 03:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbjHYHNM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 03:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508F019A5
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 00:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D863B655D1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 07:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AD0C433C8;
        Fri, 25 Aug 2023 07:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692947590;
        bh=aWBEVyXABn2qf8hvft/PEu7QwQPVq+GGY5QW34xkfAA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JbijsS9J7UZ7ROidfEYvZVFq0/84GwxNEU9TayfT0VHWp1ZGwN9/YqHPg6eHv0pN5
         jpAmgP/IJw0gyiF8mv9QBfxi2tBLRyAnJ2DEZysW2oEvvcDZld/geo9ns5QztrsdEo
         8pxp540dPXjNpZFLSnJcXxpVf8sZ3CqwRYFS0fWw0frzHxP1hCG4YkRf+fn5jCTFWw
         occoWD5Zj5QmOlhZ526VjMKzsPslpuGgBrsEu7MFkP6djHotDKxTyD2IKn9HpdHC/f
         BximUIh2DfjToyFXN3RQGgxn7vZQu5yAX4B3GOFOXfGFmOtymuGJf71TpjbjtFOXhm
         5c6h6pVSInQQw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: Re: [PATCH 0/6] wifi: rtw89: preparation of TDMA-based MCC (STA+P2P)
References: <20230816082133.57474-1-pkshih@realtek.com>
        <87o7ixhng5.fsf@kernel.org>
        <22a5d99c4f4be30dd7659400ba9a42c0701f6521.camel@realtek.com>
        <87fs49hb0n.fsf@kernel.org>
        <19deae143404590f10ffcbbb817ab24e1d360b60.camel@realtek.com>
Date:   Fri, 25 Aug 2023 10:14:12 +0300
In-Reply-To: <19deae143404590f10ffcbbb817ab24e1d360b60.camel@realtek.com>
        (Ping-Ke Shih's message of "Thu, 24 Aug 2023 01:10:04 +0000")
Message-ID: <87fs47vbjv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> On Wed, 2023-08-23 at 21:24 +0300, Kalle Valo wrote:
>> 
>> 
>> Just out of curiosity, how do you create your ascii diagrams? Is there
>> some nifty tool to help with those? :)
>> 
>
> I draw these diagrams manually, not pretty but useful (I think so :) ).
>
> Recently, I draw a diagram in cover letter, because purpose of
> patchset is simple, but too much detail things cause patches
> complicated. So, I hope a diagram can help reviewers to have a 
> concept quickly before reviewing my patches. 

At least I have found the diagrams very helpful :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
