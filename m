Return-Path: <linux-wireless+bounces-23483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3CCAC75D4
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 04:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEB83AB75F
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 02:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F9244196;
	Thu, 29 May 2025 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lEWJVr+B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC0243387;
	Thu, 29 May 2025 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748485308; cv=none; b=Nm9R2NpIbu8Z+qyxJKaFV2+kOf2SoagimpNuBaVGQ5ouANAzkbBxT72kA5VMvFonDNL0elpl1AQWb4hXERRVou8/jV0YhjDV/zbeWlKVQyWpkPGztogXzNvnYA3Lp5yl/sN4QkhqJgVWCRsUO2UYDwJLUZKhLIWUUfBNnhqHyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748485308; c=relaxed/simple;
	bh=mgm+/bEiD9yG2sJdPi+nwIxBjCYXaQjUqoKkWnjvJyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jPR5ct8cmlnCAxqDidyyXqXp+TwQoPuW58NjMV5v/80u051kVg/4/y/lltB8rwkBqf7xKQEdwJZJxc5Sn3noOwO9Ys5N3CraGRYw98nl2+fTQsHirWYKxMjIKp3K+LyCeBNRw1PkS5bGTiReMR65NnqkzcJx7yyy6xaYIZ58WLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lEWJVr+B; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54T2LeFO2647071, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748485300; bh=zqOZ6WIH3ajtZIqCrHC56N9OVYnhwGuSGQSjURs7DRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=lEWJVr+BYedc5V6DRYoYdJpsN3Y3IW1t3nDHWg0IMIwBkI6X/BeFvjfpYlALU/FAb
	 HJvxdx0gw7yPm4vqxhEwhns4pJYItGb4Qm4d/+DWlV8Q0vRaCmm8mWN59KcKpyqH+8
	 L8wIYZcnxdQ61Nfix141BfYCeQ3Z6xCiMIuXL0Tu+VkPB87aFgomoj6FIr+FV0E7MO
	 quOk5OZ3LjBmetb/RXW3lCjkMNG16eTICbQajUzHhLPa0dShsITSF5Wtqqu9HMmATM
	 O7AnpZ+bz/PlLJevsiX8bXo3kejkKeEHMxoi3TJwmdRmlpAFOkIQjIM7v3e7szDlFm
	 mmv+u1eDZV/jw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54T2LeFO2647071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 10:21:40 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 May 2025 10:21:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 May 2025 10:21:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 29 May 2025 10:21:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v2 next] wifi: rtw89: mcc: prevent shift wrapping in rtw89_core_mlsr_switch()
Thread-Topic: [PATCH v2 next] wifi: rtw89: mcc: prevent shift wrapping in
 rtw89_core_mlsr_switch()
Thread-Index: AQHbz6gTLKzSHyHrGEOZ0fuLbkUcwbPoWYyAgACHjXA=
Date: Thu, 29 May 2025 02:21:39 +0000
Message-ID: <bb4bc20d9f7346edb013f123051fc490@realtek.com>
References: <aDbFFkX09K7FrL9h@stanley.mountain>
 <a46c420109f0440a987d28c531dd39d6@realtek.com>
In-Reply-To: <a46c420109f0440a987d28c531dd39d6@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Zong-Zhe Yang <kevin_yang@realtek.com> wrote:
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The "link_id" value comes from the user via debugfs.  If it's larger th=
an BITS_PER_LONG then
> > that would result in shift wrapping and potentially an out of bounds ac=
cess later.  In fact, we
> > can limit it to IEEE80211_MLD_MAX_NUM_LINKS (15).
> >
> > Fortunately, only root can write to debugfs files so the security impac=
t is minimal.
> >
> > Fixes: 9dd85e739ce0 ("wifi: rtw89: debug: add mlo_mode dbgfs")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > Use IEEE80211_MLD_MAX_NUM_LINKS as a limit instead of BITS_PER_LONG.
> > It's stricter and also more informative.
> >
> >  drivers/net/wireless/realtek/rtw89/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/realtek/rtw89/core.c
> > b/drivers/net/wireless/realtek/rtw89/core.c
> > index 49447668cbf3..3604a8e15df0 100644
> > --- a/drivers/net/wireless/realtek/rtw89/core.c
> > +++ b/drivers/net/wireless/realtek/rtw89/core.c
> > @@ -5239,7 +5239,8 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwd=
ev, struct
> > rtw89_vif *rtwvif,
> >         if (unlikely(!ieee80211_vif_is_mld(vif)))
> >                 return -EOPNOTSUPP;
> >
> > -       if (unlikely(!(usable_links & BIT(link_id)))) {
> > +       if (unlikely(link_id >=3D IEEE80211_MLD_MAX_NUM_LINKS ||
> > +                    !(usable_links & BIT(link_id)))) {
> >                 rtw89_warn(rtwdev, "%s: link id %u is not usable\n", __=
func__,
> >                            link_id);
> >                 return -ENOLINK;
> > --
> > 2.47.2
>=20
> It looks good to me.
> Thank you.

I will add a tag during committing.=20

Reviewed-by: Zong-Zhe Yang <kevin_yang@realtek.com>



