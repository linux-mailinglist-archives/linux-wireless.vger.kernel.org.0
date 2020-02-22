Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F23168B49
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2020 01:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBVAwu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Feb 2020 19:52:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42941 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgBVAwt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Feb 2020 19:52:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so2155498pfz.9
        for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2020 16:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+4bEXLvrN1EShLxnmVNtXDVtqb+zVXaf5iquO/gqozw=;
        b=mBG7TMAfABXvXGc0DHfYGigyK9Afds8jf+aIHbest8Ve/Idj9lBgeFzXk+oe/Idwue
         Yy6ZQ3e1OxA8zQgRyYBlhrL0MpbqRcMIibX+/qs9YBC5ODWjUyBZa2Vs0RgcH+rx2ucf
         QqUjya/w4xoSYXXj84TsbE70pl0Qmq/WIbFj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+4bEXLvrN1EShLxnmVNtXDVtqb+zVXaf5iquO/gqozw=;
        b=MP4H4JhUB0fprdKt46CXNJnK2liorvOlSrL9UpdBxTaPQFVKM7hfQtih498oABBs8a
         MjjaRVikY+XHZ7V7wjFWAWYP7N3jZ66ZJXY8yytRuy1z933+k6YKsqOxfW/COkH3lvvZ
         2dafw97Wuw+gIohAgIENJkJQWCBnJf+2yrwmSMoP5hcCPy6NMStUROGFl/MMkXs93OX9
         MsjmDwrnep6fkv8x71AYSVcUh/Unhq+b67Win/gy1S+IuQaIK5qUCHfT4+2GWKrwOFeV
         r0a1oPC1dQ0MWEkKw0pJ+FWDytvY7MAKnISymfw8UUIptrsm7PkjqHkGEKgCRKxadU2E
         vWfQ==
X-Gm-Message-State: APjAAAWvf6NvjQYyirqjG7EW9JI2nKcqMpg5luyOV2LmvRh/2e7AOmVn
        XW5Vqaba6FWLzWs2GCVoZvqUrnyyVLI=
X-Google-Smtp-Source: APXvYqxNA9tzhTJ3a4QBWISAW13OHPh57qwjZeHqMSQKw/GH6NLmlYRD+JhMGaZ2nK6gApFm2xHcqg==
X-Received: by 2002:a63:26c4:: with SMTP id m187mr41384579pgm.410.1582332766989;
        Fri, 21 Feb 2020 16:52:46 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id w2sm3943720pfw.43.2020.02.21.16.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:52:45 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:52:44 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        chiu@endlessm.com, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v4 6/7] rtw88: Add wowlan pattern match support
Message-ID: <20200222005242.GA100360@google.com>
References: <20191219085816.20709-1-yhchuang@realtek.com>
 <20191219085816.20709-7-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219085816.20709-7-yhchuang@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Johannes for nl80211 questions

Hi,

I'm a bit late, as this is already upstream, but this is *really* not a
good implementation. A few comments below:

On Thu, Dec 19, 2019 at 04:58:15PM +0800, yhchuang@realtek.com wrote:
> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Pattern match is an option of wowlan to allow the device
> to be woken up from suspend mode when receiving packets
> matched user-designed patterns.
> 
> The patterns are written into hardware cam in suspend flow
> if users have set up them. If packets matched designed
> pattern are received, wowlan firmware will get an interrupt
> and then wake up the device.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

> diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
> index 70289bccd5e4..f4645f3c98e0 100644
> --- a/drivers/net/wireless/realtek/rtw88/wow.c
> +++ b/drivers/net/wireless/realtek/rtw88/wow.c
...
> +static void rtw_wow_pattern_write_cam_ent(struct rtw_dev *rtwdev, u8 id,
> +					  struct rtw_wow_pattern *rtw_pattern)
> +{
> +	int i;
> +	u8 addr;
> +	u32 wdata;
> +
> +	for (i = 0; i < RTW_MAX_PATTERN_MASK_SIZE / 4; i++) {
> +		addr = (id << 3) + i;
> +		wdata = rtw_pattern->mask[i * 4];
> +		wdata |= rtw_pattern->mask[i * 4 + 1] << 8;
> +		wdata |= rtw_pattern->mask[i * 4 + 2] << 16;
> +		wdata |= rtw_pattern->mask[i * 4 + 3] << 24;
> +		rtw_wow_pattern_write_cam(rtwdev, addr, wdata);
> +	}
> +
> +	wdata = rtw_pattern->crc;
> +	addr = (id << 3) + RTW_MAX_PATTERN_MASK_SIZE / 4;
> +
> +	switch (rtw_pattern->type) {
> +	case RTW_PATTERN_BROADCAST:
> +		wdata |= BIT_WKFMCAM_BC | BIT_WKFMCAM_VALID;
> +		break;
> +	case RTW_PATTERN_MULTICAST:
> +		wdata |= BIT_WKFMCAM_MC | BIT_WKFMCAM_VALID;
> +		break;
> +	case RTW_PATTERN_UNICAST:
> +		wdata |= BIT_WKFMCAM_UC | BIT_WKFMCAM_VALID;
> +		break;
> +	default:
> +		break;

^^ This is pretty nasty. At least log an error or something? But see
below.

> +	}
> +	rtw_wow_pattern_write_cam(rtwdev, addr, wdata);
> +}
...
> +static void rtw_wow_pattern_generate(struct rtw_dev *rtwdev,
> +				     struct rtw_vif *rtwvif,
> +				     const struct cfg80211_pkt_pattern *pkt_pattern,
> +				     struct rtw_wow_pattern *rtw_pattern)
> +{
> +	const u8 *mask;
> +	const u8 *pattern;
> +	u8 mask_hw[RTW_MAX_PATTERN_MASK_SIZE] = {0};
> +	u8 content[RTW_MAX_PATTERN_SIZE] = {0};
> +	u8 mac_addr[ETH_ALEN] = {0};
> +	u8 mask_len;
> +	u16 count;
> +	int len;
> +	int i;
> +
> +	pattern = pkt_pattern->pattern;
> +	len = pkt_pattern->pattern_len;
> +	mask = pkt_pattern->mask;
> +
> +	ether_addr_copy(mac_addr, rtwvif->mac_addr);
> +	memset(rtw_pattern, 0, sizeof(*rtw_pattern));
> +
> +	mask_len = DIV_ROUND_UP(len, 8);
> +
> +	if (is_broadcast_ether_addr(pattern))

I'm pretty sure it's not valid to look at 'pkt_pattern->pattern' without
also accounting for the ->mask. Same for all the other if/else here.

> +		rtw_pattern->type = RTW_PATTERN_BROADCAST;
> +	else if (is_multicast_ether_addr(pattern))
> +		rtw_pattern->type = RTW_PATTERN_MULTICAST;
> +	else if (ether_addr_equal(pattern, mac_addr))
> +		rtw_pattern->type = RTW_PATTERN_UNICAST;
> +	else
> +		rtw_pattern->type = RTW_PATTERN_INVALID;

^^ This is really bad behavior -- you're not logging anything or
reporting any error back to the caller; you're just silently ignoring
pattern, IIUC. That threw me for a loop for longer than I care to admit,
since I wasn't specifying the MAC address in my pattern configurations,
and so you were silently declaring my pattern "invalid."

Is there a really good reason for this behavior? Can't you choose some
useful behavior if you don't have enough information to determine
{uni,multi,broad}cast here? I see these are actually a bitfield above,
when you program to the firmware, so maybe an _WILDCARD_CAST option?

This also hints at a deficiency in the wowlan APIs: nl80211_set_wowlan()
only honors a pre-set set of restrictions, like min/max pattern length,
max offset. For restrictions like this, we either need a wiphy callback,
such that rtw88 can reject arbitrary patterns, or else some additional
declarative fields in 'struct wiphy_wowlan_support'.

Brian

> +
> +	/* translate mask from os to mask for hw
> +	 * pattern from OS uses 'ethenet frame', like this:
> +	 * |    6   |    6   |   2  |     20    |  Variable  |  4  |
> +	 * |--------+--------+------+-----------+------------+-----|
> +	 * |    802.3 Mac Header    | IP Header | TCP Packet | FCS |
> +	 * |   DA   |   SA   | Type |
> +	 *
> +	 * BUT, packet catched by our HW is in '802.11 frame', begin from LLC
> +	 * |     24 or 30      |    6   |   2  |     20    |  Variable  |  4  |
> +	 * |-------------------+--------+------+-----------+------------+-----|
> +	 * | 802.11 MAC Header |       LLC     | IP Header | TCP Packet | FCS |
> +	 *		       | Others | Tpye |
> +	 *
> +	 * Therefore, we need translate mask_from_OS to mask_to_hw.
> +	 * We should left-shift mask by 6 bits, then set the new bit[0~5] = 0,
> +	 * because new mask[0~5] means 'SA', but our HW packet begins from LLC,
> +	 * bit[0~5] corresponds to first 6 Bytes in LLC, they just don't match.
> +	 */
> +
> +	/* Shift 6 bits */
> +	for (i = 0; i < mask_len - 1; i++) {
> +		mask_hw[i] = u8_get_bits(mask[i], GENMASK(7, 6));
> +		mask_hw[i] |= u8_get_bits(mask[i + 1], GENMASK(5, 0)) << 2;
> +	}
> +	mask_hw[i] = u8_get_bits(mask[i], GENMASK(7, 6));
> +
> +	/* Set bit 0-5 to zero */
> +	mask_hw[0] &= (~GENMASK(5, 0));
> +
> +	memcpy(rtw_pattern->mask, mask_hw, RTW_MAX_PATTERN_MASK_SIZE);
> +
> +	/* To get the wake up pattern from the mask.
> +	 * We do not count first 12 bits which means
> +	 * DA[6] and SA[6] in the pattern to match HW design.
> +	 */
> +	count = 0;
> +	for (i = 12; i < len; i++) {
> +		if ((mask[i / 8] >> (i % 8)) & 0x01) {
> +			content[count] = pattern[i];
> +			count++;
> +		}
> +	}
> +
> +	rtw_pattern->crc = rtw_calc_crc(content, count);
> +}
> +
