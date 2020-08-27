Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9325426F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 11:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgH0JdW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 05:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbgH0JdU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 05:33:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10220C061264
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 02:33:19 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kBEHU-00BWop-GC; Thu, 27 Aug 2020 11:33:16 +0200
Message-ID: <f57db5715fe2177ae4901ba981fdc3a580b94b54.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: Add feature flag to indicate RSNXE IE support
 in FT
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <vjakkam@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 27 Aug 2020 11:33:12 +0200
In-Reply-To: <1596511970-8415-1-git-send-email-vjakkam@codeaurora.org>
References: <1596511970-8415-1-git-send-email-vjakkam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-08-04 at 09:02 +0530, Veerendranath Jakkam wrote:
> Add a new feature flag that drivers in which FT handshake is offloaded,

"that drivers (in which ...)" what? Can set? Are expected to use?

> to advertise support for interoperability with legacy clients which
> doesn't

don't? or what does "doesn't" refer to?

>  support using RSNXE IE for MIC calculation in FT handshake. The
> userspace can choose to enable/disable FT protocols that require RSNXE IE
> to be used based on this flag advertised by drivers.

I can't say I really understand this.

> Signed-off-by: Veerendranath Jakkam <vjakkam@codeaurora.org>
> 
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index 631f3a99..83e8079 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -5820,6 +5820,9 @@ enum nl80211_feature_flags {
>   * @NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK: Device wants to do 4-way
>   *	handshake with PSK in AP mode (PSK is passed as part of the start AP
>   *	command).
> + * @NL80211_EXT_FEATURE_FT_RSNXE: Driver supports RSNXE element in FT handshake
> + *	and interoperable with legacy clients that doesn't support using RSNXE
> + *	IE for MIC computation in FT handshake.

Nor this. Please rewrite the commit message and comment to be more
explanatory (and grammatically correct).

johannes

