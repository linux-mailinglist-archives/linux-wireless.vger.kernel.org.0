Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B599F5BCC12
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 14:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiISMoN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiISMns (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 08:43:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FA528E2D
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 05:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5129CB801B8
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 12:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44568C433D7;
        Mon, 19 Sep 2022 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663591416;
        bh=6nFVlHwJDwxB0EofWEOgiD+e6k7WCTuiWYz6W7BrpIk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Jxo1Ja34HiGIMf3ZkkZHbn7muatDQdJ0v7TO+clpinpOHzT+PbeJJpjBCrxikdl4g
         YrIch4AoCaNck5otx7I9QiV4WRN8NbFWbUDFzGOH/Udh50MWtznwhUi7lS/QYj4GEw
         dE690ZPvLeRSRknXY8XvHn6Zopki0XWJZZM0E3hKpniLoFncmhcEroazDfLgAJaNuJ
         g1Uw3fbMXH89PDuF+9KpxNF1oXRxMthErfzvOHA2x6tGJG0SBtusfNW8Akh6bJRNW0
         JMAxZFmZfsOeboeKYJJaaU+15D4NRBQoc5Mhk9hyafgF9SoF3++22yEgxpy8t6Vdwp
         HhchvZSxeQrpg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Include STA_KEEPALIVE_ARP_RESPONSE TLV
 header
 by default
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220913044358.2037-1-quic_bqiang@quicinc.com>
References: <20220913044358.2037-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166359141336.17652.14533007479146714072.kvalo@kernel.org>
Date:   Mon, 19 Sep 2022 12:43:35 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> In current code STA_KEEPALIVE_ARP_RESPONSE TLV header is included only
> when ARP method is used, this causes firmware always to crash when wowlan
> is enabled because firmware needs it to be present no matter ARP method
> is used or not.
> 
> Fix this issue by including STA_KEEPALIVE_ARP_RESPONSE TLV header by
> default.
> 
> Also fix below typo:
>   s/WMI_TAG_STA_KEEPALVE_ARP_RESPONSE/WMI_TAG_STA_KEEPALIVE_ARP_RESPONSE/
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Fixes: 0f84a156aa3b ("ath11k: Handle keepalive during WoWLAN suspend and resume")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b7b6f86149a7 wifi: ath11k: Include STA_KEEPALIVE_ARP_RESPONSE TLV header by default

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220913044358.2037-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

