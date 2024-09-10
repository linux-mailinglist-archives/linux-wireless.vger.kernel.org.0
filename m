Return-Path: <linux-wireless+bounces-12744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F805972D91
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEEE1C21015
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25406188CC6;
	Tue, 10 Sep 2024 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FATnzlXB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F074188CCB;
	Tue, 10 Sep 2024 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960331; cv=none; b=GeDKqMKybhtmumPMkpUcvdWcAapzPNq7IwfDbsIiYPxsf+cl8QgXl/G8LkJqnwzpwXmkFG/QVAvdLxmu1QV7QTZRW7y47ncI/6cXsC9pMrUPPD+RYDzsF0PAaETrpYpbn7c5lHFXx//1FPo5o0bXjINx+dHYc0O1rnpUiQNQI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960331; c=relaxed/simple;
	bh=D8dBIueGzesLGGRk3hZwyBzr/bbPBQNnsJH5SJOAP+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLdAizKJi2ArlCMRqPYMBV8LsgkpOEx5R3ECFOh4QFkWP27X2AtjN3PT7DVC/mO0CKWyc1pXZ71FXC9wOOyicD43Qr4IXv820kd1CYG/loRGvdoe9/GSfQg+Sx0Ifj5ivc2kNc/gFd58JlRFRo9jjxlJ+y5Js5QviMpBM4tYtsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FATnzlXB; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E2371BF205;
	Tue, 10 Sep 2024 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725960326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ObNOhCefIHiYjtUxb2YhyjH2bCENh8h6kLyNWuK5el4=;
	b=FATnzlXBRX92xxwLWic/BIduiLah08DGCvSnpMuqYm+tD5JZDwz6b2/F/jDeQZgcxXKA8/
	0OO/3jH6qbvsimn6PqP6oJMFbkvlN61i0hjb+IpEw9wbzBfLHqWBSTUAJlxDatj4P/Gr6q
	TtOqPCiKtzUkO3DuMmVoxZszVaVjQikNX7wM8kjmvdHYA5rcfR/wWmYmPrCmI9HO/y7F3A
	fi586sbQt9LBxOWv1X88AaaZ1BiPBVYWEMyJX67ZfOMoUmlyS8n9D/jQvcvwRseL9WeC1P
	OM5cr7CM0ZPdTIJrIp3KcEmnunmtEn/Fihd16SB/VoL4U+/XGROWmdRWx/MqGw==
Message-ID: <5b07e049-6e06-4290-abf4-8c542b76c47c@bootlin.com>
Date: Tue, 10 Sep 2024 11:25:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] wifi: wilc1000: Fold wilc_create_wiphy() into
 cfg80211.c
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240909193035.69823-1-marex@denx.de>
 <20240909193035.69823-5-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240909193035.69823-5-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 9/9/24 21:29, Marek Vasut wrote:
> The wilc_create_wiphy() is not used outside of cfg80211.c .
> Make the function static and remove its entry from cfg80211.h
> 
> Signed-off-by: Marek Vasut <marex@denx.deReviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


