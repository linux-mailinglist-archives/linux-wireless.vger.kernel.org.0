Return-Path: <linux-wireless+bounces-28517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A94C2EEA0
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 03:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD41189406F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 02:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43322264B0;
	Tue,  4 Nov 2025 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jTr3jfaJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1591D7995;
	Tue,  4 Nov 2025 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221952; cv=none; b=tKvge2aFHGXfrHgVwNfzThJOuAtlrbTP7G3YCd8H0+qYCwnRF/WFeU9VjIQWFOB1k67Shj9KDpbMRif/4l3fS2Tm9rSg17zkMB6KNFHHYhe37iPOD6XNsQjbwAm/OWflF2rVL4WtvVOu8nWgtmtE89LX2OS9sb0BhWKAZRMhwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221952; c=relaxed/simple;
	bh=pqcRddZM1d4mdjm36l3eas5dKZOeZsFCQ++ZBFOxfVs=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=KeQ+932lwlgyUH9ocGw5Ule6KdfdWpgqqQMCYRX2TXpZQYxLb0GCQ17vGhZpgH7dHgZ31fExu6YOKIvID5udJTyUpa+nk972RkUC86CKKUeumqQDWNcgma7mfdTP1YidQu8sjhyOD4mUqCZr24APPxoR2PZWwSh6J4HM6nDscGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jTr3jfaJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A425lqI62488557, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762221947; bh=1eOgtdCezQTbv/x3DIfAcyYNDUJkm74s62EYGBbHIWQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=jTr3jfaJyHVOgdTr0qxB6D3+HH8b6GUMdTcLd9lZCnxXjKcAzSpC05cGXMpuQfO2S
	 Sv+1F0fL9v+d87SeURwpyxqkJ3iVOsTviwkLjMS5ussHNNs3yx5xvYgPQaijISuVgt
	 sgnwQQlWZaxNQr2VdgIh2lzt9VBVMT1bbd006YFTm09eFiMJhx91eHTKD38t+78aVD
	 lJPa6Bggfjm0nAsX85UV0cP5Dj3Bqt0/WqUIoM5mbFMOx1XGKuOSnUX6GGRNZTFnaL
	 vwjgL7cBQFYRHfm27Zzg8VR0Ta4XVLTiU2GQnsb5r1mc/PJUvvEWM8TVpM7DsYkGRl
	 D7eilIHnKAkMw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A425lqI62488557
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 10:05:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 10:05:47 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 4 Nov 2025 10:05:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 4 Nov 2025 10:05:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Hiroaki Yamamoto <hrak1529@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
CC: <hrak1529@gmail.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: Add BUFFALO WI-U3-866DHP to the USB ID list
In-Reply-To: <20251031111641.33653-1-hrak1529@gmail.com>
References: <20251031111641.33653-1-hrak1529@gmail.com>
Message-ID: <0345a903-b98f-494d-b8f5-da49baebfea7@RTKEXHMBS04.realtek.com.tw>
Date: Tue, 4 Nov 2025 10:05:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hiroaki Yamamoto <hrak1529@gmail.com> wrote:

> BUFFALO WI-U3-866DHP (0411:03d0) is based on rtl8812bu. I locally tested
> this patch with a retail sample and it worked fine.
> 
> Signed-off-by: Hiroaki Yamamoto <hrak1529@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

8adb609f645b wifi: rtw88: Add BUFFALO WI-U3-866DHP to the USB ID list

---
https://github.com/pkshih/rtw.git


