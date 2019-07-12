Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E1667E6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfGLHmi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 03:42:38 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:54126 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfGLHmi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 03:42:38 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hlqCR-00053a-UH; Fri, 12 Jul 2019 09:42:36 +0200
Message-ID: <b6bb8a8b61ebbca40611dee07e4980a792bf2386.camel@sipsolutions.net>
Subject: Re: [PATCH v2 02/16] wilc1000: add wilc_hif.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, kvalo@codeaurora.org,
        Adham.Abozaeid@microchip.com, Venkateswara.Kaja@microchip.com,
        Nicolas.Ferre@microchip.com, Claudiu.Beznea@microchip.com
Date:   Fri, 12 Jul 2019 09:42:34 +0200
In-Reply-To: <1562896697-8002-3-git-send-email-ajay.kathat@microchip.com>
References: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
         <1562896697-8002-3-git-send-email-ajay.kathat@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +struct wilc_set_multicast {
> +	u32 enabled;
> +	u32 cnt;
> +	u8 *mc_list;
> +};
> +
> +struct wilc_del_all_sta {
> +	u8 assoc_sta;
> +	u8 mac[WILC_MAX_NUM_STA][ETH_ALEN];
> +};
> +
> +struct wilc_op_mode {
> +	__le32 mode;
> +};
> +
> +struct wilc_reg_frame {
> +	bool reg;
> +	u8 reg_id;
> +	__le16 frame_type;
> +} __packed;

'bool' is a pretty bad idea, there's no storage guarantee for it. Use u8
instead, especially in a firmware struct.

But overall, if I remember correctly, this is a massive improvement,
last time I looked I think you basically had something like

char msg[10];
int i = 0;
msg[i++] = reg;
msg[i++] = reg_id;
msg[i++] = frame_type >> 8;
msg[i++] = (u8)frame_type;

so obviously this is *much* better.

I still think you'd benefit from putting the firmware API structs into a
separate include file so you can differentiate them, but YMMV.

> +int wilc_scan(struct wilc_vif *vif, u8 scan_source, u8 scan_type,
> +	      u8 *ch_freq_list, u8 ch_list_len,
> +	      void (*scan_result_fn)(enum scan_event,
> +				     struct wilc_rcvd_net_info *, void *),
> +	      void *user_arg, struct cfg80211_scan_request *request)
> +{
> +	int result = 0;
> +	struct wid wid_list[5];

> +	wid_list[index].id = WID_INFO_ELEMENT_PROBE;
> +	wid_list[index].type = WID_BIN_DATA;
> +	wid_list[index].val = (s8 *)request->ie;
> +	wid_list[index].size = request->ie_len;
> +	index++;
> +
> +	wid_list[index].id = WID_SCAN_TYPE;
> +	wid_list[index].type = WID_CHAR;
> +	wid_list[index].size = sizeof(char);
> +	wid_list[index].val = (s8 *)&scan_type;
> +	index++;


I still find this whole wid_list stuff to be a bit confusing, especially
since it looks like a *firmware* thing but then you have the *host
pointer* inside the value ...

There must be a translation layer somewhere, but I can't help but wonder
if that's really worth the complexity, vs. just building the right thing
directly here (with some helpers perhaps).


johannes

