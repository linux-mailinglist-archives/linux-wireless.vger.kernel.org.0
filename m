Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8372DD5A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbjFMJLc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbjFMJLa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 05:11:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AC51A1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 02:11:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBC9C62A60
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 09:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE1EC433D2;
        Tue, 13 Jun 2023 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686647488;
        bh=4J/691CsI7iG+Ig8jeZXas086ObQ/IY7YU1DUEGxjZQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Xc6Nv1O2wrWHsWQhHoTVrImB1W11pXFuuGRl5wPOVK8tsZYtAe3w4du/hNHsn+NRP
         VabKRc0IQpaxpM4tF6q8MRSVQnEFFjF8luBBe9jbSK4JQpabVZiqb9a49cDZDh9X9s
         ygqVNBG9lIzraN0zBJBZ5Y/fOJP++hT17a6zv9+WmZTwhK5yFnBSpLKruX7B0V1cxX
         n9DLRYQnABk0wbIBnTbHv5GFJGY6COKybnWEfZrG9AZLGL6Bmj9HyKSPOBJVGrH2pV
         8Ub/ycw9qfFK2I0CvD2d5j5+8tYWpDTbVhZxl/oeoTp+m8puGzZESZjMGdITl1Gp6J
         niaJnHkSNe1Ig==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/15] wifi: ath11k: debug: remove unused ATH11K_DBG_ANY
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230609142440.24643-2-kvalo@kernel.org>
References: <20230609142440.24643-2-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168664748569.2274.11917166268138935303.kvalo@kernel.org>
Date:   Tue, 13 Jun 2023 09:11:27 +0000 (UTC)
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

> It's not used anywhere so can be easily removed.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

15 patches applied to ath-next branch of ath.git, thanks.

d13936d57927 wifi: ath11k: debug: remove unused ATH11K_DBG_ANY
9a599e968f02 wifi: ath11k: print debug level in debug messages
fc3b984a7d99 wifi: ath11k: remove manual mask names from debug messages
e5df15773d8d wifi: ath11k: add WMI event debug messages
8fbeaca7a001 wifi: ath11k: remove unsupported event handlers
90a9fb5b6618 wifi: ath11k: wmi: cleanup error handling in ath11k_wmi_send_init_country_cmd()
afba35d7d125 wifi: ath11k: wmi: use common error handling style
00608b40ae1a wifi: ath11k: wmi: add unified command debug messages
332c65628938 wifi: ath11k: pci: cleanup debug logging
947b5e224818 wifi: ath11k: dp: cleanup debug message
06819e471f28 wifi: ath11k: debug: use all upper case in ATH11k_DBG_HAL
ac483942616a wifi: ath11k: hal: cleanup debug message
cf036c416e9a wifi: ath11k: don't use %pK
3512593884b3 wifi: ath11k: htc: cleanup debug messages
4f52ec65a9ae wifi: ath11k: debug: add ATH11K_DBG_CE

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230609142440.24643-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

