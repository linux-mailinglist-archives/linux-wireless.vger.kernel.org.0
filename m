Return-Path: <linux-wireless+bounces-14442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1A9AD927
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 03:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197291F22AA9
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 01:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB6142070;
	Thu, 24 Oct 2024 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="j0lJnEvO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361134120B
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729732997; cv=none; b=pTlnl9/Rg7pit0lMtg7GfvKveO+LhOk2EFCo4INZbgdAra2dl6BML9W7wfYm0rCUol2SVE1G1Yd+lKiyB2wHU/SbH1D+He0PncpW6IGkoQII/hsBrcPM2RWpOuWSdChhG4OlQeH2kRODOHJSx4Q1aNRtfo351PaJI1JyW7pb5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729732997; c=relaxed/simple;
	bh=+vJz2cxQVqSCktMAqVsOOdXXZVW/vTjUpOfGih3iO2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/w55Zv8kNt1m4TCclZpVmTTzgnr+kYEg/A7BxdEr3Zqb+SHJZ+5932c3ohQ9VzsIplCkMRA7M0D/azgujo5VfvAgfoyI3QF3kfLH7itLzRJk7g3bpzRl35beGWrw6ZFLaFHehpU8I5AgAEnm24Ml04oxXdjSO7D6uhhltXRIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=j0lJnEvO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49O1MRQ102406585, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729732947; bh=+vJz2cxQVqSCktMAqVsOOdXXZVW/vTjUpOfGih3iO2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=j0lJnEvOTTBBfCOxe+Xwl+k9AmEPAl74jsSaNdVgbatOpQE8GgsYnOL3+Ef7NwWEz
	 KcPw5mxMAQsFBJjlojqxu0XNqzbTVUDRVsj9HMXxgX40qBH+QZEkL3nYqBW1zOorVb
	 dtGaIai3LMiqNV+UAA4qRO1+SGFu/ZNRxFkUk+YQAmkkcZSOoj4ELhFszxlIt4LULn
	 6fiyE3B0yqK3ysKAgV75rgx4od2bEvmlcDLfDTscwpV8+SgjJ62Hg3d53uHmuRE5c7
	 yMOj/aUzzFdyFtRFFWFyTAKUpDlD20vYWfVI6Z13d1j82IB+T679m7mZH11EdnwNPS
	 vZ9De2q193LlA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49O1MRQ102406585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 09:22:27 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 09:22:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 24 Oct 2024 09:22:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 24 Oct 2024 09:22:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>,
        "ath12k@lists.infradead.org"
	<ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 6/8] wifi: ath12k: add multi-link flag in peer create command
Thread-Topic: [PATCH 6/8] wifi: ath12k: add multi-link flag in peer create
 command
Thread-Index: AQHbJU/u9v+orQ+WG0enpVTHx4vG2bKVGtbQ
Date: Thu, 24 Oct 2024 01:22:26 +0000
Message-ID: <1a89ef140a8243f3a8909d29ae44d8e8@realtek.com>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-7-kvalo@kernel.org>
In-Reply-To: <20241023133004.2253830-7-kvalo@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Kalle Valo <kvalo@kernel.org> wrote:
> @@ -7016,7 +7017,7 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struc=
t ath12k_link_vif *arvif)
>         struct ath12k_vif *ahvif =3D arvif->ahvif;
>         struct ieee80211_vif *vif =3D ath12k_ahvif_to_vif(ahvif);
>         struct ath12k_wmi_vdev_create_arg vdev_arg =3D {0};
> -       struct ath12k_wmi_peer_create_arg peer_param;
> +       struct ath12k_wmi_peer_create_arg peer_param =3D {0};

Using '=3D {}' as initializer would be better, no matter first field of str=
uct
will be changed in the future.



