Return-Path: <linux-wireless+bounces-25860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14662B0DA79
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 15:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDFF6C480F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 13:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133A12DA76F;
	Tue, 22 Jul 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fronius.com header.i=@fronius.com header.b="OipAOWrJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx01.fronius.com (mx01.fronius.com [213.33.117.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7A2DA767;
	Tue, 22 Jul 2025 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.117.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189333; cv=none; b=WYsVJj9YGWb00+wj/pOthSG7vZdfD8E9TEXer8Y+6sd7zmifHOsu2gGU7xO8GDcKAzK59ZrxPBZqz8PKPIejIeewf+iTRrFxtSrOcCIs5TXEyf/QdRB2CuoSOgNuvqfcGz9YAFDs0KKtnX9ZEQQx4LdX3AJR3Jtz0uxiDGnA5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189333; c=relaxed/simple;
	bh=VqMMqbK/fst5K37xnNgIoLGKG0pUcpwCFbhYyZmDf2s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e5MfYbeu3jX07ueHmf+x9FfHKTutR/5h8m+gDWi3nHJJBEWLAxpYwd4K3Wzhnmpid0sFKznTUH92QMqz8I0Jnjbw/nd8jB52la5szAYM8Tb1plyVTtRQrcz5kan1JL+fIFaMx3wR/4oUFpR6s3WUPMiO9ruwaW3hdP6j7inkJto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fronius.com; spf=pass smtp.mailfrom=fronius.com; dkim=pass (1024-bit key) header.d=fronius.com header.i=@fronius.com header.b=OipAOWrJ; arc=none smtp.client-ip=213.33.117.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fronius.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fronius.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=fronius.com; s=s1;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=lZXg7IlYCNysrBEGTDmUEgh4K7F5kJfCBni7fk6/FZA=;
  b=OipAOWrJn+ULO+s8Wxf5YX1d3UBlcxOeVd3WdMsnP/9fmz6MnQKQO3jX
   CspzPkFXfQdZ6VU8TiRd0IdkTUndC9Df6ITjf4FUT3wAyy2A2L/t0ydU4
   pDhc5wvgGjWSwBzQ/daZ+tFXfzEc5/uyipEv740ohMoXDXSN1h5chZu/8
   s=;
X-CSE-ConnectionGUID: 4tdAo4QURf+u0PMgFJcGpw==
X-CSE-MsgGUID: 9kacHeSvQK+XGkmIdZybFw==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:YVjWz6vVlVeCzyAW2r9cNhAcZ+fnVPFfMUV32f8akzHdYApBsoF/q
 tZmKTzVOfaMazHwKd9xOYuz8B5XvsSAmodiGQI//iowEi1H9ZOVVN+UEBzMMnLJJKUvbq7HA
 +byyzXkBJppJpMJjk71atANlVEli+fQAOO6ULeVUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDtKg06/gEk35qmq52lC5gVWic1j5zcyqVFEVPrzGonsdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K20UqSoQai87XBdJEAatlo2zhc+NZk
 b2hgaeNpTIBZcUgrgi/vy5wSEmSNYUekFPOCSLi4JbLlxWun3HEmp2CB2lvVWEU0rwqUDsWr
 aRwxJngoXlvisrvqI9XRNWAiex/MMXCO98mh0tujiyBNdMpb7LIbL3VsIowMDcY3qiiHN73W
 480UgpRSVGZP0MQfFkND5Q/gfzujX76G9FagAvN4/BxujGVkFEZPLvFabI5fvSlTMFRn12Do
 X6A2m3lAhAXKfSR0z2D82+3wOTImEsXXapLROPiqaYw3gz7Kmo7WR4fXnu2mueAqQ2OdNFaC
 kAm6yAAsv1nnKCsZpynN/Gim1aGsxASHdFQHusNsSmL2rKS6AGcbkAOVD9Ibpomr9IeQywyk
 FSOmrvBDyZuubuTTmiH96y8pjOoPi0UMGpEYjULJSML+dDlq4wohRXnQtFnG6+zj5v0BVnYw
 TeKpS44iq47ls8TzKK/4EzGhDS34J7EUmYd4gTRQ3Lg7Q5jYoOhT5Kn5EKd7vtaKoudCF6bs
 xAsn8mY8fBLEpCXmSiAW/4lAr6k/bCGPSfajFopGIMunxy2vX6qYI1KyClzIkh0LtwDfz75J
 kPe0StN/4JVMz6qdq56ZcSxEMUnzYDmBcyjXffRBueiebAoLEndung3IxLNt4zwrHURfWgEE
 c/zWa6R4bwyUsyLEBLeqz8h7IIW
IronPort-HdrOrdr: A9a23:D57CbqqbV3QVKf2lh03c1UcaV5odeYIsimQD101hICG9Kvbo9f
 xHnJwguSMc+wxhPU3I/urwQJVoIEmsjKKdjrNwAV7PZmPbUQiTXfpfBOnZsl7d8kTFn4Y36U
 4KScdD4ajLbGSS+vyV3ODXKbsdKZK8gcSVbK/lvhBQpC9RGsdd0zs=
X-Talos-CUID: 9a23:7CdkZ2991QszpE7o9jGVvxIIFukiLkTg9nmTPheALGlHara6UUDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A9jtIMg054D6me0pYiXRWpJqm6jUjsqenA2AAqos?=
 =?us-ascii?q?/mIq0Gi91GjuvnT6ZXdpy?=
X-IronPort-AV: E=Sophos;i="6.16,331,1744063200"; 
   d="scan'208";a="186270269"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
From: Gallissot Mathieu <Gallissot.Mathieu@fronius.com>
To: "jeff.chen_1@nxp.com" <jeff.chen_1@nxp.com>
CC: "brian.hsu@nxp.com" <brian.hsu@nxp.com>, "briannorris@chromium.org"
	<briannorris@chromium.org>, "francesco@dolcini.it" <francesco@dolcini.it>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"tsung-hsien.hsieh@nxp.com" <tsung-hsien.hsieh@nxp.com>
Subject: Re: [PATCH v4 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
Thread-Topic: Re: [PATCH v4 00/22] wifi: nxpwifi: create nxpwifi to support
 iw61x
Thread-Index: Adv7B52mU5UDxz+jT+K2qBGBtnR/zg==
Date: Tue, 22 Jul 2025 13:00:57 +0000
Message-ID: <cb3be497fa7a45e68d9be6f9b8bc47b5@fronius.com>
Accept-Language: fr-FR, de-AT, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I've been try to compile this patch on 6.12.33 (commit id e03ced99c437f4a79=
92b8fa3d97d598f55453fd0), I've got the following error messages. Which vers=
ion of kernel does this patch applies?

drivers/net/wireless/nxp/nxpwifi/cmdevt.c:8:10: fatal error: asm/unaligned.=
h: No such file or directory
    8 | #include <asm/unaligned.h>
      |          ^~~~~~~~~~~~~~~~~
compilation terminated.
make[7]: *** [scripts/Makefile.build:287: drivers/net/wireless/nxp/nxpwifi/=
cmdevt.o] Error 1
make[7]: *** Waiting for unfinished jobs....
  CC [M]  drivers/net/wireless/ti/wlcore/scan.o
  CC [M]  drivers/net/wireless/ti/wlcore/sysfs.o
  CC [M]  drivers/net/wireless/rsi/rsi_91x_sdio_ops.o
  CC [M]  drivers/net/wireless/ti/wlcore/vendor_cmd.o
drivers/net/wireless/nxp/nxpwifi/main.c: In function 'nxpwifi_unregister':
drivers/net/wireless/nxp/nxpwifi/main.c:114:9: error: implicit declaration =
of function 'del_timer_syn'; did you mean 'dev_mc_sync'? [-Werror=3Dimplici=
t-function-declaration]
  114 |         del_timer_sync(&adapter->cmd_timer);
      |         ^~~~~~~~~~~~~~
      |         dev_mc_sync
  CC [M]  drivers/net/wireless/rsi/rsi_91x_usb.o
drivers/net/wireless/nxp/nxpwifi/main.c: In function 'nxpwifi_main_process'=
:
drivers/net/wireless/nxp/nxpwifi/main.c:274:25: error: implicit declaration=
 of function 'del_timer'; did you mean 'add_timer'? [-Werror=3Dimplicit-fun=
ction-declaration]
  274 |                         del_timer(&adapter->wakeup_timer);
      |                         ^~~~~~~~~
      |                         add_timer
In file included from ./include/linux/export.h:5,
                 from ./include/linux/linkage.h:7,
                 from ./include/linux/preempt.h:10,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/swap.h:5,
                 from ./include/linux/suspend.h:5,
                 from drivers/net/wireless/nxp/nxpwifi/main.c:8:
drivers/net/wireless/nxp/nxpwifi/main.c: In function 'nxpwifi_hard_start_xm=
it':
drivers/net/wireless/nxp/nxpwifi/main.c:838:50: error: 'SKBTX_WIFI_STATUS' =
undeclared (first use in this function); did you mean 'SOCK_WIFI_STATUS'?
  838 |                      skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =
&&
      |                                                  ^~~~~~~~~~~~~~~~~
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
drivers/net/wireless/nxp/nxpwifi/main.c:838:50: note: each undeclared ident=
ifier is reported only once for each function it appears in
  838 |                      skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS =
&&
      |                                                  ^~~~~~~~~~~~~~~~~
./include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
cc1: some warnings being treated as errors
drivers/net/wireless/nxp/nxpwifi/init.c: In function 'wakeup_timer_fn':
drivers/net/wireless/nxp/nxpwifi/init.c:43:43: error: implicit declaration =
of function 'from_timer'; did you mean 'mod_timer'? [-Werror=3Dimplicit-fun=
ction-declaration]
   43 |         struct nxpwifi_adapter *adapter =3D from_timer(adapter, t, =
wakeup_timer);
      |                                           ^~~~~~~~~~
      |                                           mod_timer
drivers/net/wireless/nxp/nxpwifi/init.c:43:66: error: 'wakeup_timer' undecl=
ared (first use in this function); did you mean 'wakeup_timer_fn'?
   43 |         struct nxpwifi_adapter *adapter =3D from_timer(adapter, t, =
wakeup_timer);
      |                                                                  ^~=
~~~~~~~~~~
      |                                                                  wa=
keup_timer_fn
drivers/net/wireless/nxp/nxpwifi/init.c:43:66: note: each undeclared identi=
fier is reported only once for each function it appears in
make[7]: *** [scripts/Makefile.build:287: drivers/net/wireless/nxp/nxpwifi/=
main.o] Error 1
drivers/net/wireless/nxp/nxpwifi/init.c: In function 'nxpwifi_adapter_clean=
up':
drivers/net/wireless/nxp/nxpwifi/init.c:361:9: error: implicit declaration =
of function 'del_timer'; did you mean 'add_timer'? [-Werror=3Dimplicit-func=
tion-declaration]
  361 |         del_timer(&adapter->wakeup_timer);
      |         ^~~~~~~~~
      |         add_timer
  CC [M]  drivers/net/wireless/rsi/rsi_91x_usb_ops.o
  CC [M]  drivers/net/wireless/ti/wlcore/sdio.o
drivers/net/wireless/nxp/nxpwifi/init.c: In function 'nxpwifi_shutdown_drv'=
:
drivers/net/wireless/nxp/nxpwifi/init.c:577:17: error: implicit declaration=
 of function 'del_timer_sync'; did you mean 'dev_mc_sync'? [-Werror=3Dimpli=
cit-function-declaration]
  577 |                 del_timer_sync(&adapter->cmd_timer);
      |                 ^~~~~~~~~~~~~~
      |                 dev_mc_sync
cc1: some warnings being treated as errors

Thanks,
Mathieu

