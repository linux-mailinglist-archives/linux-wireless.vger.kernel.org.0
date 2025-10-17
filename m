Return-Path: <linux-wireless+bounces-28034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57307BEA13D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF111189D46B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D9A33508F;
	Fri, 17 Oct 2025 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApLfEfHO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55E330B01
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715459; cv=none; b=D5ScQlvEEFxLsTfUKl8TFES3TGiB1w7351pEl08iBpMfIQPV6wGlAevExWisR3BnBPNLXCx0qqCPLQSzHbI2g/NcA5cXdnwxm8U/h3MpK3Usp+zWiR06lG0qGk2jGsGD2gYvGyjpgdrVV56wqj5PSWwa9KRW1o4cD1sX95qmTKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715459; c=relaxed/simple;
	bh=jnSlqMUAPa+eyLVz/0g1PqayIf3lM2TbZXxkHURbCkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9NpiBYW6GXvISUpwjr2mpHv2kqrNG1wMjpUHpTZGE33YrYPYHO7QePJ5u0xWR1NusRwasEjVG8fe4FMkrBbyonZXkkrqERVvQL2DGCsuwz7t+cnSLbvfbr+NMUGZO/0J+V/laU4dCz6aRfYa5jk3efFqPhIxY0mm+hSIoACf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApLfEfHO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471131d6121so16527855e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760715456; x=1761320256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1BoJuRNJXSzQvDBOd11eTytEqGRXiQbkzU89SqMVXiI=;
        b=ApLfEfHOuY/RJQzuoYZyiZnZZO1FTWYrE4bWeZR1SdgzsYEEGqRF14hcFBY+be4mFr
         gRMnu9Z/RhHtPzNB286PknMGuRg/3qYjb6K5gLXFBkHtiowUwU16rUPO9eHxa6Pk+D4u
         a0ckdwVyzpbGBIdM+DO3okprWychINYktP+Gw5tUejYAjdQU6GXDilAmguvEyrXH5U14
         cM18ApvXDFcMeBMdktwAFdI0OLICHwBp6S640+xx2R01sZTKECLLUA+YsgWbik8uwh9m
         YKbQQDly0X+fitKrp4J9dAIPCoRuiKEaBsGXI05beDdiozyKd1SiQ1LvugUnnHXbnxOJ
         w2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760715456; x=1761320256;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BoJuRNJXSzQvDBOd11eTytEqGRXiQbkzU89SqMVXiI=;
        b=GroY0Kbk/kkOGCRO0SO0+byFOxbdwZlmwU5NLY9S6rkPLoVYV6P9rxp/rUUc0WbzuX
         G9uWx7O4EM3izQTR3NEMJc8dj+dYGi5gA44Sxh8eeHGHqLz4eyeJnxNGASSt9tFQHVNi
         NNy4Jk6iMftvqe9vIl2fJDF+MnIZsCGJ6rBQIyr2HqxZFEOSEVvlioZZJ0/ZehtYfndc
         JNsB36sPNXj53ohnzylcrRagd1yIxIHjrlM3vxP1vAUl87b6O281t/k7UUOWTSNIAeCJ
         ShGJ7yi4lInjHJCPNYMD9rHFwzVRPO6XZG6qGI8yXZR0eg4cB4atEOAtbIsnNF7jB1EE
         9nug==
X-Gm-Message-State: AOJu0YwCZ2rnmLKq3ShTRAKOkwu1S9Iu281kNm4QeSYVaE+x1cPBu7Tv
	+7Fk7S2jWgXVQDSGpWUj7n71hC9AM6Wv+XC1M7NBlPZYciA4l5KRW9YDD+2vsSD+
X-Gm-Gg: ASbGncvmpV25LRUiHbf4XrM0GMVrwOywUyScWLaPBQ11wnmA0LXl2xtcBJvZfzlVRRo
	OVFodQc2LFf2eXuN+W0GqWt40+NEhiVRriT6HToPKxhohbj88pDFLfFGldjyJmaK6v9jLbMBT2f
	cmWgsq2p3xwE8tAik6IaIrwU8hOuBQytBQIkaFR+6yJqGM5EVBwPZ28SqqnOVL/JidjChOIWtu3
	GlKbAcjgUMOKxaFgd6ySzP7kJffaXz/9Dm0QNoif30mYWx9wCnl+SFgYcOmpzH9i9tzWTwB/qS4
	1jfBFNCTog57kpF69m3UJU67aPQQi9WeZhRyrvOBZHseOyXWXSguNGKchnSdZjnG+HhoNcFsPvY
	2+omzFitYTONn5ksdwTtgSJIuUuiOBr3OxfGLRFZocEzj3omAO88wNfUQRzs7MfWj0NbFBb+Qdt
	LnzeCl16iRz/36cHGbFyENHrzXS20dGNAgWROBhRVVfZRsnQE=
X-Google-Smtp-Source: AGHT+IGxdizsadmNUP4DyqdtkY9tA3P/0PbidzrbWBSZDjJL6m6HC8+kcqTeIt0odZZji+zDr6Brkw==
X-Received: by 2002:a05:600c:8b78:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47117902dbcmr27810585e9.26.1760715455782;
        Fri, 17 Oct 2025 08:37:35 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:eb4a:643c:a4f2:32ae? ([2a02:168:6806:0:eb4a:643c:a4f2:32ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm1687645e9.0.2025.10.17.08.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:37:35 -0700 (PDT)
Message-ID: <6d41bc00602c33ffbf68781f563ff2e6c6915a3e.camel@gmail.com>
Subject: [REGRESSION] ath10k fails initialization, bisected to "wifi:
 ath10k: avoid unnecessary wait for service ready message"
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Jeff Johnson
	 <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>, Baochen Qiang
	 <quic_bqiang@quicinc.com>, Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, 
	regressions@lists.linux.dev
Date: Fri, 17 Oct 2025 17:37:34 +0200
In-Reply-To: <175823924851.3217488.17742065327824732992.b4-ty@oss.qualcomm.com>
References: 
	<20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
	 <175823924851.3217488.17742065327824732992.b4-ty@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 16:47 -0700, Jeff Johnson wrote:
>=20
> On Mon, 11 Aug 2025 17:26:45 +0800, Baochen Qiang wrote:
> > Commit e57b7d62a1b2 ("wifi: ath10k: poll service ready message before
> > failing") works around the failure in waiting for the service ready
> > message by active polling. Note the polling is triggered after initial
> > wait timeout, which means that the wait-till-timeout can not be avoided
> > even the message is ready.
> >=20
> > A possible fix is to do polling once before wait as well, however this
> > can not handle the race that the message arrives right after polling.
> > So the solution is to do periodic polling until timeout.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/1] wifi: ath10k: avoid unnecessary wait for service ready message
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit: 51a73f1b2e56b0324b4a3bb8cebc4221b5=
be4c7a
>=20
> Best regards,


Unfortunately, this particular commit completely breaks the ath10k driver i=
n my setup.


Hardware:
- Turris Omnia (arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts)
- Wifi card (output from lspci): Network controller: Qualcomm Atheros QCA98=
6x/988x 802.11ac Wireless Network Adapter


dmesg output after loading ath10k_pci

[    5.895939] ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mod=
e 0 reset_mode 0
[    6.152971] ath10k_pci 0000:02:00.0: qca988x hw2.0 target 0x4100016c chi=
p_id 0x043202ff sub 0000:0000
[    6.152994] ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 0 tracing 0=
 dfs 1 testmode 0
[    6.154343] ath10k_pci 0000:02:00.0: firmware ver 10.2.4-1.0-00047 api 5=
 features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
[    6.214165] ath10k_pci 0000:02:00.0: board_file api 1 bmi_id N/A crc32 b=
ebc7c08

So far so good, but then come the problematic error messages:

[   12.509390] ath10k_pci 0000:02:00.0: wmi unified ready event not receive=
d
[   12.580885] ath10k_pci 0000:02:00.0: could not init core (-110)
[   12.586891] ath10k_pci 0000:02:00.0: could not probe fw (-110)

And the corresponding netdevice does not appear at all.


---


If I revert said commit (on top of current mainline), all is good again:

[    6.112174] ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mod=
e 0 reset_mode 0
[    6.264184] ath10k_pci 0000:02:00.0: qca988x hw2.0 target 0x4100016c chi=
p_id 0x043202ff sub 0000:0000
[    6.264199] ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 0 tracing 0=
 dfs 1 testmode 0
[    6.265591] ath10k_pci 0000:02:00.0: firmware ver 10.2.4-1.0-00047 api 5=
 features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
[    6.298955] ath10k_pci 0000:02:00.0: board_file api 1 bmi_id N/A crc32 b=
ebc7c08
[    7.458285] ath10k_pci 0000:02:00.0: htt-ver 2.1 wmi-op 5 htt-op 2 cal o=
tp max-sta 128 raw 0 hwcrypto 1
[    8.910074] ath10k_pci 0000:02:00.0: pdev param 0 not supported by firmw=
are
[    8.934074] ath10k_pci 0000:02:00.0 wlan1: entered allmulticast mode
[    8.934187] ath10k_pci 0000:02:00.0 wlan1: entered promiscuous mode


Best regards, Klaus


#regzbot introduced: 51a73f1b2e56b0324b4a3bb8cebc4221b5be4c7a ("wifi: ath10=
k: avoid unnecessary wait for service ready message")

