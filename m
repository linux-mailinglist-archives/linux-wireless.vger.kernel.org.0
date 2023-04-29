Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC0C6F232F
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Apr 2023 07:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347395AbjD2Fjo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Apr 2023 01:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347349AbjD2Fj1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Apr 2023 01:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7492C46B1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 22:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7CAD6135D
        for <linux-wireless@vger.kernel.org>; Sat, 29 Apr 2023 05:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F119C43445;
        Sat, 29 Apr 2023 05:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682746667;
        bh=KcRS/gSUxsdaEHHgcHS4mEbJp1Za+VdXFHnn97XmJA4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CcXINkHQdc/my3AWAk1Mwcc5+46F0VQHMzKEKYRnCGe1degcBR3qR6AH78YDk8n3U
         +HpfZ3CLLefCRrv5xs5XCCPQiFAeqyb0X/pF1MTVheWrfU/MnaTLhoy3q8pyAr0R9L
         qcMfRsb2D7aBRar5n0U+YXHvjXbROdFttCsctnLzdopMMfKAnyYEJlOkS52xg1sPZT
         9/n3byJq5Z/3Zo9n9DlvglUCQlSqmMhRKUcP1FlHUjFe5qbfKF78+ZE1A38qEnNXbA
         c1lgmWxoI4c5ynJO4BEc/k36D+/LADEfBnND8DmU/kw30uXwC+XINrvuUPqkZXw2e7
         EgDJQDhaZ8bsA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] wifi: ath11k: MBSSID parameter configuration in AP mode
References: <20230405221648.17950-1-quic_alokad@quicinc.com>
        <20230405221648.17950-5-quic_alokad@quicinc.com>
Date:   Sat, 29 Apr 2023 08:37:40 +0300
In-Reply-To: <20230405221648.17950-5-quic_alokad@quicinc.com> (Aloka Dixit's
        message of "Wed, 5 Apr 2023 15:16:45 -0700")
Message-ID: <87leibqme3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> writes:

> Include MBSSID parameters in WMI vdev up operation.
>
> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> Co-developed-by: John Crispin <john@phrozen.org>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---

[...]

> @@ -7153,8 +7161,13 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
>  			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
>  				    ret);
>  
> +		if (arvif->vif->mbssid_tx_vif)
> +			tx_arvif = (struct ath11k_vif *)arvif->vif->mbssid_tx_vif->drv_priv;

This had a warning:

drivers/net/wireless/ath/ath11k/mac.c:7200: line length of 92 exceeds 90 columns

In the pending branch I fixed it like this:

--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7143,6 +7143,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 {
        struct ath11k_base *ab = ar->ab;
        struct ath11k_vif *arvif, *tx_arvif = NULL;
+       struct ieee80211_vif *mbssid_tx_vif;
        int ret;
        int i;
        bool monitor_vif = false;
@@ -7196,8 +7197,10 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
                        ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
                                    ret);
 
-               if (arvif->vif->mbssid_tx_vif)
-                       tx_arvif = (struct ath11k_vif *)arvif->vif->mbssid_tx_vif->drv_priv;
+               mbssid_tx_vif = arvif->vif->mbssid_tx_vif;
+               if (mbssid_tx_vif)
+                       tx_arvif = (struct ath11k_vif *)mbssid_tx_vif->drv_priv;
+
                ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
                                         arvif->bssid,
                                         tx_arvif ? tx_arvif->bssid : NULL,

Link to the commit:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=c884238009e778a0c8202a5eb0a7f68b13200bde

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
