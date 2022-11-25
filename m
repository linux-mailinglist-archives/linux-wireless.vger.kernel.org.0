Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6A1638842
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 12:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKYLGs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 06:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiKYLGp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 06:06:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F54D5E3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 03:06:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51B8D6231B
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 11:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EE9C433C1;
        Fri, 25 Nov 2022 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669374400;
        bh=VBJ0FDdCVqNKDtZqIQxJiumzJp90FsIpeDmAlcn94N4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QOQEJq5BBu5eCmcfLlTjAvoOflN7N0XMPpeCEa1UatpFfnYGExkrF0cNUUiM/iKOL
         gbllaKonFZzDouy5HBTwvPZV60aTETozPtSL4XBhphfQfTMT+jG4eu5JnTgxA/+weu
         BIf1ktTXM/z+kekF5h6tQu3aC8/B52AZpMuRi10NfUZMQTnlZcYz+bdVOVd4g9AkjI
         KdIxm4ORbN2c1GCBN/hWXMT4bVoRAj3y85s9A8cJFYrFrgRHePIo4F4foz8xp5Dupu
         CE6TOni+eC2bK3d8kujQvPCK4Zd5fE2ov8LWIRV7PCDUGgcilngm46IdZJdqWp4gBL
         ADWB2wTX/ZLHg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: Re: [PATCH v2 00/50] wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices
References: <20221116163902.24996-1-kvalo@kernel.org>
        <878rk49u7n.fsf@kernel.org>
Date:   Fri, 25 Nov 2022 13:06:36 +0200
In-Reply-To: <878rk49u7n.fsf@kernel.org> (Kalle Valo's message of "Mon, 21 Nov
        2022 17:57:00 +0200")
Message-ID: <87k03j70oz.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> ath12k is a new mac80211 driver for Qualcomm Wi-Fi 7 devices, first
>> supporting QCN9274 and WCN7850 PCI devices.  QCN9274 supports both AP
>> and station; WCN7850 supports only station mode. Monitor mode is not
>> (yet) supported. Only PCI bus devices are supported.
>>
>
> [...]
>
>> Unfortunately the firmware images are not yet available but they will be soon, the
>> plan is to publish them any day now.
>
> The firmware for WCN7850 hw2.0 is temporarily available here:
>
> https://github.com/kvalo/ath11k-firmware/tree/master/ath12k-testing/WCN7850/hw2.0

Now QCN9274 hw2.0 firmware is also temporarily on the same repo:

https://github.com/kvalo/ath11k-firmware/tree/master/ath12k-testing/QCN9274/hw2.0

As the final big patch is too big to submit to the mailing list, here's
a link to the commit in my pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=e9d30f354584f7094e56e6f91bf428f7c0981602

The idea is that I'll take this commit to ath-next branch and then queue
to v6.3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
