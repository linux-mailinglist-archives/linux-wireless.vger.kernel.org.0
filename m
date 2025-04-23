Return-Path: <linux-wireless+bounces-21912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F1A98B91
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4771778DD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 13:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2274040;
	Wed, 23 Apr 2025 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BjY9foB/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B418118FC91;
	Wed, 23 Apr 2025 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415757; cv=none; b=GLEdH9BdQ64BnXjaMK5GstULN63BW7mRvdTAWUftJSnmhGOPLwc6PDaW7qVCEBAQ5yGIW/BYIG6Kl2TG2rcQwfKCysPBHfpecAZeNxvt8KIvQpgFuvZSTSB4FnUfvMkgJVJVdmb8OoPAJqGjpv4modGpXMUunzC81Zcfep9s6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415757; c=relaxed/simple;
	bh=KSs8uNBIa0d6AJ4q7vmB718nPFKS3k+/HPVpFybE7tw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvhnPlB4H9RkBDL7bpFaTWmOYASjHhZo8D+ECs1WGJaiK0edOSu0M/TgmxXGHCWpjm3l/8nv8Jnlau0+MGn7S/r1Fb1hfOUHrc2yv/p4Lw8rIpKh0J0pQ9kZ1/GkXhF1FfPfg3s9z52jH7CRjt2WOxcXEb7Oi+vQYEB0L4miCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BjY9foB/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0a0oJd/HgK/U6Iheba9LWFLFX2/Oo9t3X/dbseb1NiQ=;
	t=1745415755; x=1746625355; b=BjY9foB/8UcccY6MtWvNG0nYa1UWSP70fjZ0uzqj4B2Z8KO
	DcPOyi12p7SvFqhdU1f2y/8eE6SuPqfdHIfSC4KW4fA9WtDWCEcJSHUaKkHMsoQWspELwrE4zy2zU
	rT4L5MbcKWAqoPBM9JBfDhsieafuQ09vlCdICyFDxqYTPA9SSoWQP/IVtb7B1ukRQuFJcwC3/Qth0
	AlerSYJaziqBea63+22Kl3tVD0r624kn1DIsqzpMZFAwOD/eZI6gfVyShUU0den+WAqfw2pR3e/7y
	nq4yJX9YUllhY0/SMdZFK2g7QOUaCAj/6Bt+A15nFnf1sewcjyUjCYMsmJNHDmGQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7aMz-0000000EiAM-0zf7;
	Wed, 23 Apr 2025 15:42:33 +0200
Message-ID: <09abc0efe32d29387c745f364871271ae9177627.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/4] wifi: mwifiex: drop asynchronous init waiting
 code
From: Johannes Berg <johannes@sipsolutions.net>
To: Sascha Hauer <s.hauer@pengutronix.de>, Brian Norris
	 <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de, Francesco Dolcini <francesco.dolcini@toradex.com>
Date: Wed, 23 Apr 2025 15:42:32 +0200
In-Reply-To: <20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
References: 
	<20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
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

On Wed, 2025-04-23 at 10:21 +0200, Sascha Hauer wrote:
> This is a spin-off from my mwifiex cleanup series. I have split the
> original single patch into a series which hopefully makes the changes
> easier to follow and verify.
>=20

I'm applying this, but I removed a now unused variable in the first
patch that you only removed in the third. I guess that comment might've
gone into the wrong patch too.

Please, everyone, especially when resubmitting look at patchwork first,
there's a reason I put the bot there :)


In this case the issue was already in v1:

https://patchwork.kernel.org/project/linux-wireless/patch/20250410-mwifiex-=
drop-asynchronous-init-v1-1-6a212fa9185e@pengutronix.de/

->
http://wifibot.sipsolutions.net/results/951965/14046284/build_clang/summary

[...]
New errors added
--- /tmp/tmp.KVymmMae73	2025-04-10 15:54:35.187566833 +0300
+++ /tmp/tmp.xeV1sgB9ae	2025-04-10 15:54:51.973439711 +0300
@@ -17,0 +18,4 @@
+../drivers/net/wireless/marvell/mwifiex/init.c:490:6: warning: unused vari=
able 'is_cmd_pend_q_empty' [-Wunused-variable]
+  490 |         int is_cmd_pend_q_empty;
+      |             ^~~~~~~~~~~~~~~~~~~
+1 warning generated.
Per-file breakdown
--- /tmp/tmp.LJz16ltpSv	2025-04-10 15:54:51.980439658 +0300
+++ /tmp/tmp.5qRbEVE9cC	2025-04-10 15:54:51.983439635 +0300
@@ -0,0 +1 @@
+      1 ../drivers/net/wireless/marvell/mwifiex/init.c

johannes

