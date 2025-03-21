Return-Path: <linux-wireless+bounces-20664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F80A6B986
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 12:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B671888A1D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31B1F09A8;
	Fri, 21 Mar 2025 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LTTc5J5x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BED1F03CA
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555208; cv=none; b=AvTSmGbpP9Zg8wt8QCWWXryPJMULB6iZ/6F9zjT2OeH98NGDa7kJEnhQ6TrO/vkRjpGCX3lAYbU+AgStbLj5c+PXJ2BGxN9nnrFgKxYtMohsXMvnFtLqlfmbFtWQOUEwtgKe5UmDaT9RMZ3X+ATBLFyPjrCqhAe/CRlCmVjYp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555208; c=relaxed/simple;
	bh=bhNLIujEdNOHnANGswXgnm3dIzbU4PU0yez57XN4zp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q67g/KF1ZrkfSN8hL+zWkwdGMj5MVClmqwBcVZBZnbcP5AGoUj2ac3mT9rr4PNhvkvwOdTaDO5Fv17DkT3PI1fW3RZcH4EogDWiHF4Kg0MVB0LswTSKrjbITQC6QuIV+YHWO7/xiKyP5S181gXke1hDduJdCi6jx4SZmMBDBmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LTTc5J5x; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52LB6DbhC048470, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742555173; bh=bhNLIujEdNOHnANGswXgnm3dIzbU4PU0yez57XN4zp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LTTc5J5xgDVxPcFjaAgPyHsFt9pjclc2+P1R4XAz6Qmj24rKDf9nzaYXSg4mD81dM
	 VIhcLwmGqvzLdEAI7qlXdYqsuT4xft3QhDXDzcqEaf4rgYo5BXwLUyjaUHc1A9nQsC
	 T+jF5l5Y53JUgcLupL+Vv7bu28arSOsbung85/r5FrLUAF1vGou5qsovlIzvLHLGhh
	 kya1cN0roVfueVhxvRTnR/BJ3AVtD1FqCE72GocpWw2S+S7bEIGVzpzJZr+7D5vHDf
	 mqdid5xBct8+I5VkClv67DBCsrv3NzhKzQPnKNvArpHKuSw4JG7O7ybgZClKTUYw3+
	 fibsXeerrdMzg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52LB6DbhC048470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 19:06:13 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Mar 2025 19:06:13 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 21 Mar 2025 19:06:12 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::dd06:104c:e04d:a488]) by
 RTEXMBS03.realtek.com.tw ([fe80::dd06:104c:e04d:a488%2]) with mapi id
 15.01.2507.035; Fri, 21 Mar 2025 19:06:12 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Kang Yang <quic_kangyang@quicinc.com>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH ath-next v3] wifi: ath12k: read country code from SMBIOS for WCN7850
Thread-Topic: [PATCH ath-next v3] wifi: ath12k: read country code from SMBIOS
 for WCN7850
Thread-Index: AQHbmkAzisRTE7bSzECrHccDJM1le7N9bBpA
Date: Fri, 21 Mar 2025 11:06:12 +0000
Message-ID: <66db20d096a347d0b832baad3c5061a7@realtek.com>
References: <20250321090307.1397-1-quic_kangyang@quicinc.com>
In-Reply-To: <20250321090307.1397-1-quic_kangyang@quicinc.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Kang Yang <quic_kangyang@quicinc.com> wrote:
>=20
> Read the country code from SMBIOS and send it to the firmware. The firmwa=
re will then
> indicate the regulatory domain information for the country code, which at=
h12k will use.
>=20
> [...]
>=20
> static void ath12k_core_check_bdfext(const struct dmi_header *hdr, void *=
data)
>                 return;
>         }
>=20
> +       spin_lock_bh(&ab->base_lock);
> +
> +       switch (smbios->country_code_flag) {
> +       case ATH12K_SMBIOS_CC_ISO:
> +               ab->new_alpha2[0] =3D u16_get_bits(smbios->cc_code, 0xff)=
;
> +               ab->new_alpha2[1] =3D u16_get_bits(smbios->cc_code, 0xff)=
;

It seems that one of the masks is wrong.

> +               ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios cc_code %c%c=
\n",
> +                          ab->new_alpha2[0], ab->new_alpha2[1]);
> +               break;
> +       case ATH12K_SMBIOS_CC_WW:
> +               ab->new_alpha2[0] =3D '0';
> +               ab->new_alpha2[1] =3D '0';
> +               ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot smbios worldwide
> regdomain\n");
> +               break;
> +       default:
> +               ath12k_dbg(ab, ATH12K_DBG_BOOT, "boot ignore smbios count=
ry code
> setting %d\n",
> +                          smbios->country_code_flag);
> +               break;
> +       }
> +
> +       spin_unlock_bh(&ab->base_lock);
> +
>         if (!smbios->bdf_enabled) {
>                 ath12k_dbg(ab, ATH12K_DBG_BOOT, "bdf variant name not fou=
nd.\n");
>                 return;
> @@ -690,7 +712,7 @@ static void ath12k_core_check_bdfext(const struct dmi=
_header *hdr,
> void *data)  int ath12k_core_check_smbios(struct ath12k_base *ab)  {
>         ab->qmi.target.bdf_ext[0] =3D '\0';
> -       dmi_walk(ath12k_core_check_bdfext, ab);
> +       dmi_walk(ath12k_core_check_cc_code_bdfext, ab);
>=20
>         if (ab->qmi.target.bdf_ext[0] =3D=3D '\0')
>                 return -ENODATA;
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireles=
s/ath/ath12k/core.h
> index 116cf530621f..e2d300bd5972 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -172,9 +172,34 @@ struct ath12k_ext_irq_grp {
>         struct net_device *napi_ndev;
>  };
>=20
> +enum ath12k_smbios_cc_type {
> +       /* disable country code setting from SMBIOS */
> +       ATH12K_SMBIOS_CC_DISABLE =3D 0,
> +
> +       /* set country code by ANSI country name, based on ISO3166-1 alph=
a2 */
> +       ATH12K_SMBIOS_CC_ISO =3D 1,
> +
> +       /* worldwide regdomain */
> +       ATH12K_SMBIOS_CC_WW =3D 2,
> +};
> +
>  struct ath12k_smbios_bdf {
>         struct dmi_header hdr;
> -       u32 padding;
> +       u8 features_disabled;
> +
> +       /* enum ath12k_smbios_cc_type */
> +       u8 country_code_flag;
> +
> +       /* To set specific country, you need to set country code
> +        * flag=3DATH12K_SMBIOS_CC_ISO first, then if country is United
> +        * States, then country code value =3D 0x5553 ("US",'U' =3D 0x55,=
 'S'=3D
> +        * 0x53). To set country to INDONESIA, then country code value =
=3D
> +        * 0x4944 ("IN", 'I'=3D0x49, 'D'=3D0x44). If country code flag =
=3D
> +        * ATH12K_SMBIOS_CC_WW, then you can use worldwide regulatory
> +        * setting.
> +        */
> +       u16 cc_code;
> +
>         u8 bdf_enabled;
>         u8 bdf_ext[];
>  } __packed;
>=20
> [...]
>=20


