Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00087202B05
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2020 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgFUO0N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jun 2020 10:26:13 -0400
Received: from mail.w1.fi ([212.71.239.96]:37870 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730171AbgFUO0N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jun 2020 10:26:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id 736E011754;
        Sun, 21 Jun 2020 14:26:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HRaT6Bwp_Jve; Sun, 21 Jun 2020 14:26:09 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Sun, 21 Jun 2020 17:24:26 +0300
Date:   Sun, 21 Jun 2020 17:24:26 +0300
From:   Jouni Malinen <j@w1.fi>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] nl80211: add control port tx status method
Message-ID: <20200621142426.GA27237@w1.fi>
References: <20200527160334.19224-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527160334.19224-1-markus.theil@tu-ilmenau.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 27, 2020 at 06:03:34PM +0200, Markus Theil wrote:
> This patch adds the actual code for returning the tx status of control
> port frames sent over nl80211.
> 
> NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS is a new command which is used
> when returning the tx status. Its availability can be queried by checking
> against NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS.
> 
> The ctrl port tx status over nl80211 path re-uses some code from the path
> for advertising the tx status over socket control messages, when
> SKBTX_WIFI_STATUS is set.
> 
> The tx status can be used in a similar fashion as the mgmt tx status
> already allows for. A cookie is included extended ack data of
> NL80211_CMD_CONTROL_PORT_FRAME, which can be matched against the cookie
> in NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS. The frame content is also
> included, as for example hostapd currently uses it to match request and
> reply.

does the mac80211 part really work correctly? I see
NL80211_CMD_FRAME_TX_STATUS events for EAPOL-control-port-TX frames..

> diff --git a/net/mac80211/status.c b/net/mac80211/status.c
> @@ -649,10 +649,17 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
> +			else if (ieee80211_is_mgmt(hdr->frame_control))
>  				cfg80211_mgmt_tx_status(&sdata->wdev, cookie,
>  							skb->data, skb->len,
>  							acked, GFP_ATOMIC);

I.e., I get this one being called..

> +			else
> +				cfg80211_control_port_tx_status(&sdata->wdev,
> +								cookie,
> +								skb->data,
> +								skb->len,
> +								acked,
> +								GFP_ATOMIC);

Not this one.

And the payload that shows up in user space (NL80211_ATTR_FRAME) has an
Ethernet header, not IEEE 802.11 header, which would explain why that
ieee80211_is_mgmt() check is not working as expected since hdr is not
really pointing to struct ieee80211_hdr..

-- 
Jouni Malinen                                            PGP id EFC895FA
