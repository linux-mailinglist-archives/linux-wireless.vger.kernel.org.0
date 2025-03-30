Return-Path: <linux-wireless+bounces-20970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A281A759D3
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 13:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF063AA32A
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 11:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2B1624C0;
	Sun, 30 Mar 2025 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IoAYtVH5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25113A3ED;
	Sun, 30 Mar 2025 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743334423; cv=none; b=FQuqmiAdmL9muhbQC2BpIuzVwDwLruBMUjtPTn5Bb3RsqNXy9h1wJkyhqGF4ZZVHbW+Ig+15bu3kjRdlGZKrEud8mkZiVYcXTOF+Wic1p00Qr0Lfa0mkd1ksvqSv5xfRL3RBo4ZVMKfpDU+PwC5I9vwrvK/M5C3ZCyig0RcVvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743334423; c=relaxed/simple;
	bh=W4lWQYV1Nx1jpqIrn93+1vEwXgKDUXh7Sltms/g+zf0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=m7KW0WBiCn/mlpORAMauu7VLGuMwWTTbDZLrAI0a9bQurvRAFkqhtgK5V73C7FTorLRW3y7h1p7bfoXh/QZ9fqjTJKR62V77INVBgeBiCULG/9GYP6Bs7k5PsEYNxwCLEqXMG2HQTXMR19NYXrC9IocNud9W6wM4Zc7drI56DbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IoAYtVH5; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743334397; x=1743939197; i=markus.elfring@web.de;
	bh=WjfpMDebyAxl+8+7FiZ92vWYLwsOPaQRFwBcgNho/1Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IoAYtVH5LaM1mLKcGnetcnOfovTlMDDrvFlZgMu5tGrVDDulsyU8CYYrc8i4MoyG
	 /07H/yXtayftnXQrZJ+lQ8jwXfeL6yCCpRrTZdPKGiAJP6kvs0SC5VIuDtVfV+txS
	 SPskuFfnbGr8/47CEEYSi/A1T/loY5r1QbxVoySMyg5ZGO5Idu24bGZhe7WNnfuDV
	 Kf8rQrICsMdSzovgjUU9mhf9nMH7b7PoWB8aN5xbVlQXOzl9mHvYRk2UqnNq8+Dyk
	 f9w3tQdOBav5ciKHjIPiWZG7tN+k/QlsgHNQSgI5fY258yJx8GQj2j1aACm0S2EmN
	 oqHVLLIqw+Ea0QI0Cw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.13]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7QQB-1t2Soq1WZB-017Vkk; Sun, 30
 Mar 2025 13:33:17 +0200
Message-ID: <a7e5afa0-6f80-4685-b901-86112fca61c5@web.de>
Date: Sun, 30 Mar 2025 13:33:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abdun Nihaal <abdun.nihaal@gmail.com>,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-wireless@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jacobe Zang
 <jacobe.zang@wesion.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Kalle Valo <kvalo@kernel.org>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 Sai Krishna <saikrishnag@marvell.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20250330093505.22370-1-abdun.nihaal@gmail.com>
Subject: Re: [PATCH] Fix memory leak in brcmf_get_module_param
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250330093505.22370-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:A9YI4cvStLbW9DNbPUKkPtiLzIWEX+zwdwhlQfW369PgyboEdHI
 fJYQZvDM1qLTUTc4hY2ypynCM91wkoodWkpOfHs/u2oVQxVesU1Xzb7hPVvYRqsOuV38WmG
 EwRg3J2A8VOBveG/dDYkEM5vpXuBGwDmAFspc805DIrFB/blAnjhScVLPNNjz2SgZcUifhc
 wFVzyhG++PWWKqevs6wGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IJ1jQ9MhSAU=;GFpVcOh+Iehhjx7G0SCZnXXgfPq
 KvZ2WA8dlL9/z1yQdAN/vvjV7oj5iPA/NusJ1k9aUq6y8LED3hMDh2RWLv+0WfaVj7bgBwIeI
 fBIs9JcvMxwMU5kW9OJjkDvAeoqCF/Cu4+l97x77Pb9H3F/awz48MVr1utQxEAN/pXn4zbNzV
 DmYjwRwiR/cdKgieTOTaFZxYkmjWWuHzcC87mWKRy54NYbfoPL3rdulaPfYQa6FcP7VB5rnRJ
 cH0BdvWL2zfOFO4pkizp3NNqZ013WiMh1RcqeFXGTALJidEl/ccHEeHXOEs+qCZ/LYyJn0g2Z
 b7y0a5+tZ+6cipeoWC09JZm83JJUESLpOceM7RxQiWzFsmJf0aOcPP+Solvm89aGGyp0QOO7R
 PdKLebrTPG2mTT1PLm30EJi7mJMmFXZ2wa+PgU/ZPV1J3dcduBpAuFX9GqQwXn+mRbkusGQ5T
 NiRhXpgUugqQv/V0SmFVby1tPXFkUaW6h/aIjRvqtuUMb5uQkL7HGx+Ky4XhTbDc4TbdRKo7/
 x9ssbQ9Ygt9jgHOq5B8Jns2ehkGTn/Awb9/Ee0xKytdR7eunmdjrNLBLJoMAu0ePKizFxgi5F
 4s8Fu6G3ucsHBTRmFMh22hYXAlyB7Xfwy43ligBcJEu0mCcsTnxnGm9jhM7s3q03gVNhRIBVb
 zxA7F+Jkw5wC5iQGFDQ5gskFasLyUbQj1ffs0L+U7Ubervrf0C5UKz9cmCR82JgkYhtmQR2et
 5Mv/qndoxJAyZcv/kyA+RHnsiOSXWDIPNcap4pdUHqTKpVoDJDbkyRxGv9uwVwSuJ2rUI8e9Q
 VwiwUpdp7Ed3VPYBgCIUz1NAt++2IVUsze8OUTP/ueSDscT6JZcyZBp6JYs1jnlvMm1S+7HAt
 L3ECNzyfePx3uOUN6fKsT6Ikss00bVsNgQQNUEH4oBgaFJxYteBl7YisjPKSw9DWPoaIobQ7c
 yGZKAunwDiMjT1Xi98DTJOL6jSbSk607Aoxb95Iwvu7r2P2L5T5Xoy0HJLFjJxRk3ta+ViG3a
 RhSu8Xhg6Oa81MoS26WKmvAP6DuC5Q27yXubXg73BD2yPT0MagUWBVRhwK5YpCvY38CDsnHO/
 ZL0KpOmpKTenrHmgaA+hJacrgQeGiBEbjfXaKYomeZhN2UIVgJ2QXsRjHSHDDkTFMpH3pPE2g
 6JtBx3ohSgL0wJqrw+YxW6jOjxhBiasObw/nGcCfAmA3PadJODmkHheNd68cEtCtEobQzPJjP
 LBeXHfv6fP1HXLBoZiFkqau6mGJifu2idjiByj+3oxaLrwfX53tpTuYLey1TlxJl6vhBIc7Wy
 fb8f84RVORZiqL5/UxbtoMQlVl4rLwUe1E0EOi9qz31IJilLtvt5n2H+0Uv4CXPGqZ5oSt+lf
 pxgNItJhSD6YCPQfokN7h1SDz1yVlkUONAJLmV9ITjMKYvZ0gUvxXDfXbH/GSYQ2vPJUJPmrM
 4XgKujSUCzR7ykwPBPxVZhoj5daHwPnDDYfa3r2kfrWm5pTwx

> The memory allocated for settings is not freed when brcmf_of_probe
> fails. Fix that by freeing settings before returning in error path.

  failed?

* Would you like to append parentheses to any function names?

* See also:
  https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14#n631


Regards,
Markus

