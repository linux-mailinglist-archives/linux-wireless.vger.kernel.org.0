Return-Path: <linux-wireless+bounces-19794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E49A4F8C6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 09:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B30170154
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D031C8FBA;
	Wed,  5 Mar 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEqriGM8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E11FBEBB
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163238; cv=none; b=tI7Kk0z+ooUtt4TlTktgP90oiphUBAcwESUGZ2F6zXLg4/0DYx34er3fwzrosY8OLLViSGWJqv0dM7rOX60WNIZamI7VtN4mk4/u12me9xZvx53nlQ/MBMTBNFhsJJB16/aDcQMN9vZX8G0MCOxvULP+b7WLbFyDRtAgHtddLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163238; c=relaxed/simple;
	bh=egIQ8DzuMpi8AfafxMEYlrQn44+DhYWzu2OuHYCGSoM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=gApZgY+UA6bIN3wapTqDrMganHkycvli2sw4+erB1zuXuNqxQWgtqI1hVvcWOhDT9Q85Mo7O8zDrCJoD7JxdPscLa7bql2K6x7Rky14wSDVh96kBrJAwgQOoRKB5PciGJ6TOdfm8xF4W3M0+0PF1DUroPhz8sOdGFTgq1W4AaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEqriGM8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so29628485e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 00:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741163234; x=1741768034; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wx6niFNxB11vVymGAkoEEkkaFjOWfbgUXeUXpDwUHqs=;
        b=nEqriGM8yuwQeYFcvGj1WewRt5OY+yIf47HXdKO9elRgasFsRppSj0IlWX17AC64z/
         SHK+HRs6v1P9fFQ3ysAWkMY7bPGuhKBOS7iGTLXbE/Dz3kEAq/LoxjFqzsP636iWx5Aw
         spmT5xdRdY/JwW5c1CKQQvaBMl2YEdf6x6wkJmbtzf9/PLGupUiX+bohpmMS9o3RmXPN
         UCxwfb099xI7Z0NX7GmlNtcOqwJnlMF5yGu8TXbPEfgw4JhEhdE8WebiwIftVfCqTF8t
         Ihnybc/PwuW0/G/o6H9xGsreyIbdJJ73VCPPt1oe0vysnegaAgWzoHVEVu1sZEl6bPHm
         ZhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163234; x=1741768034;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wx6niFNxB11vVymGAkoEEkkaFjOWfbgUXeUXpDwUHqs=;
        b=gmqr8rKNoMmazTzkSlyXRRxN11a2DWxu8gBpjf12olb6qlCDEQdxrQ44qFTmxlDhEP
         8L6biQEkz9/gv9c0gFcKAA0fT0rxY7smluiC2yKwM+bHU3kJpvPViia5D2+yvXiyhY14
         icXFoSgflsLBxLDwduuPipLiUTLNYDNnF72KYgh7RO1sQKSd+QQc236Uagj8aNSqxX70
         VRZtFk7c6xmZZQ8q1peUh5C1g8o4Da1wzqidkbwc5hldYKXUedbvD915HTr2FyiHwht2
         7LppjRBMo7HPQ9cQ7m2l6/Fzs78noGmOV2mieWfEY1VJRkObSLws8FpbDH6ADKrtOBfI
         Pf4g==
X-Gm-Message-State: AOJu0YwOIB+1jCCACGH8P6ZcNQ5oaSHjhJvKW1gyACFxyslM7qJWDfQY
	5ZSwXl1l+VIdD0PuEkX2fRlaVnvemW/3qi+6IO/uYjB3dY4rcBMrDb4YqS4=
X-Gm-Gg: ASbGncsu43oBLSKpmHnRcMa7KPf6ug2djQaOcb3hNmmnZ503Qn8m7gl8sleA5bj9mxY
	kHkMMHvc0ykN9uWcpWObmtIWLf8u1zOGMDSa4lT98ozGWptHKCEjeCXTEPLlTXEz5+DmV26MwRh
	5OWlCkPxnT7PHjMg6CG2OinEK8MQuN2h/n3+Ffk+e+z1dRTQvVu/soOF40157Oa40yoVXEyUe8o
	heI8ddiilcZSqt3OogNhkTH1Ee9VXzxIRkWbG7uvU/bGmMlAGy1IaquqjWtdwxxcMM/Rv9qpgK4
	YtkGnz3hEJrxOmumdDEb0N9WnAc0LI5zEvyIZ4PncI9AcKMpm6x7W+/Z4V7383qtqCUK1jDcVaA
	Tsf3EUSYpXHP5LGxLTSU3wL7RtEeFNNg=
X-Google-Smtp-Source: AGHT+IFo/BzBCp9DlgvFbq8tLwKtcaqZqQ+JEIfrk5TZCy8Dd0SOeQ7gch8CJZYZZZfbWo2aD7lGyQ==
X-Received: by 2002:a05:6000:18ad:b0:391:1388:64b7 with SMTP id ffacd0b85a97d-3911f7c39c7mr1629746f8f.46.1741163233957;
        Wed, 05 Mar 2025 00:27:13 -0800 (PST)
Received: from winhome (cpc112753-pert6-2-0-cust678.16-4.cable.virginm.net. [86.18.22.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479596dsm20161761f8f.7.2025.03.05.00.27.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:27:13 -0800 (PST)
From: <rmandrad@gmail.com>
To: "'Dennis Bland'" <dennis@dbperformance.com>,
	"'Ping-Ke Shih'" <pkshih@realtek.com>,
	<wens@kernel.org>
Cc: <linux-wireless@vger.kernel.org>,
	<wireless-regdb@lists.infradead.org>
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com> <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com> <ff6ad414457e4b1cb68e834978a553c3@realtek.com> <CAPRryQobXZe5OwR=F-X0KHYyfBwUpFsi=Y5pKnENcUXTN42xAA@mail.gmail.com>
In-Reply-To: <CAPRryQobXZe5OwR=F-X0KHYyfBwUpFsi=Y5pKnENcUXTN42xAA@mail.gmail.com>
Subject: RE: wireless-regdb: Allow 6ghz in the US
Date: Wed, 5 Mar 2025 08:27:17 -0000
Message-ID: <006301db8da8$686cbb20$39463160$@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMUrzCf8XdNoAU6+fu4ECJnDc0awgHIktuQAg9ms7MCOQTCT7DBabeA
Content-Language: en-gb

Hi Dennis, et all

122. is not specifying NO-IR which basically is denying any 6Ghz in the =
US what it means in my opinion is=20

Client devices (like phones, tablets, laptops) need to find Wi-Fi =
networks before they can join them.
One-way devices do this is by sending out probe requests. These are =
little "Are you there?" signals that ask nearby access points (routers) =
to respond, so the device knows which networks are available.  This is =
why drivers use the non 6Ghz for allowing clients to identify the router =
has 6ghz capabilities=E2=80=A6 I don=E2=80=99t think is for =
wireless-regdb to take over the HW router compliance and certification =
which is  what 122.  is about

Thank you
Best Regards,
Rudy

From: Dennis Bland <dennis@dbperformance.com>=20
Sent: 05 March 2025 05:49
To: Ping-Ke Shih <pkshih@realtek.com>; wens@kernel.org
Cc: rmandrad@gmail.com; linux-wireless@vger.kernel.org; =
wireless-regdb@lists.infradead.org
Subject: Re: wireless-regdb: Allow 6ghz in the US

Hi everyone:

Section 122 of Document 2020-11236 (Unlicensed Use of the 6 GHz Band) =
mentions the following, which formed the basis of the NO-IR requirement:

  122. The Commission recognizes the utility of permitting probe =
requests to enable client devices to join an access point's network. =
However, these probe requests have the potential to cause harmful =
interference to licensed operations. The Commission therefore only =
permits a client device to send a probe request to an access point after =
it has detected a transmission from the access point.

Best regards,

Dennis


On Wed, Feb 26, 2025 at 2:09=E2=80=AFAM Ping-Ke Shih =
<mailto:pkshih@realtek.com> wrote:
Chen-Yu Tsai <mailto:wens@kernel.org> wrote:
>=20
> > based on this remove NO-IR flag and allow 30 dBm max power
>=20
> The original submission mentioned NO-IR requirements, though I did not
> find such wording. Dennis, do you have any ideas?
>=20

FYI. The description below in [1]

In all cases, an exception exists for transmitting brief messages to an
access point when attempting to join its network after detecting a =
signal
that confirms that an access point is operating on a particular channel.

[1] =
https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicense=
d-use-of-the-6-ghz-band



