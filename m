Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17F7B20B4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjI1PPv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjI1PPq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:15:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D248119D
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:15:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B1BC433C7;
        Thu, 28 Sep 2023 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695914144;
        bh=XOhBYn/JHHhfAw/p/+BQBzEcxPWQepN23p/3A8jF5aY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kIJMKyLGP8czi/FsD3bViZ8B8OSpGrvB01SnA1BHWrNlzNePGrS2cCyQpCmYULvu8
         sh4TPZWekcNvRbfGE/fTXYs4c6Co3JHxGSDqNyX5IFpU7IF299tCtvjzf8IoOt2aG6
         +GViy5wYKkDMeaXJ/xjdsyV7nI3956vtN0LNBfLorxAa0JchlWBmT7r/XaPhvsnim1
         lW/0Ed4OE1Ow6HoRz8qlGTkdIOEWtzuG5W7aa4+rr5oABlc4MCl/vGyWpUx0JPLITg
         I/n6p5NS3KGGwEY+l1S86hn7PzIVKd4w+XeysJaWMXip/JmwaAbMyvyitVqEkUV4j6
         9ZQwH+1mi8yMQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/1] wifi: ath11k: mac: fix struct
 ieee80211_sband_iftype_data handling
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230927142708.2897504-2-kvalo@kernel.org>
References: <20230927142708.2897504-2-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591414195.3019228.2015665207547569831.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:15:43 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> Commit e8c1841278a7 ("wifi: cfg80211: annotate iftype_data pointer with
> sparse") added sparse checks for struct ieee80211_sband_iftype_data handling
> which immediately found an issue in ath11k:
> 
> drivers/net/wireless/ath/ath11k/mac.c:7952:22: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/wireless/ath/ath11k/mac.c:7952:22:    expected struct ieee80211_sta_he_cap const *he_cap
> drivers/net/wireless/ath/ath11k/mac.c:7952:22:    got struct ieee80211_sta_he_cap const [noderef] __iftype_data *
> 
> The problem here is that we are accessing sband->iftype_data directly even
> though we should use for_each_sband_iftype_data() or similar. Fortunately
> there's ieee80211_get_he_iftype_cap_vif() which is just what we need here so
> use it to get HE capabilities.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Reported-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9e61589ac3c2 wifi: ath11k: mac: fix struct ieee80211_sband_iftype_data handling

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230927142708.2897504-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

