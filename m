Return-Path: <linux-wireless+bounces-20165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8FCA5BE18
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D05C16E9B5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371E523F376;
	Tue, 11 Mar 2025 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Mx8NavGC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886521D595;
	Tue, 11 Mar 2025 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689742; cv=none; b=MfNaPGnTGvU4Ws1cuMbniM6Vq1YbF+iLNd7jj85sZUe8G4NJLQkJFJOPDBZp3j3yg9spnpgkd2rX0eDunqX/cXkI8+mSvyxCRJWSnuOivWWEa2eXvNHCoxGB7LpOrKcwuwN99n2U/JMhOk53HYNwrRHDVppM2haypeieqHi372c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689742; c=relaxed/simple;
	bh=s2OC3HVnqDNni0DDdIbALFmfFoId89wtq6LEF/IVNCg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BlfjK1PAqsOje+wIFxBQgr5eJ3jkijO0C8TJGnmNkxWgq+fR6hj9r2RdUJr+2BARjArdRBVH81oVz3u/soDmhFOfQZz625fY6nyeCsbsc5ntVpdO5YQoP5ulXFqSdb1PRwBL4i5ViUHRDZUd2NdlU6ysq0hyjHR6F3bRr0CsjQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Mx8NavGC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s2OC3HVnqDNni0DDdIbALFmfFoId89wtq6LEF/IVNCg=;
	t=1741689740; x=1742899340; b=Mx8NavGC6G30hkfVdyzGoOEp53M4xM9s6dPWpn+JfdmexTI
	vu8WY1ZWCac2wrcQdOqFEuMF9UwGsFBqI60fvwPUgECtTMmgLsgve+FDqopknw6fbWvuH+p+qlkTy
	HwkPCsnqXEK5L8rdb+leVgaf80Yl8Moeqp1TJIqsTDzYI9Gz5Jwf/8UhCJdLFAFWokYltOoWNa1Xu
	x/ZodWalxqZZ1RXlWdkUnrVQVMqvhoyRW5Jx25ak9JcgaRhXro5hYfCidzr/FGqKfYiOb+nHRRNJU
	EtyFE5bNmYRz/XGP7w1egxNIol2P/YLLvK62LDPo9UlykRJZsl1LGcfbr9+6O9aQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1trx3x-00000007o0L-16Lm;
	Tue, 11 Mar 2025 11:42:17 +0100
Message-ID: <c058eedc7fe0d6b58dba376140291a0ba048a6d5.camel@sipsolutions.net>
Subject: Re: [PATCH][next] wifi: iwlwifi: dvm: Avoid
 -Wflex-array-member-not-at-end warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva"	
 <gustavoars@kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,  Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Tue, 11 Mar 2025 11:42:15 +0100
In-Reply-To: <af8e60b46567a0612b71d4cd198b07dc93b046e4.camel@sipsolutions.net>
References: <Zr5QR03+wyw571zd@elsanto>
		 <b0f25000-396c-4a83-abc1-1a07b3065c10@embeddedor.com>
		 <75551003-17c7-450a-89b0-818b6a01051c@embeddedor.com>
	 <af8e60b46567a0612b71d4cd198b07dc93b046e4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-03-11 at 11:40 +0100, Johannes Berg wrote:
> On Mon, 2025-03-10 at 14:17 +1030, Gustavo A. R. Silva wrote:
> > Hi all,
> >=20
> > I wonder who can take this patch, please. :)
> >=20
>=20
> At the very least you're going to have to resend, I don't have the patch
> in patchwork any more.
>=20

Oh, no, sorry, it's still there but assigned to Miri.

johannes

