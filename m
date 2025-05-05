Return-Path: <linux-wireless+bounces-22425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7BAA8B20
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 04:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA223A4197
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 02:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2917B18C034;
	Mon,  5 May 2025 02:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="C/QaNJma"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916F188915
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 02:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746412569; cv=none; b=gWYlwbufU3RGvks10TBqyqq3M8+MPClmqfgwLkkUiVhhmFU4bs1an92P6U3NYctR2stsmM9fl073NEJUAsS7/O0PJyFDVVx9jcDKg0gg6tn6idLcStXJR/NUmDIireomy+00AzGnyGy+3PAwgy2vwSyJ2fHuVoYmxmMXXeFuj+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746412569; c=relaxed/simple;
	bh=z7cIn8boEkE7mmQr1yX4QNNuwUl4H24qGhgAeAaLdko=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=HVlnfDNZd1//XPWE9PSqDWHoOjOIMNOqEFtG3HXDG4MaDXbQQR6x2XM7s1e/EHd3sMNDP7E4lxmejOwgeHxSZgc/Fi7pbmNV+y47q883ZVQz2HnkI7qSNkfFOFTivzr+ZmK92LOjT4/Pr17GNLEsehXVdZyRrfoWtQe8xC1vo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=C/QaNJma; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5452a46813464821, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746412564; bh=z7cIn8boEkE7mmQr1yX4QNNuwUl4H24qGhgAeAaLdko=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=C/QaNJmaTnpwoYUFBpMz2RVBNWn6AdYScPlXuHx2PUAuCLKGaNASk7ZH9YdFonNhI
	 6CfOwtQVwp/W4JcDPs+1NkCB1CpZaH/1wRIM5dZpqgYaOmLQUIIaxzp72gIw15sVTm
	 KP3nssAsHqTwY2/r/9Vx0utoeE7VfwRIw80R+Es8sxcDDhTQZi7zeph1EEqGINhq7H
	 iF3Q/cecWjtGej27IzBW05DwCCnQbr6HMyJpkuNb1zY3aC4YXMTFs2GbBPJa0FfNcT
	 nJ4gk2Ja4gu6q0K8EFiwSlEng9zIShL0QZ12C34AVZtEIfmX9RunlKDiceoe5ciLuT
	 vLI9csYJFN1Cg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5452a46813464821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 10:36:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 10:36:04 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 10:36:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: Re: [PATCH rtw-next 1/2] wifi: rtw89: phy: add C2H event handler for report of FW scan
In-Reply-To: <20250430055157.13623-2-pkshih@realtek.com>
References: <20250430055157.13623-1-pkshih@realtek.com> <20250430055157.13623-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <fd613a6f-8708-48bd-b1e8-2012a5b846f6@RTEXMBS04.realtek.com.tw>
Date: Mon, 5 May 2025 10:36:03 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> Newer firmware will notify driver of the Packet Detection (PD)
> value on the channel after switch channels during FW scan.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

d31c42466b1a wifi: rtw89: phy: add C2H event handler for report of FW scan
02eb1aff6fde wifi: rtw89: constrain TX power according to dynamic antenna power table

---
https://github.com/pkshih/rtw.git


