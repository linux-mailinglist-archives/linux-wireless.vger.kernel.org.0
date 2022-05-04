Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58FA51970A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 07:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbiEDFv2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 01:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiEDFv1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 01:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E52AC4A
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 22:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE87660C80
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 05:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564D8C385A4;
        Wed,  4 May 2022 05:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651643271;
        bh=lPaxMDnEb8CGp/k+R7ms4YI/h82d9xkmM+ovtzYYFds=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BArvJ6F4rYGIG5U+W8/D5KIawiShQob4LjX55c2nIEofF17N/me8YEFmfXwz5LzLh
         J1di5L4i3yUgTG3OnH0wb7USklTdJtn2FJx+xPvrPp3qgq3cUtcSINS/rhutQ4cfG6
         BZVd1Zvjog0fsu+1EBoCrcRZJoJdgr3G8IcHa9bnmjD75+7ju7iY9ZPpXtrSCxilgm
         AQapet8T63K/RISEsnB/XzXswEcchXCuzqldvT4jHzJokghSI/pe41UvLR6yJyJPzz
         I76wa8nLeBXXHdQ84+uAXPmwfufL7yDIpTiC2DOW//gZ3vqhGO3BWhPmnUS0FBC1R5
         f8AvzsBKkZfpw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath11k: Add support for targets without trustzone
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220328062032.28881-1-quic_mpubbise@quicinc.com>
References: <20220328062032.28881-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165164326664.16064.14437072371247614794.kvalo@kernel.org>
Date:   Wed,  4 May 2022 05:47:50 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Add the support to attach WCN6750 and map iommu domain
> for targets which do not have the support of TrustZone.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f9eec4947add ath11k: Add support for targets without trustzone

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220328062032.28881-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

