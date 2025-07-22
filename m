Return-Path: <linux-wireless+bounces-25874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9217EB0E0FE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0FE188B051
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C70D279DBA;
	Tue, 22 Jul 2025 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="phN7Gf5m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF125B69F
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199644; cv=none; b=BCWEpbe59DNJ7FmZanmYRx9Z8UmXSGzhqSBBtfNTu2McMdit66BKQTsbvBqNsRO519cjqY1TvHByi6o7VyW75v25LP9W2r3QY7USrFsPT89ay8QlF/ZlrPpn6tf3TRHfFsx/2w/wOmI3ZQfAS/i4zReYyLL3Xtvdv+vBlYDuFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199644; c=relaxed/simple;
	bh=xbOL1hi5iRadHG9rfEIf2bg+1nEcZrZ5+VgZN0WBB70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhrBaVJO4qzBPIGxBSZheK7qYJdarBD8ThNWDlqbZhycHHg8BwAjK0cRT+uYJpiHCsPeJxV3za04atnYNzAnoIPvKDBgqxaeeveSQ0c5A5kzZyuoY+IO9Qcuw0DVHUUu+/ba4DS3pk9fRucC0YGOY6hYUiMckOAOts0GwV8LdSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=phN7Gf5m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M9F40Q012705
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 15:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y6Xuurk2pjdpa5qe1QO08Rpr5zT9H7Qi5lcMEbAuGE4=; b=phN7Gf5mMGKXK1Vx
	IImJOJYBCBnlTQQOzxWIH80Wuo9MdclQAcY42AcrG/ZPA6Df4gNMFeIJnoR4HAr5
	MqfAssF7y2jkhLkBs4hOT56d5tlQ0rzR6wLnCWdJKYdzPAfsLOSW8qgnzAWGSjT9
	i2mH0MtnP00xkjOlmnrZOMh1FkwdDRfhW8XiBcwwSSiopjd7yMUT8WPITMujRRPp
	g1+onA8s5O4TbvhfQP33jjBgdSZsvdnfceXCu2Dnutvi8XgJT4eVqyUu84LNi+j2
	JIXaxS/27/l31n/bTY8QZjbuQjRhDQwEjIDsTR1I+maUyxCukgL1eWoyc30571B4
	9Z0bUQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6mb0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 15:54:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fab979413fso105771476d6.2
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753199627; x=1753804427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6Xuurk2pjdpa5qe1QO08Rpr5zT9H7Qi5lcMEbAuGE4=;
        b=elpd08BXh3aBIHLRj4KhmATBXEiw5hW9q3Nna5yxesW8xjHxO6dsLl3j8zSSF4Oa5a
         YpNImqXnBpDg6X0IU+xVAtqymevbWrcrykaacqnN2FN6RgwIYN7j3se6EJLwWorUzG47
         gIJOon1En7fumQX6Ikt+LwXYZJ3DF9Y6p9x6WXvE8G/t4Opjpmz8uWpkVdxoTJYdr2Ge
         ryCqWhaSpy/CaTBNHdO+dGiTy4CwfNhDJKGxVTK49yyJlQdLqaw4OCwT2ldn4dnVWzTi
         K7dn6HPI4YaOKtJY+9UNzP9xRB0UFkf0S0b2gMP2h6wvLuDOswYfg5e8tL8+E9VIrKzR
         nPcw==
X-Forwarded-Encrypted: i=1; AJvYcCV+WhqWG3Rzq1DVE04z4IgjrlVHOGD01DdIiE18G2WXCmftUumcnonaVi7dyoFcwfiWElVV2KFtcpRdB8+i+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+U5FaOp8i5DcZllbIJPRX3A3FBR39XVZ3EjWGaVy5fvosY/5N
	OD5zC7GuVSyozPhTSKOpLVoz8mDHA9ueBjC13ujMgns1AKm2X/ReI1u2Ob8GLtSItPHI5euWIPR
	PKLIFnK1LH910lf2J4khtIf738k9SzDtUiVXAvvKxDSyQvJqv3qxw9DJups6+S+LT0UNlKPgppZ
	isCn/7M4wz6Q2dMU5K+ktdMvA2vGT8q3/OZqf1vzhjHuUIg+xiB5cvlPI=
X-Gm-Gg: ASbGncsRtWEh13AQ1OXZ39Ec3Pn1SU7YGDITuWeIdMEG0SqxpN4APIYimn/NOmFw1uO
	AVv8OQo6IAIGLHIMtWYR7kmESJC/V8d3QGqjpkwM4x86AFDaUPO0WQLRBg/cLcUpLPK864pUSyO
	KooRU3NfR4andB6lGNua8KSQ==
X-Received: by 2002:a05:6214:f26:b0:6ea:d6e1:f3f8 with SMTP id 6a1803df08f44-704f6b37f26mr380279966d6.45.1753199627106;
        Tue, 22 Jul 2025 08:53:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5nYxnnUnkXLdUZwVijYybnyxwPgtN4DPlPTT28knZXVoav9qF4vOpNqIR9U6EZr2z1TuU8Trz36hSsmtbv8Y=
X-Received: by 2002:a05:6214:f26:b0:6ea:d6e1:f3f8 with SMTP id
 6a1803df08f44-704f6b37f26mr380279526d6.45.1753199626575; Tue, 22 Jul 2025
 08:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zgp0ym-MGzX2eSZdlkVYbgvjkJ0CzKItjaC5pafzQnj1AOZnVAqvCIZfYoK7nwDhUgOA0U8eNolNtaWXbExOAQ==@protonmail.internalid>
 <DAWJQ2NIKY28.1XOG35E4A682G@linaro.org> <5df11ee4-d645-4be2-841f-715343f1b7a4@linaro.org>
In-Reply-To: <5df11ee4-d645-4be2-841f-715343f1b7a4@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 17:53:35 +0200
X-Gm-Features: Ac12FXzzblHjmRwX3nirKO8RXdSrs18ryTc8DJ_DWk70nYnfPnAaEddYkwXyMlw
Message-ID: <CAFEp6-0zwy2JdFOvRQ5ghMwD-J6b7F5YcVKNf-5R=8XdEpGDSw@mail.gmail.com>
Subject: Re: [question, bug] regularly disconnecting wifi on RB1 and RB2
 boards, ath10
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, jjohnson@kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        jeff.johnson@oss.qualcomm.com, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=687fb418 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=mUlqW7PtAAAA:8 a=KKAkSRfTAAAA:8 a=vDtTJRS1lcAMuG6nZigA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=scG1X_LE5o0Lo5M-1hNW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8x9cEhTPUbVHUET7euT3Ql1a6-EbESEt
X-Proofpoint-GUID: 8x9cEhTPUbVHUET7euT3Ql1a6-EbESEt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEzMyBTYWx0ZWRfX8M1U+gAev3aE
 X2D5SaPpScHVCP82K2/kBnu5+HEuXifiv+1zu72GOBRDNx7CU5ulL+Wuklxny9EE3H6DDb0wJiC
 gkgbBojNReDJBeJJxzY6iZi1qGH8VKjzZFV+3cvYuwZq7zAJ2KyrnD2p0c3KOnWDIoJQKtdxtu7
 WciOuTEYvOf+n3zt6+BH/m3x6lEDVXhsaMs4kbUOVPHxZjUMqQgH4Q6t8iC89cQ4W9MDUlRXVsF
 pKSEsvfHLzV+//9mf2i0Gjy2DRcPK39dbBjcNrU4s38Z2IrGaWa37UKSavOSBHLycfUAWifad4p
 Ks5iDStJWR/aK4wFqNZFoBFwPSwhA0ZrFunGbqnJuLzuruRtu3TombpHT1F1FJCgusSVoSuOnrL
 b9bwttGDaCQhFh0InVQxKIG4Gc3mOQ25D6dyxNl/HS+0hM7EshcfZQyT9dQsrERcGfsX2VSd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220133

On Fri, Jun 27, 2025 at 1:09=E2=80=AFAM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 26/06/2025 15:48, Alexey Klimov wrote:
> > Hi all,
> >
> > After a long time of testing it seems the problem narrows down to qrb22=
10 rb1
> > and qrb4210 rb2 boards.
> >
> > After booting, the board connects to the wifi network and after around =
~5-10
> > minutes it loses the connection (nothing in dmesg). A simple ping of an=
other
> > machine on the local network doesn't work. After, I guess, around 5000
> > seconds the GROUP_KEY_HANDSHAKE_TIMEOUT message is printked:
> >
> > [ 5064.093748] wlan0: deauthenticated from 8c:58:72:d4:d1:8d (Reason: 1=
6=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
> > [ 5067.083790] wlan0: authenticate with 8c:58:72:d4:d1:8d (local addres=
s=3D82:95:77:b1:05:a5)
> > [ 5067.091971] wlan0: send auth to 8c:58:72:d4:d1:8d (try 1/3)
> > [ 5067.100192] wlan0: authenticated
> > [ 5067.104734] wlan0: associate with 8c:58:72:d4:d1:8d (try 1/3)
> > [ 5067.113230] wlan0: RX AssocResp from 8c:58:72:d4:d1:8d (capab=3D0x11=
 status=3D0 aid=3D2)
> > [ 5067.193624] wlan0: associated
> >
> > and after that wireless connection works for ~5-10 minutes and then the=
 cycle
> > repeats. The longer log with more info and some info with firmware vers=
ions,
> > ids, etc is at the end of this email [1]. Simple wlan0 down and wlan0 u=
p fixes
> > things for a few minutes.
> >
> > iw wlan0 link reports the following when wireless network is working:
> >
> > root@rb1:~# iw wlan0 link
> > Connected to 8c:58:72:d4:d1:8d (on wlan0)
> >          SSID: void
> >          freq: 5300
> >          RX: 45802 bytes (424 packets)
> >          TX: 71260 bytes (125 packets)
> >          signal: -66 dBm
> >          rx bitrate: 433.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 1
> >
> > bss flags:      short-slot-time
> > dtim period:    1
> > beacon int:     100
> >
> > and this when wireless connection doesn't work:
> >
> > Connected to 8c:58:72:d4:d1:8d (on wlan0)
> >          SSID: void
> >          freq: 5300
> >          RX: 850615 bytes (9623 packets)
> >          TX: 20372 bytes (247 packets)
> >          signal: -61 dBm
> >          rx bitrate: 6.0 MBit/s
> >
> >      bss flags:      short-slot-time
> >      dtim period:    1
> >      beacon int:     100
> >
> > This was tested with three different routers and different wifi network=
s.
> > Other devices here do not exhibit this behaviour.
> >
> > Any hints on how to debug this? Any debug switches I can toggle to debu=
g this?
> > I am happy to provide more info or test changes/patches if any.
> >
> > Thanks in advance.
> > Best regards,
> > Alexey
> >
> > [1]:
> >
> > [    7.758934] ath10k_snoc c800000.wifi: qmi chip_id 0x120 chip_family =
0x4007 board_id 0xff soc_id 0x40670000
> > [    7.769740] ath10k_snoc c800000.wifi: qmi fw_version 0x337703a3 fw_b=
uild_timestamp 2023-10-14 01:26 fw_build_id QC_IMAGE_VERSION_STRING=3DWLAN.=
HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1
> > [   11.086123] ath10k_snoc c800000.wifi: wcn3990 hw1.0 target 0x0000000=
8 chip_id 0x00000000 sub 0000:0000
> > [   11.095622] ath10k_snoc c800000.wifi: kconfig debug 0 debugfs 0 trac=
ing 0 dfs 0 testmode 0
> > [   11.103998] ath10k_snoc c800000.wifi: firmware ver  api 5 features w=
owlan,mgmt-tx-by-reference,non-bmi,single-chan-info-per-channel crc32 a79c5=
b24
> > [   11.144810] ath10k_snoc c800000.wifi: htt-ver 3.128 wmi-op 4 htt-op =
3 cal file max-sta 32 raw 0 hwcrypto 1
> > [   11.230894] ath10k_snoc c800000.wifi: invalid MAC address; choosing =
random
> > [   11.238128] ath: EEPROM regdomain: 0x0
> > [   11.242060] ath: EEPROM indicates default country code should be use=
d
> > [   11.248582] ath: doing EEPROM country->regdmn map search
> > [   11.253950] ath: country maps to regdmn code: 0x3a
> > [   11.258805] ath: Country alpha2 being used: US
> > [   11.263466] ath: Regpair used: 0x3a
> > [   15.355756] wlan0: authenticate with 8c:58:72:d4:d1:8d (local addres=
s=3D82:95:77:b1:05:a5)
> > [   15.363942] wlan0: send auth to 8c:58:72:d4:d1:8d (try 1/3)
> > [   15.372142] wlan0: authenticated
> > [   15.377928] wlan0: associate with 8c:58:72:d4:d1:8d (try 1/3)
> > [   15.386338] wlan0: RX AssocResp from 8c:58:72:d4:d1:8d (capab=3D0x11=
 status=3D0 aid=3D2)
> > [   15.466514] wlan0: associated
> > [   23.167251] systemd-journald[195]: Oldest entry in /var/log/journal/=
ec3e0078e5e0499bac67949f3edf3fcf/system.journal is older than the configure=
d file retention duration (1month), suggesting rotation.
> > [   23.185186] systemd-journald[195]: /var/log/journal/ec3e0078e5e0499b=
ac67949f3edf3fcf/system.journal: Journal header limits reached or header ou=
t-of-date, rotating.
> > [   31.750177] l5: disabling
> > [   31.753382] l11: disabling
> > [   31.756385] l16: disabling
> > [ 5064.093748] wlan0: deauthenticated from 8c:58:72:d4:d1:8d (Reason: 1=
6=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
>
> So.
>
> I wonder what state the GTK - offload is in here.
>
>          WMI_GTK_OFFLOAD_CMDID =3D WMI_CMD_GRP(WMI_GRP_GTK_OFL),
>
> drivers/net/wireless/ath/ath10k/wmi-tlv.c:      cfg->gtk_offload_max_vdev=
 =3D
> __cpu_to_le32(2);
>
> Try toggling that offload off or on and see what happens.
>
> > [ 5067.083790] wlan0: authenticate with 8c:58:72:d4:d1:8d (local addres=
s=3D82:95:77:b1:05:a5)
> > [ 5067.091971] wlan0: send auth to 8c:58:72:d4:d1:8d (try 1/3)
> > [ 5067.100192] wlan0: authenticated
> > [ 5067.104734] wlan0: associate with 8c:58:72:d4:d1:8d (try 1/3)
> > [ 5067.113230] wlan0: RX AssocResp from 8c:58:72:d4:d1:8d (capab=3D0x11=
 status=3D0 aid=3D2)
> > [ 5067.193624] wlan0: associated
> > [10437.346541] wlan0: deauthenticated from 8c:58:72:d4:d1:8d (Reason: 1=
6=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
> > [10440.340111] wlan0: authenticate with 8c:58:72:d4:d1:8d (local addres=
s=3D82:95:77:b1:05:a5)
> > [10440.348408] wlan0: send auth to 8c:58:72:d4:d1:8d (try 1/3)
> > [10440.356698] wlan0: authenticated
> > [10440.361077] wlan0: associate with 8c:58:72:d4:d1:8d (try 1/3)
> > [10440.369516] wlan0: RX AssocResp from 8c:58:72:d4:d1:8d (capab=3D0x11=
 status=3D0 aid=3D2)
> > [10440.446661] wlan0: associated
> >
> You can put another device on your WiFi network into monitor mode and
> sniff what is taking place.
>
> Kali Linux I've used in the past on an RPI for this purpose and it was
> very easy todo.
>
> https://cyberlab.pacific.edu/resources/lab-network-wireless-sniffing
>
> Another thing to try is to do this same test on an open - unencrypted lin=
k.
>
> If we really suspect firmware here, lets try switching off firmware
> offload features one-by-one, starting with GTK offload.
>
> ---
> bod
>

I configured the GTK rekey interval to one minute and encountered a
similar issue. It appears that something may be going wrong after the
GTK rekeying process completes.

The GTK update is handled entirely by wpa_supplicant (not offloaded),
and while the new key seems to be installed correctly, with frames
still being transmitted and received (from aircap perspective), they
appear to be dropped or mishandled in the RX firmware path.

This suggests there might be an issue with how the new keys are being
applied or interpreted by the firmware. I=E2=80=99ll continue debugging to
pinpoint the root cause.

Regards,
Loic

