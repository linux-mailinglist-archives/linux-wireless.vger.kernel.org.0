Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8537D6F8359
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 14:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjEEM5B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 08:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjEEM5A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 08:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5051FDA
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 05:56:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 217B463DA1
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 12:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFE0C433D2;
        Fri,  5 May 2023 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683291418;
        bh=LqboN86lk1pQb0m3e4Qf+Jmh3aLEz38XRms+T3U9DV8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jk6xg26/MvKP7C1mM1xoErVGTJPC4g3I1YmMcN5kNDTkZem5jYR/rvU3V01yupBrL
         Abjz3waGIOI0J5Az2LTcEW7Iuk60pXEnwnthCvSr6I6wtevPPJztFEMG3qjRrrz37H
         rZQAcuc27pqXmxUsMWMDD6o2LtkrGb41RMPVOfMuFtrmty/o4me5w5sGE1JFLgwSdn
         3x2ERJ++/RnXKfcf4zzEKRnaTL9hapyBb1/89UneoIqApAMZ84x1bau+/W0lkGfY/Z
         WbijULaQoa+VVi6FuEQabtPLq2Aut1f2zZJnWOmdlU40saKx/E7p8CJyUpu8wp7wdl
         JesekotGjS+xQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: add wait operation for tx management
 packets
 for flush from mac80211
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230419095738.19859-1-quic_rgnanase@quicinc.com>
References: <20230419095738.19859-1-quic_rgnanase@quicinc.com>
To:     Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthik M <quic_karm@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168329141362.30600.16864220030105499975.kvalo@kernel.org>
Date:   Fri,  5 May 2023 12:56:57 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ramya Gnanasekar <quic_rgnanase@quicinc.com> wrote:

> Transmission of management packets are done in a work queue. Sometimes
> the workqueue does not finish Tx immediately, then it lead after the next
> step of vdev delete finished, it start to send the management packet to
> firmware and lead firmware crash.
> 
> ieee80211_set_disassoc() have logic of ieee80211_flush_queues() after
> it send_deauth_disassoc() to ath12k, its purpose is make sure the
> deauth was actually sent, so it need to change ath12k to match the
> purpose of mac80211.
> 
> To address these issues wait for Tx management as well as Tx data packets.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthik M <quic_karm@quicinc.com>
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

5189a8dba849 wifi: ath12k: add wait operation for tx management packets for flush from mac80211

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230419095738.19859-1-quic_rgnanase@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

