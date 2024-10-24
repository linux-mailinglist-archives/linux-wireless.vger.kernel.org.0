Return-Path: <linux-wireless+bounces-14448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4439ADCF2
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 08:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2AAEB24001
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 06:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214C5189F55;
	Thu, 24 Oct 2024 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S+9KicO0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0026F305;
	Thu, 24 Oct 2024 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753090; cv=none; b=m7tgMURdsGfnu4LWxS6y2lyxJ4t4KPBI4bYqcv/GNbm1SPQSg4Ze2yEQCJuLWdAXbr0FZ+dc9cbxAxE9DF5xGzSsB+zbeKysv1sjTDMOQUo6AUj4nhabk5+SLTRYEkUAk56TBCp+aKNH0UeiwzNk/7VepkxhGJr8MlwzoevTC7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753090; c=relaxed/simple;
	bh=A9q7lHIc5ovILKLwJvIio3SKC8xXotN+uL4+V1a5uV8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iZUbh0ubTsa8WZ/67eZ8raHbON4ey0F2Cx36DN1Y2/WNxoiZGqnrCZc1380/ODTAAb8GzurpfwnwqwKj5bfkwEBi2aR1D+KWLgqqyJyZ64ASmlHKt3skxEmiszhFPTUvyPPl5J7nXDonIyQwGJRW06jKp1JMlYp9H0HSxt06XOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S+9KicO0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7x0QB+MjrL+P2LKrYclGOEWkPSBZavNlAuX7OqSOlBY=;
	t=1729753088; x=1730962688; b=S+9KicO0OurITCJzFtikxcBJr9taESTuVFHRbWZZcfGeKGB
	YJERgxlLWf6Js/dGCV77FdyG/23KDuvD1PymhInjSF9kyLGnXvG1ad/+Z4uYpA5iLJYQ9Pvz48VOQ
	gUlRoezA3hgvhxNwrjUjbMsWFD0xlZ+HvPavA9uzQfJ3XnPvSxiTc/XtkGAECUzy9Lq9XP9x7TyxW
	v8PtbzmS1NCd6h3MRYRcfB9TNJwW7Q52b8BPP/IxyBSAre2ciy93KO8DxnQjqtk9PI9Ha8DnYt5WO
	lDjgqGVOB5nkYiEAdYTxd4ezFL/mnXw6c62whAL8iOKTJgMy0yijYltzXk5UWdew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3rnH-00000003V5r-2QKm;
	Thu, 24 Oct 2024 08:58:03 +0200
Message-ID: <2bab16fa9140f8b9515c5d471ec20c5e47c877e1.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Ben Greear <greearb@candelatech.com>, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>, Wireless <linux-wireless@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Date: Thu, 24 Oct 2024 08:58:02 +0200
In-Reply-To: <20241024115523.4cd35dde@canb.auug.org.au>
References: <20241024115523.4cd35dde@canb.auug.org.au>
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

Hi Stephen,

> Today's linux-next merge of the wireless-next tree got a conflict in:
>=20
>   net/mac80211/cfg.c
>=20
> between commit:
>=20
>   8dd0498983ee ("wifi: mac80211: Fix setting txpower with emulate_chanctx=
")
>=20
> from the wireless tree and commit:
>=20
>   c4382d5ca1af ("wifi: mac80211: update the right link for tx power")
>=20
> from the wireless-next tree.

Yeah, I'm aware, we need to flush our trees.

> I fixed it up (see below)

Looks good, thanks :)

johannes

