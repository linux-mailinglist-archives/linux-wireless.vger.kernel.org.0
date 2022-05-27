Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBE15359AD
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 08:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbiE0GxH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 02:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiE0GxF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 02:53:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C346385
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 23:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97AAFB8229D
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 06:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3841C385A9;
        Fri, 27 May 2022 06:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653634382;
        bh=KACWrvizCLaIbaDheYnOMIrrlolTDX4555BFL6JdWec=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OJ2RwjFx3wLBdVMCIvkM5f8/Nqz7JShXD6A5qz3kWxaTpiZJERPqPlTvMllmKeRqp
         krosoOQc0/fUP4xjzJwYmMhkp89MtBSYeBwQVQM10wEXVoxNXXi3Ff1DKpcUyqtMJk
         360k7GY4lfqj/CfCtuYqsqT3aREGeycTbkhR4r6LnBWi5tAPX6B1EkFJfkFoXU5FF+
         K0j9+p0SF4kIQmt0Vm0qkXBvSr4bcsVy0taHCWTpM/oqiJ33Rlvg12NKHDHFz/xKYg
         fG95Epi5s0izUcD/xQ6LAmH1VwIeM46iwyHVGkTgRUst4WLuuNh6WTtWrRGi4GCmpf
         Uc1Q0jJJoGKOQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "tony0620emma\@gmail.com" <tony0620emma@gmail.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "megi\@xff.cz" <megi@xff.cz>, Bernie Huang <phhuang@realtek.com>
Subject: Re: [PATCH] rtw88: add a work to correct atomic scheduling warning of ::set_tim
References: <20220526051251.281905-1-pkshih@realtek.com>
        <871qwfwksm.fsf@kernel.org>
        <1a53b146ee034a058fad0f0d87a24e16@realtek.com>
Date:   Fri, 27 May 2022 09:52:57 +0300
In-Reply-To: <1a53b146ee034a058fad0f0d87a24e16@realtek.com> (Ping-Ke Shih's
        message of "Fri, 27 May 2022 06:35:33 +0000")
Message-ID: <87o7zjxy9i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> > Fixes: f2217968ffda ("rtw88: Add update beacon flow for AP mode")
>> > Reported-by: Ond=C5=99ej Jirman <megi@xff.cz>
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>>=20
>> Should I queue this to v5.19 (ie. take to wireles tree)?
>>=20
>
> Yes, please. I think it would be good to have this fix.

Ok, will do that.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
