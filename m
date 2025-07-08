Return-Path: <linux-wireless+bounces-24926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81055AFC8D5
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8841164AD6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7C285406;
	Tue,  8 Jul 2025 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wf3Zltsc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8083231839;
	Tue,  8 Jul 2025 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971773; cv=none; b=XDhEZlxBSN2ykAmFUbtlE31IDUU7q1cjwY87WHMLpl3usRuNtgFw7NmDXOFIuj87IiIKKL8nBcqBxbbiXyABImsPUsGuCU1g6Ody8d/9iR3whsqOV0ebAhZ6CVu46nURwUOQA0SONO154j6Pr8NSS2vkFGtTIj7FA9pdF8G15Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971773; c=relaxed/simple;
	bh=Vcd+3Kazik/8rvM8CclnTojq3pMPTK5+IGxugNM8DbI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l9oFYH6UbfmSo69ifw8yRg4kf4ICC1GYt9xnoYBcVeq8AffruJ1c+Xx/EZhEw4jlywQKaRtRb7bWoH8Bsm9KK8/txr08nGCsR6KsnYLpPldXo6EMfDbfjkujUYvbO84gpBX7/lsArnSyauh9XMJS8sFj30hWAJtOgdm8H1K9RO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wf3Zltsc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Vcd+3Kazik/8rvM8CclnTojq3pMPTK5+IGxugNM8DbI=;
	t=1751971771; x=1753181371; b=wf3ZltscjD/m++BfNw8eVZDZkE4KMrRCHKnkStIXqGbtXtp
	+uq5NfMSWoxQjJ/I0fSTxOoi6b13MWuLUC3CTuu/DY1v6zIlGH7azlT35emVqsoow7YLYlBi47jnu
	ttAJrZakNAs7DQrOUEPZMywkEVQuDgtIlfGWRoU3lB5D+7aAzKDLUFm+vOHU05VJn3FBAWtQkr8Rt
	SbIEwHk2YmLAOt7d6wEi0n0HrcnsjSrl/Lca/NQu3o8a/oXN8ksc7JYOBIx24okDpa2LlV3Nvyqva
	r4AsXuVV0qBs9NmJj0fJJtC01XzRXsJUJeau+vLeH5aEmjgq6BtvJSktdIAePIJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ5tA-0000000BpAp-3NL4;
	Tue, 08 Jul 2025 12:49:29 +0200
Message-ID: <294d5e91279556b59586f0812eee4ac809d7b011.camel@sipsolutions.net>
Subject: Re: [PATCH] mwifiex: replace deprecated strcpy() with strscpy()
From: Johannes Berg <johannes@sipsolutions.net>
To: Miguel =?ISO-8859-1?Q?Garc=EDa?= <miguelgarciaroman8@gmail.com>, 
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, 
	francesco@dolcini.it, thomas.weissschuh@linutronix.de, tglx@linutronix.de, 
	mingo@kernel.org, christophe.jaillet@wanadoo.fr, skhan@linuxfoundation.org
Date: Tue, 08 Jul 2025 12:49:27 +0200
In-Reply-To: <20250705133600.186441-1-miguelgarciaroman8@gmail.com>
References: <20250705133600.186441-1-miguelgarciaroman8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Please use the correct "wifi: " prefix for all your patches.

And I'm not sure how you arrived at the CC list, but it seems excessive,
for a trivial cleanup in particular.

johannes

