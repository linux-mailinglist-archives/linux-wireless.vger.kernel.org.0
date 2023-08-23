Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749327859E1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 15:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbjHWN4u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236393AbjHWN4p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 09:56:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A16E5E
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 06:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A87EE650A9
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 13:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E973DC433C7;
        Wed, 23 Aug 2023 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692798989;
        bh=ooaJ8zNKjuFHc3CtJAzqTrvIO2N8M7jpLnWIhMOYvik=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ajY0ndTk6zEjDv2U77yu4T6WXEphosnO47timwar25bP3Df3CCnWRpOPCl9P9G+uN
         ToyO7JusDeJb/MPlkbaUx69Wb6YFJN7HmBP2jI7i8JxFMfImT2PZQfsFOgMZl9beZo
         F9UG5+Gm+8t6S9MDHU/2+zAdO2yu1/HaXopeE/gdeeR/Nj21a+WMyFU3Et64Kf2Vh3
         k0HDfLO3/hyY2fvkTL+FHd6EQdli+LWRJoDRpasUZ5fshJCggpmr4EUV3yOkwfeCUP
         1Q6Accqci6JrOTX830cePjBMhY8EIGGF+krAbusBaRr2B8DZ892oehXmedgGu/lRXE
         Ltze6pMszn+8Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/6] wifi: rtw89: preparation of TDMA-based MCC (STA+P2P)
References: <20230816082133.57474-1-pkshih@realtek.com>
Date:   Wed, 23 Aug 2023 16:56:26 +0300
In-Reply-To: <20230816082133.57474-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Wed, 16 Aug 2023 16:21:27 +0800")
Message-ID: <87o7ixhng5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

> TDMA-based MCC (STA+P2P) is a kind of multiple interfaces concurrence.
> Basically, driver is to calculate timeslot pattern and firmware follows
> the pattern to switch channels. Since BT-coexistence is also a TDMA-based
> mechanism, also consider BT timeslot into pattern if BT devices present.

What do you mean with TDMA here? It something like that in STA mode the
driver enables 802.11 PS mode before going to another channel? Or
something else?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
