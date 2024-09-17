Return-Path: <linux-wireless+bounces-12905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E421D97AC8F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 10:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA141F21173
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C196414B948;
	Tue, 17 Sep 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linuxmail.org header.i=cemunal@linuxmail.org header.b="kazVNQpY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26B12F399
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560425; cv=none; b=mHYUxtpDwkAdj0Srr2Sa/N70gkSPxzsQUD74+kuLLQow4rCho4nDpqvvZNjqiUeQ+dprtYKElQYTMAW98Xf5emD7jZWf/chlkj5ARqFCHS4Fbhsnwn1ikRrc+6cy/fcSvTz6TD11rjSBbLjpseDGH0H8CcHb6FaN9KUoEexsaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560425; c=relaxed/simple;
	bh=e9lHIGhqczaAF52j2KFKbV23wjbuk5Nbcg+qBvsOVAc=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=ZaGHcUPSScTTC5P+OUyV2R8S8uYU7WRkN4aZ0csAAoMEjyT8b1a0/xXXEHZFiNvgjlMhWKa5ZiacXM2iyCnSMMKD5Om584u+u/V3pbU7lu1HuvpurHIBR5EYwHZa0x7ibKyj2zioqtukpNqxY9fuZ4onRF0Dt5OEW5DJXMW5JRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxmail.org; spf=pass smtp.mailfrom=linuxmail.org; dkim=pass (2048-bit key) header.d=linuxmail.org header.i=cemunal@linuxmail.org header.b=kazVNQpY; arc=none smtp.client-ip=74.208.4.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxmail.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxmail.org;
	s=s1089575; t=1726560422; x=1727165222; i=cemunal@linuxmail.org;
	bh=e9lHIGhqczaAF52j2KFKbV23wjbuk5Nbcg+qBvsOVAc=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
	 from:message-id:mime-version:reply-to:subject:to;
	b=kazVNQpY6T/8DSTuUyYET/VA0qbZotYR28LFFYodPY8eliPlY+U0jx3iQ12t1amU
	 9Z0giOsblHej38rRLydzilMuAeLZAnp+y7fNGuX5kQYyxc5E+xhbPfmFIMJ2jT/dc
	 3W+GLqe393v+YkCUkPhUttCn9OJlyX54JHogBrfQzOL4g5CbmT8IbENHjkZnglMly
	 Gk9joBmAwb010vCATeYUA+XzSuYCRhXoL8bZCcqV6RxsrN6hh9ZJ3zNZJ//o/u1sP
	 Hff99Y8NBCeEIt0Pc963vIRDzjpRMeE1Fo2Liv8R5cpxEJSGdw+DQYBpAsK3+MBxj
	 z+iFNEibT3M07WviOQ==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [188.3.12.169] ([188.3.12.169]) by web-mail.mail.com
 (3c-app-mailcom-lxa11.server.lan [10.76.45.12]) (via HTTP); Tue, 17 Sep
 2024 10:07:02 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-7a84c76b-e8b0-4da8-8f8c-07ad3485a23d-1726560422197@3c-app-mailcom-lxa11>
From: =?UTF-8?Q?Cem_=C3=9CNAL?= <cemunal@linuxmail.org>
To: linux-wireless@vger.kernel.org
Subject: PCIe Bus Error from rtw_8821ce
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Sep 2024 10:07:02 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:s/iK+1V8w+dmwU5lRDv5k8rjMwpdri/0Zrobv57FuQ9ZrL4KMDRj/GpmFBPm89RIPq54A
 hcVBs28Ym8xVf0der1ynyLK/H1hJB+SEoXs8szvS6Z9d/tf28g21/5aFaMkcL0E2ZxLuszxgB3wL
 pHtqTOZ3fcbtA5HcwPwV/pb420FGjdr/pzBsKFaaR66jUrLGYjaHL2pIaDg9xQvtTY3JlceAK4zd
 ECC4yYY/6/iZy6cUGX8QAUOEagc7zOTa27mwrOFUKhnHqMGRcjA5/dfwiKf6I6mNiRxNmcipG0nm
 1w=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ccEVGq2Vrxk=;JhvDihWo65bzPSpvOjv0YL4d1Xv
 iQ0dXF6VjDIVDUOz0Tnt3L9kZptvI2RiPBZzgpD/mariP0wmStAm9Lg2QqBxp3S2BLWQyvQdX
 bYScjFR5RaVnBSWQM8SrEkFSOeOadp9H43YRHMAZ9nr0kTqx54FvE2TTQHTI/PPaxSvqnG3YH
 qEJyVgDuz4nsj0/XA5DB1kbp6aWt0P8Pwrs6Aqr1Uwtekx+f/5uNaH7mRy16qcnimJb+DBTPa
 mhpvZNgn5hM0KvcT0Pvz57nCBnBwqXbQkQftD734zh79vQ+o6MSJATeivKgj8uhXol9/UGlFz
 ZQsZISXD74frM1I4agx/6yBnV8og9/h08xLHVHnQ78OVYdxzCHK9c2+T4gug+IX+2zYDIrnlh
 W6iDPfocOx7NDMzUQR7FOJ8VpxZtKG6SH33pxK2rdb+UWqaqxRYZ8qnm5Yn/FQf4pUY5/VMXl
 4RNlI0UAhQBZNHWDPoSg4N01lQlbMfxmbsJLvKcedlkXGNjgD2lCC6FNaHPQtn7/v+Xd5gZlm
 JBSBWwuuNSvFjitoKpGYPyYT5lSLakdti0zA3kGS6vpDJAJyuPsgIVT2vKKuP83joe6VAczf9
 8lVVyF15K43PYVynwz1St2VGYOXeXCzS0B9i8yV562mXIB6XjVd+ZfoK0E0d0HLd1PQQb57al
 nkzWEM/PykQsD6go2Cr0Clhhvc+oK62p2RrKznh26Q==

I am testing build-in kernel drivers for rtw_8821ce and getting same error logs only. Here is some info:

sudo lspci -v:

02:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE 802.11ac PCIe Wireless Network Adapter
Subsystem: AzureWave Device 3040
Flags: bus master, fast devsel, latency 0, IRQ 130
I/O ports at e000 [size=256]
Memory at ef000000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [40] Power Management version 3
Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
Capabilities: [70] Express Endpoint, IntMsgNum 0
Capabilities: [100] Advanced Error Reporting
Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-c8-21-01
Capabilities: [158] Latency Tolerance Reporting
Capabilities: [160] L1 PM Substates
Capabilities: [170] Precision Time Measurement
Capabilities: [17c] Vendor Specific Information: ID=0003 Rev=1 Len=054 <?>
Kernel driver in use: rtw_8821ce
Kernel modules: rtw88_8821ce
__________

uname -r:

6.10.9-200.fc40.x86_64
__________

sudo dmesg | grep rtw:

[ 7.785903] rtw_8821ce 0000:02:00.0: enabling device (0000 -> 0003)
[ 7.799541] rtw_8821ce 0000:02:00.0: Firmware version 24.11.0, H2C version 12
[ 7.852418] rtw_8821ce 0000:02:00.0 wlp2s0: renamed from wlan0
[ 143.722023] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 143.722043] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 143.722058] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
[ 161.626544] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 161.626558] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 161.626573] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
[ 270.552854] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 270.552863] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 270.552873] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
[ 395.381350] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 395.381354] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 395.381359] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
[ 658.591238] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 658.591248] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 658.591260] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
[ 898.787339] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 898.787347] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 898.787355] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
[ 929.845965] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 929.845969] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 929.845974] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
[ 1125.098219] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 1125.098230] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 1125.098244] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
[ 1243.387084] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 1243.387092] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 1243.387103] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
[ 1393.896592] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 1393.896605] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 1393.896619] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
[ 1401.173918] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 1401.173928] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 1401.173939] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
[ 1415.097037] rtw_8821ce 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
[ 1415.097046] rtw_8821ce 0000:02:00.0: device [10ec:c821] error status/mask=00000001/0000e000
[ 1415.097058] rtw_8821ce 0000:02:00.0: [ 0] RxErr (First)
__________

Any fixes?

Thanks.

P.S. : The BIOS is up-to-date.

