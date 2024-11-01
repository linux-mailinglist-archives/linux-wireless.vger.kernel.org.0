Return-Path: <linux-wireless+bounces-14797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD4E9B8936
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 03:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8499A1C22004
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 02:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3917A1CA8D;
	Fri,  1 Nov 2024 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PlZ33oON"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350AE137776
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427405; cv=none; b=WualwKWpQxSp3Q9hter7Jq6SmrCsdPZGKGYhbNGLQjfkE5BZZztgInedVNFlbe15iqEtvm29Drchip4vvubk2u9qZCC6USB0xCegscekDlY5WFHg7CSB1Ce9ajOwXIYYF3t02fLLdtMIvO/Zp+8m86eckxYE9Syu7WqQ4L3rZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427405; c=relaxed/simple;
	bh=SxCgLYWcqWkh09xeq9RLMxf2uGEZ9K9TdtrrgMNLW6g=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=eMEqIcm35gNPbMpvI4JNhaMlGXlBBhPyyOPhXMQc0R4J+3tbnRsTHwQh8U10YK4eCPIW0PixIY6+EKJogE6HoRV+GQwdqrRJOr9ZfGwZmqebR3REk3WZ1FF/mHHhonbkKgSAcX4DQ2DEe6mHStVRqwDK+i/+jEwtyQLxkBLpRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PlZ33oON; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A12GSovC2347920, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730427388; bh=SxCgLYWcqWkh09xeq9RLMxf2uGEZ9K9TdtrrgMNLW6g=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=PlZ33oONaLvrtwHgVi/80NsmdX0xn7+Ua1SfuUwrBBEHZTvouElq9QR1GvaE6TMJe
	 dZNZ1DEScS/xZAp0Kn4U2yTKS8I3UCHh8BKALRAXgpIixa4MttahwTNrlVxP5K5qZ0
	 TCyku0MwT5l6TYbq4aku11E8KfhQynLcCyBtix/YDGRWO6cJQLt7O+Ef89mlxYSnj9
	 oZFQNWOtw7WEPKWi+IHiLdhLHSSFsjcUFRF2aWvvkKPviJ8S3e8wv0tsGe5qDo9XRH
	 cGxdmTkODqR7gWEFCWFDwy7duZrGrFwUK8dKYaGb4gga5TbQQBvyVeKs9yKxCNNmSp
	 PxhTm94YIIXkw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A12GSovC2347920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 1 Nov 2024 10:16:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 10:16:28 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 1 Nov
 2024 10:16:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: don't check done-ack for entering PS
In-Reply-To: <20241024055509.8000-1-pkshih@realtek.com>
References: <20241024055509.8000-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c611872f-d6ea-4ded-b2c2-fb7752bd66d6@RTEXMBS04.realtek.com.tw>
Date: Fri, 1 Nov 2024 10:16:27 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> In WoWLAN mode, driver will disable interrupt after calling H2C command
> for entering PS mode, but it may lead to failing to enter deep PS mode by
> firmware because the done-ack of the H2C from firmware is not handled by
> driver. In fact, the done-ack for entering PS is not necessary for driver
> to check, so remove it.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

345c894ee79b wifi: rtw89: don't check done-ack for entering PS

---
https://github.com/pkshih/rtw.git


