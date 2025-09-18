Return-Path: <linux-wireless+bounces-27484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2662B85A56
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 17:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC483AF160
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3081A30F95F;
	Thu, 18 Sep 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="RIlW2/6C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08E3101B8;
	Thu, 18 Sep 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209411; cv=none; b=RVFuIwV8obZGJh9bGt4iU24jMjMqTE4cjDamv4xViJD13V4Japyb14R+EDp2f5Gb8JMuZaInUDQwW1Ey3GLB+EcoBna3TvnRw8XOYaDYCgoTh8g0b9F76nHnnuWFMXq55r4nu357EfwGAqGhixeoL0ul2Rk/30SMBcwxhwkTnZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209411; c=relaxed/simple;
	bh=v4on5jJ6VuOhzDc9NJSVyg2sgg1WXHxa8bnkeuJH6T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy7jQFbbi/b6bNjF98LJUhkUq1RE/Dlop6ZznWSpTRAui4fPwxi0c0cHvXTkxhdnvsDwc0O5mLkZTAor9b73LVK3tR/FIA/9Nsac46OMApV1zRTSbG3huyjgkIHSl2DqXa5f4dPtgySB/hxw9K0TZIazVZLDG4FK/tl0u+WNU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=RIlW2/6C; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id 193544076720;
	Thu, 18 Sep 2025 15:30:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 193544076720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758209405;
	bh=VqgWfX16aharHNXnVSPPXnAgVwwqi+wLO/kuJGSx2KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RIlW2/6C6xDLl3MDlneQGPCSDHRcLnwryvFQ6H9OYKQEiim9wBEEmFWtdpd3DddMU
	 Zx72KIgseS0NMbvO7eiGEQ7sq+ry6ehIQzJifCsFYV/EoP8pZmzFi3xn9z2LOUFdEh
	 f1Nqt2IsS9orAPuj0AO/GC3+ncgcpDHEItNduNto=
Date: Thu, 18 Sep 2025 18:30:04 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>, 
	Bitterblue Smith <rtl8821cerfe2@gmail.com>, Bernie Huang <phhuang@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH rtw v4 4/4] wifi: rtw89: avoid circular locking
 dependency in ser_state_run()
Message-ID: <20250918182202-29915c8fb7da60280f86084d-pchelkin@ispras>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-5-pchelkin@ispras.ru>
 <0b56e5a8cd7048a19625764bc323ba46@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b56e5a8cd7048a19625764bc323ba46@realtek.com>

On Thu, 18. Sep 05:52, Ping-Ke Shih wrote:
> Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> By the way, you mark this patchset as 'rtw'. Does it mean this patchset is
> urgent to you? If not, it will be more smooth (avoid possible merge conflict)
> if it goes via 'rtw-next'. Let me know your preference. 

The first patch of the series is rather urgent compared to the others
because it addresses the issue occasionally banging on a working system.
The other ones are less urgent.

TBH I'm not aware of your development process in details.  It's v6.17-rc6
at the moment.  If I target all patches at rtw-next, are they to land in
upcoming merge window for v6.18 release (a couple of weeks from now)?
If yes then no hurries from me, rtw-next is ok.

