Return-Path: <linux-wireless+bounces-34880-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO35Ecu04Gn5kwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34880-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 12:07:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB240CB4A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 12:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F90E3050202
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0778C39DBFE;
	Thu, 16 Apr 2026 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="kzPX/LYQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84E395257
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333979; cv=none; b=pn338rQuugjuj2iqm1eMG9KS4vvpoLOfZJPxrsbYJa1CwC1aR2ssNXk+bgN+smOe5ZJWK1DIpC9kicr8/3OOkG/g9yv1KY64kGtDkEkW/4PkYr+JroLreQWUYpSe1RnEZVPJI3aLI38I1CJeTk98jIcHeya9kuIKZa0LvRBWGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333979; c=relaxed/simple;
	bh=TRTbSHQMURjU0ZW+9bSmpSmU4dNIK7D4YlFMBvnDA7w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TrGN2np/WCZ5gAhE+tbsqsXpx66BGQ7m7Wq1r7/b2MOj/39Y+g3THalx+Tqyl7WAlfKqw9kBsPTa68A3o8CxFpS7O5dQ4ApNnyW+yMrY5qBnbcYclVA/66vIbeRorr39T4scRbjeErll0hVT6A8EJ//CG7TGHkp8WLu5qAUdPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=kzPX/LYQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6716a2d9596so6728749a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1776333976; x=1776938776; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StUmw+VWigYj7b9CbzCzolN8uC+xmf43R5kKEaP2dK4=;
        b=kzPX/LYQ7y4Em+5vweuPtbDVXDcoj3YiojA1EIvviwOb9DAfGlxBFgYuW0pUQr84F7
         o3C2dIlrz9fvBp/prcIwvOOsh5tJ+WHEVOCqXz3ITsX9ZGDDf3F0/hgcVVOjJS6rTvW5
         TR/v39UwUsDGxg8Gm/VS9YgP283HLqywpv2g7Qmh8ul1teNUy9fMVk379o2Maq4hgeKZ
         Mt9Q5acvzcEKbEBTvfEHV6jZiBMpMonajIaSSdLLz8e4c9pmUFCivqqrXN3EnyytrJYt
         iHTj82htSnT0m1K8P7M6h5r9aOcIQ7qc8fGh7LqZrwMWA6jumfV+Bg+7/lDo46khGJsl
         Y+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776333976; x=1776938776;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StUmw+VWigYj7b9CbzCzolN8uC+xmf43R5kKEaP2dK4=;
        b=J5BMaSSBdXIDFqxoKfBqkuMMx3VgdB3mbAV/bZI/6cyHqF6K9s7fYLXYGeEZ4gbzzt
         f27ELbNL/DQmKgnA2VWNz9Ls0qgqHrFfp2J3D8gY9XdP+YbnTzuBbTkvdAYt/ucb8fWe
         srPhlZleIjUYeFhwDbC/tGdYMQ4s83WTK4ioe2kQfJo3sOZvKxR6iry2OTIVE2xpH3gG
         uKX6yg8JTLFAVuZrhsUeWdS1M0p6gw4aUGQKfkNnnpNLpxfjbxZDu7dYzRlmnICiRWHi
         ZRycH93AysxhKSMtHLC83oZ2mfDpnnZNXRr/tc75eS/4dh9cWpUOfVg3i6SW0n+6QK5i
         FMKg==
X-Forwarded-Encrypted: i=1; AFNElJ/RT5LURpSbzwrk7IBu2OEeBVdVIBPTmPT5pqLIokiCDdNAHEbteBALPsC/NGFBLlMVqAJWtxbdyA3WfICkTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSof0Jyjrt8Z7Fvue4HRLs57QqJ4bPCN9rDdGdkArGEG43FnbE
	cZupc47GnpXnvqhaid3qvC12uLA25Qd5oCWiWmediMigqpfdUg5sgjDBkU8o2o5j38Q=
X-Gm-Gg: AeBDiesGkoyMwLkCtMNeHzuyvpjquKaZJ0fQ90QXpftGfUa6mTlZ+/xGCtAIHfQ8KST
	bLW7VO8jPKQkUY5mTNQhS2OK5yt7gb0Gjg4u9MhewxGKBNQkR6APnxTq2BkQASR7M4jnwTW65Ek
	nOpxqMvipgTtcqlSrNGqBeNhqIpDC373JXAkgUYr66sWg472urgHof982if/hPYf+LugmqQCldK
	48q0sU/estTNBS2SgBxy1MbYhYOVlUi4Aze7eUX1afQKBf/Q7dplna2kV+e362n6hChItsrk6I4
	gSAYSFW229EHq5KloCRrdrhW/Z6CFo4L+PXcDdDEvzfFM9o/72XyuvigAixuShTbY0Hwd12lXqt
	C5X+nWE+1ECH00ocek2mrsHU1Brje0KdSBU3h4jDMoV8ilxpBYhz1cIzsd4CpqZyHVC6zdhkpDm
	RDRdMyA/Y5n/9qx70nulI2jcybzqMKLF/CwBSIdT4lsrkL5Y1a180QKeZz9vq805TZXAM8pstcF
	wHizP0=
X-Received: by 2002:a05:6402:548c:b0:66e:f4c0:c348 with SMTP id 4fb4d7f45d1cf-6707898ffc1mr11228460a12.7.1776333975499;
        Thu, 16 Apr 2026 03:06:15 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67237d79258sm1152533a12.4.2026.04.16.03.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 03:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 12:06:09 +0200
Message-Id: <DHUHU7UIT487.139L3KIVRVREU@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
 <linux-pm@vger.kernel.org>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/8] wifi: ath10k: snoc: support powering on the
 device via pwrseq
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>,
 "Marcel Holtmann" <marcel@holtmann.org>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "Jeff Johnson" <jjohnson@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Vinod
 Koul" <vkoul@kernel.org>, "Balakrishna Godavarthi"
 <quic_bgodavar@quicinc.com>, "Matthias Kaehlcke" <mka@chromium.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
In-Reply-To: <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34880-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,kernel.org,holtmann.org,quicinc.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[fairphone.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: C1EB240CB4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dmitry,

On Mon Jan 19, 2026 at 6:07 PM CET, Dmitry Baryshkov wrote:
> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> voltages over internal rails. Implement support for using powersequencer
> for this family of ATH10k devices in addition to using regulators.
>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 53 ++++++++++++++++++++++++++++=
++++--
>  drivers/net/wireless/ath/ath10k/snoc.h |  3 ++
>  2 files changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireles=
s/ath/ath10k/snoc.c
> index b3f6424c17d3..f72f236fb9eb 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: ISC
>  /*
>   * Copyright (c) 2018 The Linux Foundation. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
> =20
>  #include <linux/bits.h>
> @@ -11,6 +12,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> +#include <linux/pwrseq/consumer.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc/qcom_rproc.h>
>  #include <linux/of_reserved_mem.h>
> @@ -1023,10 +1025,14 @@ static int ath10k_hw_power_on(struct ath10k *ar)
> =20
>  	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
> =20
> -	ret =3D regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
> +	ret =3D pwrseq_power_on(ar_snoc->pwrseq);
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
> +	if (ret)
> +		goto pwrseq_off;
> +
>  	ret =3D clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
>  	if (ret)
>  		goto vreg_off;
> @@ -1035,18 +1041,28 @@ static int ath10k_hw_power_on(struct ath10k *ar)
> =20
>  vreg_off:
>  	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
> +pwrseq_off:
> +	pwrseq_power_off(ar_snoc->pwrseq);
> +
>  	return ret;
>  }
> =20
>  static int ath10k_hw_power_off(struct ath10k *ar)
>  {
>  	struct ath10k_snoc *ar_snoc =3D ath10k_snoc_priv(ar);
> +	int ret_seq =3D 0;
> +	int ret_vreg;
> =20
>  	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power off\n");
> =20
>  	clk_bulk_disable_unprepare(ar_snoc->num_clks, ar_snoc->clks);
> =20
> -	return regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
> +	ret_vreg =3D regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs)=
;
> +
> +	if (ar_snoc->pwrseq)
> +		ret_seq =3D pwrseq_power_off(ar_snoc->pwrseq);
> +
> +	return ret_vreg ? : ret_seq;
>  }
> =20
>  static void ath10k_snoc_wlan_disable(struct ath10k *ar)
> @@ -1762,7 +1778,38 @@ static int ath10k_snoc_probe(struct platform_devic=
e *pdev)
>  		goto err_release_resource;
>  	}
> =20
> -	ar_snoc->num_vregs =3D ARRAY_SIZE(ath10k_regulators);
> +	/*
> +	 * devm_pwrseq_get() can return -EPROBE_DEFER in two cases:
> +	 * - it is not supposed to be used
> +	 * - it is supposed to be used, but the driver hasn't probed yet.
> +	 *
> +	 * There is no simple way to distinguish between these two cases, but:
> +	 * - if it is not supposed to be used, then regulator_bulk_get() will
> +	 *   return all regulators as expected, continuing the probe
> +	 * - if it is supposed to be used, but wasn't probed yet, we will get
> +	 *   -EPROBE_DEFER from regulator_bulk_get() too.
> +	 *
> +	 * For backwards compatibility with DTs specifying regulators directly
> +	 * rather than using the PMU device, ignore the defer error from
> +	 * pwrseq.
> +	 */
> +	ar_snoc->pwrseq =3D devm_pwrseq_get(&pdev->dev, "wlan");
> +	if (IS_ERR(ar_snoc->pwrseq)) {
> +		ret =3D PTR_ERR(ar_snoc->pwrseq);
> +		ar_snoc->pwrseq =3D NULL;
> +		if (ret !=3D -EPROBE_DEFER)
> +			goto err_free_irq;

I'm fairly sure this is now broken with CONFIG_POWER_SEQUENCING=3Dn since
then pwrseq_get() is returning ERR_PTR(-ENOSYS) which is not handled
here.

I'm observing my ath10k_snoc is now failing to probe "with error -38"
which definitely seems to be related, but I haven't debugged it further
yet.

Regards
Luca

