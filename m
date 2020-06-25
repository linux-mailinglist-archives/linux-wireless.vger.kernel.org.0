Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CBF209BB8
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389917AbgFYJH6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 05:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgFYJH6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 05:07:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ACBC061573
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 02:07:57 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joNrP-00BmxG-VU; Thu, 25 Jun 2020 11:07:56 +0200
Message-ID: <426ce6f8a8dd65f545b4cc094c4ad7f461549934.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/2] mac80211: allow rx of mesh eapol frames with
 default rx key
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
Date:   Thu, 25 Jun 2020 11:07:46 +0200
In-Reply-To: <20200617082637.22670-3-markus.theil@tu-ilmenau.de>
References: <20200617082637.22670-1-markus.theil@tu-ilmenau.de>
         <20200617082637.22670-3-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +	/* check mesh EAPOL frames first */
> +	if (unlikely(rx->sta && ieee80211_vif_is_mesh(&rx->sdata->vif) && ieee80211_is_data(fc))) {
> +		struct ieee80211s_hdr *mesh_hdr;
> +		u16 hdr_len = ieee80211_hdrlen(fc);
> +		u16 ethertype_offset;
> +		__be16 ethertype;
> +
> +		/* make sure fixed part of mesh header is there, also checks skb len */
> +		if (!pskb_may_pull(rx->skb, hdr_len + 6))
> +			goto drop_check;
> +
> +		mesh_hdr = (struct ieee80211s_hdr *)(skb->data + hdr_len);
> +		ethertype_offset = hdr_len + ieee80211_get_mesh_hdrlen(mesh_hdr)
> +				 + sizeof(rfc1042_header);
> +		if (!pskb_may_pull(rx->skb, ethertype_offset + sizeof(ethertype)) ||
> +		    !ether_addr_equal(hdr->addr1, rx->sdata->vif.addr))

might be nicer to check the address first, pskb_may_pull() is
potentially more expensive, and you should be able to check the header
address already before even the first pskb_may_pull() here since it's in
the normal header.

But I don't understand the second pskb_may_pull() anyway, because you
use skb_copy_bits() below?


> +		skb_copy_bits(rx->skb, ethertype_offset, &ethertype, 2);
> +		if (ethertype == rx->sdata->control_port_protocol)
> +			goto pass_frame;

can return 0 here immediately and save the label.

johannes


