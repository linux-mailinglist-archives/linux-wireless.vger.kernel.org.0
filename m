Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602B73DFD09
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 10:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhHDIgC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 04:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236493AbhHDIgB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 04:36:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DA4560F43;
        Wed,  4 Aug 2021 08:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628066149;
        bh=muTWgcFJLnLXzIosEs5tdTY/jGxKmJvIwmLNkrSK/gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kNlTmd20IZnrkMP0Vz/yHd1XsRMuCAQw19C0GmzKejR96pkJQEOaFklYzIyCE4Dj3
         lZ+M8CrBsTEQb1ir1JfkJqn8ZccZIiuDQiGIB07Cq8PWxNbCk6Qn7W7fCI7e238uN1
         gwAJamNxMT1V3KoGvSvg1cEEmGY3SNnYY9ua6PlGrk+M4MFMuVCmMzs+vnDr/Pz85D
         x8CguSgvxP5gHzwkFU7wh7doTPPuY1WDIHXfZDOz4qlHA0bQgGL7Ha8P2Clzfa2Ot8
         tFYPUHQmCsIrfJdwg/3cJJBbbIPpCAlhGD2LxES4aHUtHfqh6Ux2BztBd1/6BAbR3u
         8A6IgYF6Kf0FQ==
Date:   Wed, 4 Aug 2021 10:35:44 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: Re: [PATCH mac80211-next 7/7] mt76: mt7915: add twt_stats knob in
 debugfs
Message-ID: <YQpRYH3AuzAHQwq3@lore-desk>
References: <cover.1628062233.git.lorenzo@kernel.org>
 <c15deb39ada1d7f642a7cf7bf21a60e84dde240d.1628062233.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ric8hidzDizXyMIJ"
Content-Disposition: inline
In-Reply-To: <c15deb39ada1d7f642a7cf7bf21a60e84dde240d.1628062233.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ric8hidzDizXyMIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Introduce twt_stats knob in debugfs in order to dump established
> agreements
>=20
> Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../wireless/mediatek/mt76/mt7915/debugfs.c   | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index 1a48b09d0cb7..5ed329f720d6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -335,6 +335,32 @@ mt7915_read_rate_txpower(struct seq_file *s, void *d=
ata)
>  	return 0;
>  }
> =20
> +static int
> +mt7915_twt_stats(struct seq_file *s, void *data)
> +{
> +	struct mt7915_dev *dev =3D dev_get_drvdata(s->private);
> +	struct mt7915_twt_flow *iter;
> +
> +	rcu_read_lock();
> +
> +	seq_puts(s, "     wcid |       id |    flags |      exp | mantissa");
> +	seq_puts(s, " | duration |            tsf |\n");
> +	list_for_each_entry_rcu(iter, &dev->twt_list, list)
> +		seq_printf(s,
> +			"%9d | %8d | %5c%c%c%c | %8d | %8d | %8d | %14lld |\n",
> +			iter->wcid, iter->id,
> +			iter->sched ? 's' : 'u',
> +			iter->protection ? 'p' : '-',
> +			iter->trigger ? 't' : '-',
> +			iter->flowtype ? '-' : 'a',
> +			iter->exp, iter->mantissa,
> +			iter->duration, iter->tsf);
> +
> +	rcu_read_lock();

ops, there is a typo here, I will fix it in v2. I will wait for some feedba=
cks
on v1 first.

Regards,
Lorenzo

> +
> +	return 0;
> +}
> +
>  int mt7915_init_debugfs(struct mt7915_dev *dev)
>  {
>  	struct dentry *dir;
> @@ -352,6 +378,8 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
>  	debugfs_create_file("implicit_txbf", 0600, dir, dev,
>  			    &fops_implicit_txbf);
>  	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
> +	debugfs_create_devm_seqfile(dev->mt76.dev, "twt_stats", dir,
> +				    mt7915_twt_stats);
>  	/* test knobs */
>  	debugfs_create_file("radar_trigger", 0200, dir, dev,
>  			    &fops_radar_trigger);
> --=20
> 2.31.1
>=20

--ric8hidzDizXyMIJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYQpRXgAKCRA6cBh0uS2t
rOtQAQCVPQEnHq9JyMUWRFZ/pzZ2jLI3T3zZpmpTzSKMR3coSwEAw4ysMI+LmEKv
yGNYcNtO1KWVRzBZAjCPXs3mWu7HTQE=
=P8VX
-----END PGP SIGNATURE-----

--ric8hidzDizXyMIJ--
