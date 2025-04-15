Return-Path: <linux-wireless+bounces-21547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F4EA89C54
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 13:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB2F1901054
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 11:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9642973DF;
	Tue, 15 Apr 2025 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Vv4PXsdL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6002973BD;
	Tue, 15 Apr 2025 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716100; cv=none; b=J+yfT2P+TtCEzk+FXc1c1RVVzVTNeZYH6/ohA3kMOhFRbcQ89UG2HgxcrmbUe1WNjlSRTJR84XgQ2ZfWTeEnr2v2ls8HOaRXho96GDrM828JfZAp07pwBTsTbqoEQrnfaMuaF2bvuDiINEcUPLhhMU8RQUV/tCWVuI674uDvWHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716100; c=relaxed/simple;
	bh=swlEp5ONWnOjBUXTr3HxuyUXycsO0Zbkbf91UmbdTJo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qz2u4DN5MUR0RnUfpCIR9QB0BX3VSQRhhS1/jtf/eqz4npPvBmbunC4nkW6RZSoc0bJ4EqyQJR/0IFEJFLhMOv3qJFaRzPyuMACK+61t5XeJWk3q9mTBZgfBhBNiBufrZHJ0MDu2e58lIuKTBfuBUBPkJpHSMU4NwWArSOKQXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Vv4PXsdL; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744716085; x=1745320885; i=markus.elfring@web.de;
	bh=swlEp5ONWnOjBUXTr3HxuyUXycsO0Zbkbf91UmbdTJo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Vv4PXsdLsO2S1Lxta+qqtrwGNUYct4sGg1j00001ylcTg6DNlmi8TwSdOumaP2Bw
	 jjg6DO3ZDHU2EkLAmdNrFrY4fBBro+5VJ9bAf2Xb9X8cPdwUC4aRc2XPsyuzDjdHg
	 +w7CndTRBv5lokAS3x3tBqVrXH50GqJm/sod2B1+HaRoCKqcYbFNypO/lTAqLmzoH
	 3m93xZTYNi/Ztg6UZKDUxNPBD8wMwblmlqntJcXD2fhTS0hEhsAQpmwMH5YSK6Hf3
	 MSGsO939wjn0Nnb5+c7bBk611LmvzVcMbOy9UlrFGy/kG5Sm379sQav1KpAF7FLQw
	 DsC8N/XUeZ0IlR0eag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.24]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTfon-1tbCjR3zEj-00PNiJ; Tue, 15
 Apr 2025 13:21:25 +0200
Message-ID: <af72dff7-8ad1-476f-81f2-6f7d76761b12@web.de>
Date: Tue, 15 Apr 2025 13:21:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Erick Archer <erick.archer@outlook.com>, Jacobe Zang
 <jacobe.zang@wesion.com>, Kalle Valo <kvalo@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20250415072048.2629-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] brcm80211: fmac: Add error handling
 forbrcmf_usb_dl_writeimage()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250415072048.2629-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dhz2nwlJ5aVsbY/GDkK3rbaI8ZhD37Qt48RXdwBTSD9VIDEvvgZ
 osoYzVB1fp7HFEopYGEezs2tavB91d23PZ0nnZTCO12lhBPpkwHYJaVkEJqWJ8i1hn8Z2IR
 GOiDlVP61W/+/rHppIelVe3Mgjj+fkCAYXLayyXsn3b0GyjNXNBpXJsKQrXzXPk4t6xgyLN
 M7hzES+Y9WaUAiNPPTujg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CAYibJvv6NM=;SqoCF8okJXN5n36Sry04u1pUXkf
 GfQH/HLyOkq4Y0lczLsGu/bO85zjjesl1uiMGLnV/cq2J1tX2pRkpxH28C0PdRLvrr7kaCy3m
 k5znkezQYYKufXTYHaJnyqyfQmY+4wbifDcH6wflPirtxFDg9QObKH+/anZ3G078x4Lb+ON8H
 RBf+4Ia0MdofphvDx1aG6qzD7enjaqOByu7MVQg+1Mzm8aFcfY9jn+IgIyeKqs4M7VX1EWOHx
 AVEPiym/FbzTNXGc8wp7ajwmNSz1br4ss/7VZGZKG2DyScKHPUKYKZhLKNaYYAKLfikTHm76J
 a2G8xqZ5/ojG8b+ZSJI4bmcPrrAZlNMsCMcRAydmTNNo+ZhNLc2a25K0U/CGh2MpILMAQmfsb
 bjolYOBGBb0Zz8+FbAdwDccyhwup7k8XItjH610zz9ZPir5Lp3KA6SG/o2vMhUwGKTtrXTMAO
 EtZgRRc5AKPHkjKJLDPaCsBMjJSvNpYtb/p8ITVh3xMmRe9nXSngEgUm3FoZYX4VWOv42po4v
 GbBEjmNPhPeJbh9esc/3fxEXep1+kl75sXkHpWhUusK9TKZp9ine9SRXxBVPEO0IkEmQtqMrN
 63FOQX++0gq/MpWkhRkpaDVwPJitBBaI0cpt0G8wR3PLrlJVCsba03spVFgpzZnWshzcEqE/o
 M5r/jMqmDKj9CQdc14NAAjSyKV38wMtPm/KfnYyrF1tQ3Of8WCGv2MYaao5h1WehVZ4dkpvKr
 ZCodSewaBu/RMOBpy08QORn9VsyiEInishTFFKywJjwHJnTDDhDypUFbQRqISyuBU/mjEyKtk
 udUK14SQzRC1dVuMRjiRunHKDkdnWPEGIAirgVvLZu6URMem/xNpdedooA8k1Mvs/KipOYHv9
 +jvlkIxTMqzDdu9K8QDnhzp32p89/bWjpopIosgqALhn/f2+bBTRcVMst5kWfUt8J8KfUhEHY
 iFyGNLa7cZugPsNhGOG9BO1Yo5eMFBoqAxuOTxBeLJaS/niHaL4EznVygjtdiPDtw1RYsnCgg
 BTCP35RmH8+T+l+NfNYiaqz93Bswp3Z5ljZoY9isnLxM5reFFcWQEwaRZbQxEKYvF2OQ8ctMy
 DOPzSTLUEWZZ+nHwOMZOOLr0QWLd6JIiBBuNmyelhPW7w4KlTg4g0ZU19A2hSD2WCTI4+Dbam
 edw6FFwuPX5Ibh9m7Oz0kPWphxmX4kp+RxV2hPT87QlNJrPTcNFTXliIDKiNe7/sCnJHJ3DZz
 NXaP/UJa12j9xU5rjkt5kf8WIYqOTExxiOI9U+FkD3QxsUXd1Ab6oqu6mi2dJSFmXFAy7GgRy
 8UTWr+OzYFXHnt4B1Oq4zOZsxdPT4FHhjBzc27Sg7uav2YYVsoUvkxISnzw7UQC5nsCnAezoB
 OXfwEEP8TmWjTIAiS3kjY1vEoVwwgKaOmeW9q8brasz5iHk/Z0L302v288GhWSjKCx8DXliol
 T19XdeX/AiF3xu7qchhQf23fIa/94HCTp5AcbM5RkEmtb9ni1glVObu8Ltf7t+wjbcDU+fA==

=E2=80=A6
> brcmf_usb_dl_cmd() but dose not check its return value. The
> 'state.state' and the 'state.bytes' are uninitialized if the
=E2=80=A6

Would you ever like to benefit any more from change descriptions
which may contain text lines that would occasionally be longer
than 60 characters?

Regards,
Markus

