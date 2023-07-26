Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36369762D15
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 09:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGZHTJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 03:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjGZHSp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 03:18:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672C33583
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 00:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0908616BD
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 07:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48132C433C9;
        Wed, 26 Jul 2023 07:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690355739;
        bh=t8DhHa/ZfFQ4O+NBAyFPpqKY1E9TvtW68eNEjkdnSDY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Zr4/t27NI3HvWm90vbM1O3JQr7yST05eFidX3B6R4HgZYT4gz4dLfYf7W3Q602k4E
         SE7Y3+i9x/e2Ip3M5/gCsAVMAOMWORB7+jS1+iMfHSTYGtpoFU0BAwj/T0wkgLmSAG
         WM7RbiqV6lanSmCSpD1+rvChWHm/exu02c5UZ8Mx/ejAs6IRWgPMZvKl/6EF5gatro
         vnFpY9itefcg62HioZs0OKBt5AGhHITyvXqsV5Dgp934/XfncanqwT5ZV4qQygc1Yx
         iYgXCQegfQd4pgniustsALLYMnZMKg7dCG3acEnhujaDn/RCaw/0R4Xn0AFsGnE2T4
         HLdz79L4xYS2Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: MAINTAINERS: add Jeff as ath10k, ath11k and ath12k maintainer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230725094248.3205486-1-kvalo@kernel.org>
References: <20230725094248.3205486-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169035573624.3467307.11100400634973948208.kvalo@kernel.org>
Date:   Wed, 26 Jul 2023 07:15:38 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> Jeff will now start maintaining these drivers together with me.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Patch applied to wireless.git, thanks.

456b5e85d8a5 MAINTAINERS: add Jeff as ath10k, ath11k and ath12k maintainer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230725094248.3205486-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

