Return-Path: <linux-wireless+bounces-33377-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OjrAg9YumnFUgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33377-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 08:45:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 607E12B725B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 08:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840D630692DF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451EE36B06C;
	Wed, 18 Mar 2026 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDvuhAC4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4B4368279
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819793; cv=none; b=CvbrC26APqa9xuZgIvuaRQTIxqYIE4yzhIQvxMDj7Ls7mVtBIecBE1e4lsqIIkiFlayUOAnYdNR/vJfvGVZ4a0BBkCq1ikOPKyqwvNn7e8tNDh0pXqcMlpksNoQIO6bMXzvoyMnRzET0KDP5+S3tjlaiAJn1bHslBO1YEppdUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819793; c=relaxed/simple;
	bh=fM3TBzoRoSe8b8SqRDYcio9WC5Bw19Lr3Awy7fCtMOk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZjA/35KMeevNe2l64Qxx3OuTaYP9/WbqGE5O9C8Er91wItu53QR2OXFYwDvihYDsoi7m+q7XrLFWsnna22Z43n7RduPETDJbiEGiX9AdRzBBJvNazQTTxBAdpI1+FATBZY+oaZBiha6Hybl/Kj1LFhltvOhLoxvRzhcdOykiHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDvuhAC4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48532925a4bso34572985e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 00:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773819790; x=1774424590; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzRjTk+57YDXQ6ggP3smXE9BVEZhmcL4mcy3VaD7WAI=;
        b=eDvuhAC4suNJdy1RomdFHKfq8cYIYX5N1X/CggdRy5/G7EP9H8v6u3fxPl08fs9NCE
         gqMvZWrytxOJ4nSS6PwiKzhPYO4N6YvdsqnwNh9Mnh8I54OJ0Yo/xStTO+LYOCZ1SWhv
         d0h+rV7wzHmkB1ipookCKiBPWolPO+yp8zsY4O9g/0RAQgliU4vYWM+XELzp+52m6zK4
         r64TOicbRaeJqy7+gSldBiUkte0eRkniICZLktcH51foatGyU1hAA31GtUXhw6oo2QlV
         rLxEaeYkabVpaSBh/9mf27c2qcVKiNu/u0/TnhCbBLhjmAYGvtwhgfF22qc2DCofv7nF
         SLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773819790; x=1774424590;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzRjTk+57YDXQ6ggP3smXE9BVEZhmcL4mcy3VaD7WAI=;
        b=AiRRkEZ3h2X+DrBaZ7nHYipXbphCLA9T7qoeygDiTCd8Z49rETEYGb8hTgMjlBJr4p
         RxhEWVgNcsTs+cgTYPahxVPH6bvjWVnv/d2Ir6Pw4wmDmicxp7nKxpOeWrd1oZLNurk5
         iL6SXrUk3zlz2DEIVwkF7sxAze2X1naFiBBzcnsuSstNoodIZ+jHv2h5sLhJnrEtUhf7
         i/EsQgtUVUTrWpVkGd9vbL9+GW/lv81UaZdzbXiUwGrottqsJfjp1h51WSMfaYPzd+m7
         4HULyzfXS8gUJlnQA0KXLeev9wM/tbyZBXbu7jmL2Uud7y+WFtRTllf8zpU5zU6DsBLV
         Zu1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmLMvbagPYDg+AHUT6I3QiSbwl3B6PQX5v6WQrIraRN62PhxnG7S5DOt+GZUN/L0gKXYmWNwBBrCTT7FuTCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKBLdQul6eOTqsF5FZvALGzGxn312Me/aHW3RtMMcqkf111lg
	9XuHfpqKRm3PDsvUcodjrjLF2ge8MAiPuuaEAU9JCQU5U7+1O47Nde7mdFn1rOIiOnw=
X-Gm-Gg: ATEYQzyX1JV7aIzgUd0o0Yz09np2jKYc2Ye6wTdYnYKXYm5ijS7wcrs5nuAHlA3L/+z
	ZqeADk831CdrgF7VNSIfCZ5BAY65w7TLWzemzID74SuMiFrU55w56qxnQBAPfZhdKOaOkQ+Vx0N
	KCxEicbgiO/A031PiSTHWhGcSoTl7BYmSZHXQnFcdmjjqfr7g1GBfxkEL8OIDCNWb23VJjDr96F
	ajOWAS4HUg9UguYeMOH/g5HtfITqUHw7QX6aU3zyEAhnlhdtDiStHxmvPmiXl+28JbjQH8BeThO
	uVyAYrVOC4SI3K89wHWk9uF59X7iUCsTdDPZUPnk5s3XxA0DdMKqmQksilas+obdlFKaqpqy4s7
	lBMi13rVSJZPTINnqLLpXkxArT9hroxOrbQPJR8lR0H8po1DtBtEleSygUqXUpXKL71t7LIy2in
	vJq1lzjiGmcZgJYC2gs7L90W3+j7U4S9MytC9ofgSIMTX6euXb31YR9x+YlWrv3/mkEYv0DJ1hO
	e2UtvsfLePyK3/mZTqemP/+XeI=
X-Received: by 2002:a05:600c:83c3:b0:483:badb:618f with SMTP id 5b1f17b1804b1-486f44635a9mr33632955e9.25.1773819789614;
        Wed, 18 Mar 2026 00:43:09 -0700 (PDT)
Received: from smtpclient.apple (static.253.36.98.91.clients.your-server.de. [91.98.36.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4e48ad5sm43744425e9.1.2026.03.18.00.43.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2026 00:43:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 1/1] wifi: brcmfmac: silence warning for non-existent,
 optional firmware
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20260317111202.1074675-1-alexander.stein@ew.tq-group.com>
Date: Wed, 18 Mar 2026 11:42:55 +0400
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <48BB2A8D-D969-4686-9B30-11331FB14C56@gmail.com>
References: <20260317111202.1074675-1-alexander.stein@ew.tq-group.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33377-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christianshewitt@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sh-git:email,tq-group.com:email]
X-Rspamd-Queue-Id: 607E12B725B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On 17 Mar 2026, at 3:12=E2=80=AFpm, Alexander Stein =
<alexander.stein@ew.tq-group.com> wrote:
>=20
> The driver tries to load optional firmware files, specific to
> the actual board compatible. These might not exist resulting in a =
warning
> like this:
> brcmfmac mmc2:0001:1: Direct firmware load for =
brcm/brcmfmac4373-sdio.tq,imx93-tqma9352-mba93xxla-mini.bin failed with =
error -2
>=20
> Silence this by using firmware_request_nowait_nowarn() for all =
firmware
> loads which use brcmf_fw_request_done_alt_path() as callback. This one
> handles optional firmware files.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

On behalf of all distro maintainers receiving end-user issue reports
that wrongly finger-point to =E2=80=9Cmissing firmware=E2=80=9D as the =
cause of all
brcmfmac wifi problems:

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

Before and After below:

VIM1S:~ # dmesg | grep brcmfmac
[   12.687679] brcmfmac: F1 signature read @0x18000000=3D0x15294345
[   12.727469] brcmfmac: brcmf_fw_alloc_request: using =
brcm/brcmfmac43456-sdio for chip BCM4345/9
[   12.727947] brcmfmac mmc2:0001:1: Direct firmware load for =
brcm/brcmfmac43456-sdio.khadas,vim1s.bin failed with error -2
[   12.813544] brcmfmac mmc2:0001:1: Direct firmware load for =
brcm/brcmfmac43456-sdio.clm_blob failed with error -2
[   13.157373] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available =
(err=3D-2), device may have limited channels available
[   13.157423] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob =
available (err=3D-2)
[   13.159391] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/9 wl0: =
Jun 16 2017 12:38:26 version 7.45.96.2 (66c4e21@sh-git) (r) FWID =
01-1813af84

VIM1S:~ # dmesg | grep brcmfmac
[   12.218764] brcmfmac: F1 signature read @0x18000000=3D0x15294345
[   12.283612] brcmfmac: brcmf_fw_alloc_request: using =
brcm/brcmfmac43456-sdio for chip BCM4345/9
[   12.382176] brcmfmac mmc2:0001:1: Direct firmware load for =
brcm/brcmfmac43456-sdio.clm_blob failed with error -2
[   12.678015] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available =
(err=3D-2), device may have limited channels available
[   12.678066] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob =
available (err=3D-2)
[   12.680092] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/9 wl0: =
Jun 16 2017 12:38:26 version 7.45.96.2 (66c4e21@sh-git) (r) FWID =
01-1813af84

Is there any chance the same change can be done for the clm_blob and
txcap_blob error messages? (for the same reason). Other than for RPi
boards I=E2=80=99ve never seen these files available and used with any =
large
scale Linux distro and there are none in the upstream linux-firmware
repo; thus these files are only being packaged by specialist distros
or images targeting a specific or limited set of hardware devices. For
everyone else running a mainstream distro image these errors are just
log-noise, and while they are harmless and technically correct, end-
users constantly misinterpret them.

Christian


> ---
> .../broadcom/brcm80211/brcmfmac/firmware.c         | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git =
a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> index 4bacd83db052e..e84cec58470c5 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> @@ -714,9 +714,10 @@ static void brcmf_fw_request_done_alt_path(const =
struct firmware *fw, void *ctx)
> if (!alt_path)
> goto fallback;
>=20
> - ret =3D request_firmware_nowait(THIS_MODULE, true, alt_path,
> -      fwctx->dev, GFP_KERNEL, fwctx,
> -      brcmf_fw_request_done_alt_path);
> + ret =3D firmware_request_nowait_nowarn(THIS_MODULE,
> +     alt_path, fwctx->dev,
> +     GFP_KERNEL, fwctx,
> +     brcmf_fw_request_done_alt_path);
> kfree(alt_path);
>=20
> if (ret < 0)
> @@ -779,9 +780,10 @@ int brcmf_fw_get_firmwares(struct device *dev, =
struct brcmf_fw_request *req,
>    fwctx->req->board_types[0]);
> if (alt_path) {
> fwctx->board_index++;
> - ret =3D request_firmware_nowait(THIS_MODULE, true, alt_path,
> -      fwctx->dev, GFP_KERNEL, fwctx,
> -      brcmf_fw_request_done_alt_path);
> + ret =3D firmware_request_nowait_nowarn(THIS_MODULE,
> +     alt_path, fwctx->dev,
> +     GFP_KERNEL, fwctx,
> +     brcmf_fw_request_done_alt_path);
> kfree(alt_path);
> } else {
> ret =3D request_firmware_nowait(THIS_MODULE, true, first->path,


