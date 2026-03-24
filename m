Return-Path: <linux-wireless+bounces-33764-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEUuEVc0wmmUaAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33764-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:51:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B4D303783
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06DCF310FEFF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 06:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB0A3BED3B;
	Tue, 24 Mar 2026 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JTNJpacX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3E3BED23
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334195; cv=none; b=lX6gHro36PLgJIRZkEcOxYnv2J8cZdVbSi/kLy0LE0ZCVH7Lo4/gBTS5USO6kqo5zfNXqGhwjUQ6kxxo5J2t7GtzCplndY2+6hd/0+9KvlAvKoIOQDXAafY+KHnGEBelXEQAN3KtOQfVAHJUC8lJ7s2lGoOUwbCQaKFtEZoQFdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334195; c=relaxed/simple;
	bh=G0kTBOovsFDlftR+cujCPo4acel3b2girqOmsNnQiOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=diRfQT+KHPN4T63glLwu1+ZZLcLC1Wh3gJZ9x1wJ71U23liPF5TkHD0RwbCEF5WdJpZDAPa2MUf7FbW1+ybsoiLE1d3h9xFQ85VaBavVdM6qhTpPNdPhIqe3FrxPmBPf1FVd657qU7eGm3XvXbCVLIA1E+fnI9QZ2KwPXWUlx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JTNJpacX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=G0kTBOovsFDlftR+cujCPo4acel3b2girqOmsNnQiOE=;
	t=1774334194; x=1775543794; b=JTNJpacXLy50Le8qSrN/ZSYrUWx1ujX1uhfyJBOsK+rtN+x
	HRVlvBfz2SwlnLer4CX4LwOcMT9ZuCBCAqsY6pEGsmAGw4ELZO56yEcywocNLWsjGo0QWVvhrP7Fi
	AE16foJZv7ouUv5hTmeznxY3PV605CdMYVij+uw/XGBHBDyiJtvV02ata6jf461d+ST/YnAt6GvXP
	EnP8j1TNVrdDGceB3zCLYQL945lCDY+utdS7QGBfH2rHkMYc0RVxEaNrdpnxw5y3cmCUr5NbELHgK
	CTaVMrjOa+qXkMfhnsDjdbGvsf3ToeVTJ5M4wzyBOp3/PB88u3xYA/DXp0OkaoEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w4vNO-0000000AiVl-2vgK;
	Tue, 24 Mar 2026 07:36:30 +0100
Message-ID: <7fcbb9390fc715478559a30065e6835301fa9226.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: fix AEAD functions not
 handling errors
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date: Tue, 24 Mar 2026 07:36:30 +0100
In-Reply-To: <20260323231539.aa9f1db285a8.Icf2051ed1acac174b85b99158cc2b0757310765a@changeid>
References: 
	<20260323231539.aa9f1db285a8.Icf2051ed1acac174b85b99158cc2b0757310765a@changeid>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33764-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: B7B4D303783
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-23 at 23:15 +0200, Miri Korenblit wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>=20
> This was done for CMAC but not for AEAD.
> This was spotted by Coverity.

I'm not going to apply this, given that this is all refactored (and the
bug removed) in -next:

https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?=
h=3Dlibcrypto-next&id=3D5e07ce466356d9833757b2d6c0380b6ee7b11a77

johannes

