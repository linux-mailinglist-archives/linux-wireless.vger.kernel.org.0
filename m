Return-Path: <linux-wireless+bounces-20526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E130A68315
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 03:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA53A188A301
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 02:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDE920CCDF;
	Wed, 19 Mar 2025 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="aLHmoAbC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60484E552
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350439; cv=none; b=s64tzLEVgoOgRN42pUr3z8UM1wJRm7YMZLV8brXM2cKPgpHwJcfqRuEFxkDjB0ipzAEmrEJC7WmjmSPd0Y8Mm/pkbzpubxk0PkFbbHmexaXnYEyH2N4Z2gFAfXFZegLHcgIPa7epXwDV4KEY6+d+dICB7cBpa4mjwJkB8VSFTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350439; c=relaxed/simple;
	bh=g02CxhLnITR9atErOioi2W2UfsqyGWOOnYZ4ve5gFmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LkHwrjheDm9OXx6pvTM16J6Vot2485XOb0P6k8eXvJg4OgyYV7moZZgj7tzNXwTLaVMhbSgS/7CJIJ7shCOS+YEI98hmTgbh7T1wdb0SyOa6etmfo+lavobM73xI/MRAv5UQ+NEZI3f4/yPtcu124xMkMW566MLcUxk2jr+79sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=aLHmoAbC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52J2DI2m84034513, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742350398; bh=g02CxhLnITR9atErOioi2W2UfsqyGWOOnYZ4ve5gFmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aLHmoAbC/DIZWg4rYEeOI5jlrQ/Q0JmHYC4JrIPfILFsTaFOBN54JHf5ZoOVsYGPA
	 6w273I0sQjOHSNd/nMvHReQscZ5JjDMxH/HOGTb1sniXXc+XaTFDLQDL5lmzrJIjwy
	 P0SEAzBGNjIessRahRX8GwoTn3cacgsbCEvrEDNioucaA+W8wH3kMmODTBApztQ1UE
	 chTg2rplSPxHIQ8xWkqSKMtvQGyjVITyxVQW5vFtESTNbT5pN/rfbzOdKJmIqyNn8o
	 hUees2zVM/aqqjWMUlPwKFKZ3iJaqUz4C3nf5AXAY/+ewScorS/L0nq5B2AEV9lFS/
	 N/X0kjQDh8x6g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52J2DI2m84034513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 10:13:18 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Mar 2025 10:13:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 19 Mar 2025 10:13:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 19 Mar 2025 10:13:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Pradeep
 Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: RE: [PATCH ath-next] wifi: ath12k: Fix incorrect rates sent to firmware
Thread-Topic: [PATCH ath-next] wifi: ath12k: Fix incorrect rates sent to
 firmware
Thread-Index: AQHbl+LVk9ag1XJlc066SGr3iqd/NrN5uHhQ
Date: Wed, 19 Mar 2025 02:13:18 +0000
Message-ID: <02b93d7699504cac89f46b1aa43c3c1c@realtek.com>
References: <20250318085013.1296262-1-quic_rdevanat@quicinc.com>
In-Reply-To: <20250318085013.1296262-1-quic_rdevanat@quicinc.com>
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


> @@ -3450,7 +3450,9 @@ static void ath12k_recalculate_mgmt_rate(struct ath=
12k *ar,
>         }
>=20
>         sband =3D hw->wiphy->bands[def->chan->band];
> -       basic_rate_idx =3D ffs(bss_conf->basic_rates) - 1;
> +       basic_rate_idx =3D ffs(bss_conf->basic_rates);
> +       if (basic_rate_idx)
> +               basic_rate_idx -=3D 1;

Using __ffs() might be more readable, like

    u8 basic_rate_idx =3D 0;

    ...

    if (bss_conf->basic_rates)
         basic_rate_idx =3D __ffs(bss_conf->basic_rates);




