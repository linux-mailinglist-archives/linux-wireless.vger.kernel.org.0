Return-Path: <linux-wireless+bounces-236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1317FED81
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 12:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93E41C20D93
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E73C07B;
	Thu, 30 Nov 2023 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="upgVrcnc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E3D50;
	Thu, 30 Nov 2023 03:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uGytFMxpGI7JlPQDKfJO8ZqFvcljBnOYCH7721H3cm4=;
	t=1701342459; x=1702552059; b=upgVrcncB/P1AnThEmhWcQ5qmw/5lcdWsM8Q/+HR+lDfuth
	1axLLMx9eFyuNyeCDJZx1T1RSZFhh7HQqk+X9UXcpjTHy5PBh3K4ivPYzWh5WyjH+baCune07N64U
	dzCG1dkGPSSmHHabAj1ScYJsCqKUJps1hHKWHyCpbn+JraKav5xrZPlheCICkyUMa/hNDIZFeq/r+
	u8meKphWIzyc7199GrAiEWg5cAO/aroMwnici28GV/xsiUdlBweCN3ejO5KAkf9sSXi2k1rCXfRxj
	B857vFUJVIHV9SzrhiVc9jG0BedgYo3HivSuxy4wfjjERw+iOPMBXvueUIt9iTcA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r8etL-00000009v1D-3DAG;
	Thu, 30 Nov 2023 12:07:36 +0100
Message-ID: <b5d672096829cb9645205c3803e9471cef98643f.camel@sipsolutions.net>
Subject: Re: iwlwifi: WRT: Invalid buffer destination
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Len Brown <lenb@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, Gregory Greenman
 <gregory.greenman@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "open list:NETWORKING
	DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>
Date: Thu, 30 Nov 2023 12:07:32 +0100
In-Reply-To: <CAJvTdKkcxJss=DM2sxgv_MR5BeZ4_OC-3ad6tA40TYH2yqHCWw@mail.gmail.com>
References: 
	<CAJvTdKkcxJss=DM2sxgv_MR5BeZ4_OC-3ad6tA40TYH2yqHCWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2023-11-29 at 21:03 -0500, Len Brown wrote:
> Automated suspend/resume testing is grumpy about iwlwifi, because
> iwlwifi dmesg's with the words "Invalid" and "Failed", which our
> heuristics highlight as issues a human should review.
>=20
> If this is normal, can you delete the messages?=C2=A0 If this is a
> failure, can we fix it?

I had been looking a bit at either removing messages with level
KERN_ERR or or fixing the underlying issue. With the plan to get clean
runs with regard to kernel log level at least. I didn't look for
specific keywords like "invalid" or "failed" though.

I believe The debugfs one is an actual bug (harmless though) for which
a patch should be posted soon.

I don't remember seeing the "WRT: Invalid buffer destination" message.
Will need to take a closer look, but quite likely it should just be
hidden unless the IWL_DL_FW debug flag is set (i.e. use IWL_DEBUG_FW).

Benjamin

>=20
> thanks,
> -Len
>=20
> [20168.810433] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
> [20168.967756] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
> [20168.967806] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
> [20168.967857] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
> [20168.967919] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
> [20168.969387] iwlwifi 0000:00:14.3: RFIm is deactivated, reason =3D 4
> [20169.074918] iwlwifi 0000:00:14.3: Failed to create debugfs
> directory under netdev:wlp0s20f3
> [20169.076354] iwlwifi 0000:00:14.3: Failed to create debugfs
> directory under netdev:p2p-dev-wlp0s20


>=20
> ps.
>=20
> lenb@lenb-Dell-XPS-13-9315:~/src/linux$ grep IWLWIFI .config
> CONFIG_IWLWIFI=3Dm
> CONFIG_IWLWIFI_LEDS=3Dy
> CONFIG_IWLWIFI_OPMODE_MODULAR=3Dy
> # CONFIG_IWLWIFI_DEBUG is not set
> CONFIG_IWLWIFI_DEBUGFS=3Dy
> CONFIG_IWLWIFI_DEVICE_TRACING=3Dy
>=20
>=20


