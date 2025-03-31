Return-Path: <linux-wireless+bounces-20989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A81DA75EC9
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 08:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D1E3A597B
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 06:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B617B418;
	Mon, 31 Mar 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ShW9YCUS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3881AC8
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401901; cv=none; b=KoR8ezpWq8gdK8LCSAFz8l4gSbW4QXJzvfWIAHNSwGolrox+edAOZ/WJHL26wzr76JEvk/HWaQzT5IpiwvX4UVixKEPfBUJKLs7U9dBWb48kJ9oF3T9Sku6ioOKkk8/k0N2zm6PeUwR9N9qXbDstfWcdKzKXmFPmoW6Q5oFXcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401901; c=relaxed/simple;
	bh=8QlGrQhQwymXYmR5/JA3SbNZm91jLVdRFtdXM1S9qkw=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=be887eVE34CCmSntKvT+kHnXf7rVr1CDbFeY/FyGGnJW6nxB17GvvF3qPP5eOOhfpEaC26C9EHQqlbJ09+uhhQE6NqX36iERengSwuSqVSLONfY67FhyE8LfX5rmAXYb/c0LVwHFK9ofawbgfF1hhG+Bmp4rL1XeFDpUHAUDhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ShW9YCUS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52V6IDM502880873, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743401893; bh=8QlGrQhQwymXYmR5/JA3SbNZm91jLVdRFtdXM1S9qkw=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=ShW9YCUSf9O753sZPL0sijLhy8/p4Gn2xlW9+Bf6BN9NSfYm97eTWK9Y9g1uP4KII
	 Abozux6Do8en8DGl5cO2cLwddFOECMgvtawY5ZzqCI/9FPiRrhL5IoG7tYhW88zGBC
	 YTeRz34h16yTznc8OYsmGLQrh3qG8LAbDUXcVv8m2/o/ZOFlbjJhzKaXmHvgWfObAk
	 1owp1VEbOFuvI7g8LSEju4fhopwlJAy/kUU6YRcxntXo3z/0nBV1EJhK4RuqOnCYnv
	 Iwbs0RIU4bo3svwV6y2w81WJMCMS1CFby64G1ON3KbPHhKChGw3FSeJAe/geP32Tfj
	 QXY7JPn7LfoEA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52V6IDM502880873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 14:18:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 14:18:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 31 Mar
 2025 14:18:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH rtw-next] wifi: rtw89: phy: reset value of force TX power for MAC ID
In-Reply-To: <20250325031021.15619-1-pkshih@realtek.com>
References: <20250325031021.15619-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <99291d84-9e05-48d6-99ec-7c8c2ae48a8b@RTEXMBS04.realtek.com.tw>
Date: Mon, 31 Mar 2025 14:18:13 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The force TX power function is disabled, but the force TX power value is
> preserved, causing misunderstand the behavior in debug. Clear all values.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

e95129709a86 wifi: rtw89: phy: reset value of force TX power for MAC ID

---
https://github.com/pkshih/rtw.git


