Return-Path: <linux-wireless+bounces-1269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F72E81D550
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 18:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B601AB218B9
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C43F12E47;
	Sat, 23 Dec 2023 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GH5m4QK3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291D12E53
	for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uhUxCj6wkY7jnwyKG1rcTGgAjFfno+ANrJ2yVf1eiuw=;
	t=1703352656; x=1704562256; b=GH5m4QK3t9iPenZ2vWv6Lh06yT7xvpMGIqdqE9A/dFmMA4o
	27FlGArIFgPbjPq8pwioCdGAj5GAIQUTAfFJ/WLXL1n3U0SoSn1ZPFtuIF7OA2QHgIb7q0tauonYz
	Y2dXR5UrgKVi93x+7HCUj2Q41UVeLoSavcJIuGmRymKQRx7pKwY7sl5ITVO7rHFvCOOCxW7CvGJ21
	FL4wMHRHVMxJP2FA9myN3cREAiKZILqkSexfu3t5kq/UEwBUMJ807j2LmghxguvQ5mLf4y4dA5AwF
	8tRnXhkOJ9uzQF0GDWn+jvgU9uw19hl9lebN8iP2nsgQoH8NPhxYATt0TBlFyv0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rH5pt-00000005mCS-0gIH;
	Sat, 23 Dec 2023 18:30:53 +0100
Message-ID: <785436c0080a7a7d20175a45ed671ceaf82cd79b.camel@sipsolutions.net>
Subject: Re: [PATCH] tests: Modify the QoS mapping tests
From: Johannes Berg <johannes@sipsolutions.net>
To: Jouni Malinen <j@w1.fi>, Andrei Otcheretianski
	 <andrei.otcheretianski@intel.com>
Cc: hostap@lists.infradead.org, linux-wireless@vger.kernel.org, Ilan Peer
	 <ilan.peer@intel.com>
Date: Sat, 23 Dec 2023 18:30:52 +0100
In-Reply-To: <ZYa5CotWy+00CHII@w1.fi>
References: <20231213113735.289408-1-andrei.otcheretianski@intel.com>
	 <ZYa5CotWy+00CHII@w1.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2023-12-23 at 12:40 +0200, Jouni Malinen wrote:
> On Wed, Dec 13, 2023 at 01:37:35PM +0200, Andrei Otcheretianski wrote:
> > The cfg80211 default QoS mapping was updated to align
> > with the recommendations in section 4 in RFC8325. Align the QoS
> > mapping test accordingly.
>=20
> Thanks, applied. Though, I changed this to accept both the current
> mac80211 mapping and the one proposed in the patch that has not yet been
> applied.
> =20
Should I take that to mean that you think making the kernel change is
reasonable / makes sense?

johannes

