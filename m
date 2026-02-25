Return-Path: <linux-wireless+bounces-32177-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CsCH9/xnmnoXwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32177-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 13:58:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9941E197B17
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 13:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD84D3013C76
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61C2318EDC;
	Wed, 25 Feb 2026 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="k2IwiTGH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8C739449B
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024240; cv=none; b=IZS7T5A6x8IjQrilv91hMajwugI3mmVcwBI6PSwLMpcINdSX2H5DVtgfzE2itXbK1p29Mt28Ke0Li7GsIV6y5h5uNwEQxnpRmSyxYfaKBi7pNS27m52tPyenMut8XsgF8pC0uTBu1ph4dEigehLZIvJ8f2cLjPj0hpgE7OsZLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024240; c=relaxed/simple;
	bh=4TAVCHc14CW4hnY7SV7tbUeQlgGFixHOwVlpMgFb/JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFytBkm7FVnifRNhC0YotyKbGPN1FRxmbp4UpJS/L78p1OBoQ1GOpfHZR0Jm6h+V/fyK8eGKexaZB7KL8ygyjLNbqBfQQhf5h5y8a9yBW5VuhR4ICftkZ9lHYu7jV/8vFtFVkM1bGdgONLfzi2Qy80rIFmRcA95++//+x0TFkn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=k2IwiTGH; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-436309f1ad7so5222935f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 04:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1772024236; x=1772629036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1C7yIlT94IoBr8iXO/ZX1qatNSVFuy44K0ykk4DpylY=;
        b=k2IwiTGHLBzw22huZ2NGKKHQ8QJm0QLveMETEPhX3cklJW3eZ1Q9dzzvS+HC6My6fc
         W2btS3d2Ey7GBV4YbhuHSEzB6dBN3jQmNJsQzgIRdXs48UUj6skwgmcMNYBRtGuMSDGd
         Mz/jB36jtm/PPBEbJIK1yPjvMOk6X4aQbGA5A/f39jiJ3OoeNymrZdzpl76iH4Gw0nL1
         cHiq2m0tkxXAaKirK0EXThMdqPpY/kptw/8mWtxEj3HX3im7hRJBwukdzZRj7NPYB5aq
         IrAhH7ZgTTf38UX5ZkNIa2myYpTM07m1VtVXuKxi3eMV4Oytts0R5e7hC3hadMOch7xc
         1BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024236; x=1772629036;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1C7yIlT94IoBr8iXO/ZX1qatNSVFuy44K0ykk4DpylY=;
        b=DG4GajkajsRIDM62wJBVCqAj6CWkt6W1C0WqBeGFmwjwIcV4wejWzWNF1MzXya7eJM
         54VEkZ28LbUojHIaiAZrmqdLA18cpx2D34rqUc95ztld4AhBs6xOy4hKsF8aqogib6YQ
         OuLDjA0npWDJFXWgfmqsf04YZwZQCDKt0XCXAT37JmnbX0I/O/tC6xdYK4OykfH30V9W
         lyeiUyUP31g15i/b5zokHw1jaGDxDl9omA1+rFX6m14wAppiTzImCe24IolT3M18OKW2
         Kk4Ct/zfiCt7yr+hQdfvKwkyWKZEdCb5XVdLL465ngAbaJgqn/scgAvF6m3poC7uwt8/
         y/5Q==
X-Gm-Message-State: AOJu0YwPRO7ivMgfo7OPRH2i5Uy2NpA8w+GtkzQv9xzrUeC4wT3WEyni
	0vUCbwoENEb3+PeUG5VT62Rv9laW1bDTe1IxUoOllwDGYv0+v1QBYz8HvnTXFHzChm8UsC1pery
	v8JaDREg=
X-Gm-Gg: ATEYQzz+ioGDwgmrJFPfF5gtMYedSOv8sOS7wZxJ+meTERaj1pCoDK3vnITauCp9l/I
	CRqDgh/k+Na/zw1Hutn4xuTA/eKefVeUL374xRquA5+ApMW6oVGfV2R3Hre+7dx6Lvikqt6lpSb
	VTKcOuh8Iw/c+gv0yMoaUQ+hJOUl86ILi2bXf5s5X2bFQSorQr0dbomksz0xJ0S+gZF9ARQ5LoH
	ZfH2e7/wPikX85u7oHHvpEdbeChiJ6q1n9+MPyt1t3d1y3bXOP7lefx+l4uNg21o5rMtW2myfOJ
	faBqchpgE3uauaW/zPrYS+r2YOzhCXBy0KjTMeBFHgNLfziGDIIcFa4vufWJjBF2wTzGm58HfTL
	rUz3jaq8QkZwBjOUo+zUXqYYfZgl3NbDnCR1FLpB9ku0AdTExG9cFxj+kylOKs1t3AXseslGDWi
	uk16JFfeFCEOYIDWfPpgeqGu2D0Pr5s107cpWDTnFerWnfLCjqdMqA1w==
X-Received: by 2002:a05:6000:1a89:b0:439:86ac:6dae with SMTP id ffacd0b85a97d-439943068c9mr741587f8f.58.1772024236115;
        Wed, 25 Feb 2026 04:57:16 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398fefa3f8sm4145940f8f.36.2026.02.25.04.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 04:57:15 -0800 (PST)
Message-ID: <a1057b77-de96-4fa2-8eb7-54320f0f3aca@freebox.fr>
Date: Wed, 25 Feb 2026 13:57:15 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Pass the correct value of each TID
 during a stop AMPDU session
To: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>,
 ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260225114912.966266-1-reshma.rajkumar@oss.qualcomm.com>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <20260225114912.966266-1-reshma.rajkumar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-32177-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9941E197B17
X-Rspamd-Action: no action

Hello,

On 25/02/2026 12:49, Reshma Immaculate Rajkumar wrote:
> With traffic ongoing for data TID [TID 0], an ADDBA request to
It's a DELBA that is going to be sent to stop a BA session.
> stop AMPDU for the BA session was received on management TID [TID 4].
> The corresponding TID number was incorrectly passed to stop the BA session,
> resulting in the BA session for data TIDs being stopped and the BA size
> being reduced to 1, causing an overall dip in TCP throughput.
I'm guessing you only tested TCP traffic, but UDP throughput is also going to dip.
> 
> Fix this issue by passing the correct argument from
> ath12k_dp_rx_ampdu_stop() to ath12k_dp_arch_peer_rx_tid_reo_update()
> during an AMPDU stop session. Instead of passing peer->dp_peer->rx_tid,
> which is the base address of the array, corresponding to TID 0, pass
> the value of &peer->dp_peer->rx_tid[params->tid]. With this, the
> different TID numbers are accounted for.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
[...]

Pablo MG

