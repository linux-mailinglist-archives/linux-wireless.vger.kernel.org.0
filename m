Return-Path: <linux-wireless+bounces-27116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA28B49EA0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FD37B199D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 01:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679271D5AC6;
	Tue,  9 Sep 2025 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YYuNwlOF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF016DC28
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757380901; cv=none; b=fvUd/rJ89zESNYOheXjad7Bg5rjzrvGOmr396oVVsPINKWemHFyafBgC6UrZctQ3jafm/4nYOoxN6clzJKLrMjpha3gJaCPjIq0cN18PSvIbgvL6u+g5SwJisoDwm5e6NHZZURIoRVkURKQ9cmfJMvpFFpBbW/C6KrfxqFx1u+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757380901; c=relaxed/simple;
	bh=tIgkL+VVlLDJO7DQU0KTKksGw/W2aVDlSgLsPwZtfP8=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=cP3BiFuro/IS1v+CwGognlJLNdLqwmPDz7Lzhwn1eX9M5TBOaVg33+DYTi3jYF2b1pUMs35dWp2yCuqzCpDDtS9rwxAORI06sNpb08k2BPyqrdugeasAW99PUhA0brgJZ4zf3fS57raUOCf2RkdQZoxe5zpJo7U9P6XZnTQxXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YYuNwlOF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5891LCqtC2885408, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757380872; bh=Ti20AZEjbGOWp+WspSC3GXZwCVGfyiT3ZHTr+3bHhjQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=YYuNwlOFF74qeV2n2oCPL6GU0UOsh6DTmRJlCfWQeU/uKOlVtMws6W3XWg0cB8ubw
	 g1mgmsMfSrW8JvG76SgGY6GvowELOCTWZFwIJ2gdu/837sSzHczxO79gLasYHXY6u3
	 ngNOhmq+P6s1xwvtGLlF/dViSvZan8Bk68ccsAiTkJ0NeLSqgkPYvf2CrMv1XEaciu
	 9Jsm19E5N5HTRtzp0kHHqPo3lkokw8GrpipR9ukMlqbDU7Fm94jYgB6a1ttj+m/nXt
	 32JraIPkFhwD9j4KsYQM1Aet30XRDF4GA+n9Pa6EBGH54fryrlfnldG58ckxxq6Sgt
	 TtRiZ+r9Y3/DA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5891LCqtC2885408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 09:21:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 9 Sep 2025 09:21:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 9 Sep
 2025 09:21:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v2] wifi: rtl8xxxu: expose efuse via debugfs
In-Reply-To: <20250901121613.1876109-1-martin.kaistra@linutronix.de>
References: <20250901121613.1876109-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <33ee752b-bded-4af9-adbf-7c863b0108b0@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 9 Sep 2025 09:21:12 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

> The efuse contains the mac address and calibration data. During
> manufacturing and testing it can be necessary to read and check this
> data.
> 
> Add a debugfs interface to make it available to userspace.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

00afddfe4c99 wifi: rtl8xxxu: expose efuse via debugfs

---
https://github.com/pkshih/rtw.git


