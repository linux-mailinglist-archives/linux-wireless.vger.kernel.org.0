Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6F151D0BE
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 07:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347742AbiEFFea (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 01:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389199AbiEFFe1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 01:34:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0224BF9
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 22:30:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16E7761E08
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 05:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB57CC385A8;
        Fri,  6 May 2022 05:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651815040;
        bh=KI6+6UJeqe6dplUr47HI9kHSUrSPOUUIANPOnEoqGfg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MGMuosxGf697u6sDZ1X7+67xS3JHmYhfuD7vp1FP+4aqqfmzo/nJ1pN/pBpJnokvU
         i9QbC4vDddnHJhJhHyQDIRNdrwXXpNG1NzIEIrTN41bgWBVjqHAvAvDspcFlrv1j5O
         8u+FWQlD0wz2cek2luNBYMUx4HvhOrF8YPN7li4GwFiWS6G60Y38zdHj0mpZPU98zO
         7rPT/y8cC/wSq16u4cA+kCtvIJlAxDEasjuk8VIxWEvB7IM1RGXz0dzKtX/YBPW/+U
         809Z1XESw++8ulT4+i9GaUJTenV+JR9Dm7Lk8vQU+BO+6egAmw3mP4AszmeDw5o5E7
         lCg0eLv43kBBg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next 0/3] wifi: netif_napi_add() conversions
References: <20220504163316.549648-1-kuba@kernel.org>
        <87a6bwzjvk.fsf@kernel.org> <20220505085418.5384f6c9@kernel.org>
Date:   Fri, 06 May 2022 08:30:36 +0300
In-Reply-To: <20220505085418.5384f6c9@kernel.org> (Jakub Kicinski's message of
        "Thu, 5 May 2022 08:54:18 -0700")
Message-ID: <871qx7z0qr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

>> Feel free to take via your tree:
>> 
>> Acked-by: Kalle Valo <kvalo@kernel.org>
>
> Actually I didn't cc netdev so would be easier if you could take them :)
> I have to wait for RDMA/infiniband to get merged up before I can start
> deleting stuff anyway :(

Ah sorry, I misunderstood. Then I'll take these to wireless-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
