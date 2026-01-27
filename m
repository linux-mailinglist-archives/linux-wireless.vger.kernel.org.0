Return-Path: <linux-wireless+bounces-31220-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AJiLTGceGmTrQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31220-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 12:06:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E416893599
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 12:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B1B53003BC2
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6D30B53F;
	Tue, 27 Jan 2026 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="PleGCWe3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9113030BF79;
	Tue, 27 Jan 2026 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511976; cv=none; b=ZvDdHRmXw/47qqgfyJJozH7McsvUvCBQexYqISDJySJiuv0Q/va0KQTmegrB51sg1JIi3r6Xm5Khm37FQa9dx54NMOovQI5NMIMe5RFKNQOPNQwVgMFelamJNPy6eJcv77u4Jm321qi94rbmRTaAbyW17+mD+8g7cXaZxl8HE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511976; c=relaxed/simple;
	bh=sIvRkYqAQuz66YvmDwCt3k+esCCc3AMRfzjWwpi0deU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI+QgFA70SIcHFk293EIlaTkO1h0L7Mm/OjKoHwP5ICspMZl0o1DOKeGA0Kf6LlvfaTIxYDnvig/2yAgv1C9Kk+jSuVnQzK/b1TOA3P9X9MxJxKnbCjzHk9VzzQig+QbJZ8lguVV6fXPqHXUlg/NViZ+CzM44Kw+PuNIXpoM62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=PleGCWe3; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Na1vcvFToKAlP+gcDTXu43Yb7D0Mcd0xqiMaFIxU/qI=; b=PleGCWe3qI/8WoePBKkbGLb+tz
	SbvHCRLSH3TQaEXlW/J1Kd7OC1FaIR9Wxwe5x2tZq0B/V9Y2PwIJEioIPXJisyZ+peEabpsUcvOOx
	Zd/1GnOv3CMgk1qkIUjoZs6G1Cq32K8qjVBZGslxD4FwRxkKMtw547xYO8aDMNCn3zec=;
Received: from p54a43f8f.dip0.t-ipconnect.de ([84.164.63.143] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vkgtc-00BXsD-0B;
	Tue, 27 Jan 2026 12:06:08 +0100
Message-ID: <8d1b7d91-5191-4292-b49b-3d96dc76232e@nbd.name>
Date: Tue, 27 Jan 2026 12:06:07 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] wifi: mt76: mt7925: fix ROC deadlocks and race
 conditions
To: Zac <zac@zacbowling.com>, sean.wang@kernel.org
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux@frame.work, lorenzo@kernel.org, ryder.lee@mediatek.com,
 sean.wang@mediatek.com, zbowling@gmail.com
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
 <20260120201043.38225-1-zac@zacbowling.com>
 <20260120201043.38225-13-zac@zacbowling.com>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <20260120201043.38225-13-zac@zacbowling.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31220-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.778];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nbd.name:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,zacbowling.com:email,nbd.name:mid]
X-Rspamd-Queue-Id: E416893599
X-Rspamd-Action: no action

On 20.01.26 21:10, Zac wrote:
> From: Zac Bowling <zac@zacbowling.com>
> 
> Fix multiple interrelated issues in the remain-on-channel (ROC) handling
> that cause deadlocks, race conditions, and resource leaks.
> 
> Problems fixed:
> 
> 1. Deadlock in sta removal ROC abort path:
>     When a station is removed while a ROC operation is in progress, the
>     driver would call mt7925_roc_abort_sync() which waits for ROC completion.
>     However, the ROC work itself needs to acquire mt792x_mutex which is
>     already held during station removal, causing a deadlock.
> 
>     Fix: Use async ROC abort (mt76_connac_mcu_abort_roc) when called from
>     paths that already hold the mutex, and add MT76_STATE_ROC_ABORT flag
>     to coordinate between the abort and the ROC timer.
> 
> 2. ROC timer race during suspend:
>     The ROC timer could fire after the device started suspending but before
>     the ROC was properly aborted, causing undefined behavior.
> 
>     Fix: Delete ROC timer synchronously before suspend and check device
>     state before processing ROC timeout.
> 
> 3. ROC rate limiting for MLO auth failures:
>     Rapid ROC requests during MLO authentication can overwhelm the firmware,
>     causing authentication timeouts. The MT7925 firmware has limited ROC
>     handling capacity.
> 
>     Fix: Add rate limiting infrastructure with configurable minimum interval
>     between ROC requests. Track last ROC completion time and defer new
>     requests if they arrive too quickly.
> 
> 4. WCID leak in ROC cleanup:
>     When ROC operations are aborted, the associated WCID resources were
>     not being properly released, causing resource exhaustion over time.
> 
>     Fix: Ensure WCID cleanup happens in all ROC termination paths.
> 
> 5. Async ROC abort race condition:
>     The async ROC abort could race with normal ROC completion, causing
>     double-free or use-after-free of ROC resources.
> 
>     Fix: Use MT76_STATE_ROC_ABORT flag and proper synchronization to
>     prevent races between async abort and normal completion paths.
> 
> These fixes work together to provide robust ROC handling that doesn't
> deadlock, properly releases resources, and handles edge cases during
> suspend and MLO operations.
> 
> Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
> Signed-off-by: Zac Bowling <zac@zacbowling.com>

The rate limiting code seems a bit suspicious to me.
What does "limited ROC handling capacity" mean? Outstanding ROC 
requests? Does it need time to settle after a completed ROC?
This needs to be clarified and likely replaced with a more targeted fix.

- Felix

