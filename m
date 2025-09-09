Return-Path: <linux-wireless+bounces-27117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913ECB49EA2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6793A686F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E41D5AC6;
	Tue,  9 Sep 2025 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vvnSS48U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02B16DC28
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757380981; cv=none; b=nRmEmOYYQAoP/rJIVHLxviqUkoJmGThYEZx8FNBDaCj5Nrq/AcXwD5yG8RMGOuljBuIKJdeN6X1n5SPZygR84w7s6ArlKslT5SNN2i3tSZKCvtCkVl2KldcbEP/Gvnl0L4beU34G433HH/byv7rjKZIvouDT5OQ3ZAhL6vYtqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757380981; c=relaxed/simple;
	bh=TcgScafHQ1x2yDlRf6sQfKPVC3/D+C1pU59c6sX5A0A=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=lOtEYD1lzk9UEa+gn06ffiz1gadL7YUia6NlqGvQLXxzq5gRFZlGuQI07jaQGy/60JSj+RtHYA6Q0eV4AuWhGNjGrVnnanG5/WsyHI598avons7unuKJi+bXSC9HROMmOqmZom2+sYdz/5GpT0PfiucnQ3brwN5XXsB0guhcM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vvnSS48U; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5891Mt3A22888556, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757380975; bh=LMNoBWB1llBmhhFlNOnbtSd6XbazuYanY7jIEa6Z164=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=vvnSS48UNE5mfwPv3J8NEbo4+o2FFw/AF6+gRz33ppp77w9wegyzl+/xkAIWIkonK
	 c/RYHsQlstJ923R5MSRDlFxVty3XvsFnHDXCEFumz4dq6ezPcQko9V2F46UJrjJZlg
	 dB4oeAZr3SzY266Ze+rbtyv+Mw7aDp1Snd3/+pBygQPCDrHH0SH9nKjd1CcCJFrb8j
	 fecjvaM1XniSBDMeyYz24jquyoEGcpzokSjfsHrbN7RwqwYaLzFLgh7CClSO4onIAw
	 i0MAXMv3DFBwLIJTRJk9I5LY7EmAx+iopDdT0CJkL+eZR5b29XZ8QlJ1AFUaXV0VcS
	 WlnP2AouaFqpA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5891Mt3A22888556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 09:22:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 9 Sep 2025 09:22:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 9 Sep
 2025 09:22:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>, <linux-wireless@vger.kernel.org>,
        <pkshih@realtek.com>, <rtl8821cerfe2@gmail.com>
CC: <usbwifi2024@gmail.com>, <zenmchen@gmail.com>
Subject: Re: [PATCH rtw-next v2] wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U rev. A1
In-Reply-To: <20250902035755.1969530-1-zenmchen@gmail.com>
References: <20250902035755.1969530-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <6defcdd0-ce2f-40ad-b3df-3778979c50d4@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 9 Sep 2025 09:22:54 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Zenm Chen <zenmchen@gmail.com> wrote:

> Add USB ID 2001:332a for D-Link AX9U rev. A1 which is a RTL8851BU-based
> Wi-Fi adapter.
> 
> Only managed mode and AP mode are tested and it works in both.
> 
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

2ffc73cdb824 wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U rev. A1

---
https://github.com/pkshih/rtw.git


