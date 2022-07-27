Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ABA58240C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 12:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiG0KUD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 06:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiG0KUC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 06:20:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B2F220DA
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 03:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C523B82015
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 10:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4491BC433C1;
        Wed, 27 Jul 2022 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658917199;
        bh=vGy4avFvnSXh1+8K+r+y01EKaoKmQk8GxVtuOyg5cRU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=urK5w3VJFecpIWgxHtGE6LJ52W0LW050eFUEtltl+S0vMoZQo5gGll3Bu/ljfmb2M
         cgBto2Ievu1HVyz0tzSGAyQqh9VFYl6Kd9tjQgHrb9ENbr66N678iFvnmr7jBW46xm
         Ygmt2gYLHsdXtxer/a3nUunpBCvSlWBzCnEiiHYOYVclMmQhkPddzcx0qwUIN08QzE
         d/OqPdcoqukwOdy3ln2j54fBYArHG6KpH440z0FIMWpCuZQZC3qE8KIW5aCLEWfNs5
         Tpsb+YDb2GhbI5bm9JnrVhrftJRBzirdu7AIDqo0X09WKRwWI4qjequPeUfFiqNzFF
         zt6NcKh54Pv+w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Revert "ath11k: add support for hardware rfkill for
 QCA6390"
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220708164656.29549-1-kvalo@kernel.org>
References: <20220708164656.29549-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165891719619.18387.7495759163759552127.kvalo@kernel.org>
Date:   Wed, 27 Jul 2022 10:19:58 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> This reverts commit ec038c6127fa772d2c5604e329f22371830d5fa6. Tyler reported
> that on L390 Yoga Thinkpad with QCA6390 the suspend was failing because of this commit.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215881
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

169ede1f5948 Revert "ath11k: add support for hardware rfkill for QCA6390"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220708164656.29549-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

