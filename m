Return-Path: <linux-wireless+bounces-32336-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN+vDmsmpWm14AUAu9opvQ
	(envelope-from <linux-wireless+bounces-32336-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 06:55:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D86E41D34B0
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 06:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42FAD300C0D9
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 05:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD9A3370FF;
	Mon,  2 Mar 2026 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo2EfCL4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9B30CD85
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430950; cv=none; b=plI5ytJoypr3jrDV6dmVZpzIrCNtigAfTy1OMawcaGzNR6bKhYFhBC1G/uT+SIF5hPDB0Wr7/+9vrerWSHvpdIetKHQjy7cRBxpYpLoRdwPmOw2tQSMgCWaynbaLe6ac4uu5t/gJWSeAWfGlDzn8mijChYwAeFdIuG8GXwUdXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430950; c=relaxed/simple;
	bh=E28PYxEby162HDiG+ZHzQXYypL1443yUoh3vpe4Ronk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hrbjuje2R55Eg5OdW41wNCnDa3Va7+7AnkehQbnJ2jFPzVjsGEhMA13NkSEn0yul93HeMuW/LJkgj/IMg9ODSsj1BN7tJ0h53tltbVdNJzdaj7fDtlUcEmTKl+AgHFWFcKOgUCORCzJ5kvZYcE+1hpFpTuRkH04kcY35Z9x+nRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yo2EfCL4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so48088215e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 01 Mar 2026 21:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772430940; x=1773035740; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaxQozfKHpn+XVw6fWKA0kIBpYvNcT6Pt64DOJc8D1E=;
        b=Yo2EfCL4Uvkp3PtBbzrj3H5tBCQX8y6Tt8AIoQVuBnwVVUvuiKq2usLWLECxrorIOb
         6/R2S4O1/y+c0kP1rPlNgD6MiSHN/cMc5B0prfd5T/eSf4dRRuYzJcScjaY1SQmEXhiU
         Ok7g6BXWJDrl1FVR14/JDCWEPIHDtORDIsvM0eKBD6H4W94BoE6uYeWe+CCMKdybsvPM
         IvU1cmRl3VZTWBYw8JXbGn3iWxutT2KN0MKP2DJIkvG4iCX2NkEXZlOe9yFh0bxsSBO0
         HHZxfnKmUXRHhMzFFlaUqinY2C9t7BA1RB5qJ0IsBjkQs0PSFOvxdoajdY+pZqPHviNZ
         2TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772430940; x=1773035740;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eaxQozfKHpn+XVw6fWKA0kIBpYvNcT6Pt64DOJc8D1E=;
        b=mqS9NU6UYe2OayisvwimijMun75hlpW7ucjK5KWYAUA+bwNaAvShG1ra2Z3fy7UghT
         RmQQ0uLuPFQ17HtTXYcWymDnBjwjyqA08xoAEYPuDbq0csoPkRhOUSXBXVNQ96i6BXt4
         fIZuUJJ2mNP8gqg6NTJEcatcZqAVVBtfOALXzrcQGdlay3Zbl63pLRx0x6q+qKhGstMl
         gn+O4Yo7QOgsLIkic6jfIt3ZGEAibfxoqDjdDcYbqAE5TiqVOkju5+RY/kehlRvoE1xJ
         P9kOxhV17c1FQL9mmEmaxHhlbNpPfG3MTr0bijSPpj8pvFG/ZXDruxxZlUQYBlJFYevp
         iIpg==
X-Forwarded-Encrypted: i=1; AJvYcCWM3X6lJg4+t6DSOM5UnD1jGqcHTzcZUgqiZPjnE4zoCFhFO+fueJo7Yzwm8ilmKQz2JMW+tpOmiNxlKmFGVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUmRLwDNwn8YLI+uGQ9FqlenGaL/TMng1n8AeO1fu8UJv7BCqA
	hdWq8VZVpcxPm615y55WjoIWfhjdPVMWlUeu82YAkILepm016iP4ujFkNR5TNfYn
X-Gm-Gg: ATEYQzwgsrLTIls6GzXzi+1DUTrtDJ3g4exfJdJJqt64R9fPlJCKfYwBjyMOLc59Qo9
	hUkRRTJCNJsH+sQnn435Wb+TsWPBU8emPlGSJglBe2XXB9Q0ESkVvIdl98WCfGXGLZ0aBU2H+cX
	sSdiUODd1lG7t1iFICV0i6zxORZKBRqzNIHoXf+4lQNdNEvgED6gIzxT4KfZIhJOPczAa7/ckUW
	09DJfyzh4Y3tQHXgLdco2er3ChFZvra9HuCla7+20YyaAwaeWGV3+Jv8uP2rdQZO72DqlXVC2DR
	JulA3poc0JiEv7BnLy09lbYk0yP7PqluF9p6unCUSz1X+aLg2L6g5eh8llIgjCyj2guXTLhsSEO
	izlJPgaKqY4l1XGHwceeQeQ5/ny+Ud+a2/S5VpQceEAza+rUPyfhzuGT3pdeBCBiQf0pUPI5yvv
	0ft9NKQ9yo+uoT2x95j1sCxZy4jrAQdA1IaSNc3obQZ4I=
X-Received: by 2002:a05:600c:3108:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-483c9c1d177mr192468685e9.29.1772430940303;
        Sun, 01 Mar 2026 21:55:40 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfccd7b6sm123940475e9.24.2026.03.01.21.55.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2026 21:55:39 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] wifi: rtw89: retry efuse physical map dump on transient
 failure
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <c751f9505a664f6895bacecb62bc534a@realtek.com>
Date: Mon, 2 Mar 2026 09:55:27 +0400
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E6E752BD-5F3D-4F30-9820-CB44FA767E69@gmail.com>
References: <20260301042422.195491-1-christianshewitt@gmail.com>
 <c751f9505a664f6895bacecb62bc534a@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32336-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christianshewitt@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: D86E41D34B0
X-Rspamd-Action: no action

> On 2 Mar 2026, at 9:47=E2=80=AFam, Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>=20
> Christian Hewitt <christianshewitt@gmail.com> wrote:
>> On Radxa Rock 5B with a RTL8852BE combo WiFi/BT card, the efuse
>> physical map dump intermittently fails with -EBUSY during probe.
>> The failure occurs in rtw89_dump_physical_efuse_map_ddv() where
>> read_poll_timeout_atomic() times out waiting for the B_AX_EF_RDY
>> bit after 1 second.
>=20
> I'm checking internally how we handle this case.
>=20
> [...]
>=20
>>=20
>> For context, firmware also fails (and recovers) sometimes:
>=20
> Did you mean this doesn't always happen? sometimes?

It=E2=80=99s another intermittent behaviour observed on this board (and =
not
related to the issue this patch targets). It occurs less frequently
than the efuse issue and the existing retry mechanism in the driver
ensures firmware load always succeeds.

> We has seen similar log because of 36-bit DMA. Try below to force 32- =
or 36-
> bit DMA to see if it can resolve problem in your platform.

I can experiment but this doesn=E2=80=99t happen often so I probably =
can=E2=80=99t
provide meaningful feedback.

Christian

> diff --git a/drivers/net/wireless/realtek/rtw89/pci.c =
b/drivers/net/wireless/realtek/rtw89/pci.c
> index 43c61b3dc969..9d003ab93c85 100644
> --- a/drivers/net/wireless/realtek/rtw89/pci.c
> +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> @@ -3305,6 +3305,8 @@ static bool =
rtw89_pci_is_dac_compatible_bridge(struct rtw89_dev *rtwdev)
>        if (!bridge)
>                return false;
>=20
> +       return true; // or force to return false;
> +
>        switch (bridge->vendor) {
>        case PCI_VENDOR_ID_INTEL:
>                return true;
>=20
>>=20
>> ROCK5B:~ # dmesg | grep rtw89
>> [    6.436873] rtw89_8852be 0002:21:00.0: loaded firmware =
rtw89/rtw8852b_fw-1.bin
>> [    6.437165] rtw89_8852be 0002:21:00.0: enabling device (0000 -> =
0003)
>> [    6.450228] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 =
(6fb3ec41), cmd version 0, type 5
>> [    6.450239] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.15 =
(6fb3ec41), cmd version 0, type 3
>> [    7.864148] rtw89_8852be 0002:21:00.0: fw security fail
>> [    7.864154] rtw89_8852be 0002:21:00.0: download firmware fail
>> [    7.864160] rtw89_8852be 0002:21:00.0: [ERR]fwdl 0x1E0 =3D 0x62
>> [    7.864165] rtw89_8852be 0002:21:00.0: [ERR]fwdl 0x83F0 =3D =
0x80011
>> [    7.864173] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
>> [    7.864188] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
>> [    7.864203] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
>> [    7.864219] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
>> [    7.864234] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
>> [    7.864250] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
>> [    7.864265] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
>> [    7.864281] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
>> [    7.864296] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
>> [    7.864311] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
>> [    7.864327] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
>> [    7.864342] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931150
>> [    7.864358] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
>> [    7.864373] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
>> [    7.864387] rtw89_8852be 0002:21:00.0: [ERR]fw PC =3D 0xb8931154
>> [    8.181342] rtw89_8852be 0002:21:00.0: chip info CID: 0, CV: 1, =
AID: 0, ACV: 1, RFE: 1
>> [    8.184322] rtw89_8852be 0002:21:00.0: rfkill hardware state =
changed to enable
>>=20
>=20
>=20


