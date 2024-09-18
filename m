Return-Path: <linux-wireless+bounces-12937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C1F97B8D1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 09:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243B51C2122B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 07:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4974C08;
	Wed, 18 Sep 2024 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=dknueppel@online.de header.b="aZdRDiMY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECB4158219
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645996; cv=none; b=u7wfYen8JWsjb3GPkkv0qNy9HycldWtXNG4TXLW9PwPXwgdRcah+zaA+6Pb5m2aORv0rP9vhEXWZmBxjIvotW1jF2XIGUPgB0WUvhmRAKcQz3pFHvaBPJkD4T0JAQt6Js1rvzUKh9wnlhLzM+rNx995z0C1+JNY9jyW/w6En1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645996; c=relaxed/simple;
	bh=SHADO+5G+ctbY7oDTmbw1MAP9K+OoYNe6wqdch3z80Q=;
	h=Date:MIME-Version:To:From:Subject:Content-Type:Message-ID; b=e8ExkSkZ+FMmLJ/2Wytlz9jCXsI089d9UMsP4sxC6f6L3UZzbElwNnryrEilKdfmI2MDARADXG2Svia89Dn+f6zsFE4hSBxweD8hoJxp3oToq5YwY4T4G0eEtBG3R3RPaaNtevjsumZHKzcGX9I0o4mQixckWaE5LQP4eF4pFVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=dknueppel@online.de header.b=aZdRDiMY; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1726645985; x=1727250785; i=dknueppel@online.de;
	bh=SHADO+5G+ctbY7oDTmbw1MAP9K+OoYNe6wqdch3z80Q=;
	h=X-UI-Sender-Class:Date:MIME-Version:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-ID:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aZdRDiMYsNCscoV0+jghC4Csq0EFkEGmz2ENQc1AW3yQiwkZMmsCgrhgT6+Ew6OI
	 pteexVLc8/qG7UNOieVn/BNYi4YUDFo1I356eI8+8Vew94x/6TT8sB31aopBLcxQC
	 IJ3lxZivWvBtIZEJiD+19/kj1x4FewP+OkiRa37T1RfeCwF2ctC7JppYytdcPh/qy
	 mOhxBOo2LUh+Sxsq5ICR6kJX4wC7BbleCxIkS74PaXaobPj9vEeWFMjRCVEFVoK94
	 961BZa45CtcqeZQnjiBxWj8n/WdbdGBnamagwE9MklUyoosNCe7SqeiyDfJuruBbf
	 XOEgUwqsnVG+NYIYsg==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from xXx ([87.122.98.153]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N4hex-1rs1AM2KqF-0133W0 for
 <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 09:53:05 +0200
Authentication-Results: kalliope-7.home.xx;
	auth=pass smtp.auth=dknueppel@home.xx smtp.mailfrom=dknueppel@home.xx
Date: Wed, 18 Sep 2024 09:53:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-wireless@vger.kernel.org
From: Dieter Knueppel <dknueppel@online.de>
Subject: ath12k - HTT timeout error with NCM86
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.10 / 6.00];
	BAYES_HAM(-3.00)[99.98%];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action
X-Rspamd-Server: kalliope-7
X-Rspamd-Queue-Id: 6B4A0439AD
X-Spamd-Bar: ---
Message-ID: <1N7iT4-1rv3yN2hUI-016bkv@mrelayeu.kundenserver.de>
X-Provags-ID: V03:K1:WTlUVa3riEnkPdOJXsFsIqij9g2rKWpgJ3Yt2p3sWUQNGw1bZEv
 /Z+0BNQMzDTjytdDourZjlIQjFkhYtIIomISub3815FwM2yviJE6mfyvBC3B0DVLdiTkhsm
 Di4YKfUivmUE7Z6Xd9g2+PrENpU9GRz8EJam4x9amSuwDjTqMMQx3Mq2Oo0rS2buFQLC09E
 Ju2svTPhSzlY/w31mhnsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AIFI7BSEBk8=;opEjfR22cMmC3gEbTnImxig391U
 gZxgj7MZK2d99EljsDWwGuRn44lJstoir5VWV7zMVtHWrBLhilAP8UHtmKxIv5zhD4V7kvbeD
 ycQxYCiYPWBtWaVxT70vGL30QYYx8TeX/rE61uw+x0S1DumO8FHN/jBWVau8QIM3TUHwHTcFw
 loUIX46ngwVgHlRoF0cSCFiY4KvRRlf74uf7l1TQa77boZLPrEQgyZ8wLngjkvIVE49RksPh6
 umT2Xu2uHvOkeq0p3i46T5k6+RDO8OTdxEDd0idZl7CZAffAMRIVhyRfaYjZcW6XR4vE0iMrG
 p/B7ii26vaWZCV1W4PJ2qS6uzkQA81TEprs+/PVfBKP7tQMfNoyrA7jQ4RYP7bITXRNkHMIgr
 lqyTsoaAMjzkuzdaPvUKm2CkfzGPOrxi5paRHB7bYFS/DR1cRFWN5mY5ffNb83gX+PdPZ4k9T
 fYx+7i4Lv3KrEf8KzAIPtpzv3+XTOOMA/MfI3G9WilEyESh9NBsI6N1ATkVw6urGVPbhbC/1o
 dJAyKoMFBQ1wgvKNKUG+Ef0lr1oXcF4qt3N0w5Iom72CIm0qAyPN7mAj8UT4zRGgoJ+/v4e3C
 FpqrCVTaCTgL0HXB9mDKhzirRUDcziygyMnXi6zk06j8HmSazXd6c2GHacLER/BYAlyQsrBg2
 c1lavtBgysCWSmhqwwg6EyXZo61ZSAtF5UUZI2MdfCbO4KM1uxcexKudvnOnSx/wPEWeDLAJB
 fzAHsyxymYOKjEHC41EU/GRctFDZiwQyw==

Dear developer team,

I'm trying to get "MSI HERALD-BE NCM865" up and running within a kvm
based VM on

Ubuntu server 24.04.

 =C2=A0=C2=A0=C2=A0 08:00.0 Network controller: Qualcomm Technologies, Inc=
 WCN785x
Wi-Fi 7(802.11be) 320MHz 2x2 [FastConnect 7800] (rev 01)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Foxconn Internation=
al, Inc. High Band Simultaneous
Wireless Network Adapter
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Physical Slot: 0-8
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Control: I/O- Mem+ BusMaster+ =
SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB=
2B- ParErr- DEVSEL=3Dfast >TAbort+
<TAbort- <MAbort- >SERR- <PERR- INTx-

With kernel versions 6.8 (coming with Ubuntu) as well as with versions
up to 6.11 i get the

below syslog outputs:

ath12k_pci 0000:08:00.0: BAR 0 [mem 0xfda00000-0xfdbfffff 64bit]: assigned
ath12k_pci 0000:08:00.0: MSI vectors: 1
ath12k_pci 0000:08:00.0: Hardware name: wcn7850 hw2.0
ath12k_pci 0000:08:00.0: qmi dma allocation failed (7077888 B type 1),
will try later with small size
ath12k_pci 0000:08:00.0: chip_id 0x2 chip_family 0x4 board_id 0xff
soc_id 0x40170200
ath12k_pci 0000:08:00.0: fw_version 0x100301e1 fw_build_timestamp
2023-12-06 04:05 fw_build_id
QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILIC=
ONZ-3
ath12k_pci 0000:08:00.0: leaving PCI ASPM disabled to avoid MHI M2 problem=
s
ath12k_pci 0000:08:00.0: failed to receive control response completion,
polling..
ath12k_pci 0000:08:00.0: Service connect timeout
ath12k_pci 0000:08:00.0: failed to connect to HTT: -110
ath12k_pci 0000:08:00.0: failed to start core: -110

I already searched for similar issues, w/o any success so far :-( Have i
overlooked something?

I would be glad for any advice.

Thanks a lot,

Dieter


P.S. Earlier i gave "Gigabyte WC-WIFI7" a try, even with less success.
Here i received an error "unknown HW type: 0xf".




