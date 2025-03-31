Return-Path: <linux-wireless+bounces-20992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95ABA75EF2
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 08:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D17B1889100
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 06:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E115B0EF;
	Mon, 31 Mar 2025 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="N90n4noL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E413A258;
	Mon, 31 Mar 2025 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743403381; cv=none; b=On0beBK/eZniReFZaVKIbwOfYwxQenz+GYAPnXWLAsk+WBEtpBY9wx3lBL0QsEp3Imh9x9idzhGXsPrrgsVHtfz8zAYYZ5Y4/n2/HGXrWM0bHD1ts123Z84EIRpA3ELQmCJ1tt33qpMoT+eVQRY426EhlRUobau30mc2uwmw4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743403381; c=relaxed/simple;
	bh=ZMCgQiBl0Uni1H4m7nrjeqy4ygpCCxdKFnUryK6hr8U=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=eJ6D2JksSuhL1lYm/lyoKBNslVHRqB0a9PYUACrhRdFdeOC0LCUyZWthfX63GcnbuFyyOxL8PrENBxqNlSnguW41Cvc4MhcwmnOpSj2nPd8fgrd9i9ixZi7ze8469Ac8ZQs6NjcZ+bRHrogqkdljvSUBo3hmFNHp+dyLZj30cz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=N90n4noL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52V6gukiF2917882, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743403376; bh=ZMCgQiBl0Uni1H4m7nrjeqy4ygpCCxdKFnUryK6hr8U=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=N90n4noL8NYPjMpPXuooDdmNR8wxuEOsC3TKWr5RJhfsRqdSD2JwcVhJdEpT9fbcO
	 TRXx2C6mTMxd0+7J5Jmc+vHk1/9urXMqNj+kSVA9I2kxmDcYJKK7laxaCENbRzTb26
	 h7otlc7sJYgvJ9xo1QsPtW/vQqcBF0byl2DYedZJ+IzeDTx+UWJu75/7s6KhUj4RO6
	 twUT5SI8xvl4me2S1ZXIrKAyIYxt4Mmydj2c5pymfBKxSeHbNWHqc+tq2krvaMQCPL
	 zVV+Sg1gm5JM1F0JC/KMyOGaXgFh+WiDQ00Pk1gh4qx5VMd8ti5noFK7s3CglBC0Bv
	 lperSO57sgtNg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52V6gukiF2917882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 14:42:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 14:42:57 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 31 Mar
 2025 14:42:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Chen Ni <nichen@iscas.ac.cn>, <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Chen Ni <nichen@iscas.ac.cn>
Subject: Re: [PATCH] wifi: rtw88: usb: Remove redundant 'flush_workqueue()' calls
In-Reply-To: <20250324080303.408084-1-nichen@iscas.ac.cn>
References: <20250324080303.408084-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <1dc55808-0534-4355-80f2-3068312c4651@RTEXMBS04.realtek.com.tw>
Date: Mon, 31 Mar 2025 14:42:56 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Chen Ni <nichen@iscas.ac.cn> wrote:

> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> @@
> expression E;
> @@
> 
> - flush_workqueue(E);
>   destroy_workqueue(E);
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

625fbc16524a wifi: rtw88: usb: Remove redundant 'flush_workqueue()' calls

---
https://github.com/pkshih/rtw.git


