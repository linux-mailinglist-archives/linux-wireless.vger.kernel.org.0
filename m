Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07C476E438
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 11:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjHCJUu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjHCJT6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 05:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B0230EA
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 02:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0AD661CDA
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 09:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8DCC433C8;
        Thu,  3 Aug 2023 09:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691054396;
        bh=ShL7hrHKNKPly01wi1qDkRUwsTVX6toD8afVDWIE21c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=F/QQkStCbotVXmvBcxARavevCuFoNh97OEFhXYg1+xefLjNksaaz+8xtsjmOSNZaQ
         bTkst+Qe9jqs1gtuU3AJZRn1EyJ3/D7VCe4RPaV1cYMq/DoXTdiooneCz30s/qOH0g
         vYyf8QUfWll9pzdilBXYbWkOoWMU9EdSDOixnZ5KNEj4Sq65TkSg2wRkX+wpCLzh+o
         jfmXvF0NThAVJ31CMwzov8JeOgU0faFeefGiDGS50AfuHhWA/xYq90UI5T53N2bNhY
         Y5GdaG076u7hR7gIj9qmk66oj+l7N8r2thuZ7UuOqLSwawuU5uOKY5Nf7PFP+hKN4u
         /mPwxK0OgeHfA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: avoid deadlock by change
 ieee80211_queue_work
 for regd_update_work
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230718024724.29120-1-quic_wgong@quicinc.com>
References: <20230718024724.29120-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169105439308.894438.14073090276070005288.kvalo@kernel.org>
Date:   Thu,  3 Aug 2023 09:19:54 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Deadlock is easily happened while shutdown wlan interface such as run
> "ifconfig wlan0 down".
> 
> The reason is because when ar->regd_update_work is ran, it will
> call wiphy_lock(ar->hw->wiphy) in function ath12k_regd_update() which
> is running in workqueue of ieee80211_local queued by ieee80211_queue_work().
> Another thread from "ifconfig wlan0 down" will also accuqire the lock
> by wiphy_lock(sdata->local->hw.wiphy) in function ieee80211_stop(), and
> then it call ieee80211_stop_device() to flush_workqueue(local->workqueue),
> this will wait the workqueue of ieee80211_local finished. Then deadlock
> will happen easily if the two thread run meanwhile.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8198950ccb7d wifi: ath12k: avoid deadlock by change ieee80211_queue_work for regd_update_work

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230718024724.29120-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

