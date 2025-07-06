Return-Path: <linux-wireless+bounces-24848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AABAFA333
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 07:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857EA7A94C2
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 05:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597C19343B;
	Sun,  6 Jul 2025 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NUYyb6Yv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3691386DA
	for <linux-wireless@vger.kernel.org>; Sun,  6 Jul 2025 05:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751778805; cv=none; b=pyxJvzVm/Lu//sSnCIR0I/mqUsFJYoz4M6NYpltOtObWKXiZMo1liXGbW7symUttmjWYteIdzQDIT9SQik5bK1fI9pIO/ybd5ugT95QC92i4obL64o7v3dpDoQvdghK1M/CYvNJe+VCcu6cCN8NZeAPaKX4pSFHWI68MLbmKsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751778805; c=relaxed/simple;
	bh=cRs4nt2/uMGOIJV3cgwwou6RQ4wheKW8zcvpYgqN3UY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Q/1A+tstfGnk0h/8fJQjSNlnUS6HXK2qRqMqiHoAISMCg0LfimfBcm6zEqRrjeylztTopFZSdMNuUVoW6c6XJon/MqkkCNfNU7KQyTyJMWpIKUuHWgxDpBv2J9pYpYWjkVlAJJZVj/nJu7m7N6oOO8uaT0eOCjawEyKZJxSY3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NUYyb6Yv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5665DIglC3356637, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751778798; bh=TesPmotCaij+exXSd9eprIgsJAMKgfUY2Rh2xyYVfj8=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=NUYyb6YvkR9/eSat+GOc+/Jq2a4d5zh7ATaOhWS5/75f3LNb7OSORemeYCByuamah
	 ysyOTAywjkFkffZa92FkZHvvwysyC0skl2h+xCcFEliGszq8HSHFpQvTbeHC9hw71U
	 BTrxZ2RHAqgF03XLlLUxk4WJsuc6DJ6JZIayxARZOjRF3TjCIwZ3/+sha+yt+WZmjs
	 CiwZ8KWUBH2FipdgSvqaTmW1tPbMt2PJdIv2fLAJ6AmYOK25XDOnUrL/PsSgQR+9tt
	 /1BLy1BlgYGhQLbVI23z6QchsFms2XULqXOd9T/SKiouGkDgrd8R/fzrqC8mMwH98o
	 PT8eJVhT8W5gw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5665DIglC3356637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 6 Jul 2025 13:13:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 6 Jul 2025 13:13:44 +0800
Received: from [127.0.1.1] (10.22.225.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 6 Jul
 2025 13:13:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v2 1/6] wifi: rtw89: 8852bx: Accept USB devices and load their MAC address
In-Reply-To: <1f58d168-67a9-4d86-9e6a-73789c7a59f4@gmail.com>
References: <e6538194-116b-49b6-b2d5-2dbc69aa1a11@gmail.com> <1f58d168-67a9-4d86-9e6a-73789c7a59f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <075f5134-1d97-4138-8680-6292c4b0bc6e@RTEXMBS04.realtek.com.tw>
Date: Sun, 6 Jul 2025 13:13:43 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Make __rtw8852bx_read_efuse() accept USB devices and load the MAC
> address from the correct offset.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

6 patch(es) applied to rtw-next branch of rtw.git, thanks.

5e9184ae7207 wifi: rtw89: 8852bx: Accept USB devices and load their MAC address
0980de01da08 wifi: rtw89: 8852b: Fix rtw8852b_pwr_{on,off}_func() for USB
b57b556a02e6 wifi: rtw89: 8852b: Add rtw8852b_dle_mem_usb3
f56b4446d07a wifi: rtw89: 8852b: Add rtw8852b_hfc_param_ini_usb
0ed2a8b1a14e wifi: rtw89: Add rtw8852bu.c
4b295f4fdc80 wifi: rtw89: Enable the new rtw89_8852bu module

---
https://github.com/pkshih/rtw.git


