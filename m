Return-Path: <linux-wireless+bounces-11619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AD6956AE4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 14:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1601C23A55
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65771684A8;
	Mon, 19 Aug 2024 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ONXGgN5t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805216A952
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070467; cv=none; b=QHEeutC1t3LFX/ormU32qrtxiuI/4Pmm1gGe58CBpaVD7o2aRn7XEGI4aKqBjp9Vbyxtr4rvwakQa1WibjbIjp3tdwpgq1hBCwbnNZMuT/7/qsPm5C6RMAS913l2aCMw+erJhyqfiL1CilW0tvRxt6mhoSCIy6lLmmTrES6UIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070467; c=relaxed/simple;
	bh=sRUMmeNc+LaTqbAGQeEKh+qDdr/sBXNg8MB61XjoGj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eY2M76cx/R570kNkkVgvkfQ6RewicSE+9O3OrhoyZTtaqOxQILoDeN687JsKDpkCf0alLDaEDCM904Xmv9EniWRBycRyOBW98G9oydWDaSrXNw4KyRuHtNSCWmP4amEizfPIY1DuhHkbwchfQt8D0cg2vcoM9cfXWBlQ5sr1HaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ONXGgN5t; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sRUMmeNc+LaTqbAGQeEKh+qDdr/sBXNg8MB61XjoGj0=;
	t=1724070465; x=1725280065; b=ONXGgN5t0KBiD4f1PddvHSYtrFja4+R2xeIisrWNRaUmrav
	ZZlGsjB/TwSWf/vqNzxZB4po8hh0IzU7haJzR9fAimNlY1vvZaT47TM9za5Sh/KCYjXJxgQx0IocL
	KCJPl+4JpwxUcDX45i3ZUA09sPYyN4faF8SdMDuk837ALuyxkePJY/WVcxKmwk06QJtG3ZlzrNwEU
	UJ6+hOoin6kwGgF1WuDyr3LYxCHu7AkIF1VDNeTLu3Af7pMu4TwqX5Btpx+JOW1WtHYBPlwwyoTUr
	6PUDLqaV3ZxXTihVPkKIr22V3DBdundh3vxFWQFrPg1wmJXljUmWBpDpbkA0yxuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sg1U6-00000007YRy-2W1D;
	Mon, 19 Aug 2024 14:27:42 +0200
Message-ID: <835984452bebf8d61e9f9e36c31f6cc408441506.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] wifi: cfg80211: fix per-STA profile BSS entry issues
From: Johannes Berg <johannes@sipsolutions.net>
To: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 19 Aug 2024 14:27:41 +0200
In-Reply-To: <a0a6cfbf-4538-1be0-80a2-4aea8a656555@quicinc.com>
References: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
	 <ef80a0b77fcab051e256deb310c725d4d8884fbd.camel@sipsolutions.net>
	 <a0a6cfbf-4538-1be0-80a2-4aea8a656555@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-08-13 at 10:19 +0530, Veerendranath Jakkam wrote:
>=20
> But I didn't observe any RCU warnings in my hwsim setup. Not sure if it=
=20
> is due to difference in kernel .config between our setups.
>=20
> I enabled below kernel config additionally to find out RCU warnings but=
=20
> with no luck. It would be very help for me if you can share kernel=20
> ".config" from your hwsim setup.
>=20
> CONFIG_RCU_TRACE=3Dy
>=20

You want CONFIG_PROVE_RCU=3Dy/CONFIG_PROVE_LOCKING=3Dy I think? I don't
think my config as is would be all that useful since I have UML patches
too.

johanness

