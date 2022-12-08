Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F61647221
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 15:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLHOqR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 09:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLHOqP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 09:46:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC0DFEA
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 06:46:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A351A61F1E
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 14:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187DCC433C1;
        Thu,  8 Dec 2022 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670510773;
        bh=NZYiWDnKrzok7dOfgT2GVOiGbZZw7hDwghFzO4CzQJA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tDf5CTJxcVtf5Zq5c00cLxdiHpoym+ATBxnECvE8krXik/2DNxYSnp8hbPZSrLkm6
         ZgyrG3IbZ3pAiUfVA+llA1v5PewuXZ6cGTDfBiqO3NU9pmWll/CgvDOZxbcPGSCGGB
         TjvwNfbX0zcpmH+I7GluKQs+DQMObKnko+Rx5y9j8UeG3242lTUtt18AYgeMHk6Pyu
         0bWchXPJjWYiUb6B1fKRUbxhvAqqRax+Z+0nRUVOJT0hxFFFW1cgKKSVTEhT0yP8jn
         1sGUMLxzs1MR+sHxpR7I1nl9AQopLzQsKSl4l3KfRP67v9ukFQTwhBxAAvLZTP3bJg
         ZPXLzIny+qFqw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/3] wifi: rtl8xxxu: Add __packed to struct
 rtl8723bu_c2h
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com>
References: <1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167051076986.9839.5190764583556098656.kvalo@kernel.org>
Date:   Thu,  8 Dec 2022 14:46:11 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> This struct is used to access a sequence of bytes received from the
> wifi chip. It must not have any padding bytes between the members.
> 
> This doesn't change anything on my system, possibly because currently
> none of the members need more than byte alignment.
> 
> Fixes: b2b43b7837ba ("rtl8xxxu: Initial functionality to handle C2H events for 8723bu")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

dd469a754afd wifi: rtl8xxxu: Add __packed to struct rtl8723bu_c2h
76c16af2cb10 wifi: rtl8xxxu: Fix the channel width reporting
7de16123d9e2 wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

