Return-Path: <linux-wireless+bounces-5199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE088A91C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 17:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439CB380919
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD26E616;
	Mon, 25 Mar 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rWp4NeTC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083E128377
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376865; cv=none; b=kMnpLHz1OBBHQQXeP/qIPWtSQuzCAgb5NM5XR0bM5n1Gu+0f5f0+thD4oMb136tBF4v5DwMudZcm2SuKMlVVi+Y9ppzABUdyhjYlJPLgFDltVWtKx4RcPh8RlKKcZSNKoq0bjkK4qcT1oVk6tWmSQ6PZ/LQDc8el5vacaoknUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376865; c=relaxed/simple;
	bh=PSQZ+Ozdu8cQPLJxQXrDn9n6O7TZmAyAIkZ18i1ub1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0krzM2QiIX2poz5ylr0LmqNHq4hUWw4+XRUwjUK2n/CvxejtSwZCQ5do9wxYSZd8uS7IFVpAaCpdsJGhBZerkZKxFQ7jOKtKgF6ff3zwrdPQPIt0rKRL7P4R6ijrrAeU5iGeP4vj+IG4Tjhdk+ektYuwrKjPGIUXwy+r1BlTlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rWp4NeTC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SBbUL15zjlK6CBiHDHkylojz2BS2Xhc/F/dz7Eh30wY=;
	t=1711376862; x=1712586462; b=rWp4NeTC33cj4VoHh6Pv3xe29pvfObAEhYm6PlmGZp90Tms
	cnAbwFx8lz38cDoJ0gMqx0cthSXJPjO7pNXGduCW63oRbkURhpyDUDNY4lMO81eIJZTFNR+OxEIHo
	uOV7n/kszbYjQihK1c/7OHW8ZOl6Vkwu+v8wM2wssxQp4gR2lGVphw8DfQVPbjB8GUn+3iJWdjC2w
	BH1idrLY1ZJXjqUMZf8Rj8fxPcmEBA3V+zQEFAKHQ6QZqWga+gW4SuRElvhleqUlKcXeQXILmyapX
	P6NYMmccVlYiP1I4bRGR1EbOE1XxoVae92CEqJENBkiSdUztjKT//QB00xHJ/2kw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rolIZ-0000000DsNl-3zfs;
	Mon, 25 Mar 2024 15:27:40 +0100
Message-ID: <b4fd4267dd4751a85a472c5daa137c06f5303fc1.camel@sipsolutions.net>
Subject: Re: [PATCH 15/17] wifi: iwlwifi: mvm: select STA mask only for
 active links
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 25 Mar 2024 15:27:39 +0100
In-Reply-To: <20240320232419.c6818d1c6033.I6357f05c55ef111002ddc169287eb356ca0c1b21@changeid>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
	 <20240320232419.c6818d1c6033.I6357f05c55ef111002ddc169287eb356ca0c1b21@changeid>
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

On Wed, 2024-03-20 at 23:26 +0200, Miri Korenblit wrote:
>=20
> -		link_sta =3D
> +		mvm_link_sta =3D
>  			rcu_dereference_check(mvmsta->link[link_id],
>  					      lockdep_is_held(&mvm->mutex));
>  		if (!link_sta)
>  			continue;
>=20

I forgot to adjust this condition, and as we found out, that will be
needed during link switch :)

I'll fix that when I apply it.

johannes

