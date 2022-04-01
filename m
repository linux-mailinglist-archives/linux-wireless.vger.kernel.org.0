Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB94EE7D8
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 07:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiDAFsq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 01:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiDAFsp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 01:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B98C220FD1
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 22:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5133661B5F
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 05:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40B6C2BBE4;
        Fri,  1 Apr 2022 05:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648792014;
        bh=Yi1ww34V/4lgByjz2wZL+Sp/2Eq+U8FYc9kImdBmQhk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Q5cRatCHYoDPG3EspBtGpM5PCM3Qh0jt+DVc2W3lk03RVN1WIEe17W6tvMq4w9eRz
         72EpAfCfc2RR08D6YA21ihQzYZbh2X6vQY7Usl/YB6LaRMX5rZ9Qe+pIoGzCcob5bx
         ctflp7Em36ki1ZbVRo9O2Ss1rip//4KqvgcBMDS7436tPmmq3uHg93TFILfVSLaE+b
         hbrtfLA65qQY3vLqx4YLSjOQDjT4dSERj2t/E31ToNJVVf3bsp/8n3Vd+F2E1aaQgK
         Q7GtQuBzxWDN0c307tvHP40wOrbBWzA2YrXymT6DQW1S0SYBq2YIKVJBLfT40+8qRy
         9bdT6fY0jcQ0g==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Nagarajan Maran \(QUIC\)" <quic_nmaran@quicinc.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "ath11k\@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v5.18] ath11k: fix driver initialization failure with WoW unsupported hw
In-Reply-To: <MW2PR02MB3899E0AF9C08EDF0F9CE1E52EDE19@MW2PR02MB3899.namprd02.prod.outlook.com>
        (Nagarajan Maran's message of "Thu, 31 Mar 2022 16:37:35 +0000")
References: <20220331073110.3846-1-quic_nmaran@quicinc.com>
        <87sfqyv1td.fsf@kernel.org>
        <2f25bb87e665488b30f6fdaa5877ad8b5b19da0a.camel@sipsolutions.net>
        <MW2PR02MB3899E0AF9C08EDF0F9CE1E52EDE19@MW2PR02MB3899.namprd02.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 01 Apr 2022 08:46:49 +0300
Message-ID: <87mth5uzhy.fsf@kernel.org>
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

"Nagarajan Maran (QUIC)" <quic_nmaran@quicinc.com> writes:

> -----Original Message-----
> From: Johannes Berg <johannes@sipsolutions.net> 
> Sent: Thursday, March 31, 2022 5:29 PM
> To: Kalle Valo <kvalo@kernel.org>; Nagarajan Maran (QUIC) <quic_nmaran@quicinc.com>
> Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v5.18] ath11k: fix driver initialization failure
> with WoW unsupported hw
>
> On Thu, 2022-03-31 at 13:44 +0300, Kalle Valo wrote:
>> > 
>> > Fixes: ba9177fcef21 ("Add basic WoW functionalities")
>> 
>> Fixes tag is wrong, it should be:
>> 
>> Fixes: ba9177fcef21 ("ath11k: Add basic WoW functionalities")
>> 
>
> $ git config --global --add alias.fixes 'show -q --format=fixes'
> $ git config --global --add pretty.fixes 'Fixes: %h ("%s")'
> $ git config --global --add core.abbrev 12 $ git fixes ba9177fcef21
> Fixes: ba9177fcef21 ("ath11k: Add basic WoW functionalities")
>
> :)
>
> Johannes
>
> Thank you for the commands.

Please use '> ' in your quotation, otherwise your replies are hard to
read. See item 5 here:

http://www.infradead.org/~dwmw2/email.html

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
