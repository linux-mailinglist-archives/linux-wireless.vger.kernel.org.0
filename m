Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF332066AD
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 23:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgFWVyX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 17:54:23 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:64783 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387455AbgFWVyW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 17:54:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592949261; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=47OjbNY3nzvkQNlJtmdRn4i+/sZyWINPrykpi02PoMw=;
 b=dEekktLYPHM/eN7mt2+xyXEGlOzmUcg5yBpnRkWkt7S6OWu+Zt7qSBvgc3bHsJQO7eTJ6zkO
 Hh6rBeQA9gF14cnX8Bxw6YsCCC4hhth/5e1WHizQ0QFyLbbfyxtTF7b/ITwCbxTqgUK5FC7M
 zb+P5KEQCjLLoK7XsDgGXehAFf8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5ef279f25866879c76f89bf4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 21:53:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54F8AC43391; Tue, 23 Jun 2020 21:53:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E38DDC433C6;
        Tue, 23 Jun 2020 21:53:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Jun 2020 14:53:53 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 3/3] ath11k: add support for BSS coloring
In-Reply-To: <20200617150021.4183253-3-john@phrozen.org>
References: <20200617150021.4183253-1-john@phrozen.org>
 <20200617150021.4183253-3-john@phrozen.org>
Message-ID: <9597d58917d651655e51ba313b69d0c4@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-17 08:00, John Crispin wrote:
> Whenever the MAC detects a color collision or any of its associated 
> station
> detects one the FW will send out an event. Add the code to parse and 
> handle
> this event. and pass the data up to mac80211.
> 
> The FW does not provide an offload future such as the one used for CSA. 
> The
> CCA process is hence triggered via the beacon offload tx completion 
> events
> sent out by the FW.
> 
[...]
> +static void
> +ath11k_wmi_obss_color_collision_event(struct ath11k_base *ab, struct
> sk_buff *skb)
> +{
> +	const void **tb;
> +	const struct wmi_obss_color_collision_event *ev;
> +	struct ath11k_vif *arvif;
> +	int ret;
> +
> +	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
> +	if (IS_ERR(tb)) {
> +		ret = PTR_ERR(tb);
> +		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
> +		return;
> +	}
> +
> +	ev = tb[WMI_TAG_OBSS_COLOR_COLLISION_EVT];
> +	if (!ev) {
> +		ath11k_warn(ab, "failed to fetch obss color collision ev");
> +		goto exit;
> +	}
> +
> +	arvif = ath11k_mac_get_arvif_by_vdev_id(ab, ev->vdev_id);
> +	switch (ev->evt_type) {
> +	case WMI_BSS_COLOR_COLLISION_DETECTION:
> +		break;
> +	case WMI_BSS_COLOR_COLLISION_DISABLE:
> +	case WMI_BSS_COLOR_FREE_SLOT_TIMER_EXPIRY:
> +	case WMI_BSS_COLOR_FREE_SLOT_AVAILABLE:
> +		return;
> 
tb should be freed here.

-Rajkumar
