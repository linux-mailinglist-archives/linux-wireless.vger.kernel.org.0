Return-Path: <linux-wireless+bounces-23368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A4FAC2476
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 15:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131161885166
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D069D17E473;
	Fri, 23 May 2025 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQBrYFAs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9015290D8E;
	Fri, 23 May 2025 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748008111; cv=none; b=DJqr4MJanBx1qkzJXuI4QI2TgkV3NxWbmeTE+pVOeH+TtSqogExdCsk3UZ6DiaROyaeq620cIpAJuWOmr0t16tg/T4KWyde/uoife7G3hkleNMDAEeBVw/XK9Oq/mWE/ksmIK8L+wNlxwrxe2j8+wT/GqfgjtUj2yCM4lYvfNAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748008111; c=relaxed/simple;
	bh=5WZKHVX1SoX76iCdr9eUwSznmo4DZk0Nvw57g9VWXTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G2DZYjXXxdplUD1JWw6SaiOBaqpJuRx+p6ErmSpBB3+ugl0uq48vehkM/k3SW1NITzPFjY0O1eRx5TZ1kOP5pEaZYjsNTKSqPsd4ZOWLuL5XfPJAXj88wVJYLfJQa1MwQvqoczG7K6DpHW53kdLBgWcUeT7OAj/Kv+K+OuF+Ycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQBrYFAs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso71151595e9.2;
        Fri, 23 May 2025 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748008108; x=1748612908; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5WZKHVX1SoX76iCdr9eUwSznmo4DZk0Nvw57g9VWXTs=;
        b=hQBrYFAsJnrxOJ00xzBZplDWmDcAGA41v5QhnY1KaF2giV1jByL5lQpwc4SbRCtXqf
         EVQ9Bct+ROpq97pSoVXI3Jcr5PrbQEjEVAjVi5GKXpKxXgEIQJSgvhcw7RCRCN8/fboG
         fZ+f3Zl0ms43Ke/cImCaqTFlm2SdZTibqmnNUOsrjAjP8sg9wZO94660+jRvhf5jAL8i
         RJAyJYzVo3Yut53RjBst2KaYNsE6XsUJGMBkvlfCqebTq5b1tmd0F45PZ4rgxmuv322P
         nDewBkJQTUNn0hBxobOJVmwnQPuL7qhwLnvrHWXJGnIOXgRQAMex96hyFW++HqK9T6zg
         CF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748008108; x=1748612908;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WZKHVX1SoX76iCdr9eUwSznmo4DZk0Nvw57g9VWXTs=;
        b=uhSNkhCeOUfsaTxoetPRryOkgkRv0QIs45fIigw82HEJ+QhjxcrpenmUAebHRfgzQp
         BrbC/ryYQakgzTPzgGoPzbGRKT7hidpcDkwLnxqP2vgp2U4tr7u6Ad517ngypd2nbjCT
         9x70ek71u0qoN8OmnlbZJ4DGV+36K6+b02xKPb9E/YBlWoHevA5y3YZQhAdra7n+81Lb
         0b7qzOFQnOcjDMzWUTmvWH++XTUA3hPXLOwMBE04ldhAj6xPUht4+1WA80K6jxaQwP1T
         6C+PebAu7C72GVxC2b1AdjTgk8aZCeZQ8phDYA1Td5R8xZsFwTnXdaBsG6FlQ9K16ENo
         KfbA==
X-Forwarded-Encrypted: i=1; AJvYcCUu5wAYEiNDuJCCRlH0Q1trhwZCma+efhbCPqo3ZpG2nVbz7g6dw3no0/Z/Sm8siN4F/r4tHx6jF5JeD54=@vger.kernel.org, AJvYcCXbYt413P10umUn5wMKJm6UDNZ59QE3ZfV53wvw7AdIC9h3sBuhmyUZn8VmTq0yuPwGCfYD7WzioSzuDxXO/Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJ1Mr7DbHj98I+vJi91lCrOYY0AM6MimujB84+5LpwEsYQ7cN
	E8VUHHLiKYAP928GHeNptVFdcFNmVqwR3LMUebVcl4QPheEADuLzB6l39J9Bcfbl
X-Gm-Gg: ASbGncs71ULXKr2rHJf5gZOnCG4gcUxyoUp+G9QfI0a4a+dyarWP+zfzkxNmkjb/PpA
	JMJ0mdTGzjGOR7JDHTumza/SZUCgN6HKjNXkIngsyugJk9GKZBqZJq5JcgZw3zkpjILCPd9F+hh
	S6pP/qq5X01rXI/qeLTjq/wyOankhezNX+3dxb8GT5KWkYwZ6tgPqS+DziDJ8lN+OKJ7OZR+fWY
	uS8qaYiyGALX6FYJt46ZNLaU8VrsJ0VjId2u/b2tThrHD+iSMghWfT8SNeUHtoB052Y+TEpbX9A
	lUdukTEsGdw5ZIIHPhkSscZ3GNcSCLy03cUWfzNAOIzLd6yH3QmoiPmXfghmZH11l2fb1VYTMv7
	N1d/5Bk7nUqWDPdyLSuay6e9rvt9sXRQJaMOfW2e/eWykaV2QZS6L/YPDXq4z06Q=
X-Google-Smtp-Source: AGHT+IHCHWgzs6ok+9oUDkNDixpXJM3owBcKd/3Mx5okhrSd+/1j2ORV0V99xgFBPmR9KO9HsFGkBA==
X-Received: by 2002:a05:6000:188c:b0:3a3:79cb:8b14 with SMTP id ffacd0b85a97d-3a379cb8e37mr14344708f8f.33.1748008107615;
        Fri, 23 May 2025 06:48:27 -0700 (PDT)
Received: from dominikat-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3648baa6asm24418561f8f.91.2025.05.23.06.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:48:27 -0700 (PDT)
Message-ID: <91bc6f30004f80feb193a24292f841ee88d48504.camel@gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST
 definition for WCN7850
From: Parth Panchoil <parth105105@gmail.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>, Jeff Johnson
 <jjohnson@kernel.org>,  Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
 Wen Gong <quic_wgong@quicinc.com>, Vasanthakumar Thiagarajan
 <quic_vthiagar@quicinc.com>, Bhagavathi Perumal S
 <quic_bperumal@quicinc.com>,  P Praneesh <quic_ppranees@quicinc.com>
Cc: Sriram R <quic_srirrama@quicinc.com>, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org, Francesco Dolcini
	 <francesco@dolcini.it>
Date: Fri, 23 May 2025 15:48:26 +0200
In-Reply-To: <20250523-ath12k-wrong-global-reset-addr-v1-1-3b06eb556196@quicinc.com>
References: 
	<20250523-ath12k-wrong-global-reset-addr-v1-1-3b06eb556196@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks Baochen for the patch.=20

This patch fixes a bug in older kernels, so it should be backported.
Minor correction needed on the reported tag.
Tested on TI AM69 SK board with SX-PCEBE (WCN7850) Wi-Fi module and did
not observe the reported crash anymore.

Cc: stable@vger.kernel.org
Reported-by: Parth Pancholi <parth.pancholi@toradex.com>
Tested-by: Parth Pancholi <parth.pancholi@toradex.com>

Regards,
Parth P

> GCC_GCC_PCIE_HOT_RST is wrongly defined for WCN7850, causing kernel
> crash
> on some specific platforms.
>=20
> Since this register is divergent for WCN7850 and QCN9274, move it to
> register table to allow different definitions. Then correct the
> register
> address for WCN7850 to fix this issue.
>=20
> Note IPQ5332 is not affected as it is not PCIe based device.
>=20
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-
> QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>=20
> Reported-by: Parth Panchoil <parth105105@gmail.com>
> Closes:
> https://lore.kernel.org/all/86899b2235a59c9134603beebe08f2bb0b244ea0.came=
l@gmail.com
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7
> devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
> ---
> =C2=A0drivers/net/wireless/ath/ath12k/hw.c=C2=A0 | 6 ++++++
> =C2=A0drivers/net/wireless/ath/ath12k/hw.h=C2=A0 | 2 ++
> =C2=A0drivers/net/wireless/ath/ath12k/pci.c | 6 +++---
> =C2=A0drivers/net/wireless/ath/ath12k/pci.h | 4 +++-
> =C2=A04 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/ath/ath12k/hw.c
> b/drivers/net/wireless/ath/ath12k/hw.c
> index
> 7e2cf0fb2085ab014fc14a5c81074802674b154e..8254dc10b53bbfb54a44c7ff2f7
> 05c72461d1031 100644
> --- a/drivers/net/wireless/ath/ath12k/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> @@ -951,6 +951,8 @@ static const struct ath12k_hw_regs
> qcn9274_v1_regs =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hal_umac_ce0_dest_reg_ba=
se =3D 0x01b81000,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hal_umac_ce1_src_reg_bas=
e =3D 0x01b82000,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hal_umac_ce1_dest_reg_ba=
se =3D 0x01b83000,
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.gcc_gcc_pcie_hot_rst =3D 0x1e=
38338,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ath12k_hw_regs qcn9274_v2_regs =3D {
> @@ -1042,6 +1044,8 @@ static const struct ath12k_hw_regs
> qcn9274_v2_regs =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hal_umac_ce0_dest_reg_ba=
se =3D 0x01b81000,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hal_umac_ce1_src_reg_bas=
e =3D 0x01b82000,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hal_umac_ce1_dest_reg_ba=
se =3D 0x01b83000,
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.gcc_gcc_pcie_hot_rst =3D 0x1e=
38338,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ath12k_hw_regs ipq5332_regs =3D {
> @@ -1215,6 +1219,8 @@ static const struct ath12k_hw_regs wcn7850_regs
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hal_umac_ce0_dest_reg_ba=
se =3D 0x01b81000,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hal_umac_ce1_src_reg_bas=
e =3D 0x01b82000,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hal_umac_ce1_dest_reg_ba=
se =3D 0x01b83000,
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.gcc_gcc_pcie_hot_rst =3D 0x1e=
40304,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ath12k_hw_hal_params
> ath12k_hw_hal_params_qcn9274 =3D {
> diff --git a/drivers/net/wireless/ath/ath12k/hw.h
> b/drivers/net/wireless/ath/ath12k/hw.h
> index
> 0fbc17649df463334aa0ebb3da407115985335ca..0a75bc5abfa2410ab3c7b6ce038
> f4d5f6445ecf9 100644
> --- a/drivers/net/wireless/ath/ath12k/hw.h
> +++ b/drivers/net/wireless/ath/ath12k/hw.h
> @@ -375,6 +375,8 @@ struct ath12k_hw_regs {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 hal_reo_cmd_ring_base=
;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 hal_reo_status_ring_b=
ase;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 gcc_gcc_pcie_hot_rst;
> =C2=A0};
> =C2=A0
> =C2=A0static inline const char *ath12k_bd_ie_type_str(enum
> ath12k_bd_ie_type type)
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c
> b/drivers/net/wireless/ath/ath12k/pci.c
> index
> 489d546390fcdab8f615cc9184006a958d9f140a..1f3cfd9b89fdcfd84731ec90c9c
> 678b0c477a2af 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -292,10 +292,10 @@ static void ath12k_pci_enable_ltssm(struct
> ath12k_base *ab)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ath12k_dbg(ab, ATH12K_DBG=
_PCI, "pci ltssm 0x%x\n", val);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val =3D ath12k_pci_read32(ab, =
GCC_GCC_PCIE_HOT_RST);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val =3D ath12k_pci_read32(ab, =
GCC_GCC_PCIE_HOT_RST(ab));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val |=3D GCC_GCC_PCIE_HOT=
_RST_VAL;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ath12k_pci_write32(ab, GCC_GCC=
_PCIE_HOT_RST, val);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val =3D ath12k_pci_read32(ab, =
GCC_GCC_PCIE_HOT_RST);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ath12k_pci_write32(ab, GCC_GCC=
_PCIE_HOT_RST(ab), val);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val =3D ath12k_pci_read32(ab, =
GCC_GCC_PCIE_HOT_RST(ab));
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ath12k_dbg(ab, ATH12K_DBG=
_PCI, "pci pcie_hot_rst 0x%x\n",
> val);
> =C2=A0
> diff --git a/drivers/net/wireless/ath/ath12k/pci.h
> b/drivers/net/wireless/ath/ath12k/pci.h
> index
> 0b4c459d6d8eabb0773162e6bb3ca666c0a8f15a..d1ec8aad7f6c3b6f5cbdf8ce57a
> 4106733686521 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.h
> +++ b/drivers/net/wireless/ath/ath12k/pci.h
> @@ -28,7 +28,9 @@
> =C2=A0#define PCIE_PCIE_PARF_LTSSM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
0x1e081b0
> =C2=A0#define PARM_LTSSM_VALUE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A00x111
> =C2=A0
> -#define GCC_GCC_PCIE_HOT_RST=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x1=
e38338
> +#define GCC_GCC_PCIE_HOT_RST(ab) \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0((ab)->hw_params->regs->gcc_gc=
c_pcie_hot_rst)
> +
> =C2=A0#define GCC_GCC_PCIE_HOT_RST_VAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x10
> =C2=A0
> =C2=A0#define PCIE_PCIE_INT_ALL_CLEAR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x1e08228
>=20
> ---
> base-commit: 3d933084a072fd5fb5da54c06a017abc0412c86f
> change-id: 20250506-ath12k-wrong-global-reset-addr-b75ddc6e7850
>=20
> Best regards,


