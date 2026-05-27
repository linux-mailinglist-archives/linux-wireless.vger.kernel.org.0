Return-Path: <linux-wireless+bounces-37001-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDeqLRfIFmpVrwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37001-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 12:31:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9735E2C13
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 12:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11B7E300729E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC260385D9A;
	Wed, 27 May 2026 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VM4aTSzs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA60379EDA
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877618; cv=none; b=RjraUZJE9e8fDPeh7yYYmJWxHUEF4gsMwHqQvMn+1pn6HpHievOrva97D8hsFrCdhQF/ForQWBF4TLpIRg5eKLXOCl0RL6yF7/Z2P0QdhQsr9oo18+BZ2+EefergZVYeOhEJEjWii/4N7d0wbnakorS50tslfLsiyKpgedpusWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877618; c=relaxed/simple;
	bh=uTVVwPK8k7Dnp2JrQ2p2Eqe6kR6X54QMPfEd/a8VpPE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=paXqtqggqR3Wc8OTcqzmsttE55l+PtCOGbUu444p3tjDE2HRG7qpr/YsVYd1xjjsRRHw85C8r2A2BnADYIJNTQ1Z9lH/msNhtg9ZXmuvc5e2vAp0fUBTLQYFtMPDlB6TaV/6zeJrPL4PP6IwzqAul2xgVvMhvtKt7/8gHL/uLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VM4aTSzs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uTVVwPK8k7Dnp2JrQ2p2Eqe6kR6X54QMPfEd/a8VpPE=;
	t=1779877617; x=1781087217; b=VM4aTSzsHKMp2w03UeNXOMmFOSvDIkhV/iKkGs4JjDfMbwq
	8Y17AoF5jox8OEYhm/CSeynfzVVc+kXMAI/loFvf0fssjnt2lZqP4+dt7Pki61TEw7h+qn05ZMg6c
	snd6qNMZRCpu2uA2JSd+3zAsB9AAorvvIL+vBfnjvIPLqyh2PbAetx9m5i4llJW8pTOvIXgoOHPCP
	9/R6DUvOufLpwYueOLzyenz/FlukUkCzZ8VCnOcfsISE8PMhcRa7eAMYp3QoClL0iWzhG70YsP+qH
	idkOT1cCWeS/GCCRIwsI/8EPvaFB+jRIA234HG7U8M2Q5SarwkyK+NOqsILbeQKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSBTO-000000061Q9-0Uxj;
	Wed, 27 May 2026 12:26:50 +0200
Message-ID: <1a8bbed215d7f6027d56ab42cf8f6e742d1e7fa1.camel@sipsolutions.net>
Subject: Re: [PATCH net 1/1] wireless: wext: export each WEP key size only
 once
From: Johannes Berg <johannes@sipsolutions.net>
To: Ren Wei <n05ec@lzu.edu.cn>, linux-wireless@vger.kernel.org
Cc: kilroyd@googlemail.com, linville@tuxdriver.com, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, 	xuyq21@lenovo.com
Date: Wed, 27 May 2026 12:26:49 +0200
In-Reply-To: <a039d8a18fa47ab9fce851b7f42cdadb62e54ba9.1779632308.git.xuyq21@lenovo.com>
References: <cover.1779632308.git.xuyq21@lenovo.com>
	 <a039d8a18fa47ab9fce851b7f42cdadb62e54ba9.1779632308.git.xuyq21@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[googlemail.com,tuxdriver.com,gmail.com,lzu.edu.cn,lenovo.com];
	TAGGED_FROM(0.00)[bounces-37001-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lenovo.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim,lzu.edu.cn:email]
X-Rspamd-Queue-Id: BB9735E2C13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-05-27 at 18:18 +0800, Ren Wei wrote:
> From: Yuqi Xu <xuyq21@lenovo.com>
>=20
> cfg80211_wext_giwrange() fills iw_range.encoding_size[] from the
> cipher suites advertised by the wiphy. The WEXT range data describes
> supported key sizes, but the current code appends one entry for every
> WEP cipher occurrence.
>=20
> A wiphy may expose repeated WEP cipher entries, which can make
> cfg80211_wext_giwrange() grow num_encoding_sizes past the available
> encoding_size[] slots. Track whether WEP40 and WEP104 are present
> while scanning the cipher list, then emit each corresponding key size
> once.
>=20
> This keeps the exported WEXT data aligned with the supported key sizes
> and makes duplicate cipher entries irrelevant.
>=20
> Fixes: 2ab658f9ce21 ("cfg80211: set WE encoding size based on available c=
iphers")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
>=20

Please **always** check if the issue has been fixed already...

johannes

