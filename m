Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67DC96A8A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 22:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfHTU3r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 16:29:47 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43536 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTU3r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 16:29:47 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0AlC-0007yy-UV; Tue, 20 Aug 2019 22:29:43 +0200
Message-ID: <c60afe716cc9ce3b511d8be0b04958342dfea908.camel@sipsolutions.net>
Subject: Re: [PATCH 46/49] ath11k: add wmi.h
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Date:   Tue, 20 Aug 2019 22:29:41 +0200
In-Reply-To: <1566316095-27507-47-git-send-email-kvalo@codeaurora.org> (sfid-20190820_181541_270184_9285B240)
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
         <1566316095-27507-47-git-send-email-kvalo@codeaurora.org>
         (sfid-20190820_181541_270184_9285B240)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 18:48 +0300, Kalle Valo wrote:
> 
> +enum wmi_cmd_group {
> +	/* 0 to 2 are reserved */
> +	WMI_GRP_START = 0x3,
> +	WMI_GRP_SCAN = WMI_GRP_START, /* 0x3 */
> +	WMI_GRP_PDEV,           /* 0x4 */

If you're going to spell out the numbers anyway, why not do it in C
rather than a comment?

	WMI_GRP_PDEV		= 0x4,

would tell you just as much, and be much less error-prone.

> +struct wmi_pdev_set_hw_mode_cmd_param {
> +	u32 tlv_header;
> +	u32 pdev_id;
> +	u32 hw_mode_index;
> +	u32 num_band_to_mac;
> +} __packed;

Does it really makes sense for something to be using "u32" (i.e. host
endian) but then __packed (kinda tagging it as "I am using this with the
hardware, don't change the layout")?

That really applies to a lot of the things here.

> +struct channel_param {
> +	u8 chan_id;
> +	u8 pwr;
> +	u32 mhz;
> +	u32 half_rate:1,
> +	    quarter_rate:1,
> +	    dfs_set:1,
> +	    dfs_set_cfreq2:1,
> +	    is_chan_passive:1,
> +	    allow_ht:1,
> +	    allow_vht:1,
> +	    set_agile:1;
> +	u32 phy_mode;
> +	u32 cfreq1;
> +	u32 cfreq2;
> +	char   maxpower;
> +	char   minpower;
> +	char   maxregpower;
> +	u8  antennamax;
> +	u8  reg_class_id;
> +} __packed;

Bitfields in FW structs are even less likely to work right, I'd avoid
that.

(and if you have this copy engine do endian conversion, then the u8
fields won't work right since that ending seems to be working on u32s?)

That probably all applies elsewhere too, but the file is pretty long ;-)

Personally, I'd also consider splitting internal driver usage stuff and
FW API into different files, but that's your decision. I just find it
lets me understand it better even when I'm looking at it myself.

johannes

