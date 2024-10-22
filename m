Return-Path: <linux-wireless+bounces-14288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C419A9720
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 05:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080B7287286
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 03:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DBB12E1CA;
	Tue, 22 Oct 2024 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bYGM08HN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFF256D;
	Tue, 22 Oct 2024 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567955; cv=none; b=HcvJVM3D6HoPZMFdH78Jk+Xvb3HgI9kXQL3ZWGOrJAeiOX81opcfFfWBUszalTxIg+aEINx65dlKCWCH55tBoMmaTCCfekrZVaqfpP8VQ55MVOJSRciqOfJCPPR9HtnKCc5qZzhDHfpckMSh8+9XCISd5nGKZQqj5FlNynzY/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567955; c=relaxed/simple;
	bh=G3bmWtoDYvpAbFjD4WI6gHq/z+KB1wTq7TQqp1VTSpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGrzMONBjtpdBp2uoNTxJDrWSvEH+ikxTST58CUh8zUWcuLFHU3songXn3dn39h1xrFUXDlSBaup9HSQtQ61VlaRouhNyuoGzHhGJMORFWKs3P+wFnujCcYLI2UF0p/wmEZ+0NPD44z7/mrUijKIPsy9FbCe+kAWUJ2+PcTXtwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bYGM08HN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49M3WOYe83445860, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729567944; bh=G3bmWtoDYvpAbFjD4WI6gHq/z+KB1wTq7TQqp1VTSpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bYGM08HNBX/TpMDVu9aBJ3gCpbT1slBbBCB1hgzen2OZMvoGUJJ085s0XkFXsEzaI
	 1I5TkplrgG/KebctwTlPETdsawftmVDS5YCcKhWNRQUgq7KMt8uRdZDylXRs+EFcnr
	 ZbpOBg2+IYNzGcozksOC0bs1QQbOwDnle91YxfI9XZcHZZN3KF4N1eWVLPp09N1chL
	 gv75x6K524T8748KilA52aZ2vK9/Ah/UsbU2VyW1XEfLD7CY8HPD03SA2oInKe8rxl
	 P0BhyzpoqG8eHGzvbi1EOHZXY4S7bZk73Om3B3mHqUZanMl4pwqxtV6SrMmImczqjV
	 DqeU3sJaRSo2Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49M3WOYe83445860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 11:32:24 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 11:32:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 22 Oct 2024 11:32:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 22 Oct 2024 11:32:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH next] wifi: rtw89: unlock on error path in rtw89_ops_unassign_vif_chanctx()
Thread-Topic: [PATCH next] wifi: rtw89: unlock on error path in
 rtw89_ops_unassign_vif_chanctx()
Thread-Index: AQHbI5mvMqMtxuCXfUeWI6pQPfmKb7KRlzaAgACHFlA=
Date: Tue, 22 Oct 2024 03:32:23 +0000
Message-ID: <931c79c15bc04be99bb87a9826cf2b04@realtek.com>
References: <8683a712-ffc2-466b-8382-0b264719f8ef@stanley.mountain>
 <6a80d4adc51f4ea884b5e02f16d8aaed@realtek.com>
In-Reply-To: <6a80d4adc51f4ea884b5e02f16d8aaed@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
> > [...]
> >
> > @@ -1373,6 +1373,7 @@ static void rtw89_ops_unassign_vif_chanctx(struct=
 ieee80211_hw
> > *hw,
> >
> >         rtwvif_link =3D rtwvif->links[link_conf->link_id];
> >         if (unlikely(!rtwvif_link)) {
> > +               mutex_unlock(&rtwdev->mutex);
> >                 rtw89_err(rtwdev,
> >                           "%s: rtwvif link (link_id %u) is not active\n=
",
> >                           __func__, link_conf->link_id);
> >
>=20
> Acked-by: Zong-Zhe Yang <kevin_yang@realtek.com>
>=20

Thanks for the ack.=20

Acked-by is often used by the maintainer, so I will change it to Reviewed-b=
y
during committing.=20



