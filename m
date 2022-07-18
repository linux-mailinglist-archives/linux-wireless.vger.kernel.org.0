Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51987577F43
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jul 2022 12:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiGRKEW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jul 2022 06:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiGRKEV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jul 2022 06:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E652ADA;
        Mon, 18 Jul 2022 03:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1095260B06;
        Mon, 18 Jul 2022 10:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9351C341C0;
        Mon, 18 Jul 2022 10:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658138658;
        bh=NXCJrdwlfXGhw2SIEd4NT0Rz/4qnzW7rKrxGPtjHVJA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HjMA5IxYoPYG3APFKQCFIzUj/F7mTVbWrs98aRpCT9IeDL4941BgmT4ItesDbWYzq
         NYC5+AM1WPk8T3mHvRb0yZqkUyi/uoY9GIsWULIxQnJYZt0uql+L6YC0g0VkpqkjhM
         xSAj0HpjxXpPVDLjGhFJuPLI3xJmqrZSeQTw/zZ740gAJvAmkkDZ0p93SP4UvCgmAg
         il0DcYncClS2uwJAhlMAfVM15yZbSuzH+kRnoNHYDmv/KtPUc48ukBRoiXs9/J73tj
         PnVJteNewWjt5W9BShayB7HiFxdqOF7izb+JrXerkfyx41v/EXKUUKgmrhAAWO2dPF
         WvSLQWbTWNtxA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wil6210: debugfs: fix info leak in
 wil_write_file_wmi()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <Ysg14NdKAZF/hcNG@kili>
References: <Ysg14NdKAZF/hcNG@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vladimir Kondratiev <qca_vkondrat@qca.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165813865512.12812.10345209648253608614.kvalo@kernel.org>
Date:   Mon, 18 Jul 2022 10:04:16 +0000 (UTC)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The simple_write_to_buffer() function will succeed if even a single
> byte is initialized.  However, we need to initialize the whole buffer
> to prevent information leaks.  Just use memdup_user().
> 
> Fixes: ff974e408334 ("wil6210: debugfs interface to send raw WMI command")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

7a4836560a61 wifi: wil6210: debugfs: fix info leak in wil_write_file_wmi()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/Ysg14NdKAZF/hcNG@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

