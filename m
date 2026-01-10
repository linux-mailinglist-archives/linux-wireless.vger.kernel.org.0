Return-Path: <linux-wireless+bounces-30631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF4ED0D530
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 12:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF4853015153
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 11:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2561333DECD;
	Sat, 10 Jan 2026 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNm1ZBhX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886233D6EA;
	Sat, 10 Jan 2026 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768043986; cv=none; b=pTK6vuEss50K/NdMnVCSLlu9sXTtzkplmZMWvp5r9UGcpDIvgy436R53vCXBM+iscmbo1DMT5Yhi8+VVN49/glsDJLP2I5v8e0Zpb0SLryJEk/JjBlbv98R6P7tZ5ncRQ40wwgLge85fmxardToMWx3pxINBcvOk+blF2noI4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768043986; c=relaxed/simple;
	bh=Fo+c18Xe2tfWUtdNEYdFNt+2/i05dN2dynXzKW1h+gk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VZrJfDZLvUmwCSPluwZivE/5QGsePVVi59hLwbZmek3/8o4dZGrIeR4rk8qpaNmgpFICkQBR/wAZYFRJ7b9wMNtvH9oZb38LvhHp2m2WZP4UqwxmDrLrLHa9b1DeBMT5NpfCz/U3dDqfy4lWXbJzvDgEvz7lxWzUOHNB3HaL+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNm1ZBhX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768043984; x=1799579984;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Fo+c18Xe2tfWUtdNEYdFNt+2/i05dN2dynXzKW1h+gk=;
  b=kNm1ZBhX7sn8i9y0jCS313l6sEMCAn7jdz8SYn+EGR0Bu1lGASFjyT2Z
   lJ95CblNjvso/yC3YpYjrFWrarcESpeVjrcSyueMTNQlj1BettJIR4Tgt
   KfgPYTPjQNSAUYaIHNVOq1n6uURANFedkdSzJsTeX8UPFvdnmlmlY8VkK
   bF6sOtnnHHLt16nh6Tt6AkEMdrB6MbwzxxL0LlqVmZtafz/P0frlx2PU4
   FXqRWx2NsVJ3rOcoyVBCDQoKNkD5Xot6hb/A6YTy2uHeymTcnbsG/HWPJ
   oy1Rz2K3TKFeBKZubCF0ipQgTM3F+hM8CLP8/vChdsqlrl08SJfLngCPP
   g==;
X-CSE-ConnectionGUID: 1LD2SOpnQluw0LTjv23x2g==
X-CSE-MsgGUID: +TjLMK6nS5GesC7dWBsCzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69558905"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="69558905"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2026 03:19:42 -0800
X-CSE-ConnectionGUID: SN3I9PJbST+nPQa1VKqNxw==
X-CSE-MsgGUID: rbP7RPyoSeSgZrQrabMSJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="234890814"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.227])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2026 03:19:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sat, 10 Jan 2026 13:19:31 +0200 (EET)
To: =?ISO-8859-15?Q?J=E9r=F4me_de_Bretagne?= <jerome.debretagne@gmail.com>
cc: Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Johannes Berg <johannes@sipsolutions.net>, 
    Lorenzo Bianconi <lorenzo@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
    Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    ath12k@lists.infradead.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
    Dale Whinham <daleyo@gmail.com>, 
    Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v6 3/4] platform/surface: aggregator_registry: Add Surface
 Pro 11 (QCOM)
In-Reply-To: <20251220-surface-sp11-for-next-v6-3-81f7451edb77@gmail.com>
Message-ID: <17f18028-730f-9e9f-7df5-8b792fe6c9c5@linux.intel.com>
References: <20251220-surface-sp11-for-next-v6-0-81f7451edb77@gmail.com> <20251220-surface-sp11-for-next-v6-3-81f7451edb77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-495146878-1768043971=:1002"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-495146878-1768043971=:1002
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 20 Dec 2025, J=C3=A9r=C3=B4me de Bretagne via B4 Relay wrote:

> From: Dale Whinham <daleyo@gmail.com>
>=20
> This enables support for the Qualcomm-based Surface Pro 11.
>=20
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/platform/surface/surface_aggregator_registry.c | 18 ++++++++++++=
++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/dri=
vers/platform/surface/surface_aggregator_registry.c
> index 78ac3a8fbb736384f7e50f1888a71297a892a7c3..0599d5adf02e61583cf3e1fc1=
1000070f51f7be3 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -406,6 +406,22 @@ static const struct software_node *ssam_node_group_s=
p9_5g[] =3D {
>  =09NULL,
>  };
> =20
> +/* Devices for Surface Pro 11 (ARM/QCOM) */
> +static const struct software_node *ssam_node_group_sp11[] =3D {
> +=09&ssam_node_root,
> +=09&ssam_node_hub_kip,
> +=09&ssam_node_bat_ac,
> +=09&ssam_node_bat_main,
> +=09&ssam_node_tmp_sensors,
> +=09&ssam_node_hid_kip_keyboard,
> +=09&ssam_node_hid_kip_penstash,
> +=09&ssam_node_hid_kip_touchpad,
> +=09&ssam_node_hid_kip_fwupd,
> +=09&ssam_node_hid_sam_sensors,
> +=09&ssam_node_kip_tablet_switch,
> +=09NULL,
> +};
> +
>  /* -- SSAM platform/meta-hub driver. -----------------------------------=
----- */
> =20
>  static const struct acpi_device_id ssam_platform_hub_acpi_match[] =3D {
> @@ -482,6 +498,8 @@ MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_acpi_matc=
h);
>  static const struct of_device_id ssam_platform_hub_of_match[] __maybe_un=
used =3D {
>  =09/* Surface Pro 9 5G (ARM/QCOM) */
>  =09{ .compatible =3D "microsoft,arcata", (void *)ssam_node_group_sp9_5g =
},
> +=09/* Surface Pro 11 (ARM/QCOM) */
> +=09{ .compatible =3D "microsoft,denali", (void *)ssam_node_group_sp11 },
>  =09/* Surface Laptop 7 */
>  =09{ .compatible =3D "microsoft,romulus13", (void *)ssam_node_group_sl7 =
},
>  =09{ .compatible =3D "microsoft,romulus15", (void *)ssam_node_group_sl7 =
},

Applied PATCH 3/4 to the review-ilpo-next branch.

--=20
 i.

--8323328-495146878-1768043971=:1002--

