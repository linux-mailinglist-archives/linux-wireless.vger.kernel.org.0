Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8956DF169
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 12:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDLKBS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 06:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDLKBM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 06:01:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D366A78
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 03:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D83C463281
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 10:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5827BC433EF;
        Wed, 12 Apr 2023 10:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681293663;
        bh=wxQIxrE1sEIPcHGoXAoQ54vdCxjx5JCvEeSNNTXLzYI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=M0svBZ3gmNs6WoDKi5roXLgNnbGcwpvCqV3aiVkjykUJMw31rY5XtjPjR3/1u2AgH
         2QrBdVq47UvGPKFxZ6Eh17JO53VvX9qbknBbOcsdxT2J06RMIODj+BQgeHjLK4o/s2
         y74CRd+ejNmDV13qV5QN9jmqEhXEnghPlwFZ9w8sAGfkKTaXGfEulIAGshSKb5p1/r
         ag/HDuIvBlrd5/HNZl1KyAd8nXld0Tenwkt+9/EvE/YV2z1tu9YYYvV9WpnaeIawB0
         BYSeYmDpAYQloL67UkinDfYo0OhMRnI/49CBh+vITONDtjpSAdLvbWSP3JzIODRZil
         8QE7Rz9fsYw/w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: fix writing to unintended memory region
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230321052900.16895-1-quic_ppranees@quicinc.com>
References: <20230321052900.16895-1-quic_ppranees@quicinc.com>
To:     P Praneesh <quic_ppranees@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168129366046.14673.5219483047779494901.kvalo@kernel.org>
Date:   Wed, 12 Apr 2023 10:01:02 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

P Praneesh <quic_ppranees@quicinc.com> wrote:

> While initializing spectral, the magic value is getting written to the
> invalid memory address leading to random boot-up crash. This occurs
> due to the incorrect index increment in ath11k_dbring_fill_magic_value
> function. Fix it by replacing the existing logic with memset32 to ensure
> there is no invalid memory access.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d3d358efc553 ("ath11k: add spectral/CFR buffer validation support")
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

756a7f90878f wifi: ath11k: fix writing to unintended memory region

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230321052900.16895-1-quic_ppranees@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

