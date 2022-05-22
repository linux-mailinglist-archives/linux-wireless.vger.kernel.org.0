Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8371953030E
	for <lists+linux-wireless@lfdr.de>; Sun, 22 May 2022 14:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbiEVM3L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 May 2022 08:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbiEVM3J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 May 2022 08:29:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB353CA65
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 05:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0F075CE0ACE
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 12:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D59C385AA;
        Sun, 22 May 2022 12:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653222545;
        bh=TTwbaWYmNhgxiA2PEesTWAdjhrl9YmH717xkWYfvxco=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oWGa0P0xDhe/Utv0yFmPrBBhs0UnOj5pEKQ3eW0m4WUtLm/Wrpn0Z7L1vj4xpyIeo
         dhhMDmD4hDKX0UxE2zrl/qWWGchYg7vV7RG+F3eu1iJzW0EftDsSPHoCLOodEnWZyW
         4+adJ30P7ulCPoUk5OHHcsXrcuHlpdcHi0Mr0cpJ3TWq+VxDzDZ7fNSKEDmBaHN9uS
         OJUz3ay3xv3GyzaBPbewPZexjgk8GCctk4Nc9fuJM8TNE92tGG7WV2eiDicrFe4Ln0
         r0JOmkcRlvyU/9seAPilsWPIFxr0+qkMKwjYcTbyyoEz8NQ373I3U2kLTz5777zcL9
         qcOTmB4FYmgdA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix warning on variable 'sar' dereference before
 check
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220517004844.2412660-1-quic_bqiang@quicinc.com>
References: <20220517004844.2412660-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165322254267.774.12155186929267464272.kvalo@kernel.org>
Date:   Sun, 22 May 2022 12:29:04 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> We are seeing below warning:
> warn: variable dereferenced before check 'sar'
> 
> Fix it by moving ahead pointer check on 'sar'.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Fixes: 652f69ed9c1b ("ath11k: Add support for SAR")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

77bbbd5e0ed3 ath11k: Fix warning on variable 'sar' dereference before check

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220517004844.2412660-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

