Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD171109A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjEYQNd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 12:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjEYQNc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 12:13:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AFE10B
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 09:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFB1B64695
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 16:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9495EC433EF;
        Thu, 25 May 2023 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031210;
        bh=g+fGec5xJgpwZFb1JcUtl0o7XfOMV9jDXxHQ4GUSOb4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oFE0W0bjwfAcSmTsfTsQxrcULFy9IiKE1dgYMmm7/yMNLjKjp+UG9cVZEbzCUh/H0
         7UJH7omW6boYfj+UOTpHT1+NVcqn0BpH7UdUNHiQ3xEBE91KPwidFrblNVxMbH2+0b
         ieqDYne0uDnEWb0Ns2AOnDOYamcT11Ta1eczGMwJyTLkRLvSPcI4z1GavVDld2L46B
         63xHBBUALNZmhI2mrwLwGmcvqIAo0S7Ldi5bYjWGQzFT4mp3kQbKJGH7KKfiBK+30H
         UaZgSM+uXS1Wziq6ZDuqGkPDl4L10C0z4tpzWXuTVgpGgswRsJM5a8Mv4qBrf6kgzh
         eJDfkQ5BsulRg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw89: add chip_ops::query_rxdesc() and rxd_len
 as
 helpers to support newer chips
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230522122513.13559-2-pkshih@realtek.com>
References: <20230522122513.13559-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503120740.22756.467572244695871068.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:13:29 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The next generation chips use different RX descriptor format, so add
> a chip_ops to hook suitable handlers. Also, the length of RX descriptor is
> different, so add a variable to store the length according to chip and
> descriptor content dynamically. Then, the code can be more general.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

de9f93385d0f wifi: rtw89: add chip_ops::query_rxdesc() and rxd_len as helpers to support newer chips
88bdc3ff956c wifi: rtw89: use struct and le32_get_bits to access RX info
332debb80488 wifi: rtw89: use struct and le32_get_bits() to access received PHY status IEs
c26700d2df01 wifi: rtw89: use struct and le32_get_bits() to access RX descriptor
68012b44dfc7 wifi: rtw89: use struct to access register-based H2C/C2H

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230522122513.13559-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

