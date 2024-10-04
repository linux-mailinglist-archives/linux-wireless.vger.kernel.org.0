Return-Path: <linux-wireless+bounces-13487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 922F098FC88
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 05:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F1F1C224E1
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 03:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C488C335C0;
	Fri,  4 Oct 2024 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LOjLqKW4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E35326281
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 03:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728012351; cv=none; b=iD4UCiCDSRj5rOJZTNN7ybJk2Fb0sM3LiiQn+3+4YhR1EZef3Ec2D8uRyUT2wStY9oYDyxkn85ibJeOtBQRP+/UGeZRVuckJrq2hd7rjkd+sD0qdXVmvZCjCFCnY3/oW5CY5YGeWbP6QKznmOvX2t4fVFjLbC3Z791U4om/GqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728012351; c=relaxed/simple;
	bh=D5D5JCx0QtPcfi43k5znZviCh4EHpDJKK79ZPj8wBEg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vBCQ8puXIOUalCI/60kQQoHS10/9E3nxnYrh0+htHInGWWRf/J5scA+KYtJ+Zy8fuwOPQuMfPiKLmaXm5gHexJ8R8JsqiOpVTf+76CPZQ+DIK6N9i7FOCC9wysWsthItAsOuAMMnRyibzaR1Et5UGs8ylpzEJ1EKnHlgpHFoN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LOjLqKW4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4943OC8K0777658, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728012252; bh=D5D5JCx0QtPcfi43k5znZviCh4EHpDJKK79ZPj8wBEg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=LOjLqKW46dGOHtSt2ceuI9Zflar1euiMgHgy8iwi6B4hOQUJ2ollV5EMwkf8W1TLY
	 phuWbHS17xpTOHfJpQDppuTRa5qkPBQeuP2u7stHXeWXa1qV9H3ReDxuWKDi1HPIWk
	 VAICGv95Auyj27wUCMH1Ydoa87vO0rUo5n4mTFcfiQQ1oAf4OWtTJ4zzJ4I+8+057h
	 /2kO71xvxjZkXwNNm0D4fD839CpGJijvbv6M8NhtMn0SnBgHTlndgKc2cRI0Q4cwAy
	 B++Sz6RcfpcdEoMmw1/WeGgz2ofViSEvBIYcbT9xfenUdo0jSz//TUwzWh01BZ9662
	 Ib7gURTypxxhw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 4943OC8K0777658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Oct 2024 11:24:12 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 09:22:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 4 Oct 2024 09:22:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 4 Oct 2024 09:22:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: pull request: rtlwifi: Add firmware v39.0 for RTL8192DU
Thread-Topic: pull request: rtlwifi: Add firmware v39.0 for RTL8192DU
Thread-Index: AdsV+7+iCmuFvzXHQ7+sPwzLrNMsMg==
Date: Fri, 4 Oct 2024 01:22:33 +0000
Message-ID: <2e2e7eac86db45e8a1980021c7a3983d@realtek.com>
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

Add firmware for RTL8192DU

Thank you
Ping-Ke

---
The following changes since commit 95bfe086cd84966449dc0cba734bc582b988b8e8=
:

  Merge branch 'mt76' into 'main' (2024-10-01 11:53:24 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2024-10-04

for you to fetch changes up to f2894a5b7e30621d6bb2a3f8547451990bad3496:

  rtlwifi: Add firmware v39.0 for RTL8192DU (2024-10-04 09:18:06 +0800)

----------------------------------------------------------------
Bitterblue Smith (1):
      rtlwifi: Add firmware v39.0 for RTL8192DU

 WHENCE                  |  10 ++++++++++
 rtlwifi/rtl8192dufw.bin | Bin 0 -> 31452 bytes
 2 files changed, 10 insertions(+)
 create mode 100644 rtlwifi/rtl8192dufw.bin


