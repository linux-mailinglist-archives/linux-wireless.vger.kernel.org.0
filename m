Return-Path: <linux-wireless+bounces-31753-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCPoFew2jWm40AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31753-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 03:11:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E99051291FB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 03:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39D7A300D0DA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 02:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11C41A4F3C;
	Thu, 12 Feb 2026 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTmS1Fqv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C807B19F12A
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770862312; cv=none; b=no7M+U/zsaKam4UvDHeLtdvkUeCA4fyjimzRv/27ykJfe4GAN+F6KQB1Yizwu8mKbx0Gz0WV0Y+koGrfJqzMl3W4GjprMgqmb0JjEYa5yY9gU8+uLVjljWQu7lweDsBpoHk+5BC53rwcPzQZ6XXPXqWbvbpuuvorRVZ6HLVAZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770862312; c=relaxed/simple;
	bh=ta0HKnewRUbyu7DTGvZMx7MaLt6JTRIr9YDRMJQ0k6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CeoWFXAnK/I6uB9nDpYLMARBt6ozGnC+QNkLWuEYUrLPAZ2dC2XrTQkrTQAtYxzdjXRtMCBdh23rVbtZ/tYgEGgpohRRNf6P2MRbowvFTf0ZfvpDjyr4Ian5NEDfMeNrQlr1u18JGQvsoS4N21if1vC0JnYOEmfeMk0ThoUWj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTmS1Fqv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-354b20c1112so4069834a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 18:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770862311; x=1771467111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IMeKCXYa0BHuMAh+/NngREOlmrHv2zRJEiibcrVQlgc=;
        b=NTmS1Fqv68RVB5fPrgJJJu+XPMqTT0NN9Z6md5Qy3LBnKGF+QfCu1RrBEdT2RT0kpo
         3pxC89OqehfAwsiLcfEGgef7KocB727L11b5JTR1WWezUGtG+iIpB2MA2AMbzyWYY+HJ
         n3KGfKUXR6Y71yQkdGKvGhpZGYOoj84XcD9j7hVZ7FdLqvItmlZNdMsFjLniVzVUipBa
         3imcZIeahRQwg4w5BA91sApwuNKQeHtVsVV5LHAnhOBgaJVswNkgqXJGsJbfDj7N3bH/
         6ZUf6fG9NyUfT+G4sEEM8n9uRMnDM7v2lOo8MKHqn1XVJYHJswFZqwy5oRZWah2C9yxz
         0riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770862311; x=1771467111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMeKCXYa0BHuMAh+/NngREOlmrHv2zRJEiibcrVQlgc=;
        b=k99X8CSWrXKN/twYNrRWCgCQbRau66+h4fPu6OzuUn2KdAzxSFNV8t4STgC5Py+NG8
         XK3NfLKTKZ+VdUa7gtDxsDuV1oA4oLbDdOoXJNp9FiXmyCBa/bP6i3ZmfzSpHLWovRYA
         XAhHd53g9Qpn6W28QqzbKUztwEcgp6wNkh6xhtg6/b74cEUI9Rub0UPhD20FF/In2PnI
         eEbJ97VHmcKcE2/m8h5M20hlzqrFcG4kn/tAwPKwkH62hM7A6zuKBM/X/sWf/htDkOFN
         v1Jg0IwU47MIdiIy9MeWBnP6kjRw7QOf7ZcuRYeNou1hn1WEG5TNUvT2VpqqaWauPUWM
         9Cog==
X-Forwarded-Encrypted: i=1; AJvYcCXZacOg+gnFLYQzu1zmujTrZJHk/vKrOtVYKMFSSqpnqntbVfrhTu0KvkYV6g7EpzyuBnkAY5OPwVU1v05bqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDV/9ex7j2kaCIj6EVCUUYBu/ACOHXdUBSlpzBmbLi91iuQVF
	kAIw5bAUR/bsHkrOEi7Tz1i8sFuL9orqmwoz0hWem8LKyC/XX3yjeQmtW7trDQ==
X-Gm-Gg: AZuq6aKhw/chNF4b0EzqIRtZpZ/yL1p8AH+xNzu+4MLa4IanVqtoA67rWCjaxKc4hLs
	rY2ixwhNMzmOf3lk5HiN5+Xf459xSRA0loZZ0B0rFnInPh+AEcdTTbtOwD3s5qLhZdNJU1cz6C6
	mFzRICvOh2K61un1YEq1Guc33/1PI0dSeoRyCbDCdpPF4DcKco/2SqbScwUKQxfviA99vqftLqX
	abJ7T7YxjdioYA1dv9RaJU59/nwzblEjiYY7ZH35+E0qNEQcdGJ3gaiUGHqnszhGmxRpbYtYWsB
	6B/HFbR2RnCDNjzwjX5UkOvbOD7dg3LDcXM2eK4N5CICQOT9V2LoXgyt6VUiZ0KumMg454dXPnv
	imvx7c3IU2QsvvuA0d7mJgJgcDDcYgaYbmX6o9/jyDsY9AutKOdhvCTU23fQul07sF0Z52NPnz7
	2NROATs52O37ZYtrRcrP7S29Xf58IsblrfEjyNVAFx8iWhl1n9Lclf9AZ+
X-Received: by 2002:a17:90b:180c:b0:349:9d63:8511 with SMTP id 98e67ed59e1d1-3568f40439dmr799838a91.25.1770862311053;
        Wed, 11 Feb 2026 18:11:51 -0800 (PST)
Received: from [10.100.120.15] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567cf57f81sm1563151a91.13.2026.02.11.18.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 18:11:50 -0800 (PST)
Message-ID: <dd019903-f8d9-4bd3-a90d-b4d505f489f3@gmail.com>
Date: Wed, 11 Feb 2026 18:11:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] wifi: ath10k: only wait for response to SET_KEY
To: Richard Acayan <mailingradian@gmail.com>,
 Jeff Johnson <jjohnson@kernel.org>, Michal Kazior <michal.kazior@tieto.com>,
 Kalle Valo <kvalo@qca.qualcomm.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org
References: <20260210021249.12132-1-mailingradian@gmail.com>
 <20260210021249.12132-3-mailingradian@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20260210021249.12132-3-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,tieto.com,qca.qualcomm.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31753-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prestwoj@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E99051291FB
X-Rspamd-Action: no action

On 2/9/26 6:12 PM, Richard Acayan wrote:
> When sending DELETE_KEY, the driver times out waiting for a response
> that doesn't come. Only wait for a response when sending SET_KEY.

We've run into the exact same thing on the QCA6174 and have been 
carrying an identical patch to this for at least a year.

https://lore.kernel.org/linux-wireless/b2838a23-ea30-4dee-b513-f5471d486af2@gmail.com/

>
> Sample dmesg:
>
> 	[  117.285854] wlan0: deauthenticating from XX:XX:XX:XX:XX:XX by local choice (Reason: 3=DEAUTH_LEAVING)
> 	[  120.302934] ath10k_snoc 18800000.wifi: failed to install key for vdev 0 peer XX:XX:XX:XX:XX:XX: -110
> 	[  120.302996] wlan0: failed to remove key (0, XX:XX:XX:XX:XX:XX) from hardware (-110)
>
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>   drivers/net/wireless/ath/ath10k/mac.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index da6f7957a0ae..73aa93043f8a 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -324,9 +324,11 @@ static int ath10k_install_key(struct ath10k_vif *arvif,
>   	if (ret)
>   		return ret;
>   
> -	time_left = wait_for_completion_timeout(&ar->install_key_done, 3 * HZ);
> -	if (time_left == 0)
> -		return -ETIMEDOUT;
> +	if (cmd != DISABLE_KEY) {
> +		time_left = wait_for_completion_timeout(&ar->install_key_done, 3 * HZ);
> +		if (time_left == 0)
> +			return -ETIMEDOUT;
> +	}
>   
>   	return 0;
>   }

