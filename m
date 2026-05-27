Return-Path: <linux-wireless+bounces-37015-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFCpKVcZF2pR4QcAu9opvQ
	(envelope-from <linux-wireless+bounces-37015-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 18:18:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F155E79E4
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 18:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AAE530078DE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC1B3E7BDF;
	Wed, 27 May 2026 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y14VKAI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48133E3C7A
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898376; cv=none; b=Y76mABtpFdxlBT5zJZSqLpegZn3uD2HCKRE56WvHIuc42goSZBBhhmsc66HJzZCcCplt6sYhJQXlIBccaMc2jOE5t3n+S1L8vWWjxKZOiw9/WQwJkJs/RnjHALz1MrRJR8WHqv6FFPgPFz9DKseprdJh+agg3Yv96mRVzUm1f1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898376; c=relaxed/simple;
	bh=ClNdLpwYAlOi0mAXzSPeOQJ9B677z6apEQsuLegOMTw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mXDVgI/zK8SQ0lSebjcbTKnJgfAlZXOIcKdileak/Ys2wWKke5WPHvpA/RT1j8nMoq+GOowAO8ZjtKio0g3G/COQaBaz/XG8Pglsf6VwZ+B0SY26WRELhppOQGph3OhNuh1LbdfJLrxnc2fTidC1Xu5d77LFA4fSstc7Gkwgq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y14VKAI+; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914bfa75911so581352385a.1
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779898374; x=1780503174; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCF93p0pPbudh0wfYlc1I9a7H3qyspnUPz7c6ldVCIo=;
        b=Y14VKAI+izlZfQdu5hG374LE1Z/3yItZhME2wuGPIFpSy/vTvYC57uVJ3ilpLDHwUq
         qH2AP6glrnfYECeZ/Tc4mJ9XTn/6c/dxGRaN0nAoZmMoJXHl04RuOPJ9huQsJDgPJWu7
         FySconMt3EXZXYPZjIpch3hwtjkqXVr+le8DLl+mdkAyQeAGJrXCh6kb+KIceSeZ0L4V
         clyRJdJnz+4pMB8eSFVv+OhEAWG2B8CELPdrspiKALQhDedwfiCB+JwMzdnAK6yypHAl
         8foZ4qAZMhQBsl2Ipf85WMWwUC6Ke5yS85iezRGvH8iMlO2pmymDqx8wFV6m9jBS0TZp
         ZrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779898374; x=1780503174;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gCF93p0pPbudh0wfYlc1I9a7H3qyspnUPz7c6ldVCIo=;
        b=NzFpg9PvCLBE7RaQxZzBlp8h0HiPhqQXWndCHTUJJfLpjuajoHs/2PAYJ4EZmoATBY
         6M5CiONCCfDpHmoppn+5BAJPP+6MXHwCGGaLy5akQpTPpuxKPuA/5pXFpH6R9+eX4xF9
         9ykNq5AqACYtnfWm+TikUXER2635XtOfVeGX+B73S4ziGk8qHuBTxmU1LbCo78n+OIUx
         YLlmgZXC7Tfe81Qgbf65BDfLrUyoZNygRSi4cExyEw9SgZY/uhFIp2btOKrEYQw8trrE
         jNU/8MoTAMZe6kk0VMk7BKq0JtkRU2KaMgb2W+TZuCLLammI7iuLosiJeVwb0zJ8N4li
         az4w==
X-Gm-Message-State: AOJu0YwsMD/ODurhI2Y8MRFBKTgpGjhmxirrXV2RaaBtKJbO7Ocg040J
	WcWXbcCNhORMo/HMEXDUDG7thptn9DDtvMsgeMSHgFigkSiYREH27jap
X-Gm-Gg: Acq92OGCUfYZbLwc7PHsVd5TrEtFfARPYKZ7xw86t18/97mj3zlkP8qaxOOM8hV3Ldj
	rzsYievSL75A5TrraUp577BkNvT4a1FDs0KxAjoOGCbQHfvjkpLtlBFoF2GHGsvYa7it3C8Kq9g
	eCV7emLxWy9rpBQY3K1a9oVnu6bwYZUZ6nyRH6cQlDBht3uxxKeB7f86UPypqUt9CiJXzO+i3Hp
	wu1bf8M08xLwBIOZ4EbmMMr44tqXuiPjwcCAYona6CfT1FcxckWZKEohyoUExTgANSVDYyXsUbE
	zhIvZtLHbrQs/4fejhqdlXgO1Xz+AtD3PNEXaxLDKTIfn6DOw0UHJQYeSV9+NMVsm4l8RrZE1K4
	IE8jl/AENiN9d7W/jm9uibEpjxRRn+xN9Ef4o3F8/cND90WXeoCqPn1btNXAo+qXGEoGFO2wcoe
	ECF1iuzZyc/48F31zU/eRmVPehJoqcA1Hp1UueSbv3ElHhrhs4IDEU5yjgp5FbNHBytYfaGsngy
	YWogSe3jnu7dN4gdcr3cA7fITsdZcOomes5p3gcspk25HWFamnSG1LL5x9oCQ==
X-Received: by 2002:a05:620a:454b:b0:911:fba0:6d02 with SMTP id af79cd13be357-914b510b65dmr2927962085a.22.1779898373714;
        Wed, 27 May 2026 09:12:53 -0700 (PDT)
Received: from smtpclient.apple ([2601:19b:4200:392f:e976:246b:e928:1bf7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87d26basm515826085a.24.2026.05.27.09.12.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2026 09:12:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 1/1] wifi: ath12k: support calibration-variant from device
 tree
From: Andrew LaMarche <andrewjlamarche@gmail.com>
In-Reply-To: <20260131003222.2011259-1-andrewjlamarche@gmail.com>
Date: Wed, 27 May 2026 12:12:41 -0400
Cc: linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2E3AAE1-1A80-4265-9497-0C95C3308CD7@gmail.com>
References: <20260131003222.2011259-1-andrewjlamarche@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37015-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrewjlamarche@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 06F155E79E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

A kind ping here. I=E2=80=99m not sure why this functionality is missing =
in the first place, but it is needed for loading caldata from the device =
tree.

Cheers,
Andrew

> On Jan 30, 2026, at 7:32=E2=80=AFPM, Andrew LaMarche =
<andrewjlamarche@gmail.com> wrote:
>=20
> ath10k and ath11k support reading calibration variants from the device
> tree to locate the correct Board Description File (BDF). The =
ath12k-wsi
> binding already describes using qcom,calibration-variant and
> qcom,ath12k-calibration-variant, but it is not implemented in the =
code.
>=20
> Many ath12k designs expose all the radios under a single phy, each of
> which typically require a separate BDF. Without this, the radios may =
not
> come up or will not be calibrated correctly.
>=20
> Fix this by parsing the device tree for the generation-agnostic
> qcom,calibration-variant node or ath12k-specific
> qcom,ath12k-calibration-variant node. This allows the driver to =
properly
> select, read and apply the correct BDF.
>=20
> Signed-off-by: Andrew LaMarche <andrewjlamarche@gmail.com>
> ---
> drivers/net/wireless/ath/ath12k/core.c | 25 +++++++++++++++++++++++++
> drivers/net/wireless/ath/ath12k/core.h |  2 +-
> drivers/net/wireless/ath/ath12k/qmi.c  |  4 ++++
> 3 files changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/ath/ath12k/core.c =
b/drivers/net/wireless/ath/ath12k/core.c
> index cc352eef1939..e45f76d81337 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -806,6 +806,31 @@ int ath12k_core_check_smbios(struct ath12k_base =
*ab)
> 	return 0;
> }
>=20
> +int ath12k_core_check_dt(struct ath12k_base *ab)
> +{
> +	size_t max_len =3D sizeof(ab->qmi.target.bdf_ext);
> +	const char *variant =3D NULL;
> +	struct device_node *node;
> +
> +	node =3D ab->dev->of_node;
> +	if (!node)
> +		return -ENOENT;
> +
> +	of_property_read_string(node, "qcom,calibration-variant",
> +			&variant);
> +	if (!variant)
> +		of_property_read_string(node, =
"qcom,ath12k-calibration-variant",
> +				&variant);
> +	if (!variant)
> +		return -ENODATA;
> +
> +	if (strscpy(ab->qmi.target.bdf_ext, variant, max_len) < 0)
> +		ath12k_dbg(ab, ATH12K_DBG_BOOT,
> +				"bdf variant string is longer than the =
buffer can accommodate (variant: %s)\n", variant);
> +
> +	return 0;
> +}
> +
> static int ath12k_core_soc_create(struct ath12k_base *ab)
> {
> 	int ret;
> diff --git a/drivers/net/wireless/ath/ath12k/core.h =
b/drivers/net/wireless/ath/ath12k/core.h
> index 3c1e0069be1e..39700a780ee2 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -1352,7 +1352,7 @@ int ath12k_core_fetch_bdf(struct ath12k_base =
*ath12k,
> 			  struct ath12k_board_data *bd);
> void ath12k_core_free_bdf(struct ath12k_base *ab, struct =
ath12k_board_data *bd);
> int ath12k_core_fetch_regdb(struct ath12k_base *ab, struct =
ath12k_board_data *bd);
> -int ath12k_core_check_dt(struct ath12k_base *ath12k);
> +int ath12k_core_check_dt(struct ath12k_base *ab);
> int ath12k_core_check_smbios(struct ath12k_base *ab);
> void ath12k_core_halt(struct ath12k *ar);
> int ath12k_core_resume_early(struct ath12k_base *ab);
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c =
b/drivers/net/wireless/ath/ath12k/qmi.c
> index b7c48b6706df..22ef5aab871f 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.c
> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
> @@ -2903,6 +2903,10 @@ int ath12k_qmi_request_target_cap(struct =
ath12k_base *ab)
> 	if (r)
> 		ath12k_dbg(ab, ATH12K_DBG_QMI, "SMBIOS bdf variant name =
not set.\n");
>=20
> +	r =3D ath12k_core_check_dt(ab);
> +	if (r)
> +		ath12k_dbg(ab, ATH12K_DBG_QMI, "DT bdf variant name not =
set.\n");
> +
> 	r =3D ath12k_acpi_start(ab);
> 	if (r)
> 		/* ACPI is optional so continue in case of an error */
> --=20
> 2.43.0
>=20


