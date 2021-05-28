Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1FF394083
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 12:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhE1KBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 06:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236119AbhE1KBo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 06:01:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72BFF6113E;
        Fri, 28 May 2021 10:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622196009;
        bh=1EFGuJzQrt+sV+YW/yXOh29Ca+ZeeH8P9SwtZ3MQNZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNFRpcWSgzDf/SBvMfK6oT7wMCLBgmS1OCCoaxt1FZVF4oNMqbK7AdzOsTPyjfKod
         Aperao1/Y7SaQ+2uTNB13KipFwzG41e8/mGi/LG2b/Qj2hqo3N76blkXlEWukEIEnH
         6LQ8JWVENdfWXsA4DSZw428qn9vEoCZFMkf9w7lDrktb6dsTcYXy7mDq8grka/GCG9
         l60RgQIPYAh/8/Tt+k+XJwbYTN1FtqzbbIXMM3Z6h8L0+KuB5Ytdlpen9F38mGvWER
         WYUIDfPRAd50wn0XSmbCOPwmnjG7Nim8c5KOL2drMshum8mOv2gsgAIjeLGoQ5wNRX
         j1yO6fZAsTUfQ==
Date:   Fri, 28 May 2021 12:00:05 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Deren.Wu@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: update statistic in active mode only
Message-ID: <YLC/JQhJliH1FM0B@lore-desk>
References: <9337f7947e1f0921ffb6b4af541d29af9a0a9394.1622112237.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dyk70omr0HMm6HS1"
Content-Disposition: inline
In-Reply-To: <9337f7947e1f0921ffb6b4af541d29af9a0a9394.1622112237.git.deren.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--dyk70omr0HMm6HS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> wakeup chip every 250ms may cause huge power consumption
>=20
> try to update statistic counter only if in active status only,
> and it would lead fewer power cost
>=20
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20

Hi Deren,

in order to be acceptable we need even patch 2/2. I guess it would be bette=
r to
squash them in oreder to not break it.

Regards,
Lorenzo

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index e29d4fdab572..212832b34674 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -1459,13 +1459,15 @@ void mt7921_pm_power_save_work(struct work_struct=
 *work)
>  {
>  	struct mt7921_dev *dev;
>  	unsigned long delta;
> +	struct mt76_phy *mphy;
> =20
>  	dev =3D (struct mt7921_dev *)container_of(work, struct mt7921_dev,
>  						pm.ps_work.work);
> +	mphy =3D dev->phy.mt76;
> =20
>  	delta =3D dev->pm.idle_timeout;
> -	if (test_bit(MT76_HW_SCANNING, &dev->mphy.state) ||
> -	    test_bit(MT76_HW_SCHED_SCANNING, &dev->mphy.state))
> +	if (test_bit(MT76_HW_SCANNING, &mphy->state) ||
> +	    test_bit(MT76_HW_SCHED_SCANNING, &mphy->state))
>  		goto out;
> =20
>  	if (time_is_after_jiffies(dev->pm.last_activity + delta)) {
> @@ -1473,8 +1475,10 @@ void mt7921_pm_power_save_work(struct work_struct =
*work)
>  		goto out;
>  	}
> =20
> -	if (!mt7921_mcu_fw_pmctrl(dev))
> +	if (!mt7921_mcu_fw_pmctrl(dev)) {
> +		cancel_delayed_work_sync(&mphy->mac_work);
>  		return;
> +	}
>  out:
>  	queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work, delta);
>  }
> --=20
> 2.18.0
>=20

--dyk70omr0HMm6HS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYLC/IAAKCRA6cBh0uS2t
rHzyAP0Q0zFFmdcnAJuuCidCeLFAoquizTDgg40cyTd2TnWlZgEAo4+U0LeaT1Z+
9Ti9+WF+lSb5jrYtiqGyn3f7lCHpZAo=
=+AVP
-----END PGP SIGNATURE-----

--dyk70omr0HMm6HS1--
