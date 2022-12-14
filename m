Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9539164C48F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 09:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiLNIAG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 03:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiLNIAE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 03:00:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161291AA3D
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 00:00:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A044061752
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 08:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABDAC433EF;
        Wed, 14 Dec 2022 08:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671004802;
        bh=5oLShAx49+myMGmHPRGtMfCxQQVUCV3mWLMBt+Kqy8Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PQBMXTfdF+uRu3HMT5JxnGXquUzmeorZtOcL6D4mppE4RS+/dgdEHQ342WbLDjGw8
         zfIpZHSJ3HmV2tNue+fxSR2d4weYFaifIqbH3Abk/Pdugso3U+gk3761jqBj3CW2il
         yGABC9SwVbu2lkm6nbNSdqJUI49TG+tIgwd7lLNUSelp/JvHeFbM633wbxNx8hnZ+i
         Hbk4PLO5AWQkHYxge9SH3CUYtLFxO/CUGf33swFyybkU0ENmhiLsGq2qEUyM+Z+nPP
         EucZXrDmML/jDsMYIJY2LW2PVQpUWD728dmrJDrmpe9NUaQe/iKViXzLwl9f6KXPxL
         4y11CpAsn6KWQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Charles Piekarski <contact@charlespiekarski.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Realtek 8852BE support
References: <a2a454c5-3940-52d0-77b7-e5f8376720ae@charlespiekarski.com>
        <1f878b2ec793443f96685773c6599591@realtek.com>
Date:   Wed, 14 Dec 2022 09:59:54 +0200
In-Reply-To: <1f878b2ec793443f96685773c6599591@realtek.com> (Ping-Ke Shih's
        message of "Wed, 14 Dec 2022 00:47:34 +0000")
Message-ID: <87y1ral8jp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Charles Piekarski <contact@charlespiekarski.com>
>> Sent: Monday, December 12, 2022 7:11 PM
>> To: linux-wireless@vger.kernel.org
>> Subject: Realtek 8852BE support
>> 
>> Dear Sir or Madam,
>> 
>> I would like to kindly ask for information if Realtek 8852BE Wi-Fi 6
>> module is supported or will be supported by the Linux kernel.
>> Regrettably, the module does not work under Ubuntu 22.04.1 and 22.10, at
>> least out of the box, and I was unable to find any useful information to
>> get it working in a safe way (with Secure Boot enabled).
>> 
>
> 8852BE got merged into kernel 6.2 that will release about 3 months
> later.

Related to this, we have a crystal ball service which tries to predict
merge window and release schedules:

https://phb-crystal-ball.sipsolutions.net/

I should add a link to that in our wiki, I don't think it's mentioned
anywhere.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
