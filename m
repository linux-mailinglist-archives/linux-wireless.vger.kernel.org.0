Return-Path: <linux-wireless+bounces-21589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3D6A8AF02
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 06:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCC9440BC7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9C1229B13;
	Wed, 16 Apr 2025 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ERY2Hfju"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECBB229B17
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777663; cv=none; b=D2uML/UaPYfxmPi+0ADb3wsJ6jhBUdMrxOB0RR8EoBtj08Sy2RVXMKRUutLRv9X3dCHsFZwUxzlsKWeYK5vZ/W/con9YBaqkr+kbiw1ILDQ1bFpdZHRGTXsgnuJ2hkfWAxosZRauiIagbCQzbZIcU3Cr98zj9uBcsbzC9kq+4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777663; c=relaxed/simple;
	bh=Kpgm09SXsoz/y1kAt/Rzt4dek2OpeksRdFLqEQXIy7M=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date; b=RDorZOIZNUewgkHK+Tq0QwtWB11DpMTit++yJ8PEA43867rrNDRw4KXN1+jwwpl6OHou+BUUzKez7qT8vEDkDRrSLqm4/4tEd2phchCIQczfBiNo9NQZ9ekk+kSSSqHKN7fq/kwjUkmZ+J+j8jH6aqP7gP015xwFbQPh86wIDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ERY2Hfju; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53G4RLI202654510, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744777641; bh=Kpgm09SXsoz/y1kAt/Rzt4dek2OpeksRdFLqEQXIy7M=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=ERY2HfjuE6ZmQXIcy1iowUIghzIG9lywCEaxV2POqS/LpEKsPlhyB6Mb4f7PD5f3q
	 Bd8X6RyvrHo/TiUFQs5qooQEqhpLAaGueJtGSIKOJQXiqwkW3Hm3v4mNAg86AYDB7S
	 YANr5Ic0GPry0GLRLh9AADGKUE7McTDECeU0UO2Yo4fRULSntnJrle5e9UvrMBDa3G
	 +fQ7xDtZqHJLwBFvmm9Gzy0HoXzFhln+Rry3075BrkujA4KwExiltmgkYIC0ygdqra
	 Qt0zU3AwyRNXZq5SCTsJ6nmMKkai9wco5UrEpBTxD81EL4CYgpSx5MQv/o2jBxcXBk
	 jbGYui28Nfqdw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53G4RLI202654510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 12:27:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 12:27:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Apr
 2025 12:27:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-firmware@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: pull-request: update rtw89 firmware with rtw-fw-2025-04-16
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <27ec817e-4b99-445e-8bd5-f61a38b4746c@RTEXMBS04.realtek.com.tw>
Date: Wed, 16 Apr 2025 12:27:22 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

Because firmware v0.27.125.0 for RTL8852C changes the format, old driver
can't recognize the new changes, causing failed to probe. To fix this,
move the version from rtw89/rtw8852c_fw-1.bin to rtw89/rtw8852c_fw-2.bin.

Others are to update elements related to TX power.

Thank you
Ping-Ke

---

The following changes since commit 6a006cef10cebfaa282100a81cb45ad3a9212721:

  Merge branch 'intel/guc_70441' into 'main' (2025-04-10 20:59:06 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-04-16

for you to fetch changes up to 4eeab443621fc045fa094b2f69de1cb8025aa414:

  rtw89: 8922a: update element RF TXPWR to R40 (2025-04-16 09:41:56 +0800)

----------------------------------------------------------------
Ping-Ke Shih (2):
      Revert "rtw89: 8852c: update fw to v0.27.125.0"
      rtw89: 8852c: add fw v0.27.125.0 with format version 2

Zong-Zhe Yang (2):
      rtw89: 8852c: update element RF TXPWR to R78
      rtw89: 8922a: update element RF TXPWR to R40

 WHENCE                  |   1 +
 rtw89/rtw8852c_fw-1.bin | Bin 2399272 -> 2375560 bytes
 rtw89/rtw8852c_fw-2.bin | Bin 0 -> 2411688 bytes
 rtw89/rtw8922a_fw-3.bin | Bin 1188926 -> 1224798 bytes
 4 files changed, 1 insertion(+)
 create mode 100644 rtw89/rtw8852c_fw-2.bin

