Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C332A23A2AF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 12:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHCKUR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCKUR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 06:20:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33FFC06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Aug 2020 03:20:16 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k2XZn-00Fcog-4Z; Mon, 03 Aug 2020 12:20:15 +0200
Message-ID: <6f23e2ac081a3960959f00dedcdf8795aef28a14.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] nl80211: Unsolicited broadcast probe response
 support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 03 Aug 2020 12:20:14 +0200
In-Reply-To: <20200715230514.26792-2-alokad@codeaurora.org>
References: <20200715230514.26792-1-alokad@codeaurora.org>
         <20200715230514.26792-2-alokad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Also,

> +/**
> + * enum nl80211_unsol_bcast_probe_resp_attributes - Unsolicited broadcast probe
> + *	response configuration. Applicable only in 6GHz.
> + *
> + * @__NL80211_UNSOL_BCAST_PROBE_RESP_INVALID: Invalid
> + *
> + * @NL80211_UNSOL_BCAST_PROBE_RESP_INT: Maximum packet interval (u32, TU).
> + *	Allowed range: 0..20 (TU = Time Unit). IEEE P802.11ax/D6.0

0 doesn't make sense, you should disallow that.

I see you used it for "turn off" at least in the mac80211 patch but it
seems to me that should have a more explicit way at least in the
external API? At the very least it needs to documentation.

johannes

