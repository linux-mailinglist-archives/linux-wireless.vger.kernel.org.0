Return-Path: <linux-wireless+bounces-9890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA1B92545D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1451C211BF
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 07:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CA9135A4B;
	Wed,  3 Jul 2024 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frelon.se header.i=@frelon.se header.b="XctgQu7s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB31130A4D
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.3.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990383; cv=none; b=U0Co4D68K3lphkwxrlUdn4yYmFeV5O7rRBv6BKdk3wdk+Sk8cnlDzoYqL3O3ygtjA95cmS/V1l0Z/5NpP844ycHKj9eS26MJBgkYwm4mkTMFuMJEt6cELqtrBoarDPU9Ahulzstw0CG7RXjXghm1YzY9EriOPIPnLSd+BC3QfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990383; c=relaxed/simple;
	bh=HWmtiBixxOXwD62Np8JBuyfens2fo5xCyaHHqje/n4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSbsgG81YzFPvykmt8Z6U0qgF9zbXrm9MFaW+QiSqEe6TfeZ11psWCa73qo5ZlZlbNP2RBeKhnt28AdCUUiNUgw33QmqNjpEZMfShE/l4o4IyJ5Z2MaLB6ikaMML2CTwybEXYQ8gcZNikvYqsZAlHDT5GH/0HgoaGinb6gHl6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=frelon.se; spf=pass smtp.mailfrom=frelon.se; dkim=pass (2048-bit key) header.d=frelon.se header.i=@frelon.se header.b=XctgQu7s; arc=none smtp.client-ip=93.188.3.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=frelon.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frelon.se
Received: from s807.loopia.se (localhost [127.0.0.1])
	by s807.loopia.se (Postfix) with ESMTP id 058563027D1B
	for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 09:06:15 +0200 (CEST)
Received: from s980.loopia.se (unknown [172.22.191.6])
	by s807.loopia.se (Postfix) with ESMTP id E9DB62E28446;
	Wed, 03 Jul 2024 09:06:14 +0200 (CEST)
Received: from s471.loopia.se (unknown [172.22.191.6])
	by s980.loopia.se (Postfix) with ESMTP id E7B972201681;
	Wed, 03 Jul 2024 09:06:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1.2
X-Spam-Level:
Authentication-Results: s471.loopia.se (amavisd-new); dkim=pass (2048-bit key)
 header.d=frelon.se
Received: from s981.loopia.se ([172.22.191.6])
 by s471.loopia.se (s471.loopia.se [172.22.190.35]) (amavisd-new, port 10024)
 with LMTP id gyEcWLUJcrlh; Wed,  3 Jul 2024 09:06:14 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: fredrik@frelon.se
X-Loopia-Originating-IP: IPv6:2001:2042:34bd:7800:4e1d:96ff:fe79:894d
Received: from carbon.stuxie.se (unknown [IPv6:2001:2042:34bd:7800:4e1d:96ff:fe79:894d])
	(Authenticated sender: fredrik@frelon.se)
	by s981.loopia.se (Postfix) with ESMTPSA id 5F87022B173E;
	Wed, 03 Jul 2024 09:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=frelon.se;
	s=loopiadkim1707342414; t=1719990374;
	bh=jCykE6aa1OFFBe5Zrg/ZdKsur1BAPY7wQ9N5Du+0/JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XctgQu7stRaty4luGFViLjKYM86asIY9+jcdSlTHkb8GyTvYQE+rHslJrnBa+ylMK
	 VYdXrUUbSTW4mbWixQFZFzUS5bgc6lp7a/KDRQnS3WtL7YG6LPpWo3MtsGvIT1PU3C
	 /UZ2PBVRsPeMKzrcqO9gBgqv6sZIel52Aq/QnQwWrFT8C5WLDbu3fp4+18Mt67X/kC
	 mc79fzhYc2jfemh1EQw99JVIgrNACUadBqVG/y4aqk9tXb4fD/MkwkUfUdKiTDwrkv
	 8mG+2aceUpJ+QNoC3Al51FRAWvWUGMGLcIUamsZViwC1UtY7IA+A3a6hUCox6IDlX7
	 P7DS0mEaAIjcw==
Date: Wed, 3 Jul 2024 09:06:13 +0200
From: Fredrik =?utf-8?Q?L=C3=B6nnegren?= <fredrik@frelon.se>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtlwifi: fix comment typo
Message-ID: <ZoT4ZYlvyCEmymjX@carbon.stuxie.se>
References: <20240702123048.14829-1-fredrik@frelon.se>
 <bcc37f918d994755b7f3af689e54c9dd@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcc37f918d994755b7f3af689e54c9dd@realtek.com>

On Wed, Jul 03, 2024 at 12:30:01AM +0000, Ping-Ke Shih wrote:
> Fredrik Lönnegren <fredrik@frelon.se> wrote:
> 
> > Subject: [PATCH] rtlwifi: fix comment typo
> 
> Subject prefix should be "wifi: rtlwifi: ...", and it would be better to point
> out what you change is 'default'. 

Good point, I will send an updated patch!

> 
> 
> > Change 'defult' to 'default' in comments in several rtlwifi drivers.
> > 
> > Signed-off-by: Fredrik Lönnegren <fredrik@frelon.se>
> 
> 

