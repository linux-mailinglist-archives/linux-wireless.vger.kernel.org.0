Return-Path: <linux-wireless+bounces-14582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6E89B27D8
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 07:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A78F1F22558
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 06:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F318E77D;
	Mon, 28 Oct 2024 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HksDtpUS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110C8837;
	Mon, 28 Oct 2024 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098300; cv=none; b=Cc9UViX/1vWPwl5eXw1VtnoOhYDEM6p4PRxO+eTTWt1Fga5mm9Et+5S3L8RovV8FiQPTV4XkrJYeFGrk0k7gM8pNoGewOMrzqn5dXUz679L6yDMVOI0STBVHyEvPEa0UAVqA80g6B1/NNTBttkn2D/WTWkC0pcQY7od6mKQvBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098300; c=relaxed/simple;
	bh=vpFGDnzFmS4HBY689blSVBEggXsr5VrdwmrW7HsjB9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lXRmY/fXiwspRXILeh/V1y4Y4W+IZTSBtwyS09UdQSA40rAHnAZe1Lhww7ikjXrqQrWdrG2F34NRV5Ey4S3AUPGrYoqoqizk3P+NgQ90cG4GtnC7VX1FtS+c3cvN5RvK8lSjGXperaqSUdMxcRQdzcEuKHOiVMsLNZczLUxMJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HksDtpUS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1csLsnBj4qAR3wFMapmaAnq30l1k7pkCjtVGvRAQb+g=;
	t=1730098298; x=1731307898; b=HksDtpUSrP6J2WqLYoWOHGVECk7vKkpQWtwEgXKiaYLelHU
	EgzrUcGc7CmYjvMbi4KC7oyPbZTOGAklUl5gGvHQc32W0elNF5tFlUzOo8aqdjSTi0K5gcPEYpT0N
	UgtOVUmTygj/LJQ5IVYtPt3X6b8y2F7mQ8E8WaLy7lWp/9Op5g9JIGjRkqpsgWwuefL0NhRCQAKsu
	BmsG3PQC87SCy/Spp8zySqxXDW2Pq3VOPwNZ55MCXsgfvVzhhdG79Xv84rSPNxOPMsnDHzYuveN7K
	fP1ANFYAFAqpQNe+0CIsQagmH5xRmKgqXO2XfMSKODImsygi7ds0UAg+NrJpk6mg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t5Jb6-000000071rz-12vU;
	Mon, 28 Oct 2024 07:51:28 +0100
Message-ID: <f93c5419a689c84450c3f89ca4d61b500ef545d8.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Wireless <linux-wireless@vger.kernel.org>, Aditya Kumar Singh
 <quic_adisi@quicinc.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Date: Mon, 28 Oct 2024 07:51:27 +0100
In-Reply-To: <20241028123621.7bbb131b@canb.auug.org.au>
References: <20241028123621.7bbb131b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Stephen,

> Today's linux-next merge of the wireless-next tree got a conflict in:
>=20
>   drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
>=20
> between commit:
>=20
>   cbe84e9ad5e2 ("wifi: iwlwifi: mvm: really send iwl_txpower_constraints_=
cmd")
>=20
> from the wireless tree and commit:
>=20
>   188a1bf89432 ("wifi: mac80211: re-order assigning channel in activate l=
inks")
>=20
> from the wireless-next tree.

Yeah, I'm aware, but thanks for the heads-up for everyone :)

> I fixed it up (the latter removed some code that the former moved some
> other cde around - so I effectively just used the latter)

Not sure that _description_ seems right, IIRC it was something like ABC
going to ACB in one part, and A'BC in the other part, and should be A'CB
in the end? In terms of blocks of code there. But the resolution looks
good, thanks.

> and can carry
> the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.

Yeah, still sorting that out :) We'll probably do some merges for the
resolution ourselves in wireless.

johannes

