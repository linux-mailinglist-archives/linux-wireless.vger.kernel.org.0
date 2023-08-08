Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E813B774556
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 20:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjHHSl1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjHHSlJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 14:41:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B35238FF
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 10:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7BAD62910
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 17:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610FBC433C7;
        Tue,  8 Aug 2023 17:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691516566;
        bh=94iIyGM04zZcBtLodB23NRck92fPzkLkeSTS+OWUALw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqNYHeT1pJh9YxVKJoi5nzRDcj0f+8G+tVRNv4aNOkPsiWewrcKc2N83k+VBG/WkA
         Ac/Fzd9QUajZIYdEdl6ecQHqjdiscKSy6trnrClPz6uxlbc2+LfLhiV8P36pxIFCdx
         JXupn5ymAmsjvHaD19f+febYqOZKWcelLpQdXO9RkR8VFoKGUCgSHpYfa5r4SzlZ79
         OmEUk6zE48/Y2EUgxu5mtljmniJc9UWt6TlsE8dcsg/B1W9PafEaeq2LR7WNNVvKaa
         QDRYbBzdrCBtuS2qGVsMhOoXst0j61iJYNeHwv7dkhuihQrXl0BsDNMomtLYj4JUwa
         emVi6bgmMdDKQ==
Date:   Tue, 8 Aug 2023 19:42:41 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        horms@kernel.org
Subject: Re: [PATCH v3] wifi: iw_handler.h: Remove unused declaration
 dev_get_wireless_info()
Message-ID: <ZNJ+kc30fcNirPc1@vergenet.net>
References: <20230807145032.44768-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807145032.44768-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 07, 2023 at 10:50:32PM +0800, Yue Haibing wrote:
> Commit 556829657397 ("[NL80211]: add netlink interface to cfg80211")
> declared but never implemented this, remove it.
> Commit 11433ee450eb ("[WEXT]: Move to net/wireless") rename net/core/wireless.c
> to net/wireless/wext.c, then commit 3d23e349d807 ("wext: refactor") refactor
> wext.c to wext-core.c, fix the wext comment.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

