Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387444B590B
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 18:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiBNRqr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 12:46:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiBNRqq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 12:46:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163F013D24
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 09:46:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8E8DB81195
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 17:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6E8C340E9;
        Mon, 14 Feb 2022 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644860796;
        bh=mFZfJESN5YPqbf4m7yXIntL7A7Gn9sYUSUGxG6+Wneg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Vtpv4AXYQWO//hWfi8mccIeP4Qagl9HXJXnrmimr/ZhXi1sDfgsE4GczHBltFl1qK
         b+nJgXBk6gucX+7lhasrXF8pr8xsIxCEpiAfhOIdyyAKMBsvNmcLg0TDSbT41kFrVd
         KSm2+FvKiFiYndeqjtUHfY9jV3x/y3FjtV5adrby/vjHx+n9t9c8HmdOMiiv9qnTMu
         uIzOyen8joDXhcz/H5MW+dyJWgc2SOck+cnoZUeXDjVAuoSxaxaRTwlDl9EtRUi1lm
         ImDbKfk4IpAjEzUN9ayLaJk+I1K4/yho9u/UD8s39lz0j5coKr5cZP1pkNumne8UD0
         ioxQIzsUmtuew==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: fix WARN_ON during ath11k_mac_update_vif_chan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1644416019-820-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1644416019-820-1-git-send-email-quic_vnaralas@quicinc.com>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164486079376.4355.9676044145803792175.kvalo@kernel.org>
Date:   Mon, 14 Feb 2022 17:46:35 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Venkateswara Naralasetty <quic_vnaralas@quicinc.com> wrote:

> Fix WARN_ON() from ath11k_mac_update_vif_chan() if vdev is not up.
> Since change_chanctx can be called even before vdev_up from
> ieee80211_start_ap->ieee80211_vif_use_channel->
> ieee80211_recalc_radar_chanctx.
> 
> Do vdev stop followed by a vdev start in case of vdev is down.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

5ed98fb704d9 ath11k: fix WARN_ON during ath11k_mac_update_vif_chan
4f6dd92305f7 ath11k: fix radar detection in 160 Mhz

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1644416019-820-1-git-send-email-quic_vnaralas@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

