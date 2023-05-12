Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9895670025A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 10:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbjELIPG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 04:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbjELIPF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 04:15:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FE8F
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 01:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A3FE653D4
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 08:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3222C433D2;
        Fri, 12 May 2023 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683879303;
        bh=Mn7kKvhZlvcG0pK0ceoTcJDjb3wPFHcvuQDtzeD5k7s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KNy2htuO5o4i8pRSUibIcmVX30fssvOWAncQm/6p9rwMvfAkQZmctGkfhnHbazjTB
         aj4UWG9JOjfDRo/rdQzFKXj7ldkprcOy/jWP9Ipq1+7jgqiehUjTDN0SDtEwmd+SfM
         QV5AYuBAUhrx0cN1uuSZX9vbLmcfDFkg3RaeRyncoa4J79ECkEIl/KvKdJ+i1KE60o
         l8pgKXs1qUKb68ytZ6tVWmRCooa6QasekkIgr9Kxl3wq0KrapmTD5s354TmD8E/fV+
         rWkpzxIszfRUpwr3e98B7BRgG0g3ceP/Z6Qf+fP0cQDuo3CTAwp9C6tv5IsykU7JE1
         xldaFL/FOltDg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: Remove CONFIG_RTL8XXXU_UNTESTED
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230430171519.13422-1-Larry.Finger@lwfinger.net>
References: <20230430171519.13422-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168387929841.10206.6619513559382282389.kvalo@kernel.org>
Date:   Fri, 12 May 2023 08:15:02 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> This parameter is selected by openSUSE, Fedora, Ubuntu, and Mint. Of the
> distros that I checked, only Debian on ppc32 did not select it.
> Eliminating this option will have little effect on Linux users, and is a
> necessary step in the elimination of the old rtl8192cu driver in the
> rtlwifi family.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Dropping per discussion in:

https://patchwork.kernel.org/project/linux-wireless/patch/20230428182933.19157-1-Larry.Finger@lwfinger.net/

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230430171519.13422-1-Larry.Finger@lwfinger.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

