Return-Path: <linux-wireless+bounces-388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A6C803D29
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 19:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E42428112A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F332E83D;
	Mon,  4 Dec 2023 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZJn27hic"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7498DD5;
	Mon,  4 Dec 2023 10:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GrJGKlRdeB8PafMT6uPjCN0IqpY1+UOh98nhLP86AXY=;
	t=1701714897; x=1702924497; b=ZJn27hicg0KcXFv9RfeCcYLX88r09kwFEejcNirqJd4apDQ
	qFW1lm17FrSZSbqmdivjeWUJ44y1fW+L9qkwUw+0byFAjgVPAk+LOcSnSZMpbtNUUDKI2IOwEKlrH
	u0vTeKk/kTQOB1d8HoIMBQpaTL57chxeu4Wf8CoEhvc742mvaNuiSFmTeo2kk1ftGmIMShhduwvhv
	/O1qd+m6JVYHYPEM5q4DipvQ2sj0cTrP/aeYoGvsBkm6lu6sD+6qMFVxHTOe2iPBzT9t85osIYJhA
	Pp3K5z+g9I4+R73bLhCyhBiJi9mle8fqWP2n6sRG6Y2Z6rNgNmD/k2qDbwG73g0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rADmM-0000000FBe7-2vDE;
	Mon, 04 Dec 2023 19:34:50 +0100
Message-ID: <8db5b21fee0f0e547d89b2797b0f4cc40062339b.camel@sipsolutions.net>
Subject: Re: Thinkpad P17 keep hanging in ipv6_addrconf addrconf_verify_work
 / netlink in 6.4 and 6.6
From: Johannes Berg <johannes@sipsolutions.net>
To: Marc MERLIN <marc@merlins.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ilw@linux.intel.com,  "Paul E. McKenney" <paulmck@kernel.org>
Date: Mon, 04 Dec 2023 19:34:49 +0100
In-Reply-To: <20231204165239.GB9208@merlins.org>
References: <20231202171326.GB24486@merlins.org>
	 <20231204004003.GB29484@merlins.org> <20231204073515.GA9208@merlins.org>
	 <69717129398d05b18df1c1300bfb41da268c52a0.camel@sipsolutions.net>
	 <20231204165239.GB9208@merlins.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-12-04 at 08:52 -0800, Marc MERLIN wrote:
> >=20
> > So looks like bug in the 'igc' driver wrt. runtime PM locking.
>=20
> Thank you for the analysis Johannes, I appreciate it. I'm at a spot
> where I have to return this laptop very soon if I can't get it working
> (or will get stuck with it, it's a temp one until I get my original P73
> fixed, and from the little I've seen the 3 year newer P17 with I 11th
> gen (10nm) instead of I 9th gen (14nm), there isn't a huge difference
> between the 2, especially as my I9 had 8 cores and the I11 only 6 cores.
> So I may go back to the P73 as soon as I can get it fixed).
>=20
> In the meantime, anything I can try to get around that bug and confirm
> that assumption? I assume that driver isn't something I can turn off
> since everything depends on it, correct?
>=20

Well I assume your ethernet connectivity depends on it :) If you don't
need that, I guess you can just blacklist it.

You could probably remove the runtime PM ops:

--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7321,8 +7321,6 @@ static const struct pci_error_handlers igc_err_handle=
r =3D {
 #ifdef CONFIG_PM
 static const struct dev_pm_ops igc_pm_ops =3D {
 	SET_SYSTEM_SLEEP_PM_OPS(igc_suspend, igc_resume)
-	SET_RUNTIME_PM_OPS(igc_runtime_suspend, igc_runtime_resume,
-			   igc_runtime_idle)
 };
 #endif
=20

But I really have no idea about this driver, this is purely from reading
the stack dump and code.

johannes

