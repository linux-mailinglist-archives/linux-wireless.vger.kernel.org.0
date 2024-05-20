Return-Path: <linux-wireless+bounces-7840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E18C9C3C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 13:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDDF280D88
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92A25380C;
	Mon, 20 May 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K28xO3jp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DAC51C28;
	Mon, 20 May 2024 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205278; cv=none; b=HG79fCSj4tbqKXHbEiwvBFNozQKoziidzpiIZlYrr6pLJz3w4BDHMWU3zw2rA6a7ETZF0Jg9X/Kx7frea+9uIR+qzvTW6Kytx6y3ZrIgzFXqF+nJluvQfSirGG5vZqYBufG5NtKmqog2BbBEGKGrmmEp/AY3FtUTv2Kfgo+5rKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205278; c=relaxed/simple;
	bh=WwTSMnw7dKO/AgFPsWwYsEsVevXMKMS79IXwmEUQ7zI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gexYpG4i8AIYgHmEW2gJEnAXhcfgTtI57PAMjKSkqC3HDO8SSbGigzWGjvhBLqevl+LK1jEBn9qE4nENyQmcBeW51+uUHKUU2aB9vBjrlhGopiTWeTz/1U3DHPQ5HPy2BViCvFCN4OlnfNrUwpQkfvGW5oJ5iUG2K6mrA2BYGdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K28xO3jp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WwTSMnw7dKO/AgFPsWwYsEsVevXMKMS79IXwmEUQ7zI=;
	t=1716205276; x=1717414876; b=K28xO3jpLUTFZu/gkC6rtHlD/W1/8WrAhsnqfDQY5hYEPOI
	2eDhxsxBeq7uppt5WmOAd/O0WSOhJK5vE8xDUlW5ERGBXfdFyN8MEtzllprDaOf6WdYET4EY4fC52
	1U6nl8Ny2mmmDoz1STgiiVEw66M1BTN1oi7M3sXbNOr646I7Ue/edoeZBwairX3iSn8JhVll1rmSC
	lGSjSewFpLgYDqQWKk93m7WzOiVNAGt5I2KMuUS1pEhFaywv7vEHqCypUzR4wiKBT4x0a2jtT2EKx
	6TADHdF78O0upbIfmH23jXiJ0AODt+UEewcZ5fmWdtz8uCWipcZ5jmBWTdL7A6kA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s91Nx-00000000BbZ-18IN;
	Mon, 20 May 2024 13:40:57 +0200
Message-ID: <b7583de35462b06bbfbeb39bf2435bcb5f04be06.camel@sipsolutions.net>
Subject: Re: [PATCH v1 net] cfg80211: pmsr: use correct nla_get_uX functions
From: Johannes Berg <johannes@sipsolutions.net>
To: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 20 May 2024 13:40:56 +0200
In-Reply-To: <20240520073311.44117-1-linma@zju.edu.cn>
References: <20240520073311.44117-1-linma@zju.edu.cn>
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

Couple of minor comments:

The subject is missing wifi: prefix.

On Mon, 2024-05-20 at 15:33 +0800, Lin Ma wrote:
> The commit 9bb7e0f24e7e ("cfg80211: add peer measurement with FTM
> initiator API") defines four attributes, which are
>=20
> - `NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP` with NLA_U8 type
> - `NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD` with NLA_U16 type
> - `NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION` with NLA_U8 type
> - `NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES` with NLA_U8 type
>=20
> However, the consumers of these attributes in `pmsr_parse_ftm` blindly
> all use `nla_get_u32`, which is incorrect. Hence, fix these with correct
> `nla_get_u8` and `nla_get_u16`.

Maybe mention a bit more clearly that the _policy_ actually defines them
with those types, so the users are incorrect, vs. a possible scenario
where the kernel's documentation is just incorrect and we have to keep
the code as-is for userspace to continue to function.

I believe the changes are correct since the policy wants the right types
and then on little-endian platforms it'll all work ...

johannes


