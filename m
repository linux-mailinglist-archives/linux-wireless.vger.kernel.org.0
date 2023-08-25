Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5577C788110
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 09:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241493AbjHYHjs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 03:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbjHYHjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 03:39:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799021FDD
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 00:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B49C6632E
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 07:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B030C433C8;
        Fri, 25 Aug 2023 07:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692949178;
        bh=FcgVVWIaaMGjkWRZsa9rqhRNzHzscCG/+Ymzj0BEfvs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=p+XrHrOulAUWDDHX0td/HNe0svAjiDAdKf1h46w00jhI+VxzXTLKCpJdPyPzrL5Ug
         n2TxQwkkMKmRO+0gUU7yTfBSjHyVH/+noxckn7xLNHIbVWsUAcMoJ8MAK7sox4O6EU
         dLbwJV7OMOzSmUwu8VGA6/3rtI4qN+Evgfjvvwmkm8jlLXV2+CVFMW6xLvOZG1ZAa6
         tMmuXp7C/sGBLO0JX3/P/ZxaTmXGW6kSZlZD0cfjKnWIRh84EBFcRk3SNBkdDD2fr1
         SnlV3KK7Zs7DqWyEwJ1R8Bq4GHvOGjatcloFAE6jg88W5Xh2gJELa974ccR5/OwyJP
         bdZxXNuxZztOw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next 1/2] wifi: ath: Use is_multicast_ether_addr() to
 check multicast Ether address
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230814124212.302738-2-ruanjinjie@huawei.com>
References: <20230814124212.302738-2-ruanjinjie@huawei.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     <briannorris@chromium.org>, <johannes.berg@intel.com>,
        <Jason@zx2c4.com>, <toke@toke.dk>, <tj@kernel.org>,
        <mukesh.sisodiya@intel.com>, <quic_vjakkam@quicinc.com>,
        <johannes.wiesboeck@aisec.fraunhofer.de>,
        <linux-wireless@vger.kernel.org>, <ruanjinjie@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169294917411.1674223.16902367414818975262.kvalo@kernel.org>
Date:   Fri, 25 Aug 2023 07:39:35 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ruan Jinjie <ruanjinjie@huawei.com> wrote:

> Use is_multicast_ether_addr() to perform the Checking.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4c2964ef553b wifi: ath: Use is_multicast_ether_addr() to check multicast Ether address

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230814124212.302738-2-ruanjinjie@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

