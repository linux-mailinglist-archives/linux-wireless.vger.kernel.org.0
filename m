Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02B053EB7E
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jun 2022 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbiFFOLa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jun 2022 10:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiFFOL2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jun 2022 10:11:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E2D275C0
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 07:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF644B819F4
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jun 2022 14:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEEFC385A9;
        Mon,  6 Jun 2022 14:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654524685;
        bh=ohccdRSsVDMKx6d8dgA8ZrbzxQNlb32a5JOCqtvymHY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=u9Xca3H63yHA1V2EmJMpO1lxvYNYWcCaG4Gx83pueHsITyJNN5beqtCW5orL44DMm
         sj+fslmMuBg3B07ZR7yynu7mprDB+LxCRmycPMBUS6hfF+0E3fUHL+fmjN+wVZvImw
         F2rF1yORgVYm3MeJfhP+udyDkO/MJTOA1tFlmIQ3zuiRIo+2bFbevSqg/+Pw03X047
         dQQDqqlA81bphi8WrpGHWyrwB2V5cpdrPLwQZHdkmO17ZIW9depUg1fhcs/bOrz1lE
         3kdUtKYZemMz496rQ+1586XYgpPWFEcWj0P7WWeS8GrjNLHi/vIt1WkhmZkgiAshcf
         axoWJUgAfd3qQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix warnings reported by checkpatch
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220602131350.29486-1-quic_mpubbise@quicinc.com>
References: <20220602131350.29486-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165452468243.15301.14990186060514165573.kvalo@kernel.org>
Date:   Mon,  6 Jun 2022 14:11:24 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Fix warnings reported by checkpatch tool. Below are the errors fixed,
> 
> drivers/net/wireless/ath/ath11k/hal_rx.c:760: 'recevied' may be misspelled - perhaps 'received?
> drivers/net/wireless/ath/ath11k/qmi.c:2232: Prefer strscpy over strlcpy
> drivers/net/wireless/ath/ath11k/qmi.c:2238: Prefer strscpy over strlcpy
> drivers/net/wireless/ath/ath11k/qmi.c:2662: Prefer strscpy over strlcpy
> drivers/net/wireless/ath/ath11k/mac.c:7836: 'atleast' may be misspelled - perhaps 'at least'?
> drivers/net/wireless/ath/ath11k/wmi.c:6566: 'succeded' may be misspelled - perhaps 'succeeded'?
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3926e0c12238 ath11k: Fix warnings reported by checkpatch

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220602131350.29486-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

