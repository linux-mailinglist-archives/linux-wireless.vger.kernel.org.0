Return-Path: <linux-wireless+bounces-27831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E18BBF1DB
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 21:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2000934B659
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 19:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237CA2D5436;
	Mon,  6 Oct 2025 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="m74s7RhR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7212AF1B
	for <linux-wireless@vger.kernel.org>; Mon,  6 Oct 2025 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779693; cv=none; b=IEpDqY1IoUf7RqVazPK1mwfRXAGUtIsjQH8FG1bvLuJy0FArlO4wtVTAISEm/iqvxvkVB5tQcB6EeZcxQf5GH1b5ZI0W8wJEu230z8YJqjXAWX2XVcQOMG7TZ4vAd2mZNWlBavZAMupB+u6ITaIN+g1Pbqd1M9pwyCOCr5hGcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779693; c=relaxed/simple;
	bh=bz4fVYTgP6sJRMoIRtZtxtSKODc51hWwZVURVc64i/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOC2E0vh5VV8YAnZ0GI/kQdhA7MKyh36gp6aeqiDe/ammtsoasri3lIG52DOOBfmBxOZVwz8RQ3lYaIbyBa2wfCkORYQmGwO9KZFQukrL7kKS2Myk6AgDFURxwIo1mi6BuFXlz0FL81ITXt2NEE7oUhQ9epYLmQntkNqMip/6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=m74s7RhR; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1759779685; x=1760384485; i=wahrenst@gmx.net;
	bh=UagL+hcUupd/DeD1CqLh64ezTrPUIlZ1RSHvYFADq34=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=m74s7RhR0oESlZ+ZxG510PijY4X8B84YnRiBDRRZXE6qXgaPp0no3cYTtSLdCRa3
	 phSHjRpNdm5ZPzexMeyb8CVCWcJxqJi6R3DBuKXjeKl6yk6hh0xlg8ng7CrjW5P4G
	 RuWFnmhFOVImElS819dw6FN4flfCRd7AUhcA+bsfrfqyJ2m0T0fpYKp++OXJwtSBb
	 VtP1N8nfeLJCUBoRIit/P97YfYNAWRZOiAIYZvCRkuo3YLMv9rzZtfrYJEyvuJCNd
	 e/BrG+A6+5l98HhZJPAUGRtOL+QQdXvqBUYTw1rg636XP7Jvag3mkO/mDRRciU+HD
	 ISTYwE3/j6uRqGcvZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([79.235.128.112]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOKc-1uGuOR1eoQ-00uJ8F; Mon, 06
 Oct 2025 21:41:25 +0200
Message-ID: <9811a46c-70ab-4bf6-9e20-7882fe1d0c55@gmx.net>
Date: Mon, 6 Oct 2025 21:41:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
To: Richard Reigh <richard@govivid.ai>, arend.vanspriel@broadcom.com
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 chris@streetlogic.pro, linux-wireless@vger.kernel.org, s311332@gmail.com
References: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
 <20251002232002.124609-1-richard@govivid.ai>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20251002232002.124609-1-richard@govivid.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1GdrxJ/HxCRlRw9RbU006BAzjRzpX3s7DHehVwbGXRpwWV4A28+
 fbkSHUch9nFhVZ6xzmfZ2s66wbXNatdU4Gi1zaFv3yhzShb2Ph8qcGRnKHcvD1obeTKgaUz
 YZNhBZVvLICaooPmYT1GhSZpCsiBbbC0hNo8tFJiuPiKCIVjDgv2hUFS3Xz0Ilg64iCXvOo
 Y+NQcjNbEMSrOY15XzPsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9ANOguHGYFo=;fUJiVOCcXbi5UQOjUJRavif2B+l
 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
 +lweRM0ENQCiWGAIY=

Hi Richard,

Disclaimer: my knowledge about the brcmfmac driver is very limited

Am 03.10.25 um 01:20 schrieb Richard Reigh:
> When iPhones query network information via the WiFi settings "i" button,
> the brcmfmac driver crashes with a NULL pointer dereference. This occurs
> because the P2P device vif is not initialized when handling certain acti=
on
> frames.
>
> Add NULL check for vif before dereferencing in brcmf_p2p_tx_action_frame=
()
> and return -ENODEV when vif is NULL. Also modify the retry loop in
> brcmf_p2p_send_action_frame() to stop immediately on permanent failures
> rather than retrying.
Since Arend's first suggestion didn't work, here is my feedback to your=20
version in the case you still want to follow this approach here.
> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
This is the vendor kernel correct?
> Signed-off-by: Richard Reigh <richard@govivid.ai>
> ---
>   .../wireless/broadcom/brcm80211/brcmfmac/p2p.c   | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> index 10d9d9c63..2c73156fa 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf=
_p2p_info *p2p,
>   	else
>   		vif =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>  =20
> +	/* add NULL check */
> +	if (!vif) {
> +		brcmf_err("vif is NULL, cannot send action frame\n");
Such errors are dedicated for real driver issues, but now we know that's=
=20
possible to trigger this. It's okay for your tests, but at the end it=20
should be a debug message.
> +		return -ENODEV;
> +	}
> +
I don't think this is the right place (tm), for the following reasons:
- the check is too late for an efficient bailout (e.g. there are msleeps=
=20
before)
- we introduce a special return code for brcmf_p2p_tx_action_frame(),=20
which makes it harder to maintain

So my suggestion would be to add the bailout in brcmf_cfg80211_mgmt_tx()=
=20
if it's possible.

Best regards

