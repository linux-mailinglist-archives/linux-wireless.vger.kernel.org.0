Return-Path: <linux-wireless+bounces-13543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996F2991406
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 04:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9C7284067
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 02:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19C17C8D;
	Sat,  5 Oct 2024 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="B3KV3paF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483810A18
	for <linux-wireless@vger.kernel.org>; Sat,  5 Oct 2024 02:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728097052; cv=none; b=PPolIp4q4x6DB/IAX8eCqrm4dVsdmehIWgNorT7wF3fe0IeC3OKkGbl8noIbM8CZ4vzZLUjVzPNfPppnDIfIFcRS8F8J+2aDg68RX/oCq2EV7Hln+fON9wFpDpkrzWNcSUBoOPwWXzG/H9Wf69GEjdRaYIv6/CvLl1F8Ez7l0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728097052; c=relaxed/simple;
	bh=OFEv54KQaMkTqw8aUooCp4EwuoQXhrFD3h9Dt4ekVbU=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=lMH/ja3MApRlz6/gm4i1FpjGD3Mo9geethi2UgpUvv1Kd2CzHv3wEFVoAytKLmzVBD8ElFQSZDaP9OEREDqmNNVYl5fgSGl6HeExmypfHXRREfodtR1euDF43bWg8Js0ikN+calwtFssLxrtGtVFB4jbFyxU8OB5/8vY4lsU2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=B3KV3paF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4952vPbiD2457294, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728097045; bh=OFEv54KQaMkTqw8aUooCp4EwuoQXhrFD3h9Dt4ekVbU=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=B3KV3paFxe52taHoV8mm96H1hYXXC7n4ym9O7hJ048Tod1SODRWe+ZmXv2EJI/rTf
	 8F99Qwd0snd0cq0xlMjHuhEjCJP5bWBpvM3Hy3nz6wz8x3VSCOiO1BLffu/2/dXOY6
	 HyvEGx8rLH+1Z5XWOhdz7d0iro36Q7CwlsSCOOqcPM9iB0YCZWe/q5hBft4zkIWuhu
	 Ler6kooa8NqLu3mOmCkoNMEvBGWPMvtCoGJI3+E5Zlm5kz4aIX1xA8rsosCPYcEFTr
	 dOa3JUZiv9J43pkpQF4UInf+9H28vRjZgfkORUIcBZOcnuhHyWILbV13QWLLSrBCqG
	 ajJyApl7Z7cbw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4952vPbiD2457294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 5 Oct 2024 10:57:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 5 Oct 2024 10:57:26 +0800
Received: from [127.0.1.1] (172.16.20.49) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 5 Oct
 2024 10:57:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: debug: add beacon RSSI for debugging
In-Reply-To: <20240927013512.7106-1-pkshih@realtek.com>
References: <20240927013512.7106-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c97d22d6-7d04-45d5-9d99-8aa783148799@RTEXMBS04.realtek.com.tw>
Date: Sat, 5 Oct 2024 10:57:25 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> In range test, the RSSI is helpful to check attenuation of cable and align
> difference between environments. Since data packets can be transmitted with
> different rate and power, the RSSI of all packets can be variant.
> Oppositely beacon is transmitted with the same rate and power, so beacon
> RSSI will be relatively invariant, and more helpful to diagnose problems.
> 
> The output of beacon RSSI in unit of dBm looks like:
> 
>   Beacon: 19 (-33 dBm), TF: 0
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

284939d7e87f wifi: rtw89: debug: add beacon RSSI for debugging

---
https://github.com/pkshih/rtw.git


