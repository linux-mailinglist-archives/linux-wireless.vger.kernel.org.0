Return-Path: <linux-wireless+bounces-10346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC174934AA7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 11:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB082812AF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBCC80045;
	Thu, 18 Jul 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dw50IXHh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912417F460
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293566; cv=none; b=NmGvwL5hg9aRe+2+Uqz3bU3gfnCgZWvbffnJd62NSYZuzwCcq3GmYup5pj5Jrei2T0ZaECGYJXXgdbG8gNHObRxE+u0LItwgL3pfXlDdo/hIHRZlDt6xOYM8KRUrgP+QgzdVgwxGTH6f2by8QdpS5Ic2KmYzdl2NVidrSsPWlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293566; c=relaxed/simple;
	bh=PcQcySTD/ErOGfFrxdCNEW5XL9UFRm7LnrbQlpml9LY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oCvygehTa2LnepKLxzJ7YLtCiUtCR3vc+KKT/WjDUG3NnQ7TgtsSelOLdNlWeLlkDu3ZvXsLRrZS89r3hIkX6hFHpYojpq4tZTCsvl6q9QmKUaSpqot2vhNEXBzQxVKrVdSLuCPBMSmd4Y2Cg1JKbZBnsdB46JaQ/0F00imm2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dw50IXHh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46I95tAJ23209906, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721293556; bh=PcQcySTD/ErOGfFrxdCNEW5XL9UFRm7LnrbQlpml9LY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dw50IXHhuy6jFscPEeYMygPTfw18zk7FTxEF92rIQqBFBwhgtCYKk62KM8o34BkdI
	 9tVw7kWS8uLId7jghh9vBQjj0ZJYkIbAvYUhc6WOYr3MPHII634aTAydl1gkrMF7ue
	 3WPrTmNK9I7hHiLn0Gn4vQPgCuWUtDfEge398YipSDqpMtSSuRElq932Wc/1MXEM15
	 cCHfTfPoxPF29LbaODWe3etL7bRW9llrqpc0+Kuc1FaCLtg2X/K3KD2NiUEgIiSTDj
	 HaPyWG5f1lSuZXjpySY6TlM5lwqIPu58TL9wJMH5WCjN9r/bopLv340NzMUn8LSCdm
	 rM/5WYZkAIu9Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46I95tAJ23209906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 17:05:56 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 17:05:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jul 2024 17:05:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 18 Jul 2024 17:05:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Jesuiter, Henry" <henry.jesuiter@softing.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Le Suire, Michael" <Michael.Suire@Softing.com>,
        "Sperling, Tobias"
	<Tobias.Sperling@Softing.com>
Subject: RE: Performance of Reassociation 
Thread-Topic: Performance of Reassociation 
Thread-Index: AQHa2EeueyCxNvdWakyDpuL0/ysvurH8K4CQ
Date: Thu, 18 Jul 2024 09:05:55 +0000
Message-ID: <ef8f3c47b3264aedad776ff248fa635d@realtek.com>
References: <BE1P281MB22104B386701ADEEE1E741269EA32@BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <BE1P281MB22104B386701ADEEE1E741269EA32@BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Jesuiter, Henry <henry.jesuiter@softing.com> wrote:
>=20
> we are using the rtw88 driver (with kernel 5.4) together with a RTL8822ce=
 chip (Firmware 9.9.15, WOW 9.9.4,
> H2C Version 15) on a PCI-Express card. We stumbled about long roaming dur=
ations and investigated a little
> into this issue, by using different hardware:
>     * Freescale i.MX6/ARMv7
>     * Intel Core i5-7300)
>=20
> and different distributions:
>    * Yocto Hardknott/3.3.6, Kernel 5.4
>    * Buildroot, Kernel 6.6
>    * Ubuntu 20.04, Kernel 5.15
>    * Ubuntu 24.04, Kernel 6.8
>=20
> and found roaming times from 450ms (Ubuntu 24.04, Intel) up to 900ms (Yoc=
to 3.3.6, FreeScale).

Does it mean 450ms on kernel 5.15, but 900ms on kernel 5.4 for RTL8822ce?

>=20
> Since we are used to much shorter roaming times (about 200ms even on the =
Freescale),=20

What is the WiFi card you are used to measure this roaming time?


> 2. Start authentication to the new AP
>     [  561.557691] wlan0: authenticate with <new_ssid>
> 2.1 Reinitialize the hardware
>     [  561.577099] rtw_8822ce 0000:01:00.0:  rtw_power_on()
>     [  561.577109] rtw_8822ce 0000:01:00.0:  rtw_hci_setup()
>     [  561.577128] rtw_8822ce 0000:01:00.0:  rtw_mac_power_on()
>     [  561.577262] rtw_8822ce 0000:01:00.0:  rtw_mac_power_switch()
>     [  561.580561] rtw_8822ce 0000:01:00.0:  rtw_wait_firmware_completion=
()
>     [  561.584826] rtw_8822ce 0000:01:00.0:  rtw_download_firmware()
> =3D> about 40ms here
>     [  561.614635] rtw_8822ce 0000:01:00.0: rtw_hci_setup()
>     [  561.614657] rtw_8822ce 0000:01:00.0: rtw_mac_init()
> =3D> about 250ms here
>     [  561.876080] rtw_8822ce 0000:01:00.0: rtw_hci_start()
>     ...

I measure rtw_leave_ips() which is to power on wifi card, and the cost is
about 200ms in my x86 NB.

> 2.2 PHY calibration
>     [  561.877140] rtw_8822ce 0000:01:00.0: [RFK] WiFi / BT RFK handshake=
 start!!
>     ...
>     [  561.896456] rtw_8822ce 0000:01:00.0: [RFK] WiFi / BT RFK handshake=
 finish!!
>     [  561.936393] rtw_8822ce 0000:01:00.0: [DPK] s0 dpk start
>     [  562.056272] rtw_8822ce 0000:01:00.0: [DPK] s0 dpk finish
>     [  562.056280] rtw_8822ce 0000:01:00.0: [DPK] s1 dpk start
>     [  562.176275] rtw_8822ce 0000:01:00.0: [DPK] s1 dpk finish
> =3D> about additional 300ms until here (that's the phy calibration stuff)

I measure rtw_chip_prepare_tx() which is to do phy calibration. The cost is
about 190ms on 2GHz and 5GHz channels.=20

>=20
> So, we are wondering if this long duration times for reassociation are ha=
rdware-related (maybe even someone
> uses the same chip and does not experience these delays)?
>=20
> On the software side, is there some optimization potential known in the s=
oftware/driver that is just not
> realized yet? We would be happy to realize/implement those potentials. To=
 be more specific: We are looking
> for a way that the driver does not need to reinitialize/restart the hardw=
are while roaming in order to reduce
> that part of the roaming delay specifically (and maybe skip/shorten the p=
hy_calibration part). Any ideas
> are welcome. We are also happy to provide any additional logs that might =
be needed (please specify) and
> to answer any additional question you might have.

The costs I posted are hardware-related. Ignore IEEE80211_CONF_IDLE to avoi=
d calling
rtw_enter_ips()/rtw_leave_ips(), saving 200ms to power on hardware.=20

For PHY calibration, I think this is strictly necessary to get good perform=
ance.
One way may be deferred the calibration after getting connected, but 4 way =
and=20
DHCP (right after getting connected) may not work well result from bad RF s=
ignal
quality.



