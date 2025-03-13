Return-Path: <linux-wireless+bounces-20285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B634A5E939
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 02:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63AB189A2C3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 01:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F2DBA53;
	Thu, 13 Mar 2025 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Bg/Qd13P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD633A8C1
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828188; cv=none; b=dqZxWO/9APxXK06nG0WE3IXj/iJF9OBy9K5rsyvATg6+tdcb09xrdqGQAR6W6d3n0pBYcpzKgktg+81OO2nImzy29SM1CgcuV6ZdtjIhXnbopN5MQf1qgSFts8zAsihVn1w7wQAMwRrkR/3nEf7BXIs/BUUMMNw5ox2dp/NP0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828188; c=relaxed/simple;
	bh=YGOu0ZYyB8vGywzZedXguF8z6xj+27nU2Eao/ydKva4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=lFFXjDlP0JMDvzGiU3nPpdufJI/u/NM6Vpqtgyk63w/nUxhPLuPRcbF2pNjLr8TriLnIVg88XD6r0Wx89TuRZ0fS1ga0J5a3WV8yIXIQflkAxWZv19ArihgoS53mmEYHq5edu5nJONOkADUjkTq9J2JHGccO1csdP4LmZ2y/pss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Bg/Qd13P; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52D19gulE253619, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741828182; bh=YGOu0ZYyB8vGywzZedXguF8z6xj+27nU2Eao/ydKva4=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Bg/Qd13PHBoVwtxfJbviDjmupHnoPnZb33SSmE0BcLhgJARpMohTeMMVM1cINW/jM
	 BXOpfyTF63yRxneOgoQWHIY5trKQ+AuzumTMOGGQKo8mp7R+ieQwNKaia8tDQjmFEf
	 HkTvjNs3Nxpv9IVrDgHG1t6keL35QLQsSc7RtX0mzCC1T4IEi8/wEdZxOOGjXyba5t
	 VLlmTz5V1udAypHnFgTzdHpZWmmvlfjOQD5kzX3KmSKzs5+Bt0QXint6H+gNy+LUs2
	 eHH053plgxBLZIF1WvXXdLs2suyQpDd+fPZ06tnx3Hf+MF0Ar1OthGxYRno8zU29aa
	 pw7sp3XeYduvw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52D19gulE253619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 09:09:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Mar 2025 09:09:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 13 Mar
 2025 09:09:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: Re: [PATCH rtw-next 1/4] wifi: rtw89: coex: RTL8852BT coexistence Wi-Fi firmware support for 0.29.122.0
In-Reply-To: <20250308025832.10400-2-pkshih@realtek.com>
References: <20250308025832.10400-1-pkshih@realtek.com> <20250308025832.10400-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <80c153e2-fd91-4882-b519-889f7e349fa8@RTEXMBS04.realtek.com.tw>
Date: Thu, 13 Mar 2025 09:09:42 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> Add format version of Wi-Fi firmware commands/events for firmware
> version 0.29.122.0.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

bb76dd94b7c7 wifi: rtw89: coex: RTL8852BT coexistence Wi-Fi firmware support for 0.29.122.0
a36230aa5f5e wifi: rtw89: coex: Fix coexistence report not show as expected
6db476db57ca wifi: rtw89: coex: Add parser for Bluetooth channel map report version 7
e5c45671d996 wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.4

---
https://github.com/pkshih/rtw.git


