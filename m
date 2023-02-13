Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E651D6944EF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 12:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjBML6M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 06:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBML6L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 06:58:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2684A5B88
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 03:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF6C960FE4
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 11:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DD4C433D2;
        Mon, 13 Feb 2023 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676289490;
        bh=Z0drZy9PrVSG3ZVXlacA1InhW5BoDam4jRCgidTy4sE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bfTfPrq5wQkBEH9lbs04W+FotxiQ8rO9olGsd+ybwGPmANXGits/Tf4S2TVoMwEkP
         J/fx6+Zi3R3MUXEgsncvu0KRvcil43FkgypYjgKcCRKlgXNJMXKiCB86+aSrtNFx5q
         qUUu3UgLVIDvEtt5RneA+la4WYrNeUaNPjAkgyn6IV6neCy3WV1g80U0UN+lXZN3OO
         A0+xqeEzZSDi2Tl1y8KmyFoZLOXLwWCuI9nttk3Uzzi2nUzuPf27KrsSrMc1PnnKdV
         gekqVX7l4xRTia3iJlzTmMUFzvR/TpOc1il3bGXGr89qW5GNZGIMnl+zpvsxkS9BnK
         R+li9q5UiLLhQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: Resume from hibernation fails due to ath11k_pci
References: <1263051271.53086.1674425560245.JavaMail.zimbra@nod.at>
Date:   Mon, 13 Feb 2023 13:58:07 +0200
In-Reply-To: <1263051271.53086.1674425560245.JavaMail.zimbra@nod.at> (Richard
        Weinberger's message of "Sun, 22 Jan 2023 23:12:40 +0100 (CET)")
Message-ID: <873579wze8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Richard Weinberger <richard@nod.at> writes:

> On my shiny new Lenovo T14s resume from hibernation always fails, and crashes the kernel.
> Looks like ath11k_pci is unable to resume the device.
> This happens also with Linus' tree as of today.

Unfortunately a known issue in ath11k but no fix available:

https://bugzilla.kernel.org/show_bug.cgi?id=214649

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
