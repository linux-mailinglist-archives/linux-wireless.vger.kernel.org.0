Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5504762C4F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGZHBt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 03:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjGZHAq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 03:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6162D4E
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 23:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 793476165C
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 06:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C70C433C7;
        Wed, 26 Jul 2023 06:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690354790;
        bh=Jp6sBhLvRtyYzTRKqoqq/FO5A8YEP3kr/e7NZRg7f6Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qHgaWjz1uAETY6HTbckxwBGcSBqbjObjQ4mLaq3nXcCLW9OyyMvXgh95ZL0ouxUAj
         IYceL6bFoJCdFe++DKHx9PSu6bBUom+va25syWYxeq3Gm148uM9eUd6/oJK9YLUITQ
         8iTh79giBZ6+rwEQLI/KNwvA6+dvKP3hDZ0Ycm6Knyne2HDMULS9fTF4ww58vy6F9W
         pILHmpuIb/ypRuWqSEfmjH1MsGNbjd2vj43i/EGvf2aUqQCdHIJ5qKmoyOU5hreHvk
         XrVcgrr38RLrT5yAy5oYjpwB0iZU6ymK2nCUSOgwKhL5F3I9Z9P82zmmIekDnG5Q4e
         iK/mZIj8sfmhQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 8/9] MAINTAINERS: wifi: mark b43 as orphan
References: <20230724104547.3061709-1-kvalo@kernel.org>
        <20230724104547.3061709-9-kvalo@kernel.org>
        <14cfb9d7-089d-607a-9062-eb9e268ffd67@lwfinger.net>
        <87zg3l19lz.fsf@kernel.org>
        <4bd1d468-d512-65b8-7e03-8cf879ce24af@lwfinger.net>
Date:   Wed, 26 Jul 2023 09:59:48 +0300
In-Reply-To: <4bd1d468-d512-65b8-7e03-8cf879ce24af@lwfinger.net> (Larry
        Finger's message of "Mon, 24 Jul 2023 13:03:04 -0500")
Message-ID: <87mszj17kr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 7/24/23 12:51, Kalle Valo wrote:
>> Larry Finger <Larry.Finger@lwfinger.net> writes:
>>> Kalle,
>>>
>>> Michael Buesch and I have been unofficial maintainers of this driver
>>> for years, but your change makes sense.
>> I would be more than happy to add you and/or Michael as b43
>> maintainers!
>> But I don't want to force anyone, it's not exactly a fun role :) Just
>> let me know what you prefer.
>> 
>
> Given my advanced age, I have been busy trying to get rid of
> responsibilities, not take on new ones. I think making the driver an
> orphan is OK. As long as I am capable, I will continue to address any
> bugs that turn up.

Sounds good, thank you for looking after b43. Very much appreciated.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
