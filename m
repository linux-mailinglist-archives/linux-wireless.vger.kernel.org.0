Return-Path: <linux-wireless+bounces-11581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43C955463
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2024 02:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD65C1F22048
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2024 00:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F8323D;
	Sat, 17 Aug 2024 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="QTX7qDQt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8A6FB0
	for <linux-wireless@vger.kernel.org>; Sat, 17 Aug 2024 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723856013; cv=none; b=C1/n62ToBb/C8wWulSW54Hrggvi8aXtWmv9VWENxdgvbGllCCrLzrv18HRC5ZghtH3JPt8GhuGJgtAs8tH+QVDXIxhPLs472qQRYe0RWfmEkPio7BXitk+7jaGNv/LagCIA++xmUyyzvMpmOxmr3mtc5rjuzGNUoYrlTABzMbU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723856013; c=relaxed/simple;
	bh=lZTBWJOaLYg60bRW0fCRBWaNQRnYM1IlLXBUJE1EXNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9Ep+Jv54s+Syr8wiGCBvOhWhBVzu4N+GtM4xBte6a38ZFo/vsMaQ4U3PDmJQndi/DFmVeSS0jMV9avPY2D+uqOMoMxafFk/zJtmbFZrPTyD3pMqrPWpCXC1KS3OWpwAE+i9sOUevN9JYz1pGVr8vOe+4C32c4cWUbIurEG+CTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=QTX7qDQt; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7948C005F;
	Fri, 16 Aug 2024 20:54:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1723856048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=65ox8uJ/RGg4OUccZkQBwsIw3G2kyJQ+60meEiFHu3U=;
	b=QTX7qDQtswjk4HLypiq3ROfp1fuyHwOaCPZgDG7vAFfxdfVVl4u/zMf31rMzbRaWAE28CP
	Cutat57ff2Zm2mUy5q9O1ENqtb+vt98NMqgqza4R0AjDVghBBG3ynrL3THR+dupA+hBq5A
	CVyLcNHd74SgJNkRxfN5R9bNT00jIVI=
Message-ID: <10435420-4f1f-4a56-aacd-41866ae7dac3@kaechele.ca>
Date: Fri, 16 Aug 2024 20:53:15 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] wifi: ath10k: improvement on key removal failure
To: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org
References: <20240814164507.996303-1-prestwoj@gmail.com>
Content-Language: en-US
From: Felix Kaechele <felix@kaechele.ca>
In-Reply-To: <20240814164507.996303-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

I was somewhat hoping that it could fix the issues I'm having with my 
QCA9379 as well, but it seems that's not the case.
Still getting

[ 7660.485652] ath10k_sdio mmc1:0001:1: failed to install key for vdev 0 
peer 76:ac:b9:xx:xx:xx: -110
[ 7660.485679] wlan0: failed to set key (2, ff:ff:ff:ff:ff:ff) to 
hardware (-110)
[ 7660.509935] wlan0: deauthenticating from 76:ac:b9:xx:xx:xx by local 
choice (Reason: 1=UNSPECIFIED)
[ 7661.836653] wlan0: authenticate with b2:8b:a9:xx:xx:xx (local 
address=de:56:bb:xx:xx:xx)
[ 7661.836685] wlan0: send auth to b2:8b:a9:xx:xx:xx (try 1/3)
[ 7661.849449] wlan0: authenticated
[ 7661.853884] wlan0: associate with b2:8b:a9:xx:xx:xx (try 1/3)
[ 7661.902242] wlan0: RX AssocResp from b2:8b:a9:xx:xx:xx (capab=0x1111 
status=0 aid=2)
[ 7661.913192] wlan0: associated
[ 7662.187718] wlan0: Limiting TX power to 24 (24 - 0) dBm as advertised 
by b2:8b:a9:xx:xx:xx

once every hour.

That's unfortunate.

Regards,
Felix

