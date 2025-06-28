Return-Path: <linux-wireless+bounces-24637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973A1AECA61
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Jun 2025 23:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A193F3BC00E
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Jun 2025 21:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3269D241664;
	Sat, 28 Jun 2025 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fsz08xF1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007D224B1A
	for <linux-wireless@vger.kernel.org>; Sat, 28 Jun 2025 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751146087; cv=none; b=sBE5XOLQmy2fVRLx49Hm2ZBkmLaCfqHUwN0s3afN2Q9Xmkw8SlQ8Jvb4Iyc35EfwtDHJzw34LDQH4RCdm8az+xDdkwT7qLAGVgWkebtgWQ+7dmkN6dlXiWAAyW2nx9QX+9tOitBs5Ef7e66tWp3jsos8DbEg2rIfSNVJeHvgpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751146087; c=relaxed/simple;
	bh=xPiyU4o9DEf22Axii/WdHt7PZ6g6/zgV4Njyrksx284=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=Pe2yEZzSKc0dX4aWaAudijuXzQAcyr89dWu1dFkGe49a5LVWE0q/NARi2rupHTLT4wHXUVHGC9w49Se9nIiX32fFvm8iFyFv2F40h9EgauL97mAnsq7k7pv6/DZNKqQwRIED/o6M/R/36M8RIExijCsBpJGlhkE2DokDh9Zrxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fsz08xF1; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-87611ac3456so30307239f.0
        for <linux-wireless@vger.kernel.org>; Sat, 28 Jun 2025 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751146084; x=1751750884; darn=vger.kernel.org;
        h=references:content-transfer-encoding:mime-version:subject
         :message-id:to:reply-to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPiyU4o9DEf22Axii/WdHt7PZ6g6/zgV4Njyrksx284=;
        b=Fsz08xF1FlepuJk3GtLu408e6WmO8XIEafT+dJXSxEbOaV4dQPVd05i/jm+Tz2Etc8
         Lw0RdGxSMoHLqTXCrTgo6a+BsxGwRi8bLSUje23vuLp+ljXWdWUH9O1kvfw2LTCRHDTm
         BwdSXhvr2Vcr9wfSuyrffLY3DMQqwOTViozs8MVY2V5eR8qBJQwH9e77In1ntOfr1HrN
         RgPXk0Wy1wvH4xhh6Og9V0oakgymX8570VUYQJ8XyKSS35IIc1zeztINqV1zucRshTdR
         dc/6OVR9Yx0hrhnRpEz4iQjsAUZBIG7xiaelLb5whtRADzcRuhQvwqCiKumyMa9EZH1n
         +hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751146084; x=1751750884;
        h=references:content-transfer-encoding:mime-version:subject
         :message-id:to:reply-to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPiyU4o9DEf22Axii/WdHt7PZ6g6/zgV4Njyrksx284=;
        b=B7I3Vd19Wdjq3TZ6c5xZ8MOGktjUtptwEauytFrekvDCTAlkhh+pxQm/mgll11QNRo
         azcY+AUsiu1IU6rInlyYHpJpBHo8fezUiuN/2eFHS6a7BmSGtEDAiT5s17bAystiH0Ll
         Xw2cBUdoJFCjeO7gOX+b3SsTwHtItEQdHuTmDJFJleGoATPUVGjQE+IvDKwIPT0cbBSU
         RhFvV0p2mE5AqkhezK75VUr971h7nryPGMbGcomRN+k/qJANalDqj6oaShUG64TdtlX0
         eClrYryyuIA4QX8O+z/OpuskH48totuiU7umzf8hiXnp6AsEfQU1JYOPH2s5qxCJGnMB
         BwIw==
X-Gm-Message-State: AOJu0YyiCUVr2LqHw23SsZHJaBq4YqmwyRLZ/QWT/sXGGl+jfOYzFtXj
	RSXhze5+IW/RskgfkzW1UavTMxJiHRJHUsqXb27Iw5lI8eIml5nfF0lIRU90Tw==
X-Gm-Gg: ASbGnctTPTOjKLEd0So88zGgkfGVZJYmQqImizFXK2JAIepgZEsyW0Ui4h22SYlGRPl
	fse+U+iePlxEb6VqnHbzGDh64qN41oFJRH72rL0/EUxCS5m9BFO2zjfAmLy3Iz4+7ifhuCSfELx
	JwsA/KpcO2QZaNrdklN7kQTcU6gXw+b9AOzEqEAP3qyIc0G9hC5xAFz/Mxrm2PGFO5JywEHO3fh
	22NRHe7aiFE7iN9tuezivvdHtfACKopK5Pr9B8HDFfQJcuW7ktjNC4kISyC7cflYieywt2PYs03
	Hz14lIdNwQLpxBHWY0WOs96Wo4vdpv5I0g9X1G/a6Zy03SYPKTI0dQkAmPTyraVg75PcTJUgom/
	8zAYSr2Kleqf5B2KdPQ1Wmdlb8JcoLRgMzQaDUzBaWVCV10uddmY4
X-Google-Smtp-Source: AGHT+IH0fwdz4aG3U2XZCYBs6BSR2NaUfh7xh3dD75J74nPoiX1IlnU6POuMEZX1pWw75e/vnzfKIQ==
X-Received: by 2002:a05:6e02:3a0a:b0:3df:5309:e97f with SMTP id e9e14a558f8ab-3df5309ed5cmr62702695ab.22.1751146083594;
        Sat, 28 Jun 2025 14:28:03 -0700 (PDT)
Received: from sonic319-20.consmr.mail.ne1.yahoo.com (sonic319-20.consmr.mail.ne1.yahoo.com. [66.163.188.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-502048d6949sm1171265173.55.2025.06.28.14.28.02
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 14:28:03 -0700 (PDT)
X-YMail-OSG: M0HeGVIVM1lyhkLE7s1rbU6cHdOpRpjWkXIl191r.YYCsgpyPzRKogGrq2QlXMm
 a3VxEJauEIJ9l9wb7kcxBQHvNEDzqCKqu1SXeOjZZNBb4i8VL_jJHiQy7XRV9l9Iv9Fh7Dnegz0x
 oLBz9OOSiTu.fezsnoHu.LCYXG.SF5JsyPN830g_9idgjWuxXxFgAO5PpkQiqO7lK8I1Ia0fhYtf
 uM9H802DT_jsBulgxdLIy3reggcLZWc21k8vErsWiVdbUbzV2xOCm22XGuFhWgCwsNYDw.1258O7
 U_LdaPuuav_A8XHp5JNNs9juUHCo43cw13p2wdkJmO2uldvZbkNDvrNms2lZcOUW2aDsCpkEmliM
 sIJOOE4vL104ynuf._IXxx5opfI_.Yf2iM6ynkTXaZebUW76trCrxdOCVHZ1DBOfFwdlNo5nQvl9
 1xY6Aaa1Gbc2M_S73ViJKBhorDwSZ7ukw7GqcxpxymRIImWIJGaECBpD2J5Mnw8K1zanZRuGMVAk
 iTgPIJcw5cISYZbCYZXTK47c3ffeUmlfIVUEDdaxmsYhlUEVvKdnsCKlgyesGJoxpVzNFFexBN1p
 2JvtHzHa7rOWAKCmxTuJmwQJR0Oe4vSFUzu9eWX3YSUNnR9FjX66e2ShcM1bFkObyYeokB7gWZbJ
 FVz98YS_6kKYa3tPq60gs6OCR_fzgQc.ZdR2t50ORHG05rDX13oOGm0F7vUK2rsOF_vMaMJmZXBv
 AQtGQMktnSD.E3sgdvz63Cypw5BL7cdO6r3nw757WhF2mTm_r1Knb8G6Z95.MBp.7B_5LdcnPmRK
 ha34YOCX0eeL7howzUJVWw2mmvC1kfgVDeJV383LqOh5UR3_uMdlJmXlWrXGnJZ5PHc.TPe4QT1N
 EJWQXJtr.oNjLj8vCfGP_uNwjKrClbPmOe3J7QIeZXQEBRxcGRqc7NCVn.Kj7ShG6yVCE5MrHCfV
 yL700PTMR_nHvloOvET.ExPBGg.YaKMeVEiTApJAdw6kydZ64uZncOX7v4JimRJ.dik2x.4bLnjd
 bxARJvORWY_ZPScIZIY_Khu6N_dBLYYlKKzPy1FWtIMjsIvaKwPpVpJidDJFwhP_LN.9MRCbsMe2
 03IkosXFT7HPbMNCmdZCCxVWqoGCfw.B4FLSDxXwCRSWByOX0VpwGlg3IFZqvI2zrBX15hyscLVa
 3ZiTV_t1VZa9LmI1D.XerpGGHPCSwRj_Y8koqYc1XBTN20FiCtdNEhwbRhMkY3_gIaNcw1oQsEG8
 KuxFMhhQs..DnUo0CrVeHPhrto2F2jCM73lHCXvL0rXVHA6fXGRiDdQwZKHm.L4f5PpndVlqBGFh
 YFmzJqizyt3WEbQq04iFw_HqIGPmIAU9NRQErGRCo9pjhFXCqSiZoI6EWskUBSGat9OvRMq73ZwU
 W8ldRc0OeORgfR419ZF3mAYcG0rhcG5Fl_am7j60m7CEpjYM7DJ_1AhyiqqsB2WfP6WIuPH5gkh2
 VNk1fyDXyJpVijLbMVX3CRiChnkxO8.X1IuqPnDmH30eFKOGpTTYoBf1i5uyVrSS6Qb_X3HX1C7Z
 Ezn_cbfKGxvfwRbYq75uDzGYngOAK7yI0eJCDft2rzjKbdg9e1MpQ.fq_Pqu2EAtXoQJEZ9xAhXU
 NMqgzqXgESdXCFmcbHj4F__GQR.pb0HynvRheFtYhh5SE3lSfpEzUbFA2_JrKKbGth6ld.c66VJx
 _N4HGUdawRCsS3cKx2Lde0U2agIfM2tX57qFy.eJYO_AuKtcCExKCbzkZ8wsKZ1wHIAm6urHk9_3
 vU16Zd2Zj71o91xlxh0J8AA9QfW0lWN8a4j82JPIttiXtHLN5yvPhUTKjigdqFE0DmxCP9lXiqBU
 QEUZvKnNHPQj9j4pyn0jzxVbgXeQNGbW3DA8zFqZF5Yde7sqKlQRl6EMLcxAOcg0w8Pa7o1ASM92
 uUrLDTia17m3.IVyXKoiVoO9vM7FU0OnszTPQM6U5kcHVo8ydEfWymtwMOqgswetSbyNpt1R.Vx5
 Kv0vdF2kjPhptvkTY5.4HhTje.CGcEHZ2LeUM3qJP4dO.GdrakZeCNfOo9r3LiOMUWW_JZi2QULk
 t72st30D7WtIv7.Jnpbtv8MSpyxR1PWl5Qt3FHOsymv255oLIJvSHLD9Aj1Knckc7ECSFWDcDhHl
 a7fgno3K81JgsSwkXvvciMemzCgPnfj7H41v0ukAmd067MJHKEy5n4O0_16XbUb1KjOJ2otkLHby
 ve5cuN18He2kWk4gMVw--
X-Sonic-MF: <486x86@gmail.com>
X-Sonic-ID: b71ae515-ed54-4138-9afe-376ff4178919
Received: from sonic.gate.mail.ne1.yahoo.com by sonic319.consmr.mail.ne1.yahoo.com with HTTP; Sat, 28 Jun 2025 21:28:01 +0000
Date: Sat, 28 Jun 2025 21:27:56 +0000 (UTC)
From: "486x86@gmail.com" <486x86@gmail.com>
Reply-To: "486x86@gmail.com" <486x86@gmail.com>
To: linux-wireless@vger.kernel.org
Message-ID: <1935176921.584803.1751146076922@mail.yahoo.com>
Subject: [BUG] Regression: Frame injection fails when AP mode is active
 (regression in v6.9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1935176921.584803.1751146076922.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.24076 YMailNorrin

Hi,

I'm reporting a regression in wireless functionality that appeared starting=
 with kernel v6.9.0. The issue affects monitor mode frame injection when an=
 AP interface is already active.

Description:
Monitor mode packet injection fails when performed on a virtual monitor int=
erface created while the physical interface is running in AP mode. This wor=
ked correctly in all kernel versions up to v6.8.x but fails starting from v=
6.9.0.

A maintainer of the rtw88 repository hinted that the issue might originate =
from the following commit. After compiling and testing the parent commit, I=
 can confirm that the issue appears to originate from following commit.

=C2=A0=C2=A0=C2=A0=C2=A0* Commit:=C2=A0wifi: mac80211: simplify non-chanctx=
 drivers =C2=B7 torvalds/linux@0a44dfc=C2=A0 " wifi: mac80211: simplify non=
-chanctx drivers"
=C2=A0=C2=A0=C2=A0=C2=A0* URL: https://github.com/torvalds/linux/commit/0a4=
4dfc070749514b804ccac0b1fd38718f7daa1

Reproduction Steps:

=C2=A0=C2=A0=C2=A0=C2=A01. Configure AP mode on wlan0 using hostapd
=C2=A0=C2=A0=C2=A0 2. Create a virtual monitor interface:

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iw dev wlan0 interface add =
wlan0mon type monitor addr 12:34:56:78:AB:CD

=C2=A0=C2=A0=C2=A0 3. Test frame injection with your preferred method

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aireplay-ng -9 wlan0mon


Results:

Working behavior (=E2=89=A4v6.8):

23:58:12=C2=A0=C2=A0Trying broadcast probe requests...
23:58:12=C2=A0=C2=A0Injection is working!
23:58:14=C2=A0=C2=A0xx:xx:xx:xx:xx:xx - channel: 1 - 'xxxxxxx'
23:58:20=C2=A0=C2=A0 30/30: 100%
23:58:20=C2=A0=C2=A0xx:xx:xx:xx:xx:xx - channel: 1 - 'xxxxxxx'
23:58:21=C2=A0=C2=A0Ping (min/avg/max): 4.066ms/27.308ms/170.734ms Power: -=
24.87
23:58:21=C2=A0=C2=A030/30: 100%

Broken behavior (=E2=89=A5v6.9):

23:58:12=C2=A0 Trying broadcast probe requests...
23:58:14=C2=A0 xx:xx:xx:xx:xx:xx - channel: 1 - 'xxxxxxx'
23:58:20=C2=A0=C2=A0 0/30: 0%
23:58:20=C2=A0 xx:xx:xx:xx:xx:xx - channel: 1 - 'xxxxxxx'
23:58:21=C2=A0 Ping (min/avg/max): 4.066ms/27.308ms/170.734ms Power: -24.87
23:58:21=C2=A0 0/30: 0%

Kernel Testing Matrix:

Working kernels:
=C2=A0=C2=A0=C2=A0 * linux-image-6.1.0-kali9-amd64 (6.1.27-1kali1)
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-6.1.127-custom (6.1.127-1)
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-unsigned-6.2.0-060200-generic
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-unsigned-6.2.0-060200rc1-generic
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-unsigned-6.3.0-060300-generic
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-unsigned-6.4.0-060400-generic
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-unsigned-6.5.0-060500-generic
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-unsigned-6.6.63-060663-generic
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-unsigned-6.7.10-060710-generic
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-unsigned-6.8.12-060812-generic

Broken kernels:
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-unsigned-6.9.0-060900-generic
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-unsigned-6.9.10-060910-generic
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-amd64/kali-rolling (6.11.2-1kali1)
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-unsigned-6.12.0-061200-generic
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-6.12.13-amd64
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-6.12.20-amd64
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-6.12.25-amd64
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-6.13.1/bookworm (6.13.1-1)
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-6.14.0
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-6.14.5
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-6.15.1-toeirei
=C2=A0=C2=A0=C2=A0=C2=A0* linux-image-6.15.3-toeirei

Additional Information:=C2=A0
This regression is not limited to the specific scenario described above. Th=
e issue affects multiple interface combinations:=20

- Creating a monitor interface while the physical interface runs in AP mode=
 (as described)=20

- Creating an AP interface on a VIF while the physical interface is in moni=
tor mode, then attempting injection on the physical interface=C2=A0

- Using the physical interface in client mode with a monitor VIF - injectio=
n fails in this configuration as well

Please let me know if you need additional debugging information, logs, or t=
esting.

Best regards
i486

