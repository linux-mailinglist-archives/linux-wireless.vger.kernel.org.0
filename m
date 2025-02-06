Return-Path: <linux-wireless+bounces-18607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E37A2B4DF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 23:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9433A1670B1
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 22:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CAB22FF35;
	Thu,  6 Feb 2025 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dPngntNj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5223C395;
	Thu,  6 Feb 2025 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738880038; cv=none; b=LKnz6o5VIYDqPS4vwv5yPqoZsOI19UG2Nzz1UZRZVGVRPO4zRjxoZsdlmg+n9v+UtpvaeHh7c6jtjiATeO92cKYiHu42k024VMf52W+AvHD0T+9wB7b1pd3mSYUzlIoJYfi/eY2DHm3Ut+WtCEGvi2EbWW1m4RHCD7gsE6fDUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738880038; c=relaxed/simple;
	bh=QPSWX/xi0RPCGcHZ6ZN4i8VHsUL5re2rNucDfwV3lfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCU8N0H0gcKCMwkIwHr0hKo3+iOuJ2B883QQvyVw4jyL+UWlyw/8gNqbWFhiKnpzeX6dOemNodjI/4whqvKiPacZLklNiv0+n/jdP+7iP5ixEWPbwLCsjl9sIkYU815To4vst4Uo1VE21haAxN5D1ocPzkMEfESUWoi4g1bBhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dPngntNj; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Yprwg2SJtzlgTxr;
	Thu,  6 Feb 2025 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1738880030; x=1741472031; bh=QPSWX/xi0RPCGcHZ6ZN4i8VH
	sUL5re2rNucDfwV3lfE=; b=dPngntNjukDId1ecMG9utEC9mZI2JWRlN9xKSC/h
	vsQOLLd8vMDsSyXIDlvD078U197CxSo72e9Myc4YtFeZehx9Ag8un0Kb6cPb0TCm
	nRKj+rPjOSFwakAohOaZ9yjTEGS3CL30u9iLnys2vdZsZKIwm1zS3dCuQHnkQGsL
	UOntFK2Vb0MEDssjAE/la5YtxRYunr+rTorYRcupoCkZH07nbvAyrc43viu/yXBf
	/w42+aNksLxdj1Z7zlGnsVj3i5cUaNlpddFtVepcZfSuJD1V75/sLPFvc1h0Edx/
	r+5LkvMwmjSc7/Q9GVsQ8Tlkpv/rUcXzM8dQKBPtPN2BDQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id J_o6Dsq11wuH; Thu,  6 Feb 2025 22:13:50 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YprwW2SzGzlgTw4;
	Thu,  6 Feb 2025 22:13:46 +0000 (UTC)
Message-ID: <335edb88-c850-44bc-ae1b-79349175bc8c@acm.org>
Date: Thu, 6 Feb 2025 14:13:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 25/33] wifi: ath12k: Fix locking in error paths
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
 Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <20250206175114.1974171-1-bvanassche@acm.org>
 <20250206175114.1974171-26-bvanassche@acm.org>
 <7633c19b-2aab-4f2a-8c11-27425f7299ae@oss.qualcomm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7633c19b-2aab-4f2a-8c11-27425f7299ae@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/25 10:25 AM, Jeff Johnson wrote:
> Can you submit this as a single patch and cc the ath12k and linux-wireless
> lists (as I've done in this reply)

Done :-)



