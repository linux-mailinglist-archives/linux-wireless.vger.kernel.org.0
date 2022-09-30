Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD265F0628
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 10:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiI3ICp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 04:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiI3ICo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 04:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75C4129FC8
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 01:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 536C962249
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 08:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAB0C433C1;
        Fri, 30 Sep 2022 08:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664524962;
        bh=UgG3/p2NNMnEKKo92pDY7qeNTKKfrDousFyPMw+I7i4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dhZZDpIRlDftvZUqJJOm1D33yli985LwzXwoX5GwvdJEe5+wiqyI793mdAkaTUyxF
         AREIo94ETFWMnJ7SnDPeKM9JTCao8t5QU6LgSwUhI9fKamKN9CcFhzwuTW47+8e8/I
         R6DvuPubNjwlZ9LquX+tQ2EgJRsmTSrk7+7cooGMAVtk8wcERmpeeFPYgtHJgpBMKY
         A7wYlZ3vjpj0h5hqi+rnNbdxGn29GKJCGwpwTsWilyk9jH+iSrxd503YzoelM1cvKP
         J3s45nuR+Eyv0ME0DCYcg8nN8PUPwCK0jsjDg4kYTUXRy4Wu6/f1jsxGIwfRoDtmuM
         Mh+eRXtjIa+sw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Mariano Vedovato <marianovedovato@hotmail.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: rtw_8723de Realtek driver issue in Debian 11.5 Bullseye Kernel version 5.10.0-18-amd64
References: <SN4PR22MB3271BACF8FD2F57BEDDACC4EAC549@SN4PR22MB3271.namprd22.prod.outlook.com>
        <SN4PR22MB32711526F087B9898CED953DAC549@SN4PR22MB3271.namprd22.prod.outlook.com>
Date:   Fri, 30 Sep 2022 11:02:39 +0300
In-Reply-To: <SN4PR22MB32711526F087B9898CED953DAC549@SN4PR22MB3271.namprd22.prod.outlook.com>
        (Mariano Vedovato's message of "Wed, 28 Sep 2022 13:46:24 +0000")
Message-ID: <87y1u15ly8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mariano Vedovato <marianovedovato@hotmail.com> writes:

> BTW, I tried to install Ubuntu 22.04 with Kernel 5.16.xx and the WiFi
> works fine, but I'm a Debian user since Debian 5 and I don't think to
> leave it and I have no money to buy another Laptop for the moment!

Do you know Debian backports have packaged more recent kernels which are
relatively easy to install, Debian 11 (bullseye) backports seems to have
v5.18 right now. More info here:

https://backports.debian.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
