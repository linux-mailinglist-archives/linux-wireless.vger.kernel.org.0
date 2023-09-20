Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6B7A838D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 15:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjITNhp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 09:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjITNho (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 09:37:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381CD8
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 06:37:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28081C433C8;
        Wed, 20 Sep 2023 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695217058;
        bh=veIfcWlWTsrY0AmMLrZOqSmINoFBrTlbDMbu88kTSq4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=K50G4oOUnJw7XxXV7HiR0ddeIffMHY/xsM8j26rZRZUu/HEGiMw63MkkTwqPK0agU
         hRmINIMwtg5UbIhIVH06+oS32nUMCwRGzz8slsDr9czVFTOnqCofkRAZFzYxQ34ocR
         bUzq4PkYr3FRhkpOtuhufUrypFOxRnjwx/OkeCAl9n+NAX+idN2k52ALYZELzUs1Am
         hla+aMXvrq4qwd9MRU3yQf+QOPAWsQXtOb+mVWZjtlxI/hCvgce1vCr9pWWYQDsWuR
         09WE3CvVHMoyXII+PH1fRcyrXIO1H7VqoOtBuPeXmJRsf6+vvCzug+N3PSaoGpMGx9
         5fdG4zTWc/Ivg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: change to initialize recovery variables
 earlier
 in ath12k_core_reset()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230830060850.18881-1-quic_wgong@quicinc.com>
References: <20230830060850.18881-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169521705525.1118199.1914505460908896362.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 13:37:36 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Sometimes device recovery fail with this operation.
> Run test command for many times:
> echo assert > /sys/kernel/debug/ath12k/wcn7850\ hw2.0_0000\:03\:00.0/simulate_fw_crash
> 
> While recovery start, ath12k_core_post_reconfigure_recovery() will
> call ieee80211_restart_hw(), and the restart_work which queued by
> ieee80211_restart_hw() is running in another thread, it will call
> into ath12k_mac_op_start() and ath12k_mac_wait_reconfigure(), and
> the variables ab->recovery_start_count and ab->recovery_start is used
> in ath12k_mac_wait_reconfigure(), so ath12k need to initialize the
> variables before queue the restart_work, otherwise ath12k_mac_wait_reconfigure()
> maybe use the un-initialized variables. Change to initialize the 2
> variables earlier and then recovery process become correct.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

41e7a399aea1 wifi: ath12k: change to initialize recovery variables earlier in ath12k_core_reset()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230830060850.18881-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

