Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8ED27BF23
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 10:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgI2IU2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 04:20:28 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:11625 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgI2IU2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 04:20:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601367627; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=3FrG5rxeuQOX9TtiMzLMWxPXi9gcJGQaeQPWdKB6wRs=; b=fOw62/O1sIUX5VP/4aNLGQ6xlL9CbgFQhG/NHGB9GSJ8ssgfLAE8KJwnugz7khk3vu8Ty1Md
 kwbAKT6o7RENMvq36VRwAYb3/+jYMdGcmUZJt+NT9EwXgpr2O7OJTERBDX3BbS9XiJJ+qvO0
 BNuyP6B2h5lIT7ljwsoFF8ZiQ7k=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f72ee4aaada82eaa45c3f53 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 08:20:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4DBC1C433FE; Tue, 29 Sep 2020 08:20:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3A83C433C8;
        Tue, 29 Sep 2020 08:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3A83C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <tehuang@realtek.com>
Cc:     <yhchuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/5] rtw88: handle and recover when firmware crash
References: <20200925061219.23754-1-tehuang@realtek.com>
        <20200925061219.23754-3-tehuang@realtek.com>
Date:   Tue, 29 Sep 2020 11:20:21 +0300
In-Reply-To: <20200925061219.23754-3-tehuang@realtek.com> (tehuang's message
        of "Fri, 25 Sep 2020 14:12:16 +0800")
Message-ID: <87o8lpyoxm.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<tehuang@realtek.com> writes:

> From: Tzu-En Huang <tehuang@realtek.com>
>
> This handles the situation when firmware crashes.
> When firmware crashes, it will send an interrupt, and driver will queue
> a work for recovery.
> In the work, driver will reset it's internal association state, which
> includes removing associated sta's macid, resetting vifs' states
> and removing keys. After resetting the driver's state, driver will call
> rtw_enter_ips() to force the chipset power off to reset the chip.
> Finally, driver calls ieee80211_restart_hw() to inform mac80211 stack
> to restart.
> Since only 8822c firmware supports this feature, the interrupt will only
> be triggered when 8822c chipset is loaded.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>

[...]

> +int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
> +		struct ieee80211_vif *vif)
> +{
> +	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
> +	int i;
> +
> +	si->mac_id = rtw_acquire_macid(rtwdev);
> +	if (si->mac_id >= RTW_MAX_MAC_ID_NUM)
> +		return -ENOSPC;
> +
> +	si->sta = sta;
> +	si->vif = vif;
> +	si->init_ra_lv = 1;
> +	ewma_rssi_init(&si->avg_rssi);
> +	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
> +		rtw_txq_init(rtwdev, sta->txq[i]);
> +
> +	rtw_update_sta_info(rtwdev, si);
> +	rtw_fw_media_status_report(rtwdev, si->mac_id, true);
> +
> +	rtwdev->sta_cnt++;
> +	rtw_info(rtwdev, "sta %pM joined with macid %d\n",
> +		 sta->addr, si->mac_id);

This was already in the driver before, but I'll comment still that I
find it bad practise to spam the log like this everytime a STA
associates or disassociates. So I would be happy to apply a patch to
change these messages to a debug message.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
