Return-Path: <linux-wireless+bounces-28179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779E9BFD9AB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 19:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59BD3A331B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 17:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827E2C028F;
	Wed, 22 Oct 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecfNsfd3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129662571DC
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154242; cv=none; b=K+4oI5vIDYrGJ1ruc323oKeF7n2TS+FRV7G3gkGszXl9zy5I107OwmKYyH+broHsYkBv/b1QzOr00f+0EGdlMcCS2C/0egtubablt9fObdR0TCTwhQT6bWpI9FSIefyI9cYk8YIfKusfU5UP1TtOyIU95m47f74o5PZ0cPh6bhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154242; c=relaxed/simple;
	bh=dhyaC0ICk5isf1JAQ07TmGyf/BAWBQbKFRNYZv3i8W0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BkL1dyj+U/eRhh5r6F5hyQS05j4hGbyzITLnvxONfGMbv3Yh+U0sMagrwuQuLs8E3eKeIMdU+Mob8lmk8OXiQPBra2q+foxwbI5oWCBFIZtmeyBE6t4EfVZpxV0fd8chQeSZuWV/mC6wglYFvOuzHlaS83/KdFl59X0/axsdjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecfNsfd3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42701aa714aso4325718f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761154239; x=1761759039; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1nFCN9pLEfI7dNTPvL0mUSRHrfYXPoZtHDehAzFK4eA=;
        b=ecfNsfd3DHtmTB/E7FuoAZD6acec/9UFub7eFPkwwVmRIefRcdZEyLbOb4vzz374NC
         GUCJ7X4sZCrqtSwCwRv0HDIPa0fd1D7ocmtWx4pxKnlmPuFStO5su4g1uNZ4RGUCYbxa
         MBDkiSuIdsiucYdkEqgOr5fIqojn7DzfPvm6BtANnTz5jcKhx23Xl5Sbi6M9IERHe61T
         xU9SGUP6fFDjf6oTkkRARKRGDQoUk70n73vlZNrwmI7nahiqL+T8pMWK43RnCFaJX8y9
         31cetQVmz3wJMSD+gEmAKJDcZWhsGElRoBVmaGRCGY8Jyfth7lkTvaU+XDDCxGLDcMDe
         m3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154239; x=1761759039;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nFCN9pLEfI7dNTPvL0mUSRHrfYXPoZtHDehAzFK4eA=;
        b=BtQSnGbv2HrWME1MEw1iKDqT5DU/1geTnaV3SlYbXwDKPUoANbmwAUZW+RoRifeEZu
         FqCiUN04JM3oIlYTVqLU6Nerx8IEtSI7iM6eg9VnRhpxgCbif0evbPikqFuv4F2Xw4Vx
         GB+IZLfoFMu/67TqWn6Wp/+4dTUYJ2VtRSxuA7ukZeRVqml0K8/DQ5DPn62pwbLxkADN
         wnDmmjciiCdfpt/600Tdj0dcIgtMHT94hb/iqrPS3d8OliNVy2x0kPVO5zXeZ00XtLYS
         Mnh4rsfcDdaveLNcPYAxk2kLoJautvF3PHzRXEn/eLoUssH4rQrF1joUAkvMAfI2Ny8o
         CjTw==
X-Gm-Message-State: AOJu0YyLe9bP3IrZjeSveovypMsu+PkHAbtinNnTsBzTrQYNa/VyFpQ6
	ytLsWX8szpmTYVB/rL2CEvvT9BvdV9wZNFnYwVo2UkARBhXBmFJzaF5Y
X-Gm-Gg: ASbGnctgYpMQhh2ySJxeX4y2Y8Dum3r5lN9bkYFENwupS4ZCJyr+SV5UL+u1MYGjOSk
	kBbhNN+2Vdt7c2XstlIsLsC1PuvyWPfBhlnpyTPzY/ItY+mtBcVKbOG6Hv+ITFNuPCptekEy9pw
	Ar2WIueawlPzI4QIlmFBKfKuSiXp8Q9F8CdMCinMT2ljr9pLBVBNkPlGt/N8yLvTDbd/+y4KJqp
	uanDXJ11i1LIFbh1ezapFw6t6UIp/Gd3wIjcLOYkSU89VIqc3kvEq+7RPvClQD9qaPBf1yj9D5T
	IrwfrteGNLuvnBfltJcF9alBySocC+4iBd/tIBUwt2C12E3u1rpJoeEETZ8Y34PyD/iBir/vd3L
	5kCRtek3obav8sPYb11UlyOCc4ade7Z0MBhczidqQQHmoXzLuUuKA2xa6i+WQ6+qUj4p5XrKQQ0
	nCgZxP6r+PuoUY3RF1s339BXN5HAoNNuHaevvGHoHncndGsR0DKQZVeLBEpw==
X-Google-Smtp-Source: AGHT+IGpzLyeFOtu3WGWo07Zjf+OlCN6M5eusYAHPhvOlsQ5WxNrnoYQLWAS9/q733puojsFm3TO7g==
X-Received: by 2002:adf:e19a:0:b0:427:613:7772 with SMTP id ffacd0b85a97d-42706137842mr12906996f8f.32.1761154239253;
        Wed, 22 Oct 2025 10:30:39 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:5a8f:8582:c21f:f389? ([2a02:168:6806:0:5a8f:8582:c21f:f389])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c56sm26280266f8f.18.2025.10.22.10.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:30:38 -0700 (PDT)
Message-ID: <68dd3d93509b627dbdf907332a703443f46aff6c.camel@gmail.com>
Subject: Re: [REGRESSION] ath10k fails initialization, bisected to "wifi:
 ath10k: avoid unnecessary wait for service ready message"
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, Jeff Johnson	
 <jeff.johnson@oss.qualcomm.com>, Jeff Johnson <jjohnson@kernel.org>, Kalle
 Valo	 <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, 
	regressions@lists.linux.dev
Date: Wed, 22 Oct 2025 19:30:38 +0200
In-Reply-To: <5466e122-9143-482e-a9ab-7f956e19bf86@oss.qualcomm.com>
References: 
	<20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
	 <175823924851.3217488.17742065327824732992.b4-ty@oss.qualcomm.com>
	 <6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com>
	 <76d4235d-db4e-40f4-9ede-8cb536b82fbd@oss.qualcomm.com>
	 <10919281648e306fd3f6713437b4793c50bb6692.camel@gmail.com>
	 <5466e122-9143-482e-a9ab-7f956e19bf86@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 16:00 +0800, Baochen Qiang wrote:
> Thank you Klaus, can you please try if below diff can fix this regression=
?
>=20
> diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/=
ath/ath10k/ce.c
> index 7bbda46cfd93..1a981d333b5c 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.c
> +++ b/drivers/net/wireless/ath/ath10k/ce.c
> @@ -1256,6 +1256,19 @@ void ath10k_ce_per_engine_service(struct ath10k *a=
r, unsigned int
> ce_id)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(ath10k_ce_per_engine_service);
>=20
> +void ath10k_ce_per_engine_check(struct ath10k *ar, unsigned int ce_id)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ath10k_ce *ce =3D ath10k_ce_=
priv(ar);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ath10k_ce_pipe *ce_state =3D=
 &ce->ce_states[ce_id];
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ce_state->recv_cb)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ce_state->recv_cb(ce_state);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ce_state->send_cb)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ce_state->send_cb(ce_state);
> +}
> +EXPORT_SYMBOL(ath10k_ce_per_engine_check);
> +
> =C2=A0/*
> =C2=A0 * Handler for per-engine interrupts on ALL active CEs.
> =C2=A0 * This is used in cases where the system is sharing a
> diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/=
ath/ath10k/ce.h
> index 27367bd64e95..9923530e51eb 100644
> --- a/drivers/net/wireless/ath/ath10k/ce.h
> +++ b/drivers/net/wireless/ath/ath10k/ce.h
> @@ -255,6 +255,7 @@ int ath10k_ce_cancel_send_next(struct ath10k_ce_pipe =
*ce_state,
> =C2=A0/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DCE Interrup=
t Handlers=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
> =C2=A0void ath10k_ce_per_engine_service_any(struct ath10k *ar);
> =C2=A0void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int c=
e_id);
> +void ath10k_ce_per_engine_check(struct ath10k *ar, unsigned int ce_id);
> =C2=A0void ath10k_ce_disable_interrupt(struct ath10k *ar, int ce_id);
> =C2=A0void ath10k_ce_disable_interrupts(struct ath10k *ar);
> =C2=A0void ath10k_ce_enable_interrupt(struct ath10k *ar, int ce_id);
> diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless=
/ath/ath10k/pci.c
> index 97b49bf4ad80..ce8e0c2fb975 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -1812,7 +1812,7 @@ void ath10k_pci_hif_send_complete_check(struct ath1=
0k *ar, u8 pipe,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (resources > (ar_pci->attr[pipe].src_nentries >> 1))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ath10k_ce_per_engine_service(ar, pi=
pe);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ath10k_ce_per_engine_check(ar, pipe=
);
> =C2=A0}
>=20
> =C2=A0static void ath10k_pci_rx_retry_sync(struct ath10k *ar)
>=20
>=20

Thanks for looking into this.
I applied that patch on top of current mainline, but unfortunately the resu=
lt is still the same:

[    6.094149] ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mod=
e 0 reset_mode 0
[    6.241457] ath10k_pci 0000:02:00.0: qca988x hw2.0 target 0x4100016c chi=
p_id 0x043202ff sub 0000:0000
[    6.241476] ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 0 tracing 0=
 dfs 1 testmode 0
[    6.242901] ath10k_pci 0000:02:00.0: firmware ver 10.2.4-1.0-00047 api 5=
 features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
[    6.309202] ath10k_pci 0000:02:00.0: board_file api 1 bmi_id N/A crc32 b=
ebc7c08
[   12.509266] ath10k_pci 0000:02:00.0: wmi unified ready event not receive=
d
[   12.581057] ath10k_pci 0000:02:00.0: could not init core (-110)
[   12.587057] ath10k_pci 0000:02:00.0: could not probe fw (-110)


