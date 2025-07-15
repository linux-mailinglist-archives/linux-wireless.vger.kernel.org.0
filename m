Return-Path: <linux-wireless+bounces-25420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256F3B04D62
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 03:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79B04A0962
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 01:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FC21B042E;
	Tue, 15 Jul 2025 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mNfuXPVl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B30126BFF
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542533; cv=none; b=gom8KyIXQm11CNRbK4C5UKQdIMpn5ARzOBswYnEWTCddBhHzHxaBnBRhKgpB2GW5diwMIuaBOpABEvY1D7TCw15/2osSQq/26CTAne7jT6v23/vtorSmw06xUNtB0cIPaWe4VSW8Er73eVBBrAeWQJXUi8W9pOhcuCbx7Oxkf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542533; c=relaxed/simple;
	bh=5go4wyYXu1tzFtsCEONtZZGANPVedmMJJWkUIoeyEqM=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=HDJIV3o6cTc0YrJ3jcsW9yPc/rHozLDRzmE3KgpmzHgACWIYc6JXxDQiMqfPBPpuVsFZ/M4q0UveQznrA6kRoYTaRWPS2twGUMQCPwvJkTCup3PmqUqMaGor6qI6mP2rUhVEKJmtkpWUiVEhSVtIkws+NX0BGxyHJHZ3eWixnp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mNfuXPVl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F1M72603737744, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752542528; bh=3Rt0aXDBgdbYw4f0wxp90tM3E7esChFQg1Z2CEM2r7Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=mNfuXPVlrNxOvDbx2nxuf70lwzY11qDwaIga523kfiobWmAu8YWUyfC7j+9baMDOg
	 c9qsYMcYHdsnst4sbnAi+HdiH2dQv1F6AcBzbPFEuqjJN8KUDJts+hwNd1ktqCC+bp
	 /FNPMd2oF+y9ktmewYOnOUA1nfvsTumPCr2W0A6s8zDXY+MG0JmaOAIt3ikPFlzhnZ
	 U349YA6qgwGhsroxZg0zCFr27ZG4rXdzf1Eseha9XNeVJ8yMUaaWmQW6LdltmLW/8v
	 GwRv/Jwujz756zLHACrlCib+EnS/oN4Y5LlcKkI//jfM3SXUwfbYYfsn4YeemS+cxZ
	 TNSF0LTDPSQWA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F1M72603737744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 09:22:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 09:22:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 09:22:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 1/4] wifi: rtw89: regd/acpi: support country CA by BIT(1) in 6 GHz SP conf
In-Reply-To: <20250709065006.32028-2-pkshih@realtek.com>
References: <20250709065006.32028-1-pkshih@realtek.com> <20250709065006.32028-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <8066e526-59c3-4205-9090-fe3fbba9aad7@RTEXMBS04.realtek.com.tw>
Date: Tue, 15 Jul 2025 09:22:08 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> ACPI DSM function 7 is used to decide whether 6 GHz Standard Power
> (SP) is allowed on given countries. Now, add BIT(1) for country CA.
> Besides, for searching country index, replace for-loop with index
> getter function.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

75bb7774a16b wifi: rtw89: regd/acpi: support country CA by BIT(1) in 6 GHz SP conf
01186c303ba3 wifi: rtw89: regd/acpi: update field definition to specific country in UNII-4 conf
08fbc2b6881b wifi: rtw89: regd/acpi: support regulatory rules via ACPI DSM and parse rule of regd_UK
b99d7cd36da8 wifi: rtw89: regd/acpi: support 6 GHz VLP policy via ACPI DSM

---
https://github.com/pkshih/rtw.git


