Return-Path: <linux-wireless+bounces-8112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 835728D0649
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB69CB283F4
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8816D9A7;
	Mon, 27 May 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luismita.com header.i=@luismita.com header.b="vXyPN5Bg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-108-mta131.mxroute.com (mail-108-mta131.mxroute.com [136.175.108.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8A16D316
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716820735; cv=none; b=e2CfCG64OLrpytaaHE3aG4xDQzJqT1ZZUFChCPF+Z/0ktwXImh0BxmliRyrnUU92AWBBTxzX76L2m/DAUkV3DMDPt4aH2X14ttG9KbxxXzCVj7i9Bx2ai0Cy/Q6Xg57xsUDh8buuvhQ61703MEvijLutS7ACUJtIDhjbFI3Ngrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716820735; c=relaxed/simple;
	bh=Ua3THd9/N42+tEEf/GSlzoHGVAAcUakDtkkyB0xmiwk=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=Za5F53Enkqlc55E753hZEAt4uh62MTY7Asu7nxOt35Lf2UpFW9n5QmmjyhBZ8cSaINXzoP5d59YbQG6edCmBqg5/SYTGFbJGWZ/8DoH+LktcHjMIbdmmBgumqCM1/c6AIt1J6ObiuuyiGXb0i/dTFTTPvQ9LDcmA4ah/DfM8n8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=luismita.com; spf=pass smtp.mailfrom=luismita.com; dkim=fail (2048-bit key) header.d=luismita.com header.i=@luismita.com header.b=vXyPN5Bg reason="signature verification failed"; arc=none smtp.client-ip=136.175.108.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=luismita.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luismita.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta131.mxroute.com (ZoneMTA) with ESMTPSA id 18fba78b5a8000efce.001
 for <linux-wireless@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 27 May 2024 14:33:44 +0000
X-Zone-Loop: 820a0688acf3d6d9f362fa3e01a70d0aa65a201a2def
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luismita.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:To:References:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tyO4CyN6urUSHBLZG0k2BwvDLy0bwyXf6HSGm/xxULE=; b=vXyPN5Bg2Fg1qg5bIifs6oTv5G
	AfySw1q6Y3X/TYUr6ci4hZBjzlmd5lQqpRPcAU62kSTum0+24VYdUnS2Gssssx7WaVCnjFpOoBW0O
	z17RoC6lFEb5TxtEhjP2nuJ2gJ9t4mJGBYQf1F1pPHB8hvkQEsfv/tzww+n0aJZwygeJDNs53DBuT
	/fz5rS1p1yW7hULYzhuIp+7qaCEuTKx4/+X/8ioA5Jv+xuMCigc0NGVYV+0nQg+/+7TJDE5CQA6l+
	VyVTQAkVcBYHYW22J8dLEgsXvDlBcJ0G1MPRWH7MD3AL08hpfx4znzH2eOK38uJoigTlK46yfsIuz
	rLZWg8MA==;
Message-ID: <1e2b1996-26aa-426e-bece-ac74e8d47660@luismita.com>
Date: Mon, 27 May 2024 10:33:39 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [BUG] rtw88: "rfe 3 isn't supported" on rtw_8812au
Content-Language: en-US
References: <9f4e6ffc-fd82-4404-9009-c784aa3b2ab7@luismita.com>
To: linux-wireless@vger.kernel.org
From: Luis Mita <luis@luismita.com>
In-Reply-To: <9f4e6ffc-fd82-4404-9009-c784aa3b2ab7@luismita.com>
X-Forwarded-Message-Id: <9f4e6ffc-fd82-4404-9009-c784aa3b2ab7@luismita.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: luis@luismita.com

Hi,

My adapter TP-Link Archer T4UHP doesn't work with the new rtw_8812au 
driver. Looks like the driver is new, and i'm happy to help testing.

Details:

Kernel: 6.6.31-2-lts Arch Linux

Driver: Backported rtw_8812au module from https://github.com/lwfinger/rtw88

Adapter model: TP-Link Archer T4UHP v1

Kernel messages:
[ 4163.940301] usbcore: registered new interface driver rtw_8812au
[ 4227.148165] usb 1-2.1.1: new high-speed USB device number 6 using 
xhci_hcd
[ 4227.269531] usb 1-2.1.1: New USB device found, idVendor=2357, 
idProduct=0122, bcdDevice= 0.00
[ 4227.269539] usb 1-2.1.1: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[ 4227.269541] usb 1-2.1.1: Product: 802.11n NIC
[ 4227.269543] usb 1-2.1.1: Manufacturer: Realtek
[ 4227.269546] usb 1-2.1.1: SerialNumber: 123456
[ 4227.297120] rtw_8812au 1-2.1.1:1.0: Firmware version 52.14.0, H2C 
version 0
[ 4230.399518] 00000000: 29 81 0a 86 0c 00 00 00 02 00 00 00 00 00 00 00 
  )...............
[ 4230.399524] 00000010: 20 20 20 20 20 20 24 24 24 25 25 e0 ee ee ff ff 
        $$$%%.....
[ 4230.399526] 00000020: ff ff 22 21 20 22 2d 2d 2c 2c 2c 2b 28 28 28 28 
  .."! "--,,,+((((
[ 4230.399527] 00000030: f2 ee ff ff ee ff 0e ee ff ff 22 23 23 25 25 25 
  .........."##%%%
[ 4230.399529] 00000040: 28 28 28 29 29 e0 ee ee ff ff ff ff 21 1f 1d 1f 
  ((()).......!...
[ 4230.399530] 00000050: 27 27 26 26 26 25 25 25 25 25 f2 ee ff ff ee ff 
  ''&&&%%%%%......
[ 4230.399531] 00000060: 0e ee ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399533] 00000070: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399534] 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399535] 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399537] 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399538] 000000b0: ff ff ff ff ff ff ff ff b4 2d 21 00 33 88 00 88 
  .........-!.3...
[ 4230.399539] 000000c0: 00 01 00 10 00 00 55 55 00 ff 03 ff ff ff ff ff 
  ......UU........
[ 4230.399541] 000000d0: 57 23 22 01 41 66 42 d4 6e 0e 11 19 41 09 03 52 
  W#".AfB.n...A..R
[ 4230.399542] 000000e0: 65 61 6c 74 65 6b 0d 03 38 30 32 2e 31 31 6e 20 
  ealtek..802.11n
[ 4230.399543] 000000f0: 4e 49 43 08 03 31 32 33 34 35 36 ff ff ff ff ff 
  NIC..123456.....
[ 4230.399545] 00000100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399546] 00000110: ff ff ff ff ff ff ff 21 03 03 0a ff 00 ff ff ff 
  .......!........
[ 4230.399547] 00000120: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399549] 00000130: 81 ae 98 2d 03 93 96 11 fc 8c 00 11 9b 78 4a ce 
  ...-.........xJ.
[ 4230.399550] 00000140: e0 48 e0 70 27 00 78 ea 60 d0 e1 20 32 63 4f 3c 
  .H.p'.x.`.. 2cO<
[ 4230.399551] 00000150: 12 40 92 15 8b 4a 4f 8a 15 d1 98 00 ff ff ff ff 
  .@...JO.........
[ 4230.399553] 00000160: ff ff ff ff ff ff ff ff 00 02 e1 63 12 29 03 00 
  ...........c.)..
[ 4230.399554] 00000170: cb 3f a0 e0 c2 f0 f7 cf 01 36 08 32 05 eb 94 d7 
  .?.......6.2....
[ 4230.399555] 00000180: 14 6d c8 67 80 e0 f8 80 30 80 30 38 ff ff ff ff 
  .m.g....0.08....
[ 4230.399557] 00000190: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399558] 000001a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399559] 000001b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399561] 000001c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399562] 000001d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399563] 000001e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.399564] 000001f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
  ................
[ 4230.435247] rtw_8812au 1-2.1.1:1.0: rfe 3 isn't supported
[ 4230.438442] rtw_8812au 1-2.1.1:1.0: failed to setup chip efuse info
[ 4230.438450] rtw_8812au 1-2.1.1:1.0: failed to setup chip information

Please tell me if you need more information.


