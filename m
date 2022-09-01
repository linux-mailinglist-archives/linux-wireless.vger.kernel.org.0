Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788FD5A9CB5
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Sep 2022 18:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiIAQKF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 12:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiIAQKD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 12:10:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22991F5A3
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 09:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F12D4B82869
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 16:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4DCC433D7;
        Thu,  1 Sep 2022 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662048596;
        bh=6hvdDiook25zvx8FoPSAj5qTF9HrsRKDM9Y/2TDoYV4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NbmacAaAnj69JGErJtjcFHE/aNsumMpMz+pdiUWUU6gjD3b048InSFT+we4Ug6m9b
         vyL0smTaZzmlKtoFWDzWQ3ywdEGmhBROQE8H3nUhgi0qi2aQZe+8md6xACk7pMlD6d
         0+KXpdLvM9TRTaKQhqxlVFR8xRhk/5zilKTBdeEnYrdbmj0SFedbhFU7E0Mlqoi4T2
         8Qtx8sFhVXlJ3LuyclfPmkt+kkjzO4pzDvu9FNq7hgAYYGuX4sk1DfDgJGHdaOsR0u
         rVmxIGiiKU37XL3tOh296JQbmlP/kZCxljEunPvV37+Dv+uRCxjI9DLs7FSlfQjLYD
         gye0BFbFh3syg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Register shutdown handler for WCN6750
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220720134710.15523-1-quic_mpubbise@quicinc.com>
References: <20220720134710.15523-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166204857927.15293.15300946292599236513.kvalo@kernel.org>
Date:   Thu,  1 Sep 2022 16:09:55 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> When the system shuts down, SMMU driver will be stopped and
> will not assist in IOVA translations. SMMU driver expects all
> of its consumers to shutdown before shutting down itself.
> WCN6750 being one of the consumer device should not perform any
> DMA operations after the SMMU has shutdown which will otherwise
> result in SMMU faults.
> 
> SMMU driver will call the shutdown() callback of all its
> consumer devices and the consumers shall stop further DMA
> activity after the invocation of their respective shutdown()
> callbacks.
> 
> Register the shutdown() callback to the platform core for WCN6750.
> Change will not impact other AHB ath11k devices.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ac41c2b642b1 wifi: ath11k: Register shutdown handler for WCN6750

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220720134710.15523-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

