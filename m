Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E545664E945
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 11:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiLPKTT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 05:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLPKTD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 05:19:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789A650D55
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 02:18:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34A7AB81B2A
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 10:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705DBC433F0;
        Fri, 16 Dec 2022 10:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671185927;
        bh=g7As3RJKNxeu3UYhZWD96CMAWz3efpGPv5RJc9Z9In0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIxWjeP8l0FY0C2PrYbyJWWs3chDSs0pbEcmCkE5l6/2ln4+X+OjL3P+PZPxsCdde
         +byg69YCDtw14ujNiOQieugcZczCXND1j7MyTJi32sMlxdbIbmQGDHxI3VyaMTUybQ
         l16iPj21S/lzjkc3xl9wEXzzwTOndkmJnem0TuBqNHdqWujVvN65mCzcdnA3RJ96ym
         1mgHvQB6ivf2yotAwSOr+dIlCkmOjupCUQ83Yf6+ytLUc6DZdNfMlnwGQFD0xlBQ20
         ZCIViIOzQknq5KQ+TKf2sz2BvJ5kwOA6tsXh7n/xihdMARuvU5OUSdNg+0MDXE8QSF
         uCgl4ulO+IhMQ==
Date:   Fri, 16 Dec 2022 11:18:42 +0100
From:   Michael Walle <mwalle@kernel.org>
To:     Ajay.Kathat@microchip.com
Cc:     Claudiu.Beznea@microchip.com, linux-wireless@vger.kernel.org,
        kvalo@kernel.org
Subject: Re: wilc1000 kernel crash
Message-ID: <20221216101842.jjz3glyotqbbqlk4@0002.3ffe.de>
References: <20221024135407.7udo3dwl3mqyv2yj@0002.3ffe.de>
 <6d022f41-85bb-cde2-0b3d-feef0a0711f2@microchip.com>
 <20221026085415.6jgwrhq4sunqaypm@0002.3ffe.de>
 <20221209120343.wvagbfprsgdj74af@0002.3ffe.de>
 <4f279aa2-b5df-0b76-2cdf-ddb339a19cf7@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f279aa2-b5df-0b76-2cdf-ddb339a19cf7@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 22/12/09 02:14, Ajay.Kathat@microchip.com wrote:
> No progress yet. I tried to simulate the condition a few times but was 
> unable to see the exact failure in my setup so I need to try more.

Shouldn't it also be possible to see the issue by code reading? I've
provided the call tree in my previous mail and my concerns regarding
the locking. Either I'm missing something there or there is no
locking between these threads which could cause this issue.

> For the other "FW not responding" continuous logs, I got some clue. 
> Probably, will try to send that patch first.

Ok, let me know if you have some patches, I'm happy to test them.

-michael
