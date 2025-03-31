Return-Path: <linux-wireless+bounces-20988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7748CA75EB9
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 08:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C363A6912
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 06:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D3424B26;
	Mon, 31 Mar 2025 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="hvs+uKu8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C5A20E6
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401295; cv=none; b=LCFGsiDm0yK+n+9ZCWgbhXyskI0AkeH4Pyz+6P/Ub2tlIl0HRaclvJwd61fAEtTXGffGmLoswm07QyTMTwJcOMOAfvgM8vEbylWm9W/w8qcKaTXAxX6EY4pulngCI9ddM9ESUwWmclGYeCAEp+49cNZG7DAblTO/UBgfZ0YNh44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401295; c=relaxed/simple;
	bh=UOJlaKxFXtRuzP6LeygMboEz2K5V9gkiiiJt6R8rt+c=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=EwEq/7IowEA9PB0upNB3JnXJSDo/vj6jbnMI+HkG6aunkgxeWOIq1SX3nica4TN14gsQK/+m3+azJvplqzLU1NQClY0FK9SBOOpX4PUfOWjrQN3Eed+7IfJQ6qJar9FOYMXruC4i7TN2GadPmip+gxDu1WyJ1z/bcbIjk5zEPpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=hvs+uKu8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52V68AEv82872175, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743401290; bh=UOJlaKxFXtRuzP6LeygMboEz2K5V9gkiiiJt6R8rt+c=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=hvs+uKu8seJBopnZtJbr+B629hHdSrhxfsilElQMnL9hMYhxnrzeQzZKKK0vYL/0E
	 fRVk6ayQqKiyNyP7NfaHJA1Sehcy6jC2jEJ0EHRcfzx4SJOga2TBWCEHDgwmQWJjv6
	 RjLZjft0882C+0QdUmn329ICZpUaCCLvKlJLDVoP3zZsQAT9r0hU7cw1M0+1b3bNq5
	 aKVpQSBvu0EAykh/CGV+f7E11JvHHRcbFjK7V+V7upSU2i3hNOYL4Qe5p5nrsIlLqI
	 LQD4B2+S+nAF1xx5CQBomlJAqIsLbsIQrFfJGd+RoEK6oing7dd0ikt6x33nKOiApE
	 2QUfn8//cq6vw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52V68AEv82872175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 14:08:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 14:08:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 31 Mar
 2025 14:08:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH rtw-next] wifi: rtw89: fw: cast mfw_hdr pointer from address of zeroth byte of firmware->data
In-Reply-To: <20250325025424.14079-1-pkshih@realtek.com>
References: <20250325025424.14079-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <b1fae366-2cfe-4d8c-86fe-50db181cc87b@RTEXMBS04.realtek.com.tw>
Date: Mon, 31 Mar 2025 14:08:10 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The firmware->size is validated before using firmware->data, but Coverity
> still reports:
>   Downcasting "firmware->data" from "u8 const *" to "struct rtw89_mfw_hdr"
>   implies that the data that this pointer points to is tainted."
> 
> Using &firmware->data[0] to avoid the warning. No change logic at all.
> 
> Addresses-Coverity-ID: 1494046 ("Untrusted loop bound")
> Addresses-Coverity-ID: 1544385 ("Untrusted array index read")
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

bc1265b5c982 wifi: rtw89: fw: cast mfw_hdr pointer from address of zeroth byte of firmware->data

---
https://github.com/pkshih/rtw.git


