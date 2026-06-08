Return-Path: <linux-wireless+bounces-37542-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sr1GIC0UJ2pOrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37542-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 21:12:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD6F65A029
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 21:12:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Rdtu517z;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37542-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37542-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B5EF302084B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 19:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156EF38655C;
	Mon,  8 Jun 2026 19:12:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420B2F1FC9
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 19:12:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945951; cv=none; b=EP+ud3Cbbe3LFePWoMqIc1EQESZYzfocZmSLWktLarNaZ5ATIBweb+MdoRvNR7EVLRjo6ChC3Hupx0H4vCUwjHQZCtBC2/JD18CICSS/iuUfjxSrVKX3mQLPGBw/snvL3Z0iZ5jEuhOJcxxAMpEFZDkdTeTEwNVWxQIc8iZjO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945951; c=relaxed/simple;
	bh=LDXTRbCWYEbapuQGCjzgWihWimUqlbTUN3YVX6E7j+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=a2J4oAIAxBBsFloxS3TGIo///1HEROiyL2CJnOYrlLzTTBDkklkeeeu98+EDhvaNtv6r6k7joDaLO2WHcqaKi5WWKYhdGSq/MxfY+YO+UvFqGaHqmSMbqTlgp8kkUXnR5TlAy7GFYOQ43qr8c1eOOsXrMO0x0mQD2NvkCysmBa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rdtu517z; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso3337873f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 12:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780945947; x=1781550747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjfzFHspnd0wlaOXvUBzGNzuje4byIiO0cGsAZ8d+as=;
        b=Rdtu517zdBnnGLhovBTJHthloGoO0wF014BWa5FYmC/7vb7sv9tKW73IMqq2/ZWDGk
         QH/lJcqSgDWOo8OY70MzoktSMTw624yaDDAqtSY7pR48xpZSBTUAlOggwG80xJOi//Il
         hDo8eeUfDf1Js1Y3wjX8eoHEMZzJbsbY3Uae0crGNrZelUvHiaM8IufvBWqPwMwXeCMY
         QEQRNQGI9/viw/DYcBL9c5RcxI4QJaYfS6A+IGBWE/WJTPPlzhjhpMBJCKl+WrHRofWi
         Ou4/PqAswV8TuagFdjrUWRWgbPTOEtTPVI1/c9Gft3RDCbEwTMMF4WSFvlbhsQ4m85vg
         NIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780945947; x=1781550747;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjfzFHspnd0wlaOXvUBzGNzuje4byIiO0cGsAZ8d+as=;
        b=HZtv+ewoFGUBEn4M9UfQw6PwQHMxGNl67N4eB47I7nfktQ/2WFvEA07iLK9IoIamYV
         CgbB//QpPaEkiARxOT7+w+1356DK+GbF3Idz7tkrbuXDYpfDPVHVdZ1y5zbYI9XOOw1J
         BUXdoGwB+TjBzU6aWVFQUYuzAK1EErAzNTPPvgxPrAv7SQmQ7VSx5NEzwggsz2xlIsgy
         Cu+byH9T01fhYE8lmKUrafBcPnnPVD1NrouwiQXaXHDC0dtv83aeViba5MxbAN92vT5r
         oK4ynoEgZHxQSOIzxR/P3pXpeZ8ukkfxDLtI2fgg01KO15o8ic0yAVmk6stNQG00xQRw
         wEwA==
X-Forwarded-Encrypted: i=1; AFNElJ/yfL+YbpqxnrjnKDoq15XkU+wFLbgia9Jycmcd39DHz+4VGpW5eviDpOP/S4EXG2K8ReVg46Yr4Vv80DeR6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97ExSossYQzScat18pn6tKaQb8DQxByyG+UfSGGwLXUijhWHz
	8Jn953bHXTIZ3C2IjxsV6Q+3XLIoaWOsY5Qpy2EBoAse+VZG2oc2MakgztgZAw==
X-Gm-Gg: Acq92OHUuaZ5Ki1ZPoXdJSNoSgjnPsrdcsyn7PLdlf9bA+i0TLFekKZQsIsbD9cToz4
	dGjocm9T8AEirzAAMTjWRpY1WQb61pgvN/TQ8PYqCDppToLFl3a/SJT2d2SMfXYi6gZYbj60fPk
	lzpBYva2yKCYc5CQp+oZvOVdGXvsuqBSEzltqDglFot0TpaKKaLLJfczk7eheb+u2rAOgFhB9ME
	8LpTrm8P7iqqCx0q/Bx/usPteEhmakJBjHGIZPw2aPCRii8gh09HfJKGovWzZ6Fp1x4kF628YUP
	WSRLu0FWEHlsCOGsX/r8rvDiQLiR2LokSydDlQ5mG2mMl9cRXUrXU5nOj7Cz6g0sjUPBJMDLE+S
	0+4gILXnTEQumSp3QiSbaF8snziHy0g+LrsNQeayK47Al8mojtKBPIFHFfctaCPlrg/1biKqzRr
	isUBXkcBAiLgFN/W9SmFSUmeZIAIzBCWL0G5Zz4ap6agg=
X-Received: by 2002:a05:6000:468b:b0:43d:7868:21f0 with SMTP id ffacd0b85a97d-460304f9e96mr17547329f8f.9.1780945947128;
        Mon, 08 Jun 2026 12:12:27 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm52886690f8f.16.2026.06.08.12.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 12:12:26 -0700 (PDT)
Message-ID: <c056f6b3-e2e2-4bfd-9cd0-14225bd4d510@gmail.com>
Date: Mon, 8 Jun 2026 22:12:25 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] Ongoing instability and connection loops with MT7922
 (mt7921e driver)
To: Angel Parra <jesusnavarrojr188@gmail.com>,
 Linux Wireless Mailing List <linux-wireless@vger.kernel.org>
References: <fa96f303-ba3d-47f0-8ffe-04c088d22913@gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <Sean.Wang@mediatek.com>
In-Reply-To: <fa96f303-ba3d-47f0-8ffe-04c088d22913@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37542-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jesusnavarrojr188@gmail.com,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:Sean.Wang@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDD6F65A029

On 28/05/2026 04:44, Angel Parra wrote:
> Hello,
> I was advised to reach out to this mailing list regarding severe wireless connection issues with my MediaTek card. I am writing to request a review of the `mt7921e` driver. While I appreciate the significant improvements made to the `mt7902` driver recently, the support for some newer chipsets currently feels almost unusable in real-world conditions.
> 
> My hardware details are as follows:
> ```text
> 02:00.0 Network controller: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter
>         Subsystem: Foxconn International, Inc. Device e0cd
>         Kernel driver in use: mt7921e
> ```
> 
> Below are the most consistent bugs and instabilities I have observed to the date that constantly interrupt our workflow:
> 
> * The adapter often fails to discover nearby access points, despite multiple mobile phones confirming their active presence.
> * Both 2.4GHz and 5GHz WLANs frequently remain undetected, even when the laptop is directly next to the router.
> * Regardless of physical proximity to the modem, the connection process regularly hangs on "Configuring interface" (in the KDE Plasma desktop applet) for over 15 seconds. After this delay, the connection either succeeds or fails completely.
> * When successfully connected to 2.4GHz bands, download speeds are remarkably slow and fall significantly below what my phone achieves on the same connection.
> * The detection range is severely limited; establishing a link to a 5GHz SSID requires being in the exact same room as the access point.
> * Introducing a single wall between the router and the laptop triggers the aforementioned 15-second "Configuring interface" hang, usually resulting in a failed connection.
> * Upon failing to connect to an otherwise healthy access point, the system enters an infinite loop. It hangs on configuration, fails, jumps to the next saved SSID, fails again, and cycles endlessly through all saved profiles.
> * Overall connection stability is exceptionally poor. A successful connection might persist only if the laptop remains perfectly stationary. Otherwise, the link randomly drops after a few minutes with a "Connection deactivated" state, triggering the failed connection loop.
> * Attempting to bypass these issues by tethering to a mobile hotspot directly next to the laptop also fails. The adapter either cannot detect the hotspot at all or hangs during configuration, leaving the machine entirely offline.
> 
> The failing connection loop in `dmesg` looks like this over a span of several minutes, clearly illustrating the continuous authentication timeouts as the adapter cycles through my saved profiles:
> 
> ```text
> [148485.661369] PM: suspend exit
> [148488.781860] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [148488.795305] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [148488.843935] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [148488.996043] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [148489.044916] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [148491.867424] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [148491.880895] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [148491.939014] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [148492.094896] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [148492.142676] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [148495.354718] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [148495.368216] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [148495.418798] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [148495.577799] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [148495.625990] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [148499.324558] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [148499.337991] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [148499.387641] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [148499.542987] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [148499.593575] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [148510.294935] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [148510.308356] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [148510.360427] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [148510.406754] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [148510.566970] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [148520.573843] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [148520.587285] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [148520.644274] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [148520.693177] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [148521.140382] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [148541.462597] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [148541.476062] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [148541.522330] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [148541.973505] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [148542.022304] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [148548.610998] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [148548.624376] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [148549.075668] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [148549.121771] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [148549.574886] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [148552.427178] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [148552.430014] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [148552.470639] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [148552.513942] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [148552.556374] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [148565.252575] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [148565.266023] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [148565.396382] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [148565.446749] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [148565.605849] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [148579.997166] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [148580.010594] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [148580.072257] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [148580.112398] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [148580.152361] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [148592.848439] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [148592.861867] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [148592.903480] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [148592.995422] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [148593.041528] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [148607.612953] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [148607.626393] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [148607.698476] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [148607.742091] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [148607.783429] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [148620.219579] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [148620.233011] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [148620.328013] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [148620.374159] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [148620.534020] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [148633.224869] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [148633.238306] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [148633.303939] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [148633.356603] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [148633.514978] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [148637.634640] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [148637.647620] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [148637.694360] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [148637.743291] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [148638.192244] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [148655.509368] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [148655.522809] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [148655.572981] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [148656.021379] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [148656.070061] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [148677.626050] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [148677.639450] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [148677.704689] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [148677.753188] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [148677.914243] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [148680.509871] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [148680.512694] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [148680.530021] wlp2s0: authenticated
> [148680.530280] wlp2s0: associate with 84:d8:1b:9f:91:10 (try 1/3)
> [148680.555487] wlp2s0: RX AssocResp from 84:d8:1b:9f:91:10 (capab=0x411 status=0 aid=4)
> [148680.582777] wlp2s0: associated
> [149142.517235] nvidia-modeset: WARNING: GPU:0: Correcting number of heads for current head configuration (0x00)
> [149361.823195] wlp2s0: Connection to AP 84:d8:1b:9f:91:10 lost
> [149418.133906] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [149418.145316] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [149418.194402] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [149418.242746] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [149418.692292] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [149437.001016] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [149437.012391] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [149437.095855] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [149437.142168] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [149437.593548] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [149464.557438] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [149464.568407] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [149464.730630] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [149464.777125] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [149464.932766] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [149474.631073] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [149474.644554] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [149474.690700] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [149474.849313] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [149474.895328] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [149535.532981] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [149535.546820] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [149535.678835] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [149535.725111] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [149535.880819] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [149879.705065] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [149879.718556] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [149879.794297] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [149879.843592] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [149880.017253] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [149888.633997] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [149888.647548] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [149888.805077] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [149888.856075] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [149889.015401] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [149928.562888] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [149928.576448] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [149928.619097] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [149928.661687] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [149928.737998] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [149941.444820] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [149941.458370] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [149941.615999] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [149941.662509] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [149941.711201] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [149956.605669] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [149956.619156] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [149956.673039] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [149956.721411] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [149957.172885] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [149969.882794] wlp2s0: authenticate with 84:d8:1b:9f:91:10 (local address=38:d5:7a:12:c2:3b)
> [149969.896301] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 1/3)
> [149969.943140] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 2/3)
> [149969.990954] wlp2s0: send auth to 84:d8:1b:9f:91:10 (try 3/3)
> [149970.442757] wlp2s0: authentication with 84:d8:1b:9f:91:10 timed out
> [149984.624558] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [149984.638187] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [149984.697458] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [149984.737544] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [149984.778744] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [150016.560488] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [150016.573492] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [150016.614971] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [150016.673246] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [150016.721924] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [150051.575890] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [150051.589489] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [150051.636535] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [150051.685162] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [150052.134899] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> [150064.827990] wlp2s0: authenticate with f8:64:b8:b8:3d:7a (local address=38:d5:7a:12:c2:3b)
> [150064.841478] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 1/3)
> [150064.966855] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 2/3)
> [150065.015378] wlp2s0: send auth to f8:64:b8:b8:3d:7a (try 3/3)
> [150065.174847] wlp2s0: authentication with f8:64:b8:b8:3d:7a timed out
> ```
> 
> Thank you for your time and for reading through this report. I would greatly appreciate it if this could be routed to the appropriate maintainers to help address these driver issues. Have a great day wherever you are.
> 

Hi!

These details could be helpful:

- Laptop model
- Wifi card's PCI ID (from "lspci -nn")
- Name and version of the Linux distro
- Full output of dmesg

The mt7921e module has a parameter called "disable_aspm". Have you
tried to set this to 1? Just a random thing you can try.

I'm not sure if it's necessary with the Mediatek cards, but if you
try this parameter, do a cold boot (set the parameter using the
bootloader or a file in /etc/modprobe.d/, shut down the laptop, then
turn it on again).

I added the maintainers of mt76 to the Cc list.

