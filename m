Return-Path: <linux-wireless+bounces-871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2E4815E64
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Dec 2023 10:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746202834B5
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Dec 2023 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786DA1FAD;
	Sun, 17 Dec 2023 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="KSEk208r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1975C1FB2
	for <linux-wireless@vger.kernel.org>; Sun, 17 Dec 2023 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id DCFAC11717;
	Sun, 17 Dec 2023 09:42:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FOTIgX7cxu8b; Sun, 17 Dec 2023 09:42:07 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Sun, 17 Dec 2023 11:42:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1702806127; bh=vl6aQBoqcJn88mjLXDa+tGyx/qSRdbLm9kx6eorx8xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSEk208rqlmfX++L+tS4N79W8yJLHATL7Laa8bkn5RAlXBqQz6QurwdSGWX9huAcs
	 I+v07or5ODnpkclbdYFN+bpwIaYJuwqI08sK3JdWB/ThdNDaCvgQ5NdPNbuq2Chl80
	 k93UW9giEpHE3og/Zj3tnwaHzjfsbnLLNntZZcNuwUzA7xWK3E/dsecABsuRkZlSr/
	 Ma7ukViTNjjYozQZoDzDz5a1K10Tzm/jP2Gu+BimN/G9ONthUt9SZ0KWXEU9sja17z
	 yWQ9EAj8P/X2qAM1jbfYPdd526iU3K9mP3V6IXnX/SDcxS/EyfVU2P7v1y5SuSsp2J
	 HsmkD4VxUxHOw==
Date: Sun, 17 Dec 2023 11:42:05 +0200
From: Jouni Malinen <j@w1.fi>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 06/14] wifi: cfg80211: Update the default DSCP-to-UP
 mapping
Message-ID: <ZX7CbSCEv7Zvv476@w1.fi>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
 <20231211085121.8a1c7d1f0034.I50aed38be78ae9aea052938e2cb6b5800010ecd4@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211085121.8a1c7d1f0034.I50aed38be78ae9aea052938e2cb6b5800010ecd4@changeid>

On Mon, Dec 11, 2023 at 09:05:24AM +0200, Miri Korenblit wrote:
> The default DSCP-to-UP mapping method defined in RFC8325
> applied to packets marked per recommendations in RFC4594 and
> destined to 802.11 WLAN clients will yield a number of inconsistent
> QoS mappings.
> 
> To handle this, modify the mapping of specific DSCP values for
> which the default mapping will create inconsistencies, based on
> the recommendations in section 4 in RFC8325.

Could this commit message give some more justification for why these
exact specifications are the best source of this information? For
example, should this also reference the Wi-Fi QoS Management
specification?

> diff --git a/net/wireless/util.c b/net/wireless/util.c
> @@ -980,7 +980,53 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
>  		}
>  	}
>  
> +	/* The default mapping as defined in RFC8325 */
>  	ret = dscp >> 5;

Could you point to the exact location in RFC 8325 that has that as the
default mapping? Figure 1 has this note: "Note: All unused codepoints
are RECOMMENDED to be mapped to UP 0".

Section 2.4 does describe what many APs do, but that section is called
"Default UP-to-DSCP Mappings and Conflicts" which does not sound like a
recommended default mapping in RFC 8325..

> +	/* Handle specific DSCP values for which the default mapping doesn't
> +	 * adhere to the intended usage of the DSCP value. See section 4 in
> +	 * RFC8325.
> +	 */
> +	switch (dscp >> 2) {

What about "Standard: DF" (0 --> 0) and "Low-Priority Data: CS1" (8 ->
1)? Are those omitted here because the "dscp >> 5" happens to have same
value? It would seem to be good to have at least a comment here pointing
that out in particular taken into account that comment above about the
status of that "default mapping" and how it relates to RFC 8325.

> +	case 10:
> +	case 12:
> +	case 14:
> +		/* High throughput data: AF11, AF12, AF13 */
> +		ret = 0;
> +		break;
> +	case 16:
> +		/* Operations, Administration, and Maintenance and Provisioning:
> +		 * CS2
> +		 */
> +		ret = 0;
> +		break;
> +	case 18:
> +	case 20:
> +	case 22:
> +		/* Low latency data: AF21, AF22, AF23 */
> +		ret = 3;
> +		break;
> +	case 24:
> +		/* Broadcasting video: CS23 */
> +		ret = 4;
> +		break;

Typo.. Should be "CS3" instead of "CS23".

What about "Multimedia Streaming: AF31, AF32, AF33"? Shouldn't those
values 26, 28, 30 be mapped to 4? If not, it would be good to add a
comment explaining why that is not here while it is included in RFC 8325
Figure 1.

What about "Real-Time Interactive: CS4"? Shouldn't that value 32 be
mapped to 4? If not, it would be good to add a comment explaining why
that is not here while it is included in RFC 8325 Figure 1.

What about "Multimedia Conferencing: AF41, AF42, AF43"? Shouldn't those
values 34, 36, 38 be mapped to 4? If not, it would be good to add a
comment explaining why that is not here while it is included in RFC 8325
Figure 1.

> +	case 40:
> +		/* Signaling: CS5 */
> +		ret = 5;
> +		break;
> +	case 44:
> +		/* Voice Admit */
> +		ret = 6;
> +		break;

To be consistent, that comment should be "VOICE-ADMIT: VA".

> +	case 46:
> +		/* Telephony traffic: EF */
> +		ret = 6;
> +		break;
> +	case 48:
> +		/* Network Control Traffic: CS6 */
> +		ret = 7;
> +		break;
> +	}

This does not include "Network Control: CS7". Is there a reason for not
covering that case 56 now? I know it is "reserved for future use", but
RFC 8325 does provide mapping for it as well.

-- 
Jouni Malinen                                            PGP id EFC895FA

