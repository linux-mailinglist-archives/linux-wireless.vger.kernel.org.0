Return-Path: <linux-wireless+bounces-33660-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TBsfML0ev2luvQMAu9opvQ
	(envelope-from <linux-wireless+bounces-33660-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:42:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C6A2E786A
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF1B830093A8
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A288C241CB7;
	Sat, 21 Mar 2026 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icSDnDjg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F57242D9D
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774132919; cv=none; b=na4Zi9dIIm5YT+Kr9+9r0Kv7V3sxY9TfWR+jTrHeodRxl1iEgrdzgHqVeV6I9h7pbZsOtpVkMNnxWUND3V276K4LPjJSxUfy1L3nRp3NxmyOp2tiHhn2uSTXq4Bus3qP8dMJjh9hrRvvU3CWOIyt+d4gnUH3TitirrMTzUT2ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774132919; c=relaxed/simple;
	bh=vNNwgmtjkPeT7iVunquUyx1AtzmJo9kc/1a1OFMY6tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vr2sBFp4xjM+nERgLYrmqbudHJOBPn2sKMcjXg15ZPQ2TfBXnd5GjT5rl5Usg/c37B3eg1qB8FbBkNg84gb0+t72wCkGVvsFHwP1aDjKojaaLuvv1DZDt1uavEENA3ueU4DORAUodeNEWtlyr5rP1iMl4mx14BvNjsJ2dAbNb2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icSDnDjg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so24114565e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 15:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774132916; x=1774737716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEu3F/1WSwP+uP501dKOCH3i4oNbCzx3X/c+Qj9v7z0=;
        b=icSDnDjgvR3sUyc3uCI7QxT0Sn9rQow0xvBTSrZBIwAcbKtEzYZf/6722DI28649fU
         RnifgGgrOJMksfdYtXqmE5z09abklEaiTA82emlnMCkx8TDAkYkY/zejQAMfebD+5n7x
         OHxdZQLKMw9hl3Z+K8hbwqavnok4ZFDQU7cfdARRKwWU2bc7ncaMmdxUuOqOjw3A7P+d
         u03Euuu1QMQdblmshWtEFw4JzUnvWdj2HbYwD89kAOIHaoHwrHKk7tuI1wkTh140n1lR
         aUunct8vW0txxX5aF20QgoYzIt8O/DM1rnYQ7s9En0ljuHXw/SzkMsYdl5Zdcn/sTahj
         HyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774132916; x=1774737716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEu3F/1WSwP+uP501dKOCH3i4oNbCzx3X/c+Qj9v7z0=;
        b=NqCnoTyGCzmKvyj5zdyqfz75ND+Ne664PnfrrmBnXtJsoG9SvQMHG8rsLtv1GP8NYl
         HlzeS/QwIRTrmOt82mvkxXDcpJuC8/H+imflqeaWXaru/T0YqWHZ0JseqU8xiPKlAmT7
         XK/37VdRdXK3MURjDLivH4+tZEW8p2oAMTdYgdqeN6PtNkoXdit0MwOuLOam0wCEl0WE
         oTWAh/5Fm52DBSOhW6YDSLt1aSMVjyEtKxo4fpopkgCOj/VRW51P+Q+eU07X9xSGRnA/
         BL1KAAH90TSQ8MTBpPnts84639soiC0pMKYLpjA8MAbE2B08O3kXnG/pX2FOq8DdDZXp
         TSWw==
X-Gm-Message-State: AOJu0YzkUBLL3V5Tr1rnort6uXas/sY+EPSATf1ffW3mqJjvJSTbJI3p
	Ek0MEGATwMR4rVY9j/TlthsykDACyMXXop8wMRpJea36+/3LXcS5TG2F
X-Gm-Gg: ATEYQzzw6Z12gWRXQwPT5IzPMBr2JuVdBCgeLO+iVMlifNkxTe4iR2nQeE9bN0YBEzJ
	BxdHjd4GjnksjDAI/BvdXm1vFtqVbLRYIEeHJtytrnSjQVNQSs4DuQjYO7Yr5St75pthE+vsk9t
	zjinsTH1/xKy3ESvaUC/2qeS8cE0w7bcJMbaITpHn3WnmjE2tlqLCFu18JI/dHGK5Zr2cihEUWN
	ARNvbJ4VdmnH7R7G4LYK93Vh+OrG7lxmxdinmYB7E7SRDNW/X+oVMTkzzX7r7faJqc8GISAM+fg
	5Mla4+LlZiArEVeBrB2eaCOlrCR3mtG/iNTJCu9ifj35KwI6ajEtKFBacT/pZXyE3nuFyiz370s
	+wKoj62NENrSrudjAhXRVw4fYnUWFBy2IRJ/S13ya0D90Ljei29wj5vP9R0qUb/ZWISj4fLgalN
	eVLlpK8Cf5JeYqpion8iBibL+j3g9/1tt2Q5Hn6tAT9Gr9NEzQQdOJjPUoLg6RaelD4kfO0vhmI
	PLr+VmMbFH2argM9bby0lEfONoB9kbH
X-Received: by 2002:a05:600c:1383:b0:486:fbc4:8fe2 with SMTP id 5b1f17b1804b1-486fe8fb2b2mr113587475e9.15.1774132916435;
        Sat, 21 Mar 2026 15:41:56 -0700 (PDT)
Received: from shift.daheim (p200300d5ff07e00050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff07:e000:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1aeafdsm45562545e9.21.2026.03.21.15.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 15:41:55 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.1)
	(envelope-from <chunkeey@gmail.com>)
	id 1w44yO-00000001Qaf-39uk;
	Sat, 21 Mar 2026 23:41:54 +0100
Message-ID: <4b7b0e25-dc71-4f69-9908-cd19113822ce@gmail.com>
Date: Sat, 21 Mar 2026 23:41:54 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] carl9170: cmd: downgrade transient register I/O
 errors to wiphy_dbg
To: Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org
References: <20260317110634.70347-1-mas-i@hotmail.de>
 <AM7PPF5613FA0B67FB95CB5305CEF9DAA209441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Language: de-DE
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <AM7PPF5613FA0B67FB95CB5305CEF9DAA209441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[hotmail.de];
	TAGGED_FROM(0.00)[bounces-33660-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hotmail.de:email]
X-Rspamd-Queue-Id: B4C6A2E786A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 12:06 PM, Masi Osmani wrote:
> Register read/write failures during deauth/teardown transitions are
> harmless — mac80211 tries to read survey stats or write slot_time
> while the firmware is in a transitional state.  The command times
> out with -EIO but the adapter recovers and re-authenticates normally.
> 
> Downgrade both "writing reg ... failed" and "reading regs failed"
> from wiphy_err to wiphy_dbg to reduce dmesg noise.  The errors are
> still visible with dynamic debug enabled for investigation.


Sure

Acked-By: Christian Lamparter <chunkeey@gmail.com>

> 
> Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> ---
>   drivers/net/wireless/ath/carl9170/cmd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/cmd.c b/drivers/net/wireless/ath/carl9170/cmd.c
> --- a/drivers/net/wireless/ath/carl9170/cmd.c
> +++ b/drivers/net/wireless/ath/carl9170/cmd.c
> @@ -52,7 +52,7 @@
>   				(u8 *) buf, 0, NULL);
>   	if (err) {
>   		if (net_ratelimit()) {
> -			wiphy_err(ar->hw->wiphy, "writing reg %#x "
> +			wiphy_dbg(ar->hw->wiphy, "writing reg %#x "
>   				"(val %#x) failed (%d)\n", reg, val, err);
>   		}
>   	}
> @@ -78,7 +78,7 @@
>   				4 * nregs, (u8 *)res);
>   	if (err) {
>   		if (net_ratelimit()) {
> -			wiphy_err(ar->hw->wiphy, "reading regs failed (%d)\n",
> +			wiphy_dbg(ar->hw->wiphy, "reading regs failed (%d)\n",
>   				  err);
>   		}
>   		return err;


