Return-Path: <linux-wireless+bounces-4756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84C287C15E
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2661F22398
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33CF74411;
	Thu, 14 Mar 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="F9UX+QIh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D370CCB
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434178; cv=none; b=SciUaWx3LeJKDWwMEGvl40SQu6NnDp7hMFoCnTosHER0hcX5KuqZzZRxbqYIoVgb/qHftloeiOPZ7pfk4XKNJeX0YMsDtBSncRrjHRA2OV7EMw90GwhRsAqkfrVpCsbv5DPyTNMEuT4pc3w7ue6/QLb23G7gXyjV2zoitQQzb30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434178; c=relaxed/simple;
	bh=dCFd1I2Em7XvcmtL4wPtHwPzcp7oEL0x21kdZ4PMWpA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fgnE4rOI04VyhYu26sYHukV9H3IpoUBVPU2BBlSpYsyfM65lEtRo8dikGWx7jCoThO8c43+pLif1DjHd/tGAvF0NZKi9Scwzo+44yeHdumCt/oXFT6n7BpuVGTVUgSN1jikJc24l1vTiOJHZA/abhryoog4ct6i/+/0LVP2H0BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=F9UX+QIh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dCFd1I2Em7XvcmtL4wPtHwPzcp7oEL0x21kdZ4PMWpA=;
	t=1710434177; x=1711643777; b=F9UX+QIh+rQMY7LDN7wgZ4wWDdT0hd7/sa3VtmQOzB2k7Wy
	Nt0OuGZqDFa5ZBTLLDtjDP8e5bVPrr6mJ7Nyl1T+hHOjjmmZQqi3u9LAccErpgn4TPvRHdwzo3wgZ
	3S5JR57nQneb2bZe8hoie6CTSiUJR9Tw6bt891GSltxLrmooREFyq/K71XR6e3xcD26KhLnjEtvbG
	4FpGb+TMm3HLqhpNtH3wWPCLZGVIj4D+YEQrHSF3tEOAWkxyTZTvWibSWcvr4WaXPwNiAE47sX5Hd
	CV/BQ/L7ge541n4sa2o/LEWDOWoKq+DntAv5ODb658sThl06mweYLnDvL/K0O2bw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rko3u-0000000GgKk-3Sjq;
	Thu, 14 Mar 2024 17:36:11 +0100
Message-ID: <09e961f89c9d86ff8e60e860376924961a18387b.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: iwlwifi: mvm: disable MLO for the time being
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>, ath12k@lists.infradead.org
Date: Thu, 14 Mar 2024 17:36:09 +0100
In-Reply-To: <3883eb2c-54dc-4492-bbc1-9fea02e7e46e@quicinc.com>
References: 
	<20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
	 <20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid>
	 <87bk7g4x08.fsf@kernel.org>
	 <09ca997159333980a168051a2a49c675a8ad5eeb.camel@sipsolutions.net>
	 <3883eb2c-54dc-4492-bbc1-9fea02e7e46e@quicinc.com>
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

>=20
> what does it mean "disable wext" if we are a mac80211 driver that doesn't
> utilize wext?
>=20

You don't have a choice about wireless extension support - cfg80211 will
support wext for any non-MLO drivers.

However now we're faced with the situation where we have devices today
that enable MLO, and thus don't have wext. But if we disable MLO, then
those devices would get wext, and then when we later enable MLO again,
they'd lose wext again ... all that seems very unreasonable, and more
likely to lead to complaints than "new device doesn't support wext",
hence the first patch and disabling it explicitly for a device that will
again get MLO later.

johannes

