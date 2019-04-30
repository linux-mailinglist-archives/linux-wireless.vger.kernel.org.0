Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4583F79F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfD3LpY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 07:45:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbfD3LpX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 07:45:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 88D7C60741; Tue, 30 Apr 2019 11:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556624722;
        bh=e84h+9Ilxg0wEh/udlIncSD92bUIxVXOG4Yl3Crhwgk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=g/63WAkPIXh+aMjW4RyBgiZylJc2RkoJPW+9HxBbE+qNOv4fR9qS+C6HFsQi4sYoS
         k4FI5Co+awh6yvQIk60Es/1RcUjbYl2ha9xTXoWX1/weouhhRlLqaHQ9dWND35uVr8
         U7XU2QUt3nAB1BCcjARFtSMjd0KF67nHKhTKivrM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4AF0060741;
        Tue, 30 Apr 2019 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556624721;
        bh=e84h+9Ilxg0wEh/udlIncSD92bUIxVXOG4Yl3Crhwgk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RUN5wd5tGTmRqk9od5e6tMBYisLZ+eSUjNBN4zGUPAPROeC4BFFvmPGLW4VDNaJun
         t0mrcVaV3SON/YNCeg5QB/65GV6JgXNqVwdQh1oB1oiWgt/Z109KsYMkVf/g81g6Wq
         ZADyoymOTlxpXCv4DWlDXZz7YNLpnmGkyl7m+U+Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4AF0060741
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <pkshih@realtek.com>, <tehuang@realtek.com>,
        <Larry.Finger@lwfinger.net>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 01/14] rtw88: main files
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
        <1555653004-1795-2-git-send-email-yhchuang@realtek.com>
Date:   Tue, 30 Apr 2019 14:45:16 +0300
In-Reply-To: <1555653004-1795-2-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 19 Apr 2019 13:49:51 +0800")
Message-ID: <87zho7pvhv.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> main files for Realtek 802.11ac wireless network chips
>
> Reviewed-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> +static int rtw_ops_add_interface(struct ieee80211_hw *hw,
> +				 struct ieee80211_vif *vif)
> +{
> +	struct rtw_dev *rtwdev = hw->priv;
> +	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
> +	enum rtw_net_type net_type;
> +	u32 config = 0;
> +	u8 port = 0;
> +
> +	rtwvif->port = port;
> +	rtwvif->vif = vif;
> +	rtwvif->stats.tx_unicast = 0;
> +	rtwvif->stats.rx_unicast = 0;
> +	rtwvif->stats.tx_cnt = 0;
> +	rtwvif->stats.rx_cnt = 0;
> +	rtwvif->in_lps = false;
> +	rtwvif->conf = &rtw_vif_port[port];
> +
> +	mutex_lock(&rtwdev->mutex);
> +
> +	switch (vif->type) {
> +	case NL80211_IFTYPE_AP:
> +	case NL80211_IFTYPE_MESH_POINT:
> +		net_type = RTW_NET_AP_MODE;
> +		break;
> +	case NL80211_IFTYPE_ADHOC:
> +		net_type = RTW_NET_AD_HOC;
> +		break;
> +	case NL80211_IFTYPE_STATION:
> +	default:
> +		net_type = RTW_NET_NO_LINK;
> +		break;
> +	}
> +
> +	ether_addr_copy(rtwvif->mac_addr, vif->addr);
> +	config |= PORT_SET_MAC_ADDR;
> +	rtwvif->net_type = net_type;
> +	config |= PORT_SET_NET_TYPE;
> +	rtw_vif_port_config(rtwdev, rtwvif, config);
> +
> +	mutex_unlock(&rtwdev->mutex);
> +
> +	rtw_info(rtwdev, "start vif %pM on port %d\n", vif->addr, rtwvif->port);

I think this somewhat spammy. And looking at other uses of rtw_info():

mac80211.c:157:	rtw_info(rtwdev, "start vif %pM on port %d\n", vif->addr, rtwvif->port);
mac80211.c:168:	rtw_info(rtwdev, "stop vif %pM on port %d\n", vif->addr, rtwvif->port);
mac80211.c:318:	rtw_info(rtwdev, "sta %pM joined with macid %d\n",
mac80211.c:340:	rtw_info(rtwdev, "sta %pM with macid %d left\n",
rtw8822b.c:936:		rtw_info(rtwdev, "unsupport tx path, set to default path ab\n");
rtw8822b.c:940:		rtw_info(rtwdev, "unsupport rx path, set to default path ab\n");

I would just convert the last two to warning level, assuming those cases
do not happen normally. And the rest would be better as debug messages
to keep the dmesg clean.

-- 
Kalle Valo
