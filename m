Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF36062B68A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 10:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiKPJbQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 04:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKPJbP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 04:31:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6812761
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 01:31:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B96861B36
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 09:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06400C433C1;
        Wed, 16 Nov 2022 09:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668591074;
        bh=PSpRGTJV0bPPR32LjTRXK7BM0OYVFGwQJenULdOXxp8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TnPZbFDMfrQlcCSYIipbdEZPlWOnz4T+h6gjYbIVEOrSa96PmcAX3gZVwNqDofAgf
         c5/0t9vzMOPz3mjUycy0j01fO6PeafIKv8hsZINkOKxnDDuBnmGObOuTF7SCDK7aqv
         YWHayPC1NgALodIs+vupL6BxaP+S62SBC4awFn0ONTtZJMDaG8+Dv+qALBEYjmUfoo
         aOVt0x8m7rzkff/RbnhnYeSX0jr+nc4MHt/Q58xzKe+DqpBU3ikyLCwZmY/WCGfMK/
         HfWJMhXRfQFMQpnmOMv1xdrYkMd/JZmb35WUjGy2rjyCnLYdSmtg82ToqkJV+XrMu7
         hZ/dmFegnUqwA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wifi: rtl8xxxu: Name some bits used in burst init
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com>
References: <e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166859107066.16887.10800694299022449182.kvalo@kernel.org>
Date:   Wed, 16 Nov 2022 09:31:12 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Use descriptive names instead of magic numbers.
> 
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

486e0315c4a1 wifi: rtl8xxxu: Name some bits used in burst init
9b00565abf3f wifi: rtl8xxxu: Use strscpy instead of sprintf
60d18ddb53ce wifi: rtl8xxxu: Use u32_get_bits in *_identify_chip

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/e7d05bd9-e096-8361-f1b4-3c8b8599a7eb@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

