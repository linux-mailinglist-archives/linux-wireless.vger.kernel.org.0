Return-Path: <linux-wireless+bounces-787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBBD812D55
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 11:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C491C21413
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B0C3C484;
	Thu, 14 Dec 2023 10:49:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
X-Greylist: delayed 307 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Dec 2023 02:49:53 PST
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5981E10F;
	Thu, 14 Dec 2023 02:49:53 -0800 (PST)
Received: from [10.10.1.198] ([84.226.64.168]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LgJO6-1rahYl3X9Q-00nlIy;
 Thu, 14 Dec 2023 11:44:36 +0100
Message-ID: <34f364a5ed0703b562b631efa1f3cd1fd8f3a93a.camel@ziswiler.com>
Subject: Re: [PATCH v3] wifi: mwifiex: add extra delay for firmware ready
From: Marcel Ziswiler <marcel@ziswiler.com>
To: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org,
 kvalo@kernel.org,  francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
 stable@vger.kernel.org
Date: Thu, 14 Dec 2023 11:44:29 +0100
In-Reply-To: <20231208234029.2197-1-yu-hao.lin@nxp.com>
References: <20231208234029.2197-1-yu-hao.lin@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:XeA/xXqrmulH1plKeWO0XxF2pnY5I9eUikZ1d+Eg2nx5HVSmlu6
 UQSW5RY8/TQmpHT8FK/kjCI0oQgf4eMlCo62ZKFedOyOLjGVvTStfK7h3S3S5FmJ4/9PU3S
 pdl2Yu0KcqHGH3HzHElQ4dVB8xnY4/1TFMUH12hDhOR6/Iwo/x2a1zYa1oao6Agzds5EmEg
 5gxbhKsTP6EQJxpTI6eNw==
UI-OutboundReport: notjunk:1;M01:P0:fP6UGUopE7c=;FLVEd0jnlTpVRgmon88h/Q8qtvR
 OjiMLM29xt+lGFHEGefMsnL8kXnnTwRxoJSJFSYRI5vXKTnTfg4gX5n3zml/Nglx03FJYSfI9
 C0EMJMCawL+RTTun5W5joMvDZ0S6YICefjPXNiWZPBkBIUnHSGSlhjrlYhioAHye6dkryJeDX
 cHqHbJEXXfb2yUkgZiH/Y7U2wJer8yOMQ2JD+O2h54yg04pFo23JLEhB4s0RlBTgAHUFadGfN
 VP7IlZUCucjDmpjM5/rBhvY7v/sMfQxij2Pf95OXpXy6qstLNY0rqW+HRLFckST6nZ6o9psS7
 Y0McWog8eBMmZcKTsg/8fIO96oGRsthMl42aE+NlgNvT3WNCKHVth+e3K7I6qCbmyZRkcW7qS
 d+7MbK+rawPMTjfejRtQVLBCD3s3H4C49tYVT93wInC2aYmCzMf9XzNG5J4A1ruJlQRW2adl2
 NOtAW0tW9PQVPoARaF7AC6//e7aXhzRmQzi1Jja9MDduyg5QQ315XGGdL1QXx8JcSWPofXPth
 v2YDiThWtjuxo78wxQ7Qpa2QmYSobgJbxeIqFzoJR783d/alSnZEvxWTsN92XEBsxspRYZxCk
 0TXEOB4px1QIgjD9bN1xRyNPDg4vPUS8KWFlK8xKlBnQM1iH0efiurL3fNNhg57O5Nealoe+o
 ubwltyfJ4mfLQXaTfOM0XE+15VxdL8q0xlPhUyTKWcGjMwjgp9LwMnCDjTS+65RrmXoHDHDTS
 aA0rLJ56rnFvNv1jS2QzdHBapk8Wr0Ix8JUbafEhnOU0AdTkLyCb4wOagZJROUMP5TJ7m9Hkg
 O7giSIVxFob06LdNkTr6r0ClXAk447glbubpVRU0zVCJJ0+Fr4By3Bf8k0QPSOIyEseyXBJdb
 cjznSj+HF5fosOg==

On Sat, 2023-12-09 at 07:40 +0800, David Lin wrote:
> For SDIO IW416, due to a bug, FW may return ready before complete
> full initialization.

BTW: What makes you think this issue is exclusive to the IW416?

We have also seen this in the past both on our Verdin iMX8M Mini (SDIO/SDIO=
) and Verdin iMX8M Plus (SDIO/UART)
with 88W8997.

good case:

[    6.496541] mwifiex_sdio mmc0:0001:1: info: FW download over, size 59455=
6 bytes
...
[    7.272436] mwifiex_sdio mmc0:0001:1: WLAN FW is active
[    7.314958] mwifiex_sdio mmc0:0001:1: Unknown api_id: 5
[    7.347647] mwifiex_sdio mmc0:0001:1: info: MWIFIEX VERSION: mwifiex 1.0=
 (16.92.21.p55)=20
[    7.355977] mwifiex_sdio mmc0:0001:1: driver_version =3D mwifiex 1.0 (16=
.92.21.p55)=20

bad case:

[    8.720216] mwifiex_sdio mmc0:0001:1: info: FW download over, size 59455=
6 bytes
...
[   24.976699] mwifiex_sdio mmc0:0001:1: FW failed to be active in time
[   24.983098] mwifiex_sdio mmc0:0001:1: info: _mwifiex_fw_dpc: unregister =
device

> Command timeout may occur at driver load after reboot.
> Workaround by adding 100ms delay at checking FW status.
>=20
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Cc: stable@vger.kernel.org
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com> # Verdin AM62 (IW4=
16)

> ---
>=20
> v3:
> =C2=A0=C2=A0 - v2 was a not finished patch that was send to the LKML by m=
istake
> =C2=A0=C2=A0 - changed check condition for extra delay with clear comment=
s.
> =C2=A0=C2=A0 - added flag to struct mwifiex_sdio_device / mwifiex_sdio_sd=
8978 to
> =C2=A0=C2=A0=C2=A0=C2=A0 enable extra delay only for IW416.
> ---
> =C2=A0drivers/net/wireless/marvell/mwifiex/sdio.c | 19 ++++++++++++++++++=
+
> =C2=A0drivers/net/wireless/marvell/mwifiex/sdio.h |=C2=A0 2 ++
> =C2=A02 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wi=
reless/marvell/mwifiex/sdio.c
> index 6462a0ffe698..ef3e68d1059c 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> @@ -331,6 +331,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_=
sd8786 =3D {
> =C2=A0	.can_dump_fw =3D false,
> =C2=A0	.can_auto_tdls =3D false,
> =C2=A0	.can_ext_scan =3D false,
> +	.fw_ready_extra_delay =3D false,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 =3D {
> @@ -346,6 +347,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_=
sd8787 =3D {
> =C2=A0	.can_dump_fw =3D false,
> =C2=A0	.can_auto_tdls =3D false,
> =C2=A0	.can_ext_scan =3D true,
> +	.fw_ready_extra_delay =3D false,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 =3D {
> @@ -361,6 +363,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_=
sd8797 =3D {
> =C2=A0	.can_dump_fw =3D false,
> =C2=A0	.can_auto_tdls =3D false,
> =C2=A0	.can_ext_scan =3D true,
> +	.fw_ready_extra_delay =3D false,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 =3D {
> @@ -376,6 +379,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_=
sd8897 =3D {
> =C2=A0	.can_dump_fw =3D true,
> =C2=A0	.can_auto_tdls =3D false,
> =C2=A0	.can_ext_scan =3D true,
> +	.fw_ready_extra_delay =3D false,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 =3D {
> @@ -392,6 +396,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_=
sd8977 =3D {
> =C2=A0	.fw_dump_enh =3D true,
> =C2=A0	.can_auto_tdls =3D false,
> =C2=A0	.can_ext_scan =3D true,
> +	.fw_ready_extra_delay =3D false,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 =3D {
> @@ -408,6 +413,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_=
sd8978 =3D {
> =C2=A0	.fw_dump_enh =3D true,
> =C2=A0	.can_auto_tdls =3D false,
> =C2=A0	.can_ext_scan =3D true,
> +	.fw_ready_extra_delay =3D true,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 =3D {
> @@ -425,6 +431,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_=
sd8997 =3D {
> =C2=A0	.fw_dump_enh =3D true,
> =C2=A0	.can_auto_tdls =3D false,
> =C2=A0	.can_ext_scan =3D true,
> +	.fw_ready_extra_delay =3D false,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 =3D {
> @@ -440,6 +447,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_=
sd8887 =3D {
> =C2=A0	.can_dump_fw =3D false,
> =C2=A0	.can_auto_tdls =3D true,
> =C2=A0	.can_ext_scan =3D true,
> +	.fw_ready_extra_delay =3D false,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 =3D {
> @@ -456,6 +464,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_=
sd8987 =3D {
> =C2=A0	.fw_dump_enh =3D true,
> =C2=A0	.can_auto_tdls =3D true,
> =C2=A0	.can_ext_scan =3D true,
> +	.fw_ready_extra_delay =3D false,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 =3D {
> @@ -471,6 +480,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_=
sd8801 =3D {
> =C2=A0	.can_dump_fw =3D false,
> =C2=A0	.can_auto_tdls =3D false,
> =C2=A0	.can_ext_scan =3D true,
> +	.fw_ready_extra_delay =3D false,
> =C2=A0};
> =C2=A0
> =C2=A0static struct memory_type_mapping generic_mem_type_map[] =3D {
> @@ -563,6 +573,7 @@ mwifiex_sdio_probe(struct sdio_func *func, const stru=
ct sdio_device_id *id)
> =C2=A0		card->fw_dump_enh =3D data->fw_dump_enh;
> =C2=A0		card->can_auto_tdls =3D data->can_auto_tdls;
> =C2=A0		card->can_ext_scan =3D data->can_ext_scan;
> +		card->fw_ready_extra_delay =3D data->fw_ready_extra_delay;
> =C2=A0		INIT_WORK(&card->work, mwifiex_sdio_work);
> =C2=A0	}
> =C2=A0
> @@ -766,6 +777,7 @@ mwifiex_sdio_read_fw_status(struct mwifiex_adapter *a=
dapter, u16 *dat)
> =C2=A0static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
> =C2=A0				=C2=A0=C2=A0 u32 poll_num)
> =C2=A0{
> +	struct sdio_mmc_card *card =3D adapter->card;
> =C2=A0	int ret =3D 0;
> =C2=A0	u16 firmware_stat;
> =C2=A0	u32 tries;
> @@ -783,6 +795,13 @@ static int mwifiex_check_fw_status(struct mwifiex_ad=
apter *adapter,
> =C2=A0		ret =3D -1;
> =C2=A0	}
> =C2=A0
> +	if (card->fw_ready_extra_delay &&
> +	=C2=A0=C2=A0=C2=A0 firmware_stat =3D=3D FIRMWARE_READY_SDIO)
> +		/* firmware might pretend to be ready, when it's not.
> +		 * Wait a little bit more as a workaround.
> +		 */
> +		msleep(100);
> +
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wi=
reless/marvell/mwifiex/sdio.h
> index b86a9263a6a8..cb63ad55d675 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.h
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
> @@ -255,6 +255,7 @@ struct sdio_mmc_card {
> =C2=A0	bool fw_dump_enh;
> =C2=A0	bool can_auto_tdls;
> =C2=A0	bool can_ext_scan;
> +	bool fw_ready_extra_delay;
> =C2=A0
> =C2=A0	struct mwifiex_sdio_mpa_tx mpa_tx;
> =C2=A0	struct mwifiex_sdio_mpa_rx mpa_rx;
> @@ -278,6 +279,7 @@ struct mwifiex_sdio_device {
> =C2=A0	bool fw_dump_enh;
> =C2=A0	bool can_auto_tdls;
> =C2=A0	bool can_ext_scan;
> +	bool fw_ready_extra_delay;
> =C2=A0};
> =C2=A0
> =C2=A0/*
>=20
> base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c

