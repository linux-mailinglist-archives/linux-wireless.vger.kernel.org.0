Return-Path: <linux-wireless+bounces-30965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8A2D3AFD8
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 17:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6498D30A06A4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE48F38B99C;
	Mon, 19 Jan 2026 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbqoHLya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1438B997
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838209; cv=none; b=gBzb/hEPAD067SDMTKwbF330HdfLRGooSwQASM2DlZNu0YmeSs2XVp0rEE0+4DSGOg5MfnKtfByvtTlBjwRiYZN/OMk1gQtHa563hMIcCloQwmM0ntKrQfEhL23vP/vg81ZSV9MJ8qeXhQnNNGwG+kmFEueFwcW0QcDCmZaGW4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838209; c=relaxed/simple;
	bh=kmb0xz+cxH7bZ9ZsML6ZYz/AL5TRMq96zD1xbbV7jno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDBVpO8WDB+PKSdLl/BUj52NpTz2FjJRjHMmDKumql2iKRQ9gEQsiE8zaOYvlcRQIokELYqTHO+MrZ4ntDiBHAQR/4BcKIt+20+cphpKxCK44vGCtqx/UdtDSgjdRRNKBfhUs8R7CpYhj9/JnFjA/TcJLW2emnEikDMMDqYCNFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbqoHLya; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-793fdbb8d3aso4811017b3.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 07:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768838207; x=1769443007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFi+VJ96Lx+RhMsznMcBzo/7WtrXEjJe+WbuE10vlzM=;
        b=LbqoHLyasc57o6KtT0/H5E5//Xn4Hf5OSWzVk78CGBmY7QZX18ezlDb8QSYAXlEYGc
         fvC0yi7L8xhqiEa7ONU7ansM9mCaMndc9hN/v9jHRKkkuoWEE7mtoGZCJ4anx63c38mE
         UhgQji0nUPg5PDtfcTCAmu4dQ1Gp66O6ALHos6yBky71deqmxasfwSgkNFsGQ0tB5StV
         5mg3jUrD7Do8t6fZ4U7XRvKdE2i6bR2497SwBY6ZAs+qCBZbWnKEqHi6Ll/fM/mrYc2A
         mjZ0A/GbKPn43GgntLfy+T9kBFm148ewxXKr4SNQWro1eAIfGK7ep8Z9Vuj9m82oKhOV
         OJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768838207; x=1769443007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZFi+VJ96Lx+RhMsznMcBzo/7WtrXEjJe+WbuE10vlzM=;
        b=IRAGEgRGRkkBRj9Ecms70JL0w9G4BAYGkpybsO8IxFP7NhKzOkFeFzHjy5VtYyYF9V
         RWX7JUd1Q7V7UMu22cBYy9y7CCZlCL8knt7UqBVD5ovqsYGAKN/WRBwWLIaTApC+x60b
         lYnJ5D7D28YH/RwgObR8TcrT5+TtV8p95e+NGgqc0W7l7WMCyMYQE1HlRIFGHfbxQ5Bo
         yoaC0BqFxlYdnu+Lq4rlYbBI5wLLfvq4nwd9ZensC9MtF5fId4sk/+b2ouleQ/nGYyis
         JG6jOqVMH22t2mS5cr0+3mltwm3UELMvbEtnUPjzfJYmreFs2tBUabLZzdyYlfrbsXqn
         pAWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYVyk30zTNJ4l6yvSF2D2DWE2GCoCPro6dO2TRhfH5BUyicFCIWrCkpd+ECoGqdwKB+nHHAtq706Qv/sp2Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jQRL5uV44TqK8uvxbUFg8AFx8mBqJyVgaoRON68LAkxO5kCa
	eqrKsd1Bosm/ql7JCEuNxm9NrhOxQ3kCWzmmvTc6MAZCMGDNDAw9hK2V/Bow9j0/+fYD6pma0FM
	LDsDZ1BUi9v/st9Jo/4D2s3aZmBj+ez0=
X-Gm-Gg: AZuq6aLXVys1yMF2lGtpKWpHcM9n4UT+urxGhQzxJ76wfv+YjpiDS1n4XT5V3Sw1lEI
	OF6ozQ3wedZoV/mm5AD03hp5eb33DIriXGkwZilfl93nVVWFtisxuvx3ZT6BIrenCH0tC6UKVov
	3T6/zo8gZapcRh3lbDxpfQh0gYpaZQTdicsUZX3tyg/AwAMudtyz3t/lQqg2iOKxUpUsstyLAj2
	90nrM1ppyqTEGimkXThbnjr1J7xGkpx3ntD89Rb9gqr/dNE6os3x98minXzjH7yilgORw==
X-Received: by 2002:a05:690c:6d8b:b0:78c:32fc:d3c8 with SMTP id
 00721157ae682-793c54063b1mr84654397b3.61.1768838207073; Mon, 19 Jan 2026
 07:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119140238.3360658-1-miaoqing.pan@oss.qualcomm.com> <20260119140238.3360658-2-miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <20260119140238.3360658-2-miaoqing.pan@oss.qualcomm.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 19 Jan 2026 16:56:35 +0100
X-Gm-Features: AZwV_QjDpm8QDQgjkrGwqj8CMMa00N7wkcI94H42Z5svJe8pdQ2INMjNC6m63_4
Message-ID: <CAOiHx=nBLtSFNhuRZrHn5z8bCrA5nyuS9G8B0nh-WTiFU_HUMw@mail.gmail.com>
Subject: Re: [PATCH v3 ath-current 1/2] wifi: ath11k: add usecase firmware
 handling based on device compatible
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ath11k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 19, 2026 at 3:04=E2=80=AFPM Miaoqing Pan
<miaoqing.pan@oss.qualcomm.com> wrote:
>
> For M.2 WLAN chips, there is no suitable DTS node to specify the
> firmware-name property. In addition, assigning firmware for the
> M.2 PCIe interface causes chips that do not use usecase specific
> firmware to fail. Therefore, abandoning the approach of specifying
> firmware in DTS. As an alternative, propose a static lookup table
> mapping device compatible to firmware names. Currently, only WCN6855
> HW2.1 requires this.
>
> However, support for the firmware-name property is retained to keep
> the ABI backwards compatible.
>
> For details on usecase specific firmware, see:
> https://lore.kernel.org/all/20250522013444.1301330-3-miaoqing.pan@oss.qua=
lcomm.com/.
>
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ=
_IOE-1
>
> Fixes: edbbc647c4f3 ("wifi: ath11k: support usercase-specific firmware ov=
errides")
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 36 ++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h |  4 +++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireles=
s/ath/ath11k/core.c
> index de84906d1b27..1cf7f4e601c3 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1044,6 +1044,42 @@ static const struct dmi_system_id ath11k_pm_quirk_=
table[] =3D {
>         {}
>  };
>
> +static const struct __ath11k_core_usecase_firmware_table {
> +       u32 hw_rev;
> +       const char *compatible;
> +       const char *firmware_name;
> +} ath11k_core_usecase_firmware_table[] =3D {
> +       { ATH11K_HW_WCN6855_HW21, "qcom,lemans-evk", "nfa765"},
> +       { ATH11K_HW_WCN6855_HW21, "qcom,monaco-evk", "nfa765"},
> +       { ATH11K_HW_WCN6855_HW21, "qcom,hamoa-iot-evk", "nfa765"},
> +       { /* Sentinel */ }
> +};
> +
> +const char *ath11k_core_get_usecase_firmware(struct ath11k_base *ab)
> +{
> +       struct device_node *root __free(device_node) =3D of_find_node_by_=
path("/");
> +       const struct __ath11k_core_usecase_firmware_table *entry =3D NULL=
;
> +       int i, count =3D of_property_count_strings(root, "compatible");
> +       const char *compatible =3D NULL;
> +
> +       for (i =3D 0; i < count; i++) {
> +               if (of_property_read_string_index(root, "compatible", i,
> +                                                 &compatible) < 0)
> +                       continue;
> +
> +               entry =3D ath11k_core_usecase_firmware_table;
> +               while (entry->compatible) {
> +                       if (ab->hw_rev =3D=3D entry->hw_rev &&
> +                           !strcmp(entry->compatible, compatible))

You should be able to replace most of this code by using
of_machine_is_compatible(entry->compatible) instead.

> +                               return entry->firmware_name;
> +                       entry++;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +EXPORT_SYMBOL(ath11k_core_get_usecase_firmware);
> +
>  void ath11k_fw_stats_pdevs_free(struct list_head *head)
>  {

Best regards,
Jonas

