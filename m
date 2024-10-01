Return-Path: <linux-wireless+bounces-13377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7749B98BD15
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 15:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9E7281F5B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 13:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9A218C358;
	Tue,  1 Oct 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uFnfBKfx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4F637
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788239; cv=none; b=FLZQ3TdxHjajYROoow0wUKly9HRKAk1fBQKE45Wqvd+ep/U7RqagpYJGNa4/sRWUGm3IqTcVbvlwE1EI9bzf21z3tDqEemPc+hH7WKJxwnmWUpY8m7GBWOCy0bPr5DJ5NT2EWlmyHOcfSGlrUPDretCv6vxx/GY6Ee/TOwXE92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788239; c=relaxed/simple;
	bh=Nrg5mcn+X33mnzTJbr22oUpIQdUt96dTBwHb91pztcQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=PwcWzV4Xpl0fliz0zZbS9815swYcbqLr3qCqYB6Tg9D7dYf6CpZcMP1NJqSISTM2NFAmd6q/ArSSKRuek6QKD8i9C2zo4CnEpcZzXcqKjG822YZ+7gnj0lybUgvbGKHCUgw7qcTExmws9FYcpttnZatRN6spvavHRPaj8m3kC5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uFnfBKfx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 491DAYIt81008434, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727788234; bh=Nrg5mcn+X33mnzTJbr22oUpIQdUt96dTBwHb91pztcQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=uFnfBKfx3DRE4N8JZ1ehsyk4bC7u0eODV3x+vNPiWhjprnlP5M3BTGmDWf3XYMxtS
	 E/ZPRZdU6p9/slCfHNFHLHJ7fDjGGvW7+H4hXZpaUGu4kzDd/YiQCrznjEiPELXcey
	 sFC1jC/6WxBol7ZY6GmoFuVBGidRzK1IYgwWUU5ICADBGY+irkOAMd9tFCoSPiEylQ
	 5wxY3IFyBTED3+hAwCTMa0njlVrEA03oKwoSWWxKTuqTD1lHnWpmMOu1Rjn3C+0qmI
	 W0h2C2ZuxRFtWZ35D//tQI3N7bIZKycY0iR5NSlrKkGCNs+Z5sf5EdacjpGG78QkDa
	 meBrThlJSwOKQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 491DAYIt81008434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 1 Oct 2024 21:10:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 21:10:35 +0800
Received: from [127.0.1.1] (172.16.22.72) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 1 Oct
 2024 21:10:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtw89: initialize dual HW bands for MLO and control them by link
In-Reply-To: <20240925020119.13170-2-pkshih@realtek.com>
References: <20240925020119.13170-1-pkshih@realtek.com> <20240925020119.13170-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ddbd0c24-7476-46fe-959b-37cdef917947@RTEXMBS04.realtek.com.tw>
Date: Tue, 1 Oct 2024 21:10:34 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> To support MLO, we initialize things on dual HW bands of Wi-Fi 7 chip.
> And, each link will indicate which HW band it's bound to. So, in link
> control flow, we control major things based on target link's HW band
> instead of hardcode like RTW89_PHY_X or RTW89_MAC_X.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patch(es) applied to rtw-next branch of rtw.git, thanks.

f82a4471fc51 wifi: rtw89: initialize dual HW bands for MLO and control them by link
ad95bb3b92c6 wifi: rtw89: handle entity active flag per PHY

---
https://github.com/pkshih/rtw.git


