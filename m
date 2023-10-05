Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799407BA554
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Oct 2023 18:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjJEQP6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Oct 2023 12:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241480AbjJEQO2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Oct 2023 12:14:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A8D24864
        for <linux-wireless@vger.kernel.org>; Thu,  5 Oct 2023 07:42:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA05C433A9;
        Thu,  5 Oct 2023 06:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696487012;
        bh=PW+4BzLpDF9zHyyfbmwr68+cskAVvPDqhBGD3+u9VWc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YgH19h+i+TwaxJadJfRPK+U1pi0dgxhqdfDnV6X0LSAmdVLPYfd7vyN45KnFyStEP
         lF8ld8rKP4MqKVu/k7HCv9xxg2HCfm8I6RwEG+FY1oB+tXvTqJ0Wvczu2EBzRIHNyH
         gTm6zJsAkteUh+Glqfd9XPAO66Q+4TAfJ7IRigFRzvc+xStQ21cmFrzsFBIFWFlmsb
         LCmyF8xWM+/PB2Qb+Inn6cthUS7H+mQOn2Ays833m6/WdASae/9u8NlM8CoNLzBLGT
         yJquf39KbPf3vNxp9VVJm7r9l4dVPhcim/iMy8LzrBkr3gj2Bp15ZQgIe350pCFzaT
         7JvMC9EwZlYJg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/3] wifi: ath11k: fix CAC running state during virtual
 interface start
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230912051857.2284-3-quic_adisi@quicinc.com>
References: <20230912051857.2284-3-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <johannes@sipsolutions.net>,
        "Aditya Kumar Singh" <quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169648700901.444191.6213111122304356892.kvalo@kernel.org>
Date:   Thu,  5 Oct 2023 06:23:30 +0000 (UTC)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> Currently channel definition's primary channel's DFS CAC time
> as well as primary channel's state i.e usable are used to set
> the CAC_RUNNING flag for the ath11k radio structure. However,
> this is wrong since certain channel definition are possbile
> where primary channel may not be a DFS channel but, secondary
> channel is a DFS channel. For example - channel 36 with 160 MHz
> bandwidth.
> In such cases, the flag will not be set which is wrong.
> 
> Fix this issue by using cfg80211_chandef_dfs_usable() function
> from cfg80211 which return trues if at least one channel is in
> usable state.
> 
> While at it, modify the CAC running debug log message to print
> the CAC time as well in milli-seconds.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

69fcb5259056 wifi: ath11k: fix CAC running state during virtual interface start
77f1ee6fd8b6 wifi: ath11k: fix Tx power value during active CAC

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230912051857.2284-3-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

