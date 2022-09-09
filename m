Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898335B332D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 11:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiIIJKc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 05:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiIIJKX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 05:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8739580BC
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 02:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D90EF61F46
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 09:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199CFC433D6;
        Fri,  9 Sep 2022 09:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662714615;
        bh=IaWgpqu93sgkUECLoa0L6F6R7BhmK7L2O3GXCUn3v0c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fbr/JfcWTE11hBq29uZ5cf5LwpfcN9yO05il1E3t/4e+UJWUFiSpBFLp6u7mt+QWJ
         sB0Ena2zpj6MGhda5eoq+nuHUE0g4a3UHvOJVvLuFNPsze1rDF/bzzAGqMugJ/FTnM
         AlYPmXyAWqjfwdrrOhTY5Ez1pp/pLN9W+sFu+LCBeg8OM8AZfx9dz55Qg4uSJ9ZNhI
         lkDjRHkbyVkEGKXcXWjTj2XgEfYkO1n/yz1tUCjgPIvYJYEjQTPNVMd3QZqZyF1Vyt
         kSArZSm2K7kE918ztZ+xGO0Mbb7fiHPJZ4mgHH0jM2hmZAxBFx3/UHSAmLtJwjUAvH
         Gh1ceJjB41Ywg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ayala Beker <ayala.beker@intel.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: Mark IWLMEI as broken
In-Reply-To: <87o7vpcbbo.fsf@toke.dk> ("Toke \=\?utf-8\?Q\?H\=C3\=B8iland-J\?\=
 \=\?utf-8\?Q\?\=C3\=B8rgensen\=22's\?\= message of
        "Fri, 09 Sep 2022 08:26:51 +0200")
References: <20220907134450.1183045-1-toke@toke.dk>
        <87k06daysx.fsf@kernel.org> <87o7vpcbbo.fsf@toke.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 09 Sep 2022 12:10:08 +0300
Message-ID: <87o7vo9amn.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:
>>
>>> forthcoming. Since just disabling the iwlmei driver works as a workarou=
nd,
>>> let's mark the config option as broken until it can be fixed properly.
>>>
>>> [0] https://bugzilla.kernel.org/show_bug.cgi?id=3D215937
>>
>> So does the bug only happen with iwd? Should I mention that in the
>> commit log? It would be good to describe the conditions when the bug
>> happens.
>
> Well, what happens is that the interface ends up in the 'down' state
> after coming back from suspend. And iwd doesn't touch the interface
> state, but wpa_supplicant does, so the user-visible "my WiFi doesn't
> work" thing only happens on iwd...

Thanks, I'll mention that in the commit log.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
