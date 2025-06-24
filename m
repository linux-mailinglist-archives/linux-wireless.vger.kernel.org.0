Return-Path: <linux-wireless+bounces-24405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99C9AE5D42
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 08:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DF517D5AB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 06:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC39817A2E2;
	Tue, 24 Jun 2025 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GaNJpYmh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCE24C07F
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750748142; cv=none; b=HpksMauOfaYQsov0A4C82t1ILwHAy+jXFAU6H/uJNU9DEP5b7Dwo5H/O9us74NFUBcNoqG6ziePNy22bBMoVfh+A3z7YJWGeuQEhLm/mAUKqUDV3e5PdnFxDozTNy/QikulJGEMmruORz9NBd6+HzysrCsu7pmbS1WlKnVt7sfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750748142; c=relaxed/simple;
	bh=GAxtzS2O/y4K3CkJt6ArN6NgVH/xQ8FXJqJsnZmjSaI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=XBvyDSe+uO3lbW6IBCNyZuwQ5+HkfjMhkW3LiKWQq/Ju0tbmItBrugfaAosdnTzhJ+KxKWKeTTj44OI1OtvFn7FJf6ROdAZsZ5Jy2OCfL5LzijetlBr/BxNmyOEwZnSz2VQbD0PsiGMdk4FC9U+YFYR2RQuHu8lhte3uG4JZyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GaNJpYmh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O6tbYY33201312, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750748137; bh=wC7GDpjj95T44qE4kdzeERpeq0NnCh30jy2p6qEK/oQ=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=GaNJpYmhcd1aawnqg/W41y1JNVLr91UMbVupDxoR3ktN56JjgnjTR+JiDIAiXpu65
	 MhYJkCbyLpTf9ArGyE/hGGev/nOBpnpvfY+TxQDwEkaQ4kaFFOLbcH26AONONiDaVV
	 z0/0d6rPz0y3p0ZS95DdZynkfLFHEr5pp5/SGs7m9U9GLFIA9zvBq1UGsRXS+qYFMp
	 JxNNJsOQxs+EfvkzUKA7Z06x+CqU9ftbIEar0M4qTG3icuQA8H5MKgzEP+uV+LhtrM
	 kyH9TdpfUn29ogz53w3QWfZ9s+Av+m+SuSTu91p5oX5R+4iwdd4Ip9wV8PIcGaaoek
	 MqDGlSwZBUP9g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O6tbYY33201312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 14:55:37 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 14:55:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 24 Jun
 2025 14:55:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 6/6] wifi: rtw89: enter power save mode aggressively
In-Reply-To: <20250618124649.11436-7-pkshih@realtek.com>
References: <20250618124649.11436-1-pkshih@realtek.com> <20250618124649.11436-7-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <27ca88ea-2120-489f-9f51-bdfb361c894f@RTEXDAG02.realtek.com.tw>
Date: Tue, 24 Jun 2025 14:55:50 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Currently the driver allows the WiFi chip enter power save mode
> by checking the transmitting and receiving traffic is very low
> per two seconds. But it's hard for some applications to enter
> power save mode, like video streaming, which sends burst traffic
> regularly for other side to buffer and only send little traffic
> at most time. So adjust the criteria to enter power save while
> lower than 10Mbps and check it per 100ms. Thus WiFi chip could
> reduce power consumption under these applications.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Internal found that the traffic level should consider sampling interval
(i.e. 100ms), so drop this patch for now.

Set patchset state to Changes Requested

[rtw-next,6/6] wifi: rtw89: enter power save mode aggressively

---
https://github.com/pkshih/rtw.git


