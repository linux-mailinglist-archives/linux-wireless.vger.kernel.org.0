Return-Path: <linux-wireless+bounces-19098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8940A39970
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 11:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 636047A2FAB
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 10:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCBA2376FD;
	Tue, 18 Feb 2025 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=sdinet.de header.i=@sdinet.de header.b="mNmsaUl0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.sdinet.de (hydra.sdinet.de [136.243.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DE223644D;
	Tue, 18 Feb 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875593; cv=none; b=TZW6Kp7XvgiDbdh//+ew7yZ6xp7LFEG41FfaLa0BH+buwvW6ypqYxUXqpHzYhceleQwp+fJwtogXKf8mjWmhkLTZa7WpOSIff4XAPVkB9zljAL8lPVJIdeiHuUZOH05muC0nzqjerUT15BtYWgmvGgPRH6CwtwRAMU9ZLUw+NLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875593; c=relaxed/simple;
	bh=8hwAEfYHLi1qKR0YP1FUgTPhNsoxFHO8NvCdNPecFbk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gVehoRXiVw7DLwszWCbmraZUd2hp7iw8FEITHzktdhL5ka+qFZwMnuvSER5Fvhi/8OhCSaulAzyapJ/8BLGbVqQcigFhYmTgUGGOF4sFjxHgORrsOv3ns794duzaSl1jmcc8PekwEoF51/PwnLt5bEf7cRkj82Trvu499JZqTOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdinet.de; spf=pass smtp.mailfrom=sdinet.de; dkim=pass (4096-bit key) header.d=sdinet.de header.i=@sdinet.de header.b=mNmsaUl0; arc=none smtp.client-ip=136.243.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdinet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdinet.de
Received: from aurora64.sdinet.de (aurora64.sdinet.de [193.103.159.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: haegar)
	by mail.sdinet.de (bofa-smtpd) with ESMTPSA id D1C3934003A;
	Tue, 18 Feb 2025 11:38:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdinet.de; s=mail2024;
	t=1739875121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+i9Iw2wxStBEEjo8w2Ll1bq83y0kUgzFah+tO1rE1yE=;
	b=mNmsaUl02ujcoirbeRUBrWHbfOnXEe84lH/3UD2K8o3WkE+f0/ixSJC7MbknlPXm/T24+M
	csmyHJmlZGdRqQ8mARo+KuWYKcyYR8FYiCYcMJKmjD9no8reWWd03O8/34IMv9TnsxMS72
	R620cx/EZmqLRzgjwuj2HQmgzn/4rwNP+3o9KjwndkTa4/JnY1AoONngc7yEDI8qVoALtG
	3yfCJhKfP6RuDz+lSOXBn0Wzm0dg3G5Mj31ksJ7Qjj0Z3Ok92Wc8eFq4S8VE2bXIem1UdN
	xGzD4TXFwh7I4N4Zoh/Pko7MbB8bVef4BJMVcot1vHvaGBl1O1rRtLAyXrBGEY+4GVmO5a
	aQE8DX/sDTMpKchYvDRx7DXB7R4MoLcyGWvtSy/KN+Chx4VifXFAxzrpn0j2+1OEIPooNu
	FTRtyhf3JU4qwZqkJmf1u2V2hZEvIs8Ds/L51hWxYMwm9MMeMQttBM1lzDXxX9UK4P4IpL
	cZi6SFZ/x3/m3EK25OivgxLN2moTbJR4g+aqasKWUPQ3e4wlhYeVVFpxzvpKXi4jJon2yG
	skWKyskIzR8PqOnA3blPAvytGLH6Ro5w34azGjUvXPKP+vDbxjEvvQv7S4ohFd3uEnUTD3
	BNtB1vS75eoSsv7l1kaGInB3K1c3hf+/Bzmw3c64GXxVg7LOomhA8=
Date: Tue, 18 Feb 2025 11:36:22 +0100 (CET)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Johannes Berg <johannes@sipsolutions.net>
cc: Corentin Labbe <clabbe.montjoie@gmail.com>, kvalo@kernel.org, 
    linux-wireless@vger.kernel.org, 
    Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: unknow Network controller: Intel Corporation Device 093c (rev
 3a)
In-Reply-To: <6a5eb58c06cc1d5bdeb67fe877ef3a98520627ed.camel@sipsolutions.net>
Message-ID: <8eb241a2-d8d7-f01c-c2ca-b615e8a1cc41@sdinet.de>
References: <Z7N7AvQvv8k4OY-o@Red> <6a5eb58c06cc1d5bdeb67fe877ef3a98520627ed.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 18 Feb 2025, Johannes Berg wrote:

> On Mon, 2025-02-17 at 19:08 +0100, Corentin Labbe wrote:
> > The laptop is running Debian bookworm, and I tried to update pci.ids, no more information.
> > 
> > lspci -vx give:
> > 03:00.0 Network controller: Intel Corporation Device 093c (rev 3a)
> > 	Subsystem: Intel Corporation Device 2181
> 
> But that doesn't match at all, not even close.
> 
> I cannot find any record for WiFi of these numbers, so either the device
> is not WiFi or is malfunctioning. You could try to open it up, take a
> picture so we can see what the WiFi NIC is, and also maybe re-seat the
> NIC while at is, occasionally that fixes such issues.

https://linux-hardware.org/?id=pci:8086-093c-8086-2181

Suggests it to be a "Intel Wireless Gigabit 17265", with no linux driver 
existing for it.

c'ya
sven-haegar

-- 
Three may keep a secret, if two of them are dead.
- Ben F.

