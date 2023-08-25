Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4067880FE
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 09:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjHYHiM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 03:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbjHYHiE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 03:38:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4BF1FC4
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 00:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B9DA6273C
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 07:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A1BC433C7;
        Fri, 25 Aug 2023 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692949081;
        bh=rIJIPqcFDi8P6Ugm4UnTsYJPEN9MCdsOm9JaqnZrxw4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Rrgcp9Ffq85CLtYlK2qoHc/Z+itQSZ3kGOv3FLfqskuv95eFbyvFr3K3aypkzKflo
         ZCbWQes3DzyUPh08BzMVFGoenbspABUa7bfIXvJwzLJXML0rcSHsU9ik1rn8izvTZo
         o4yGTzvNzkWZQsbR6ApD6XAj1HyHIFYekHj3BvhB0BP/Tp96208oBC2Nv59OyJn4m8
         +vQWTLKv/6YzOJrsn661S0d9C4K5j8CEAIbI5hJle5ZFEsCsBIdEgVR1hiMt7MLDDA
         aEIfGOF8GKjXCLDp19rtNmQjjwML9Z2CWSQib85v5iBRunBAVj/BkUcHRfA4a1qFWq
         KvRxrVjZaNqZg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Remove unused declarations
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230816130550.50896-1-yuehaibing@huawei.com>
References: <20230816130550.50896-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <yuehaibing@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169294907848.1674223.5754694111228394396.kvalo@kernel.org>
Date:   Fri, 25 Aug 2023 07:38:00 +0000 (UTC)
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

> Commit d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> declared but never implemented these, remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

0e5b1b46925b wifi: ath12k: Remove unused declarations

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230816130550.50896-1-yuehaibing@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

