Return-Path: <linux-wireless+bounces-15427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDC19D07A2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 02:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F98BB21673
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 01:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C3C22F19;
	Mon, 18 Nov 2024 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Sbp6vqgC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952D117FE;
	Mon, 18 Nov 2024 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731894366; cv=none; b=poT410qXmdfrf+/MQr4i3jc3baJP4kxA3baU9HThcLBXfCzrP5+mMdR+qHFk+uQ/seZhm1rWMwTM0cPSct4BnRJCgvCoADg5hjEahyfD/sHcGzzHqfnAtBvReuTObiYP1ZklG/xq3fju7yf2DB3u4N6xXk+P8VobV++jYap7Wso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731894366; c=relaxed/simple;
	bh=1r+gbtYlPbbST/nWnrNKp6BA1ddNlkKAspb5Vb7w15c=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Lb9zEAdXyWl4AAeYeGl8qEuIREoCT+oj9zPFVhdK/Mu7mR+Cy2DiVAZG+nhBc9nX42uhgIZ9h8ysh8bnTuCDJ02ZO3285fS8TFyLc6mJpZ9IDqTyzVCUwXWx6zR0KNzG1DaokJhDohlINfDts5M4fxPc+00PdLCWPYV5OUSaZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Sbp6vqgC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI1jU8J14127628, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731894330; bh=1r+gbtYlPbbST/nWnrNKp6BA1ddNlkKAspb5Vb7w15c=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Sbp6vqgCyRyJhuoqAuPDCPMTYTrXzSm2juo51c0zOiewwn3Kl2jV2zy7DkWaJMTWP
	 qtcy1qEwSqxXoVF4G1ORVmzmzMcDMRnBnAlyZqQ5hh+sxgr8nF0SsSkmaKbY6vlnTd
	 X1Kx82XB7m+7gQF4jBWRY8ACbwJY2cvs35CFRorIHsXTPjNnk4x9z8MGh97bmOYfiQ
	 buDHUVqLLQN0nGqp8Yv9XYKX0+FaiyFSdkvpEh9uLaxFLuq2Qzf3tyRKoTaRCEBXr3
	 rOxsDkESlun03+V095pIcDAopcCO2Hv0F4jrCndWFxeG/3u4FsJzHAoDSncLCtIE42
	 OBkAol17FQuyA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI1jU8J14127628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 09:45:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 09:45:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 09:45:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>, <linux-wireless@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pkshih@realtek.com>, <kvalo@kernel.org>,
        <rtl8821cerfe2@gmail.com>, <usbwifi2024@gmail.com>,
        <m.novosyolov@rosalinux.ru>, <zenmchen@gmail.com>
Subject: Re: [PATCH] wifi: rtw88: Add additional USB IDs for RTL8812BU
In-Reply-To: <20241107002846.13748-1-zenmchen@gmail.com>
References: <20241107002846.13748-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <b26f7358-3163-477a-98ce-fdea9dd76adc@RTEXMBS04.realtek.com.tw>
Date: Mon, 18 Nov 2024 09:45:29 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Zenm Chen <zenmchen@gmail.com> wrote:

> From: Nick Morrow <usbwifi2024@gmail.com>
> 
> Add three additional USB IDs found in
> https://github.com/morrownr/88x2bu-20210702
> to support more RTL8812BU devices.
> 
> Signed-off-by: Nick Morrow <usbwifi2024@gmail.com>
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

d4c4903508f9 wifi: rtw88: Add additional USB IDs for RTL8812BU

---
https://github.com/pkshih/rtw.git


