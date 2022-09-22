Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3CA5E5C21
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 09:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiIVHQ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 03:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiIVHQg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 03:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B0DB4A9
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 00:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9789C6341A
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 07:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD42C433C1;
        Thu, 22 Sep 2022 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663830963;
        bh=Ug3vdNZrUkehAQu0PPgU5X+QRZMeNzLGuhSE+RMFoqI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=atBbsP5yZSiGDed0UEwbyYHSK+qTEfxtHlp3+BtfvI1XCMeRsPuo2wVdzQJr5wvIJ
         6lemTDN78N2ofHRyJgJ+aw+Y+kGcZLu3BOlOgGypDBBt7CM8xQxe6lukG0WPEvymXu
         M4wCMm1uD3nPvb53MSBT6wLHUoxOAQXzd2HEgGbi4hfzujmXvbtiBY7VUAkxrMlZwp
         Po5W56bqHp3pT+3tuJ7hxsJKM+AChWjDfrMcau7VjEDyWzVBPvP+DqJVC8nQYfYoHq
         pkR1shxy0JFbE5k7QkfYHoSXSl19FRW0GuC5k3fn4CpqaKRepbxAGBvDkXRt8s/6Po
         MduKYyHZvB5FA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: change complete() to complete_all() for
 scan.completed
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220919024413.25083-1-quic_wgong@quicinc.com>
References: <20220919024413.25083-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166383095879.28267.7782431891959207921.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 07:16:01 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently commit 1f682dc9fb37 ("ath11k: reduce the wait time of 11d scan
> and hw scan while add interface") introduced a wait_for_completion_timeout
> operation for ar->scan.completed, another one is existed in ath11k_scan_stop(),
> then ath11k has two places to wait for the ar->scan.completed and they
> run in different thread, thus it is possible to happend that the two
> thread both enter wait status. To handle this scenario, ath11k should
> change the complete() to complete_all() for the ar->scan.completed. This
> also work well when it is only one thread wait for ar->scan.completed.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

7855a6ed5cf7 wifi: ath11k: change complete() to complete_all() for scan.completed

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220919024413.25083-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

