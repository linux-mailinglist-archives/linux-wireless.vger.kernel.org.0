Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB7D4EA747
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 07:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiC2Fna (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 01:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiC2Fn3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 01:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12B31935
        for <linux-wireless@vger.kernel.org>; Mon, 28 Mar 2022 22:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79372614B0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 05:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA074C2BBE4;
        Tue, 29 Mar 2022 05:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648532506;
        bh=RwNoFM5iop5uuOcwXJSPODTVCkfxUX+FYSSJ45vyO5o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Zg0eRgW6GN9sKksqyeQqBgBzEZ+D/sKn/s5KIqgALfKs9DTYdlZIVyGRSZa1SJ6LE
         HTVcsAeJgWFU8pNELH9U55LE3/PoJYj45QnOTggm/NlTftJaU8lxKd7QFtkoQz8jbo
         W8psyShlVbe6AaBj+7JCEdUmRbq0RQb00JnpLx+kXk9pT1ZJcH/Cnd2CyjUnrDZTAR
         TSL99A8i2Ev0GV6NbdBG9UzWIx0+tBZySh3EHEkOkPVQyLVSLMU3XuXFONPuY/T02O
         EusleJCAAjO+Wh17hMkM7o1KHWEwNku2xKru3b1h1VRVY90uIxsAQvl1i68ISS+c+0
         pP+TETHBM7Grg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: Re: [RFC PATCH] mac80211: mlme: Handle Puncturing information received from the AP
References: <20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
Date:   Tue, 29 Mar 2022 08:41:42 +0300
In-Reply-To: <20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
        (Johannes Berg's message of "Fri, 25 Mar 2022 14:09:00 +0100")
Message-ID: <87o81puxgp.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>
> Handle the Puncturing info received from the AP
> in the EHT Operation IE in beacons.
> If the info changed and is valid - update the driver.
> If the info is invalid:
>  - During association: disable EHT connection for the AP.
>  - After association: disconnect.
>
> type=feature
> ticket=none

I guess type and ticket is some internal marking. I know this is RFC,
but wanted to point out anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
