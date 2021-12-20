Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C1047B35F
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 20:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbhLTTDV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 14:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbhLTTDU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 14:03:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C2C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 11:03:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6ECBCE1130
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 19:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423E1C36AE2;
        Mon, 20 Dec 2021 19:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640026997;
        bh=qk+Il0mse2agkZ8vlkrERPIHHbDmRjXbTHuasjQ5hCY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MXxQ40Whdzyb1Um3ljNOsM5YYc96uQFk2gFlP6iT0J39DyG6QvuIPVxuX9L3+pDmF
         MX5lZSXvjFm4Ycr+W8MfFV4tFsAjBx7EZYEnZtR6u2UiCTbVwUOCvDZbRN+rrgbfGX
         1KkGHgnSlIpmwu7kCU6rRSeo97+b2r++RGPaPT4Yvzch6uwDfQBZPCYajtteuRaW0q
         CRPJ28u74TlzF+0RC/ZFlSPyx0AjW8aBGXRNe4Y6/zcyXehHbF3hgsJy7mTktr5eTP
         EgKFY8IRY1RNcP6EPYvhtw+CPN8vWZLv4zObrQpU8FxZkGGAqDDX+5vvyLY4kGOTwH
         X3NwtLj9SHurw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>
Subject: Re: [PATCH] rtw88: 8822c: add ieee80211_ops::hw_scan
References: <20211217012908.9856-1-pkshih@realtek.com>
Date:   Mon, 20 Dec 2021 21:03:12 +0200
In-Reply-To: <20211217012908.9856-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 17 Dec 2021 09:29:08 +0800")
Message-ID: <87ilvj9k0f.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Po-Hao Huang <phhuang@realtek.com>
>
> Declare this function allows us to use customized scanning policy.
> By doing so we can be more time efficient on each scan. In order to
> make existing coex mechanism work as usual, firmware notifies driver
> on each channel switch event, then decide antenna ownership based on
> the current channel/band. Do note that this new mechanism affects
> throughput more than the sw_scan we used to have, but the overall
> average throughput is not affected since each scan take less time.
> Since the firmware size is limited, we only support probe requests
> with custom IEs length under 128 bytes for now, if any user space
> tools requires more than that, we'll introduce related changes
> afterwards. For backward compatibility, we fallback to sw_scan when
> using older firmware that does not support this feature.
>
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +void rtw_hw_scan_start(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
> +		       struct ieee80211_scan_request *scan_req)
> +{
> +	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
> +	struct cfg80211_scan_request *req = &scan_req->req;
> +	u8 mac_addr[ETH_ALEN];
> +
> +	rtwdev->scan_info.scanning_vif = vif;
> +	rtwvif->scan_ies = &scan_req->ies;
> +	rtwvif->scan_req = req;
> +	ieee80211_stop_queues(rtwdev->hw);
> +	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
> +		get_random_mask_addr(mac_addr, req->mac_addr,
> +				     req->mac_addr_mask);
> +	else
> +		ether_addr_copy(mac_addr, vif->addr);
> +	rtw_core_scan_start(rtwdev, rtwvif, mac_addr, true);
> +	rtwdev->hal.rcr &= ~BIT_CBSSID_BCN;
> +	rtw_write32(rtwdev, REG_RCR, rtwdev->hal.rcr);
> +}

quite a few functions in this patch are not using empty lines which
makes it harder to read the code it's like trying to read english
without punctuation please use more empty lines and send v2 :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
