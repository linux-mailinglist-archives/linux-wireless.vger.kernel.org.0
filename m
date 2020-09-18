Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1EA26FAF1
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIRKu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRKuZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:50:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46493C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:50:25 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJDyB-006Cmv-JR; Fri, 18 Sep 2020 12:50:23 +0200
Message-ID: <5025b542741e18d0f329b5a1f5d110fd6a1eeae0.camel@sipsolutions.net>
Subject: Re: [PATCH v2 13/22] cfg80211: handle Association Response from S1G
 STA
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 18 Sep 2020 12:50:22 +0200
In-Reply-To: <20200831205600.21058-14-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
         <20200831205600.21058-14-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
> 
> +	/* Detect whether this was an S1G Association Response and adjust IE
> +	 * location accordingly.
> +	 */
> +	rcu_read_lock();
> +	ies = rcu_dereference(bss->ies);
> +	if (WARN_ON(!ies)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +	s1g = cfg80211_find_ie(WLAN_EID_S1G_CAPABILITIES, ies->data, ies->len);
> +	if (s1g) {
> +		cr.resp_ie = (u8 *)&mgmt->u.s1g_assoc_resp.variable;
> +		cr.resp_ie_len =
> +			len - offsetof(struct ieee80211_mgmt,
> +				       u.s1g_assoc_resp.variable);
> +	}
> +	rcu_read_unlock();

That ... is rather strange?

Why not check bss->channel->band?

johannes

