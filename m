Return-Path: <linux-wireless+bounces-25857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A898AB0D9A4
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FE21C82AA9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 12:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD001DFE0B;
	Tue, 22 Jul 2025 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TfRMkSZ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA8F1A0712;
	Tue, 22 Jul 2025 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187196; cv=none; b=IcrykrgqP0yRHqI05GUvjSz5qaLZ2PLYz232k18Jxvacu4zu8DBycpB1cZ8llAE6mytNSkwy6WBKDjzPRHNVZMDPc6DLemQ1JNrpySXk4O2JuHQZ4Mezyyn2GS/qxwLbqi7foays5O/YOqpF0swLh5vAlPIC9ZSd+lUQ1vzG9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187196; c=relaxed/simple;
	bh=K4/7wWuzRzd2WkprSHGz3PIxrxEYd3qOezXv0jUGxhU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XGw/Rhypy6CEj2NFP/DIy1DaXkqjn3vqJuJT2irrsAF06ZNhOwYsdOhMuy3nESkPXQqiGFFHM1annWGMTI3SAyKGMJ/DFvrXprB4cTLVfqXqFTK84h613yh2wg2uYG3J0VMoEoFdivHNvKujimByRvFCOIu6SGJTfLejVJWcVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TfRMkSZ7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=K4/7wWuzRzd2WkprSHGz3PIxrxEYd3qOezXv0jUGxhU=;
	t=1753187194; x=1754396794; b=TfRMkSZ7R+C4bTUOB3Or2UqWvHNqX3DszSjpn96tUFrs3OO
	AkJss7ZM6ESasiso0UGthATR9GlqmT8eCDFvyFS8OJDnRlzMQ9EfvWE3mxLZXDtU0cfRTCpuRFJsQ
	5QLjU4eqEG0WoCC+mjUQxdLLQV4q100UrpYTqwzfFTcnJO54AfMwAA1zOiVR8HOB/mI0seu7zf70X
	+yjuxAQhQC3QjqdWVrdgEL0uIjzPKEyZDUkI3c8EsIarKAriS7eCcS+35UmWMuhu6zBGbe6fRb5i6
	qIJitWMGsinVPadyFY+nXTkSBsWsx72x3WO/cuvylBZ2sJ22+SL+ukujMIQuERwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueC4l-000000026gk-28pj;
	Tue, 22 Jul 2025 14:26:32 +0200
Message-ID: <e3c98a92b7c6177f7784387f6f2038ca0b11c57c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 wireless-next 3/3] wifi: mac80211: Check link id
 at station removal
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 22 Jul 2025 14:26:30 +0200
In-Reply-To: <ce42107117526535474cf81d514fd030c7376e85.1752225123.git.repk@triplefau.lt> (sfid-20250711_121425_681537_FFC4AA99)
References: <cover.1752225123.git.repk@triplefau.lt>
	 <ce42107117526535474cf81d514fd030c7376e85.1752225123.git.repk@triplefau.lt>
	 (sfid-20250711_121425_681537_FFC4AA99)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-07-11 at 12:03 +0200, Remi Pommarel wrote:
> hostapd can remove a non-MLD sta connected to one link of one MLD AP
> several times. If the sta roamed to another link of the same MLD AP
> between two of those removals the wrong sta_info could be removed.
>=20
> To fix that remove sta only if it is currently using the link specified
> in NL80211_CMD_DEL_STATION if they are any.

That also looks fine.

Would be nice if you could later contribute the hwsim test for it, since
it sounded like you had one :)

johannes

