Return-Path: <linux-wireless+bounces-8577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42788FD5E3
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 20:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F6E1C23A80
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A5022615;
	Wed,  5 Jun 2024 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="siRgdmpA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7B19D8B8;
	Wed,  5 Jun 2024 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612786; cv=none; b=RkYf7+AGS5FwpUrlQhjC2Kp3X7L8JYHfyxLYKsSlWIY7kAVRM6PXNoEFFQPdQQ9bC46d03XNpJgQgOgJz52CwB12V5eOtvG6LvVInX3sZIXGp8d3vc0ZgBwC0+ck5IkByB6ALbXgxMBGnwC1C28i7PxvRMsGkXn4C43FV9XCgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612786; c=relaxed/simple;
	bh=ll7BJXBgyzFfVEbUvstry2CP0ImNl+s6mup20BRuXyU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=so8WHsAskyIQziTeYYdXhcClgF948fnbsSZgig9DfPyMbanRC7WybBrNnv7vg2DgXBQvBrpR/4RzWKjyzXN8hKqILbV//JZ+MIhUfZ05h5bNlKOGdSAP2qHqq3BqI36B4U5hvh5hvn3vDc5ivDIdT5gmnLVeJT3rwiPTqcDEM/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=siRgdmpA; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=y/VdjsL4ukypdzxZWoyFIbTeiY0cZ0qqJTSU7aQD81I=;
	t=1717612784; x=1718822384; b=siRgdmpAjcjnZydxxmYuvGqTuioP5MknYzvFcCYy2cFcRfK
	V7nTjzHkyrP+DUF70Tt1dGAnNwh11KdrYsL6GFkBTxvljTjmfD64g5R27IAsR3nLPyNa4gFY48vxb
	gXGpEYUQTxVv6HVgMGLHO8bNWaM8wTa2SQ5iVhvp8CEIZtulTb7aVhGTqQLhjTqBQ8i8OkJnI+poR
	60jWi2/hsrSx9XLLVE17Gwj5PVnOHY9g6Ka65+jPKXnhsOPclEJunwVkxHCnGXZaiYQBAfflfx4MY
	hpsUCLjyDmwRGHTiHZSYaWw63CyMUyiUnmeO9QQh2K0gkLXoKV54rpiR4g/1Af6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sEvXw-0000000EuRA-3zzb;
	Wed, 05 Jun 2024 20:39:41 +0200
Message-ID: <00555ae56b4193f47d32550440829d1c542534f6.camel@sipsolutions.net>
Subject: Re: [RESEND PATCH v2] iwlwifi: mvm: adding check if the thermal
 firmware is running
From: Johannes Berg <johannes@sipsolutions.net>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, 
 miriam.rachel.korenblit@intel.com, kvalo@kernel.org,
 rafael.j.wysocki@intel.com,  daniel.lezcano@linaro.org, dmantipov@yandex.ru
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Jun 2024 20:39:39 +0200
In-Reply-To: <20240605183710.66016-1-trintaeoitogc@gmail.com>
References: <20240605183710.66016-1-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-05 at 15:37 -0300, Guilherme Giacomo Simoes wrote:
> In the dmesg is showing the message "failed to read out thermal zone"
> as if the temperature read is failed by don't find the thermal zone.
>=20
> After researching and debugging, I see that this specific error is
> occurrenced because the thermal try read the temperature when is started,
> but the firmware is not running yet.
>=20
> For more legibiliti i change the tt.c for return EAGAIN when this was occ=
urrence.
> After this change, in my computer I compile and install kernel in /boot
> and in my dmesg the message "failed to read out thermal zone" is not show
> any more.
>=20
> I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> an=
d
> Kalle Valo <kvalo@kernel.org> for your suggestions in my first patch.
>=20
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wi=
reless/intel/iwlwifi/mvm/tt.c
> index 8083c4b2ab6b..68ab9966330c 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> @@ -620,8 +620,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zon=
e_device *device,
> =20
>  	mutex_lock(&mvm->mutex);
> =20
> -	if (!iwl_mvm_firmware_running(mvm) ||
> -	    mvm->fwrt.cur_fw_img !=3D IWL_UCODE_REGULAR) {
> +	const int res =3D iwl_mvm_firmware_running(mvm);

const is useless, but you should not have variable declarations in the
middle of the function (per kernel convention)

johannes


