Return-Path: <linux-wireless+bounces-27583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113E7B9068E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 13:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A7C420DE5
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 11:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E568B27702B;
	Mon, 22 Sep 2025 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="f4PQRb6a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DE2877DF;
	Mon, 22 Sep 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540795; cv=none; b=s26esgzLQaTUn1cMrFjw0HjXZwD0qvgB6b1l2tIDprvkOxyTnN+nK6cspzAPsazmsMuY4aN+rVdkxCuP0Jzi/SPwIn96V1ENErNz6qjHHmgkRj9nDjz8cUn6+eynl3Ivzh6LHZwwpKmodJL5/FlABkdmunjMRHD7pLHy6qDrGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540795; c=relaxed/simple;
	bh=JdtzYqDXJN0YAlihtRSDdwdNLzKFCTT8HObuKo41drc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=urIxqd6Fd0fuG8jrpgXGJKdj3t+O5kSlwdXbL0p5lwWO6w6paNxDQms0b4KgwsA9wN7lGN7vcGXZbSk5WGdvTUhSrkdQzK6d68VSewS1pgEB7lSV83d4z70aCb4APTYEcypFLlk+LGAqsNzaLc7JlWyd4zgKivdhmWRWKdf9iZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=f4PQRb6a; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JdtzYqDXJN0YAlihtRSDdwdNLzKFCTT8HObuKo41drc=;
	t=1758540794; x=1759750394; b=f4PQRb6aPikwjaiuaY4kp2u2l0eLMiIMDBNiwq+rwxhSkcY
	cLEemXeKgo2pTztmc7ggFoKQzP2SiNVx/zJ5TY/c7WB1NnKsNwq0LQ1fYtwL4yA2oj8qBIpMK8RM4
	DC1rbUu3qUF5epbo0Qvx9KDJpURv8FBX2EgaGCreXf2ImE4T/uu169CjD4E0umWV8u0dJr1KS18DC
	EC+7EsW5nsre7dK/ofWhC1wJyUULfrlQ3aQPX6A6vDqweaH86cLSjoG85TSiKNKPeK23HY75eya8Z
	euoTnTzsIVjnC7jgqu/dFtzjOJbXlLyiBpGJkusyXG9LXPLk+Wp0ob52f5Ve73EA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0en8-00000004V8l-3fsF;
	Mon, 22 Sep 2025 13:33:11 +0200
Message-ID: <b64db199e6e1cd09b26f44d2e8cc1bec43b163fd.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: libertas: WQ_PERCPU added to alloc_workqueue
 users
From: Johannes Berg <johannes@sipsolutions.net>
To: Marco Crivellari <marco.crivellari@suse.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker	 <frederic@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Michal Hocko <mhocko@suse.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Brian Norris	 <briannorris@chromium.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Kalle Valo	 <kvalo@kernel.org>, "Dr
 . David Alan Gilbert" <linux@treblig.org>, Jeff Chen	
 <jeff.chen_1@nxp.com>, Stefan Kerkmann <s.kerkmann@pengutronix.de>
Date: Mon, 22 Sep 2025 13:33:09 +0200
In-Reply-To: <20250922102407.186660-2-marco.crivellari@suse.com>
References: <20250922102407.186660-1-marco.crivellari@suse.com>
	 <20250922102407.186660-2-marco.crivellari@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-09-22 at 12:24 +0200, Marco Crivellari wrote:
>=20
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ_U=
NBOUND
> must now use WQ_PERCPU.

Which I guess forces a decision, and should be kept for a few releases,
but ... is "keep what it did" really the right decision in all places?
It seems to me that for instance for libertas here, there really is no
reason to be CPU bound?

johannes

