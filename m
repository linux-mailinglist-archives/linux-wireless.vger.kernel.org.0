Return-Path: <linux-wireless+bounces-12830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAF09779C0
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 09:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5916B1C22093
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682E7143C40;
	Fri, 13 Sep 2024 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZYPWlN6X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D977107
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212900; cv=none; b=XbgNii6RpJnnqrVyNYWZd73XsA0mvxulKKXnzWkdRB/yztzeM5YOKn/0iXFBs9GXTT1XUVAConKuNqn7q94pkkrg0cWBeA+9PHUc+LEFIUOWZT/qSvHWp9fpcvUFbgEc10RdYTX3HF/R8f2xTaVUkoCA8+Mw+DRRNFkaMkJvWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212900; c=relaxed/simple;
	bh=GOtH+8RJl/wTD0A3yc7L1Pq5M80vBwfy9m7TADvt2Mc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JQxqd56wTdpMybcdnOEU5BSwIWIOC6YT7F80YX80ixJM+cjiHzZZkTRwgMdiMkfcieow7RZtHHYP1lFy1MSBOtaNGDNUivrXNhCQydR0vPd8N92qW0C8i/vC0MUHJjQktrVgvPWVRLRe2tbj+zeHcv0GY2/5irxGCKXHvwEj4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZYPWlN6X; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48D7Ypf862573885, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726212891; bh=GOtH+8RJl/wTD0A3yc7L1Pq5M80vBwfy9m7TADvt2Mc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=ZYPWlN6XftbHWPoUCnD81BY6d+/3O2YeqNdh1rIIPH7/66VT+JpaSAgFyd2Yw+1gW
	 +cUcTUWAVH9CXVss2d71sUldViBY9Sl554dWJ7wJ3WeV5tIsg10PPsGOnqlwtb4NAB
	 dy53ISisfgpJGsy9UzO9Z7KrfdzCckhpjbOkR/cuvxtTMbvsNtIx7nziC5rPAWbVNN
	 72ef75WnHeVoE0CFvHRZJURKI/YLNVn5y8l0zePGQxAuBNk3LgYmNXdc6Crm6P5vdj
	 1qxMdOezxpkFQdjVL6Nw0NLt+cNdVysA5SR+PV3OPYQA6RNncUkk2WpPGKGjx/V6KB
	 R+DQH5PhQ/kdA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48D7Ypf862573885
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 15:34:51 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 15:34:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 13 Sep 2024 15:34:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 13 Sep 2024 15:34:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Timlee
	<timlee@realtek.com>
Subject: pull request: rtw89: 8922a: add fw format-2 v0.35.42.1
Thread-Topic: pull request: rtw89: 8922a: add fw format-2 v0.35.42.1
Thread-Index: AdsFrxRbFYw1/HcRTNWpL95YKBrH5g==
Date: Fri, 13 Sep 2024 07:34:50 +0000
Message-ID: <28a0ab5067a34a308c155f3ccc08790b@realtek.com>
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

Hi,

Add rtw89 driver firmware for RTL8922A that firmware version is 0.35.42.1.

Thank you
Ping-Ke

---
The following changes since commit b9daf8c33f02650b79bd1c61d61d6b1fae470e8b=
:

  Merge branch 'amd-staging' into 'main' (2024-09-12 16:05:08 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2024-09-13

for you to fetch changes up to 5685e14f2a1cf8ce8ee2ab5883eb327c9c9c5d15:

  rtw89: 8922a: add fw format-2 v0.35.42.1 (2024-09-13 15:28:58 +0800)

----------------------------------------------------------------
Chin-Yen Lee (1):
      rtw89: 8922a: add fw format-2 v0.35.42.1

 WHENCE                  |   1 +
 rtw89/rtw8922a_fw-2.bin | Bin 0 -> 1586954 bytes
 2 files changed, 1 insertion(+)
 create mode 100644 rtw89/rtw8922a_fw-2.bin


