Return-Path: <linux-wireless+bounces-10527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9E393C9CD
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 22:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0633B20D35
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 20:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54269208A5;
	Thu, 25 Jul 2024 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bae0e18c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FEE556
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940405; cv=none; b=TOvrBgObK8mnI3J/Ab7UC5lwvOfTechD5M4DlPd0GXffsoJS7pPv1fDA+oQxtjLx2tI0W3soywv1FvkP6/2MU8vmhQBPn4KKyF9UovUhlk4gVUmEOSwinOoAXDcl6rMB3BdkTPaVyEu9cuX35KKvU8+DtQ2Ebuc2E2HBQxAkTNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940405; c=relaxed/simple;
	bh=P8H11NttAc6Msmk7+7tKjlmFkHDeRBkShmxX2Xtp7jE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oyHqASmDs9tL8oapvJOJ2WtlkgIzXbavYopq34fd6qisi3q0GhAVTvJwRDA5+kPSygu7I3VPJHB2vbXguFk+tu0oAHev4Djc7rF/M3ZW54joXG73lkfcRcmSTMEv+0RgUv+k94TC0Fj8JemWAhKSDdL+gO9jjjHujpyisiNhwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bae0e18c; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Phw4NttKMMcf/h3rDAaLPFPthPuilYGOaVPYPZvU0l4=;
	t=1721940403; x=1723150003; b=bae0e18cXL1VRfrmC+AdkGE3dqq70AeZmq5S5MtcBCmzieb
	ZHsMgtsj/osyR6ACIpHNdJuQewFHDv2v0BT4KJTYkaPbAGPG3QofyVrxYIYCtM5RbwyvZoe0GCfOZ
	Q3g/6DsIFq5x7eI+pCOeLslQYI7YZHWAnIVOGT+bG69w6SJ2XEgdU75hYBB5KQ2xpWz74CyQQ8IAE
	PvYLhJtDfZvm8cWBUcyH3V1V7Rk9aiJFHR9YSMFf8CcHyW/+t6+FCqtwLQlCexIyRXfnCU/Zyts50
	fiUpAnIwWtKSYGAJH/kGFt2F4u2TLuSPQiItJ8SWbH3govc3jFwTsJMimxa3Sg+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sX5MC-0000000H326-1syE;
	Thu, 25 Jul 2024 22:46:36 +0200
Message-ID: <92696aa1704e43897cbed421136845745e023127.camel@sipsolutions.net>
Subject: Re: pull request: iwlwifi firmware updates 2024-07-25
From: Johannes Berg <johannes@sipsolutions.net>
To: Josh Boyer <jwboyer@kernel.org>, "Korenblit, Miriam Rachel"
	 <miriam.rachel.korenblit@intel.com>
Cc: "linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
 "kyle@infradead.org" <kyle@infradead.org>, "Hutchings, Ben"
 <ben@decadent.org.uk>, "Ben Ami, Golan" <golan.ben.ami@intel.com>, "Yang,
 You-Sheng" <vicamo.yang@canonical.com>,  Wireless
 <linux-wireless@vger.kernel.org>
Date: Thu, 25 Jul 2024 22:46:35 +0200
In-Reply-To: <CA+5PVA6zGFMsV16BhmbB9QnZQ9UsUw1-44MK6gOc84MnhroDXA@mail.gmail.com>
References: 
	<MW5PR11MB581002D586D332CACEB335BAA3AB2@MW5PR11MB5810.namprd11.prod.outlook.com>
	 <CA+5PVA6zGFMsV16BhmbB9QnZQ9UsUw1-44MK6gOc84MnhroDXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-07-25 at 16:03 -0400, Josh Boyer wrote:
> >=20
> >   http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware=
.git tags/iwlwifi-fw-2024-07
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-f=
irmware.git
> tags/iwlwifi-fw-2024-07
> fatal: couldn't find remote ref tags/iwlwifi-fw-2024-07
>=20
> Did you forget to push the tag out?
>=20

That's ... curious :)

Seems like the day ("-25") got cut off at the end, we've always used
dated tags here, and there is one from today around the time Miri and I
were discussing this issue, named "iwlwifi-fw-2024-07-25", which also
matches the subject. No idea how it got cut off in the email though.

johannes

