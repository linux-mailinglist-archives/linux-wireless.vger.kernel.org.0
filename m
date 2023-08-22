Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEDB784239
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 15:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjHVNjh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjHVNjg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 09:39:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2FC184
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 06:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D99063355
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 13:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD94AC433C7;
        Tue, 22 Aug 2023 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692711573;
        bh=AvKa/erUN0ws2EFeUpphX4aesqLNCkhhOUVpNvq2fU0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=go1QrCn/xeXC2hXBrygCCq2DgwwwprYSSEBkkvtPavzHJTUeQOT0TJVm8OoY+mzDV
         0y5bKZ0wJG69ZBn/v2myPvp5COE0Zl029bTRRkAIUEsJz2vgAIB/5ps+072biCrKuQ
         ht3urU+qfepLlRtHu7WwoavAoOodNfIPafGkjoToA1iNw6ElYWMJ6IDqrBStX2DnSZ
         o0YYZX6DwdJw/a9Hi/1fccR1np3m0ZAXurvdLfa5UT+wgqv4nbs2mbbUt4xlr52NUc
         O6l61Isn509XNQ1Oy0wGZGid4h9c6P/394nL/EE9P+D1GyMTQmzF8QUxths6TI22D5
         xyr8hooU9ezxg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath9k: Remove unused declarations
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230810145222.34364-1-yuehaibing@huawei.com>
References: <20230810145222.34364-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <toke@toke.dk>, <christophe.jaillet@wanadoo.fr>,
        <yuehaibing@huawei.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169271157074.680890.13591170537504180085.kvalo@kernel.org>
Date:   Tue, 22 Aug 2023 13:39:32 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yue Haibing <yuehaibing@huawei.com> wrote:

> Commit b57ba3b2f7b0 ("ath9k: move ath9k_reload_chainmask_settings to common")
> removed the implementation ath9k_reload_chainmask_settings() but not the declaration.
> Also commit 978f78bf7137 ("ath9k_hw: Move bt_stomp to hw from common.") left behind
> ath9k_cmn_btcoex_bt_stomp() declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

383e1b6a90c3 wifi: ath9k: Remove unused declarations

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230810145222.34364-1-yuehaibing@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

