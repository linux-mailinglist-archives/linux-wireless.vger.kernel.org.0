Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3258868A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Aug 2022 06:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiHCEc0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Aug 2022 00:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiHCEcZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Aug 2022 00:32:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03A356BB6
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 21:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C5C2B82188
        for <linux-wireless@vger.kernel.org>; Wed,  3 Aug 2022 04:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7D3C433D6;
        Wed,  3 Aug 2022 04:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659501142;
        bh=Om26xXGcv9YIGyKareU2TVHfsIr/zu+7e8lbyTtvC7M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=S/OTgXwTY0DHljfSxLL6fp3SBxxS4mPljxo9aizmbnGLUZezcMWM2381azUVI7Eq/
         TpLveZgW5h8JKQe/TQ8Ir1dTpuHcuCC6diPZ6W3SgVuqI3s2xCGTGX4qNf3mEI/Il5
         QF/IKWaW4tI8PIyXOHwZYpwlgYWBt9amrX2l2OZhhgiUTJ5rQqSI2zMMF99jMWKDOr
         yRPN6LSQjBH49H7YyFEPVIek7hJyanqLNtIC0X1Nflv1zzwnbdWEcKBqliYDAieU8r
         yOnXBhwgghJBeG0+awIXyBGI5lpYx9oRWNKS94tVlqqnolqOmV1bXrXXbR4h3zxUGc
         vh6TXO3rS35Ig==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dennis Baurichter <dennisba@mail.uni-paderborn.de>
Cc:     Zachary Michaels <mikezackles@gmail.com>,
        linux-wireless@vger.kernel.org, Troy Volin <tmvolin@gmail.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: Re: [PATCH] iwlwifi: Make missed beacon timeout configurable
References: <20220226045047.643695-1-mikezackles@gmail.com>
        <c09a353b-8e52-6d9d-a3c6-743e4e6f444b@mail.uni-paderborn.de>
Date:   Wed, 03 Aug 2022 07:32:13 +0300
In-Reply-To: <c09a353b-8e52-6d9d-a3c6-743e4e6f444b@mail.uni-paderborn.de>
        (Dennis Baurichter's message of "Tue, 2 Aug 2022 20:50:31 +0200")
Message-ID: <871qtyj6b6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dennis Baurichter <dennisba@mail.uni-paderborn.de> writes:

> Hello,
>
> the below patch was sent to linux-wireless 5 months ago, but (as far
> as I can see on lore.kernel.org) didn't get a reply, so I guess it
> might have slipped through? May I ask to consider it for inclusion?
>
> As stated below, this is a workaround for frequent wifi disconnects
> described in https://bugzilla.kernel.org/show_bug.cgi?id=203709. As an
> example, on one laptop with Intel Dual Band Wireless AC 3160 these
> disconnects occured sporadically initially, but later became very
> frequent, e.g. around 100 disconnects within 5 hours (with the laptop
> 1m from the wifi access point). Setting the beacon_timeout parameter
> provided by the patch allowed me to completely "fix" / work around the
> problem, with no disconnects anymore. Many more examples can be found
> in the linked bug report.

The patch did get to patchwork and is assigned to Gregory:

https://patchwork.kernel.org/project/linux-wireless/patch/20220226045047.643695-1-mikezackles@gmail.com/

Gregory, please take a look. This looks to be a common problem.

Not really fond of a module parameter approach, I think it should be
automatic. Why not just increase the default beacon timeout value?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
