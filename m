Return-Path: <linux-wireless+bounces-9863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA96924132
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403971C2342D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E81BC063;
	Tue,  2 Jul 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="XTFvY3cO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D11BA891;
	Tue,  2 Jul 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931499; cv=none; b=plXv+f0Bb/Ei0RbjItVIfe+yLqdqT3fyNuHlhmueadEEZd8WyddunXH01C1XrOkl/TKLeRJJdHzI61jW0sa2Xe3bphwQcCzp/9b6VjdqN/9hzxcdwsEEcsOOVNRQPm3InnIcgWzweYDJKG1t4OsB/hr20yZSD6BlGD39VE2vUTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931499; c=relaxed/simple;
	bh=S3PKQPHsAPjo5DeUHZE8ZPmG8NV78qHKXTn8IeASt+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQDzaD1RTc0XbONRghCyQF5ZhAzHFQXeeNF6d7DvVGAXUtD701QF+Oe7SWUoXhpSwLDbFZuXWLVibMc+nhanG5GsPOzmkRCSqn4hbixVUwLLn40/7Ra/P+eNI3jTGQqtQZwKGtdfmozMCfZHwwyT66dhGkF2G3zYQE5BJJzHSeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=XTFvY3cO reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 66157746b08292f7; Tue, 2 Jul 2024 16:44:48 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B2DD6A562AE;
	Tue,  2 Jul 2024 16:44:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1719931488;
	bh=S3PKQPHsAPjo5DeUHZE8ZPmG8NV78qHKXTn8IeASt+s=;
	h=From:To:Cc:Subject:Date;
	b=XTFvY3cOw4kj8LLvbHa3rryOAFzdA9M+UHiBdgmUrn89LH5ZFX7WpSoeNX08p0nVn
	 hPn1CKbDahVmMXoanNg5d3VPXk1j+dALUU7i9MlbQ9pjXr10/10E9N6w1KSWAvsGsD
	 TKNSfXnrED1DdMAFm73qAGIkI2RML1s+rKw+LgK5HTenvpL7vO1RDGBwK+MkIEm9ey
	 JU+xUBPGv9l7vyWc0L5JwXe68QVqO4sFQPzUSjbn7lWaGm/5fGqKoGmK23ox1JI3s/
	 MxsEqGm1KCtFYI0pSmguIX6U/wiXEwSjjbHp1FXKHoyD8xtTSlOlARgCbN+KAzBFfR
	 0GuWxKQEG3dUA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-wireless@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject:
 [RESEND][PATCH v1 0/5] thermal: Pass trip pointer to .set_trip_temp()
 callback
Date: Tue, 02 Jul 2024 16:37:52 +0200
Message-ID: <1890956.tdWV9SEqCh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhr
 tghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14

Hi Everyone,

This is a partial resend of the patch series at

https://lore.kernel.org/linux-pm/8409966.T7Z3S40VBb@kreacher/

that has not received much attention.

However, I would like to get at least some of it into 6.11 and we are
effectively 2 weeks away from the merge window.  I'd need to put them
into linux-next this week so they received at least some coverage there.

Since the majority of the original series is mostly unrelated changes in
different drivers which can wait, this is a smaller set of 5 patches
including the most significant change of the driver interface, which
to pass a trip pointer to the .set_trip_temp() zone callback.

Two of the other 4 patches are preparatory and the other 2 are cleanups,
one in the imx driver and one in the core, where the former is needed to
unlock the latter.

This series is based on the current thermal branch in linux-pm.git.

Thanks!




