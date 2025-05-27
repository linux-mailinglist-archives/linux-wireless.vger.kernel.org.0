Return-Path: <linux-wireless+bounces-23433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C98AC4961
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 09:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F07A4B53
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 07:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9672475CF;
	Tue, 27 May 2025 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Oxnoi3Vj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B4288DB;
	Tue, 27 May 2025 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748331506; cv=none; b=o7Gm6hM9WrnWa4KTuhfDOvlwuJxexdKHI7yb3+Up+mnrvddDCNhAQ0kMrX2G8xyIAhSs+8BiBlKYAm7aZbOGWCBzeVrhIp4eDEUX8fdLXwwwUKOk2f3iVH8XObAKmxwSzRow/69L60iw05dsGajBjJrr/D5vQUTZGskK22UzDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748331506; c=relaxed/simple;
	bh=i690CQjuRjliu6SJ2bm4fdZsogyF2RzFSpwTyVOSEyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dQRIf5I6mm7aXBq1utkAjpbc8PApW61x7+htBJL39+HmIqWV752UiuOtYrox8UwXbhUi+R1s0UCubSXFr9H2T5+dv8kZrgAySFZ8h6jRqtPLi4suZAfjxWjs5DAGiAgboS9iM223/n8TNuU4yWI2apuu4JPjTuk+LRMOVEjtLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Oxnoi3Vj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54R7cId251450466, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748331498; bh=x/ATG9zs6W7XqSUAA4bWjhCLRx0nRfw2siWd57FWhc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Oxnoi3VjOMGzejapufOTkYDHiskwr/UNp8AN3YMz4X3El4EILiulJvYCcCUtE94Mz
	 kEfwELD003mf4esntSyRIwsGeD6DtbjnQ8mgTk7UF38Xcl7l3W9ZwndDSipfYx+w48
	 e7bPjdTtzwKpF43ROKqkvmblJV+SbuMW35dI9p+r9Rk64gREvoNC8A4wB0cDZ0JzQJ
	 9wezHNH8bOs8ku03tpZG0bPoQrYdXPk4tCbM/UKSjmIkd0xcEtUZuNK/wkdFtBiSVn
	 ri4OjcXJwUOjoub/eD+z9BdZnJxEs1Oi9ndF+yYq3vfyIy07gzOcvu0gQf0ItjmLJz
	 mrgIcjkhEOB8w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54R7cId251450466
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 15:38:18 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 May 2025 15:38:18 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 May 2025 15:38:17 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::dd06:104c:e04d:a488]) by
 RTEXMBS03.realtek.com.tw ([fe80::dd06:104c:e04d:a488%2]) with mapi id
 15.01.2507.035; Tue, 27 May 2025 15:38:17 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] wifi: rtw89: mcc: prevent shift wrapping in rtw89_core_mlsr_switch()
Thread-Topic: [PATCH next] wifi: rtw89: mcc: prevent shift wrapping in
 rtw89_core_mlsr_switch()
Thread-Index: AQHbzswfjeN9r26I10eoAov9FdTI97PmBnfw
Date: Tue, 27 May 2025 07:38:17 +0000
Message-ID: <582b5bc4c4434934838ae28d77b7f73a@realtek.com>
References: <aDVUEHfa9q2zBD6i@stanley.mountain>
In-Reply-To: <aDVUEHfa9q2zBD6i@stanley.mountain>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Dan Carpenter <dan.carpenter@linaro.org> wrote:
>=20
> The "link_id" value comes from the user via debugfs.  If it's larger than=
 BITS_PER_LONG then
> that would result in shift wrapping and potentially an out of bounds acce=
ss later.  Fortunately,
> only root can write to debugfs files so the security impact is minimal.
>=20

Thank you for catching this problem.

>=20
> [...]
>=20
> @@ -5239,6 +5239,9 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev=
, struct
> rtw89_vif *rtwvif,
>         if (unlikely(!ieee80211_vif_is_mld(vif)))
>                 return -EOPNOTSUPP;
>=20
> +       if (unlikely(link_id >=3D BITS_PER_LONG))
> +               return -EINVAL;
> +

Since I think this problem only comes from dbgfs path, would you like to ju=
st add a check in debug.c ?

For example,
(based on 0 <=3D valid link id < IEEE80211_MLD_MAX_NUM_LINKS < BITS_PER_LON=
G)

rtw89_debug_priv_mlo_mode_set(...)
{
        ...
        switch (mlo_mode) {
        case RTW89_MLO_MODE_MLSR:
               if (argv >=3D IEEE80211_MLD_MAX_NUM_LINKS)
                       return -EINVAL;
                ...


>         if (unlikely(!(usable_links & BIT(link_id)))) {
>                 rtw89_warn(rtwdev, "%s: link id %u is not usable\n", __fu=
nc__,
>                            link_id);
> --
> 2.47.2


