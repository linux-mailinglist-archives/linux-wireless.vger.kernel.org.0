Return-Path: <linux-wireless+bounces-14627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F259B4190
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 05:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A64E1F23035
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 04:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9678D1E0DA7;
	Tue, 29 Oct 2024 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YdvVJ0dm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6714900E
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730175752; cv=none; b=npPjef5gQHu+od/p9NcIqBr1ALgKAzgWVETr5ITlNfh1MiVvpwtiV7cWASL5CdqWDFP0Buo0RGL1GGkIYC6haSLcVqcRfegbQcMzMCtrXpM4AdGMn8VuAAe/K+UxR9JVmJAcQZc/s/hNT2iKYgIru3HfmZBJCO++eDMwYc7e2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730175752; c=relaxed/simple;
	bh=UoXbLEEORhkbqS+cB3wZC64pm/6434iVgD+RVdZ3ESk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=RsDBUZYyHqhSxKyameB251+fT+Azku1E7m4/qXSUOhAgCVkpvYZSnFzFh2tvlfmDWhwuw8NKTotblVXWvPGnh/rNQOmXvX3AKWbrtDnJcVIWrXbuZnUGSlG2mWhu6kNFqgBg3kF9Bq8b0T4M3h6aJ9SMWye9ICErZsNFyln6CcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YdvVJ0dm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49T4MLb741845039, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730175741; bh=UoXbLEEORhkbqS+cB3wZC64pm/6434iVgD+RVdZ3ESk=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=YdvVJ0dmUzWTetXtulVy4FIDF2C6qcYAZsWJ29ZuQHLbSYR8pXeJOhq43Kcp1GyVP
	 d9FsLqaY7fIINWJaVSQnF+qRkeCg08UumU6b2Iik9iwYgXvLkX2GuJxQ/w8mzgTkaO
	 M2tLf/wf71WlUWkBqCvcGJGbt+wY3qbvmVO07X6+pQ3N5UgBeoE54nm4j8ex2kR8xM
	 vCh3GIG7PtqBq1lSYhTa95VkAM28j4sdkJybS75DGh5qyiWjAMBqE43ZEwVON249op
	 mcl3/9wwOjM4JQMPDZC6ObWSIGfca6D8ntPneLwkd9SqUS9cwTFrlXh6mchSIr2Lbi
	 Uy8sFLoIZMjHQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49T4MLb741845039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 12:22:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 12:22:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 29 Oct
 2024 12:22:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v3 01/22] wifi: rtw88: Add some definitions for RTL8821AU/RTL8812AU
In-Reply-To: <9279a9cd-6f86-4dc3-a095-7c36cb9b9d06@gmail.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com> <9279a9cd-6f86-4dc3-a095-7c36cb9b9d06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <808c66fa-60a2-4878-b1f8-65d064735692@RTEXMBS04.realtek.com.tw>
Date: Tue, 29 Oct 2024 12:22:22 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Add 8821A and 8812A chip type enums.
> 
> Add cck_high_power member to struct rtw_hal. This will be used to
> calculate the RX signal strength of RTL8812AU.
> 
> Add various register definitions which will be used by the new drivers.
> 
> Move some existing register definitions from rtw8821c.h and rtw8822b.h.
> They were duplicated in those headers and will also be used by the new
> drivers.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Smatch warns

  drivers/net/wireless/realtek/rtw88/rtw8812a.c:619 rtw8812a_iqk() error: uninitialized symbol 'tx_x1'.
  drivers/net/wireless/realtek/rtw88/rtw8812a.c:621 rtw8812a_iqk() error: uninitialized symbol 'tx_y1'.

Please respin patches 16-22.

15 patch(es) applied to rtw-next branch of rtw.git, thanks.

d12722830ea4 wifi: rtw88: Add some definitions for RTL8821AU/RTL8812AU
87341ca1eac9 wifi: rtw88: Dump the HW features only for some chips
d9018f437351 wifi: rtw88: Allow different C2H RA report sizes
95a772e30b60 wifi: rtw88: Extend the init table parsing for RTL8812AU
7c5bbeba7c36 wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be NULL
fbb5e1b3637a wifi: rtw88: Let each driver control the power on/off process
c7706b1173c7 wifi: rtw88: Enable data rate fallback for older chips
abb0f19492ba wifi: rtw88: Make txagc_remnant_ofdm an array
82a617413e85 wifi: rtw88: Support TX page sizes bigger than 128
67d915604e69 wifi: rtw88: Move pwr_track_tbl to struct rtw_rfe_def
85bf3041a0ea wifi: rtw88: usb: Set pkt_info.ls for the reserved page
57289d30cd2a wifi: rtw88: Detect beacon loss with chips other than 8822c
b19840afc051 wifi: rtw88: coex: Support chips without a scoreboard
bfcee5ee924f wifi: rtw88: 8821a: Regularly ask for BT info updates
f9e0189cbc2d wifi: rtw88: 8812a: Mitigate beacon loss

---
https://github.com/pkshih/rtw.git


