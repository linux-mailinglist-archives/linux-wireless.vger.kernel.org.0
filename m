Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041E7667C7
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 09:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfGLHb4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 03:31:56 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:54046 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfGLHb4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 03:31:56 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hlq26-0004rt-TH; Fri, 12 Jul 2019 09:31:54 +0200
Message-ID: <86bc79ccd379497d56bade79ec8f717603110ef7.camel@sipsolutions.net>
Subject: Re: [PATCH v2 05/16] wilc1000: add wilc_wlan_cfg.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, kvalo@codeaurora.org,
        Adham.Abozaeid@microchip.com, Venkateswara.Kaja@microchip.com,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com
Date:   Fri, 12 Jul 2019 09:31:52 +0200
In-Reply-To: <1562896697-8002-6-git-send-email-ajay.kathat@microchip.com>
References: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
         <1562896697-8002-6-git-send-email-ajay.kathat@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-07-12 at 01:58 +0000, Ajay.Kathat@microchip.com wrote:
> 
> +	buf[0] = (u8)id;
> +	buf[1] = (u8)(id >> 8);
> +	buf[2] = 2;
> +	buf[3] = 0;
> +	buf[4] = (u8)val16;
> +	buf[5] = (u8)(val16 >> 8);

There are helpers for that, put_le16_unaligned() or so?

> +				if (w->id == wid) {
> +					w->val = get_unaligned_le32(&info[4]);

You use the opposite one here :-)

> +	/*
> +	 * The valid types of response messages are
> +	 * 'R' (Response),
> +	 * 'I' (Information), and
> +	 * 'N' (Network Information)
> +	 */
> +
> +	switch (msg_type) {
[...]

> +	case 'S':

Hmm. :-)

> +	wl->cfg.str_vals = str_vals;
> +	/* store the string cfg parameters */
> +	wl->cfg.s[i].id = WID_FIRMWARE_VERSION;
> +	wl->cfg.s[i].str = str_vals->firmware_version;
> +	i++;
> +	wl->cfg.s[i].id = WID_MAC_ADDR;
> +	wl->cfg.s[i].str = str_vals->mac_address;
> +	i++;
> +	wl->cfg.s[i].id = WID_ASSOC_RES_INFO;
> +	wl->cfg.s[i].str = str_vals->assoc_rsp;
> +	i++;
> +	wl->cfg.s[i].id = WID_NIL;
> +	wl->cfg.s[i].str = NULL;

I really don't understand this style. Why not give it a proper struct
and just say

	wl->cfg.assoc_rsp = str_vals->assoc_rsp;

etc?

johannes

