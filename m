Return-Path: <linux-wireless+bounces-7684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D578C6607
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 13:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19ECB233A4
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4296EB4D;
	Wed, 15 May 2024 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E+uWCMsG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8214AB4
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715774268; cv=none; b=deDBAluQ4rtHRzT8XI/ffSAzpKn4XWQYp9MtX7LZ/Bx8Gute5dhCpqPxX9x0th6YF7wCuKvXB766lfW1fc/uC1eEQa2RiZG5SZHO4817dsZOFwObJr9HqxZmJ0rzP/6a0wHqBczKmGeS6CHB873VDKTEQyGnV13KlQ/+hwKQ3qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715774268; c=relaxed/simple;
	bh=kCXkXqb9XwSbCACbfI/J06aWDK+woiUsR0o60ggIejw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwkKu8lmOo58jPIlk4a+yEnMvnGBorXaQycQG8V5q6OrGhE1NwDd2/pKkQEKQ7YTf8/09TGeF0cZr1saGvoMyAmk06qL6S43FDE1vCIYh4/m+d9WpPqzWlT5VO6a7mcKYIHj6DveFBqNK3TCKjz+zd/DbCS7Fa9v+eK4Qvk5WOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E+uWCMsG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kCXkXqb9XwSbCACbfI/J06aWDK+woiUsR0o60ggIejw=;
	t=1715774267; x=1716983867; b=E+uWCMsGbLhFcPo1cXfNXotxktqp781ZbCEXEGfgHhzrl3h
	ZnTNa43bxcG6D2CyMOm7/v9D39DPTheG9DmCrw4lc1cEhU/+LvSWFFrSHmqefR/th7Q4C8uFozMoE
	Ft3ZYVMApfeiMPce/kghomDvF2tkd/Cn117QH/zMgT7YuWUYZYSe/RIovkd0YrNpEEqZpssT7RPFd
	gezT6ss6Y+ilf2nfEXdleYAg9GaQsZd+O3M44geIpo9hEFQL3OHG03wGXZc0g0ndg0T1j2Ry/Pjt9
	K3fTnbWUaLPrwx9ETh2FEpUIM7nICroHuKV+V7J7rshm0oMauYbAqwRuNZfk00jw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s7DGS-00000006OVu-2SIA;
	Wed, 15 May 2024 13:57:44 +0200
Message-ID: <a351bba727b5fe8129c30b19d2b5c354ad32c363.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: handle tasklet frames before stopping
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: syzbot+8830db5d3593b5546d2e@syzkaller.appspotmail.com
Date: Wed, 15 May 2024 13:57:43 +0200
In-Reply-To: <20240515135318.b05f11385c9a.I41c1b33a2e1814c3a7ef352cd7f2951b91785617@changeid>
References: 
	<20240515135318.b05f11385c9a.I41c1b33a2e1814c3a7ef352cd7f2951b91785617@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-05-15 at 13:53 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> The code itself doesn't want to handle frames from the driver
> if it's already stopped, but if the tasklet was queued before
> and runs after the stop, then all bets are off. Flush queues
> before actually stopping, RX should be off at this point since
> all the interfaces are removed already, etc.
>=20
> Reported-by: syzbot+8830db5d3593b5546d2e@syzkaller.appspotmail.com
>=20

I suspect this might also address
https://syzkaller.appspot.com/bug?extid=3Dac648b0525be1feba506

johannes

