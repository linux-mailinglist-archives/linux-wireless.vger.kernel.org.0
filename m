Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376455BA66E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 07:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIPFlA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 01:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiIPFk7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 01:40:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3FC7FE58
        for <linux-wireless@vger.kernel.org>; Thu, 15 Sep 2022 22:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CFCAB8235A
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 05:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868FBC433D6;
        Fri, 16 Sep 2022 05:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663306851;
        bh=0Ry4wH5Rz2WvxH+iMDnYDOverOqyXZxPcfiZSKnbpFw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=I0LerziGGTBlBA+grbLxwWaw/+uToo+hb7gYV5vrH53HX7L8ZqIea/e5iXFK0EofE
         733k1aQ5BUULc5vhp8A2sqE8t6XLxfiflIiLSheXtIikJimlAh+wD2C5QXnegLFKde
         /ul6kzR9ee458xTn/J0aG6bb5rzmCTDiWT8RBo9ave9oMcAZHR0wG9TEeUcHfp5XFG
         4RzoryrXu06YKY0ESVHTTCd9eDxmTwv5hEw4nW0rUUuH2vOXwGrQLEJxy/bmOmkedv
         BDmo3PkiW6ovgcVhOY9doghazpEAhljTHU3KzDmN4/o1bN7K4dNVBD1I6BnEL6Yf4m
         nhE6qz39Z/NBw==
From:   Kalle Valo <kvalo@kernel.org>
To:     <sean.wang@mediatek.com>
Cc:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <kuabhs@google.com>, <druth@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3] mt76: mt7921: fix antenna signal are way off in monitor mode
References: <e987d8149d6e00b2bec979a343681ddedea3c347.1663288354.git.objelf@gmail.com>
Date:   Fri, 16 Sep 2022 08:40:40 +0300
In-Reply-To: <e987d8149d6e00b2bec979a343681ddedea3c347.1663288354.git.objelf@gmail.com>
        (sean wang's message of "Fri, 16 Sep 2022 08:39:19 +0800")
Message-ID: <87tu57anc7.fsf@kernel.org>
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

<sean.wang@mediatek.com> writes:

> From: Sean Wang <sean.wang@mediatek.com>
>
> Group 3 in RxD is disabled in monitor mode. We should use the group 5 in
> RxD instead to fix antenna signal way off issue, e.g we would see the
> incorrect antenna signal value in wireshark. On the other hand, Group 5
> wouldn't be used in STA or AP mode, so the patch shouldn't cause any
> harm to those modes.
>
> Fixes: cbaa0a404f8d ("mt76: mt7921: fix up the monitor mode")
> Reported-by: Adrian Granados <agranados@gmail.com>
> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

The title is missing "wifi:".

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
