Return-Path: <linux-wireless+bounces-9128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC290B963
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 20:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF561F2196A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 18:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235B19B3D4;
	Mon, 17 Jun 2024 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="IaNjVhRy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E21993BE;
	Mon, 17 Jun 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648001; cv=none; b=jRzqnuJ1nF9eCUQySdDh7qAFVrPR79CX+Z784jOywT24orh0aKONvJst4EWOF6kqeTmFv3aFuPqHgDEoqkOrxwhdKikJLGj21htvf/oYqmudGzZpJmtzQDnXBbATMlMdsVI/I1q1yq3g61QYcBHG603S7Lz7kscddT7ahCbjqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648001; c=relaxed/simple;
	bh=oZqVWvku/3wzgM7EoqTwvP3AdUcWOcwhRu6vy9hsujw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=puzBqwrZU2u91BCFlrRK15Nysk8N7kKhB3viNTfgeUgsy27FQ5d9thiNX5O7E6Sa5atvVYEVpvZVP/mnZJ62GKxoA6ZtwQeUqOhEZ2h+yBnlW2YFiqSLQhx1jKHvFTauc0dUFa7W/JDuXxbPCDx3ecpjIJpSLsib2//YuvHPuNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=IaNjVhRy reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 238e5fc1c563fd29; Mon, 17 Jun 2024 20:13:16 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0F8C516606FD;
	Mon, 17 Jun 2024 20:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647996;
	bh=oZqVWvku/3wzgM7EoqTwvP3AdUcWOcwhRu6vy9hsujw=;
	h=From:To:Cc:Subject:Date;
	b=IaNjVhRykSBMld0JSQ76dZuThhBHX0affopQxzMJMH5KF5xCk3dQzdMGHTe0vT6Lw
	 DO8gNoBDf8XXCBZPIzz5l1B9py/rQjgu2LxKeBlEQ1W52YTleM0gJp6qh7KpapUQe1
	 0a3466vbpGtKft4OMNLE4u3uecPeCMLoRa/lT5vV3n/PN+rUojyREl626RJq9VGznz
	 oiD7z3Bhpc2bnE/nt2t5SyB29P1y1W7XkvBxGQz8UMC+wyqYsdkgi5qRsNKW18nF8c
	 7OuaoCzRIPHDN2pGq+RKPYFD6q8AcAqi8J9qP3722GhScuIuSAPajRIVNmLgAqERDP
	 ZufN8cim6+WsA==
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
 [PATCH v1 00/14] thermal: Eliminate trip IDs from thermal driver interface
Date: Mon, 17 Jun 2024 19:41:25 +0200
Message-ID: <8409966.T7Z3S40VBb@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
 pdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14

Hi Everyone,

Trip IDs, which should be internal to the thermal core, are still used in the
thermal driver interface in some places, but fortunately it does not take too
much effort to get rid of them.

First of all, the .set_trip_temp() zone callback uses a trip ID as one of its
arguments, but this isn't really necessary and there are a few weaknesses
related to doing that.  Please see the changelog of patch [04/14] for details.

Apart from that, several drivers use the thermal_zone_get_trip() helper
function for trip point lookup which can be differently.  Patches [06-12/14]
address those cases (please see the individual patch changelogs for details).

The remaining patches in the series are preliminary changes or cleanups.

The series is based on the two cleanup series posted previously:

https://lore.kernel.org/linux-pm/5794974.DvuYhMxLoT@kreacher/T/#t
https://lore.kernel.org/linux-pm/12458899.O9o76ZdvQC@kreacher/T/#t

that have been included into the linux-next thermal material.

This series is available from the thermal-core-experimental branch
in linux-pm.git.

Thanks!




