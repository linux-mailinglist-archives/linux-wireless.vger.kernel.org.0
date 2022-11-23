Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737F9635123
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 08:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiKWHhN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 02:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbiKWHhM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 02:37:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EDCF8864
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 23:37:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D072EB81ECD
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C77C433D6;
        Wed, 23 Nov 2022 07:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669189028;
        bh=DkMxWFiG8y7zqTgwJQjsxzyy9YxJGvEU4ofwChdGo24=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=d1h+bYJHsowHzhPgWLTRj8v6FjJ2pUpZ2NLH+6g1Fh73B5OLNBdkXQZYtyfPpgngg
         ipBRG85vzD+QDjp04UzDRh8Q4dDpT0W3IHTm7gKMhA6Smo+QqRJNKtcl9Jaw9OGCIj
         lUiNIzF2rGikvUPZW7Uw4NQz9muhwY2EPMmsU7NMkbE+tyb2BWa5sRAZHhmv+tBSuN
         Zf9+H2P9iQeXbMa+AObglzC7rmt8OlHmT6BtkSmtBD7afuFn4QC4r5+za2oDSioQKE
         RZ0pebMX1/QaBcWHlM+45khL0KEqr3L60/M3USuOHGHzdEMfoaQ+hnmrtXczcH5ZK5
         WXhkrfYy84OIQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     shayne.chen@mediatek.com
Cc:     =?utf-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek\@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?Q?Howard-YH_Hsu_=28?=
         =?utf-8?Q?=E8=A8=B1=E8=82=B2=E8=B1=AA=29?= 
        <Howard-YH.Hsu@mediatek.com>,
        =?utf-8?B?TWVpQ2hpYSBDaGl1ICjpgrHnvo7lmIkp?= 
        <MeiChia.Chiu@mediatek.com>,
        =?utf-8?B?TW9uZXkgV2FuZyAo546L5L+h5a6JKQ==?= 
        <Money.Wang@mediatek.com>, "nbd\@nbd.name" <nbd@nbd.name>,
        =?utf-8?Q?StanleyYP_Wang_=28=E7=8E=8B?=
         =?utf-8?Q?=E4=BE=91=E9=82=A6=29?= <StanleyYP.Wang@mediatek.com>,
        "lorenzo\@kernel.org" <lorenzo@kernel.org>,
        =?utf-8?Q?Chui-hao_Chiu_=28?=
         =?utf-8?Q?=E9=82=B1=E5=9E=82=E6=B5=A9=29?= 
        <Chui-hao.Chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>
Subject: Re: [PATCH v2 9/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices
References: <20221110093525.29649-1-shayne.chen@mediatek.com>
        <20221110093525.29649-10-shayne.chen@mediatek.com>
        <87ilj8pcqr.fsf@kernel.org>
        <83f60433f893331337012a6ce8ed920db67639c4.camel@mediatek.com>
Date:   Wed, 23 Nov 2022 09:37:04 +0200
In-Reply-To: <83f60433f893331337012a6ce8ed920db67639c4.camel@mediatek.com>
        (shayne chen's message of "Tue, 22 Nov 2022 09:04:30 +0000")
Message-ID: <871qpup1en.fsf@kernel.org>
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

shayne.chen@mediatek.com writes:

>> >  18 files changed, 12288 insertions(+)
>> 
>> This patch is too big, please split it. One patch per file is a good
>> rule of thumb.
>> 
>> I did see some suspicious static variables in pci.c, but otherwise I
>> basically skipped everything.
>
> Thanks for your reminder.
>
> I've splitted the big patch into smaller patches by functionality for
> easier review.

Nice, thanks Shayne.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
