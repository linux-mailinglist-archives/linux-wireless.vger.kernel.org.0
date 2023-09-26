Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241CE7AF0D6
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjIZQgw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbjIZQgt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 12:36:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B9BB3
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 09:36:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B478C433C7;
        Tue, 26 Sep 2023 16:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695746202;
        bh=lP81uXoqChNq6ZrPgB/+WsvOkHx6EnfAUwM1LkqDnvU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CKbs5rJ0/RY2YSaDoBpcEwpN4FKzVMUIxuRpWOM+IJXQ2cARULamePKKGm69YBj3a
         EXewJ2LBEsDebRZ/p+APfg3H/NPIH4iJEc+NXT6O7V+oHn2srYUvSKWZU4x/ImzxFP
         0sjfxyn0KglrgfqEVzsS68gEsIucNYWuAnlxZJ0MiOdFfkdd6/Qxtlj1JiiThr/W9L
         8XNCHKK5ImfQZfhNu0VjiBd49YM+mf1mRFKlc9Z5rQQw7xKCcgigYc7cVOTYpoKvAT
         6mgw7agEBRGD1D7qtsHMGAxrrp699ETLX7Fv4DgqnK1ope7UamRWOWzKt8/FtpmsEs
         T9HA6pryhJYAA==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath11k: mac: fix struct
 ieee80211_sband_iftype_data handling
References: <20230926163350.2641064-1-kvalo@kernel.org>
Date:   Tue, 26 Sep 2023 19:36:40 +0300
In-Reply-To: <20230926163350.2641064-1-kvalo@kernel.org> (Kalle Valo's message
        of "Tue, 26 Sep 2023 19:33:50 +0300")
Message-ID: <87jzsc99if.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> From: Kalle Valo <quic_kvalo@quicinc.com>
>
> Commit e8c1841278a7 ("wifi: cfg80211: annotate iftype_data pointer with
> sparse") added sparse checks for struct ieee80211_sband_iftype_data handling
> which immediately found an issue in ath11k:
>
> drivers/net/wireless/ath/ath11k/mac.c:7952:22: warning: incorrect type
> in argument 1 (different address spaces)
> drivers/net/wireless/ath/ath11k/mac.c:7952:22: expected struct
> ieee80211_sta_he_cap const *he_cap
> drivers/net/wireless/ath/ath11k/mac.c:7952:22: got struct
> ieee80211_sta_he_cap const [noderef] __iftype_data *
>
> The problem here is that we are accessing sband->iftype_data directly even
> though we should use for_each_sband_iftype_data() or similar. Fortunately
> there's ieee80211_get_he_iftype_cap_vif() which is just we need here so use it
> to get HE capabilities.
>
> Tested-on: WCN6855 hw2.0 PCI
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>
> Reported-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Changelog for v2:

* use ieee80211_get_he_iftype_cap_vif() instead of open coding it

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
