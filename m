Return-Path: <linux-wireless+bounces-38626-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bbyNBFZoSWoJ1gAAu9opvQ
	(envelope-from <linux-wireless+bounces-38626-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 22:08:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE8270864F
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 22:08:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="h/reNsFp";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38626-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38626-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD3373005AA4
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0B72C21D8;
	Sat,  4 Jul 2026 20:08:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08C26CE39
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 20:08:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783195729; cv=none; b=cgp/I1ZllrB8jkrSVyS3PjNif9ooMP+0Do+AOPdkbrXm5P33djggjFJMELa4CWX4AF04xENxCoSEyIduQpiXYuGu449epaGTlScQ66jOvDq4Njkkprpcvj11pTQ1OUnF4mmXqDlJtC6UE8wY3271aA1BlNIylQoQyaWAzcVbczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783195729; c=relaxed/simple;
	bh=/mljatL7jfR8u/fC5oFpIrgmq2oqa5zg1DjRnBq+lO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=II3WQGEoslUBP5k+LTw/RIJ0+lTKamcFRXgee6MDLwJiZ5G3oXNe26xfjlAIIO9OI8h0pOf5NkXV4H9UZUwCCcfMgbDiWjZ9vpXFsXj1LOxmAp+F+DHssygakr3NmwVJsdpcD8WCj+wGAiKUm/F7q9VSSJuzJR4RRdgvUr7Gz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/reNsFp; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c486f012so7059505e9.3
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jul 2026 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783195727; x=1783800527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZ6s5Jw0wnLJ083z7ESM3Mk2xFWuRhKwyQC7d0QvTWY=;
        b=h/reNsFpoYhNoFWceqDqEi4jl0nrz/P+M7z/QE96Veq9K5j1o/CyS0cHvfRUZrX5NC
         T4aZYpi7IGzydZH16DkjOgBg7hU2iNRq8NkqtIBcBYxqetZeBhVW7RjT98REVmn5OKXc
         OIx67gJubd5iGuFV29csxIIncc/lNJbh4YgfZyiFNyNMHvP8nFe6MjMV/pwu5uNTjJ1K
         3ydusGic8QJxIQGkNu/hbKSbCx+uUpcOq4hbR0oXw9TaX0Zk7TMXACTyms4VWATZXoEK
         9sBQ4PRwJRujdse26NJM9wdF8dtBePZ9KR8XXvsXuz/A6G98YsMtNPUJeYDuNQY7tGXo
         fwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783195727; x=1783800527;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZ6s5Jw0wnLJ083z7ESM3Mk2xFWuRhKwyQC7d0QvTWY=;
        b=Ka+DqXI9vyaTUQWAg2Giyl2YprGdAinaF4mDuWbYhMYdp+npn85CHDB0rGgoKLDbv6
         WozZqjWbYMQGo2Jy1KaUQefkBEUwlvR7Urczq8QEpBoGc/3oFr+1gN3XINTB0CTGSg+m
         T5pAHjlWcJNMzZj5v3OITq00J5aHeWpnkegnCiU6VSSCYBRP0R7yEgUmDgzFBoNya/Hm
         lhCz+8M0D4qMefLnc/P71fXH3s94D/XRFQKpMFwgw1K1fGAFJY0ulQH9tZ2tDysfwyFG
         32j6k54otyG7zcKVB887jXs7Ss67lGtFAWuIeJYJoxOe9t4frU9NnukmJh9OscWx6tAJ
         Q6rA==
X-Forwarded-Encrypted: i=1; AFNElJ9AKF6IDr+rUVCXB+qf4Rn3HB9mvMRX68irnlI8y7X+7bEITjRUc2LRyfmu1fDh5n4EbiP7m36AKd0rn4O6Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7o4Ww6Y112c5oeEGIRpzRL/QcIQz/2OUZskixijRpOI0r4ml
	G22qfxqIhzyOqI+18bZuF/HD8qmRpET7IomR3DMEj5G4evyQIFR9Pmjp
X-Gm-Gg: AfdE7cmvxe5RT3AXAykuwTjlBVroflZkK8Q/tzz1O9RsaJL2h6QK92FCkLvE+rwY4hO
	iKQyhkqf9HHinUs36b13S3likmJ2E0p296efbRYsYLQmQEVT4mTmMYQ8nTZpUMHZX8DcdFrGXhk
	mXQ9GFkBHIuz6gx7JngGjhcnDRmc4TUQRwLCfUmnTspeN6dDSHqDQ7/JhsF0UURLpvtj3d/0j98
	C36XnS9zEVMCUHmN3FdNbe8kufHODuwttWVvIpbxkyjyGtLsg6uZS4GIRazeKEkjGs9J7GmM5BR
	hEjD9pAKk8vgXol9f+rJuQd4fQushtw1KcFTGVvdlvlZ6s63lB0eNQzDUFozX3DaxlLar/xckBs
	zdVAFU6dW50T4csp8tbtihRR46OasuAdJYW1pMhG/DpgjUEq5T51oLujWvbdmXpj8H3O9ueYmp+
	VqDpzooRKAT9jZo7uLHXaOLw5dzmW8QZULpeuJa2gmxxJiodJGo6/hmqMEsqy6FuJ7Jd8OT/g68
	lTvmvD0MY7eHIkegpS0AA==
X-Received: by 2002:a05:600c:620e:b0:492:5e22:ef18 with SMTP id 5b1f17b1804b1-493d2be8646mr41874915e9.9.1783195726563;
        Sat, 04 Jul 2026 13:08:46 -0700 (PDT)
Received: from shift (p200300d5ff229f0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff22:9f00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccd9d620sm158811555e9.1.2026.07.04.13.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 13:08:45 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift with esmtp (Exim 4.99.4)
	(envelope-from <chunkeey@gmail.com>)
	id 1wg6fL-00000000KNV-1pW0;
	Sat, 04 Jul 2026 22:08:43 +0200
Message-ID: <80d10637-2654-4dd6-bb24-3fbada3aa801@gmail.com>
Date: Sat, 4 Jul 2026 22:08:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: p54: validate RX frame length in
 p54_rx_eeprom_readback()
To: Xiang Mei <xmei5@asu.edu>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 Arien Judge <arien.judge@morsemicro.com>,
 Lachlan Hodges <lachlan.hodges@morsemicro.com>,
 Weiming Shi <bestswngs@gmail.com>
References: <20260628000510.4152481-1-xmei5@asu.edu>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260628000510.4152481-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38626-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,morsemicro.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johannes.berg@intel.com,m:arien.judge@morsemicro.com,m:lachlan.hodges@morsemicro.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AE8270864F

On 6/28/26 2:05 AM, Xiang Mei wrote:
> p54_rx_eeprom_readback() copies the requested EEPROM slice out of a
> device-supplied readback frame without checking that the skb actually holds
> that many bytes. Commit da1b9a55ff11 ("wifi: p54: prevent buffer-overflow in
> p54_rx_eeprom_readback()") closed the destination overflow by copying a
> fixed priv->eeprom_slice_size (and rejecting a mismatched advertised len),
> but the source side is still unbounded: nothing verifies the frame is long
> enough to supply that many bytes.
> 
> A malicious USB device can send a short frame whose advertised len matches
> priv->eeprom_slice_size while the payload is truncated. The equality check
> passes and memcpy() reads past the end of the skb, leaking adjacent heap:
> 
>    BUG: KASAN: slab-out-of-bounds in p54_rx (drivers/net/wireless/intersil/p54/txrx.c:507)
>    Read of size 1016 at addr ffff88800f077114 by task swapper/0/0
>    Call Trace:
>     <IRQ>
>     ...
>     __asan_memcpy (mm/kasan/shadow.c:105)
>     p54_rx (drivers/net/wireless/intersil/p54/txrx.c:507)
>     p54u_rx_cb (drivers/net/wireless/intersil/p54/p54usb.c:163)
>     __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1657)
>     dummy_timer (drivers/usb/gadget/udc/dummy_hcd.c:2005)
>     ...
>     </IRQ>
> 
>    The buggy address belongs to the object at ffff88800f0770c0
>     which belongs to the cache skbuff_small_head of size 704
>    The buggy address is located 84 bytes inside of
>     allocated 704-byte region [ffff88800f0770c0, ffff88800f077380)
> 
> Check that the slice fits in the skb before copying.
> 
> Fixes: 7cb770729ba8 ("p54: move eeprom code into common library")

Sure

Acked-by: Christian Lamparter <chunkeey@gmail.com>

> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>   drivers/net/wireless/intersil/p54/txrx.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/intersil/p54/txrx.c b/drivers/net/wireless/intersil/p54/txrx.c
> index 1294a1d6528e..9f491334c8d0 100644
> --- a/drivers/net/wireless/intersil/p54/txrx.c
> +++ b/drivers/net/wireless/intersil/p54/txrx.c
> @@ -499,11 +499,19 @@ static void p54_rx_eeprom_readback(struct p54_common *priv,
>   		if (le16_to_cpu(eeprom->v2.len) != priv->eeprom_slice_size)
>   			return;
>   
> +		if (eeprom->v2.data + priv->eeprom_slice_size >
> +		    skb_tail_pointer(skb))
> +			return;
> +
>   		memcpy(priv->eeprom, eeprom->v2.data, priv->eeprom_slice_size);
>   	} else {
>   		if (le16_to_cpu(eeprom->v1.len) != priv->eeprom_slice_size)
>   			return;
>   
> +		if (eeprom->v1.data + priv->eeprom_slice_size >
> +		    skb_tail_pointer(skb))
> +			return;
> +
>   		memcpy(priv->eeprom, eeprom->v1.data, priv->eeprom_slice_size);
>   	}
>   


