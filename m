Return-Path: <linux-wireless+bounces-15519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A91399D326F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 04:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3331C1F2345E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2024 03:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F149E14A0A4;
	Wed, 20 Nov 2024 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jeUqTeJv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580414A4C6
	for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2024 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072499; cv=none; b=bX5h/+VK36KOLFmIBuaiZEMaf6NqChcr1UWOGpPf2Fay5mRZYxAwowXfPqcmUqdQuMUJlKcOxJZrDL0J7/bjFgwwuj7mvDyVBcXHMuVgmPVI4nbmF0XqgCaBcc0td8SZ7tXqaPQHO22c86CORnn/IXZ66RqF8MgDHroHVUE0gIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072499; c=relaxed/simple;
	bh=RQci3X+sGcrhCu3yX2MP6VeE2z4IZAhrTTmC1uakWDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WHsdFoaCtC4d+I+2kluEU8N1/MjJLlLYu5pO1LWGcnEwYcuRaiCF5jwq8afiVpYudgax04LBPjBo1HKNczJCZsOKHuv/8PH1hrgFAmz8XZtkMrfB0L1s3VLvwqn9rT2LZFwma7QxLid3dTqPw1NrWu4TMtiZF0ImfznOyav/l+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jeUqTeJv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK3Epg763438779, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732072491; bh=RQci3X+sGcrhCu3yX2MP6VeE2z4IZAhrTTmC1uakWDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jeUqTeJvYDPYEpQV9uZ+RVvFjaxxos8100JkXs94BovM+PseTFWNCezEodgIhMDXw
	 v73Pqzk65GftplXlWW4pHllaZAXpvtGp9K0/32vknXitYlBIB8+3GuotP4ZBZTKD/b
	 xj/HMdnDx/P24iU71RliPhr5XT6t9Aj3dnq+CY4Mi2hqTO/HQuJITrvkq10x+7+D5+
	 W6tMPSYmDIyPsz16eI+H/Rq7kx4DHk+8dLHdBVUJzXeCEzdw2+kPNC2bBJlEGHojFR
	 qFgHE/McCU/057XfLprL+IHqogsVyl6YDdFGKMI3Gf/40AKYW5LkzGePioKWoPNF12
	 X9Lvww96nCjIw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK3Epg763438779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 11:14:51 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:14:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Nov 2024 11:14:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 20 Nov 2024 11:14:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Zong-Zhe Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH v2 1/6] wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
Thread-Topic: [PATCH v2 1/6] wifi: rtw89: 8922a: configure AP_LINK_PS if FW
 supports
Thread-Index: AQHbOW7zpSXp73vNCUiGSBdsDq1AS7K8+eGagAKHYJA=
Date: Wed, 20 Nov 2024 03:14:50 +0000
Message-ID: <28b8c5c56c374a2da274f8d32b12f0da@realtek.com>
References: <20241118040255.40854-1-pkshih@realtek.com>
	<20241118040255.40854-2-pkshih@realtek.com> <87ikskvhwt.fsf@kernel.org>
In-Reply-To: <87ikskvhwt.fsf@kernel.org>
Accept-Language: en-US, zh-TW
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

Kalle Valo <kvalo@kernel.org> wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
> >
> > After FW v0.35.46.0, for AP mode, RTL8922A FW supports a new FW feature=
,
> > called NOTIFY_AP_INFO, to notify driver information related to AP mode.
> > And, one function of it is to monitor PS states of remote stations. Onc=
e
> > one of them changes, FW will send a C2H event to tell driver. With this
> > FW feature, we can declare AP_LINK_PS.
> >
> > For now, driver still needs to determine if a frame is ps-poll or U-APS=
D
> > trigger. So, add the corresponding RX handling in driver, which activat=
es
> > only when at least one AP is running.
> >
> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>=20
> [...]
>=20
> > +// CLASS 36 - SoftAP
>=20
> In wireless we prefer '/* */'.
>=20

The checkpatch is changed to allow this style by default, so I didn't catch
the warning. Add option "--ignore C99_COMMENT_TOLERANCE" to my local script=
.



