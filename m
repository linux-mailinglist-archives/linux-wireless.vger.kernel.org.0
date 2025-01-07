Return-Path: <linux-wireless+bounces-17134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C205A038F5
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 08:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D951881B80
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 07:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB101AAA10;
	Tue,  7 Jan 2025 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KCrPTFDs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7280BFF
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235821; cv=none; b=mOqW8+uMTa4glG1lwf5F03fY70mS6blgHF48JstaWpy1afEtH+YT4RVHjeerC4GhEEdi3r9TrE3FzCKCeN/CY4aD/yJnfvVRdheeZ12sBGmHtP/vwuXC/L0LV4bHme+re1zcpkUZlApzO73YbcP4jFqOV/o9leRZ/ie8E4AWOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235821; c=relaxed/simple;
	bh=M+PkqrS1YergHccZ9CL/3jt79QnbT6GW2JV4Fb0MY6Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=V050jdIOj1hQKSM2lGgFi18p6FpA0PXKHlJloPRZ4MqV60zWQEF8VkowkRrWq52dt4L2aL4wqzA2LA12G1MrHE7ISYNJiW4reEb3lRLraMzI834uqmE/pOPuecfphoEGABCrROE6fD5eC0DBVwMDv4kRjIOiYWeBegEiOCC7+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KCrPTFDs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5077hZigD3554329, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736235815; bh=M+PkqrS1YergHccZ9CL/3jt79QnbT6GW2JV4Fb0MY6Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=KCrPTFDsBP1lDqkxvijobeBnlOFPwjwm80vvD0OkQam6Wdn6jHu0sLW6YHi1M3L1Z
	 B+3uHIa6GUH4wTT7j0yC3upCpn4Gyj23IMJlxKabJUXURELXgW0wVPK/oWkJTfHxPf
	 PyEB0M7ORcsczpmk8l7NRVzB1NIOKC0qU/LGePL/YY/eXgZ0vi0A4LmUoLyqTi5JSw
	 NZAw3iWJoTIXxRSJFfDCEY+EYiIhAHzLDDW0JqBsz50FyreaQZUVV5IM2iAdISosPb
	 yYM+v/PeP6vfTN99+rgdLTjpxFNnOEdTWGTzZAGB0Td8IGE/IOBUin9MVCzOPF4qVm
	 mFu6kFquxYy3A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5077hZigD3554329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jan 2025 15:43:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 7 Jan 2025 15:43:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 7 Jan
 2025 15:43:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: pci: disable PCI completion timeout control
In-Reply-To: <20241225122804.10214-1-pkshih@realtek.com>
References: <20241225122804.10214-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <7b55ec53-c4d1-4107-b099-2d6cb90881b6@RTEXMBS04.realtek.com.tw>
Date: Tue, 7 Jan 2025 15:43:35 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Realtek's chips follow suggestion of PCIe spec to design the max timeout of
> PCI completion, but some PCIe host reply too slow to meet it and lead PCI
> AER. Disable PCI completion timeout function via PCI configuration to
> avoid the AER.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

f69ccbc50a12 wifi: rtw89: pci: disable PCI completion timeout control

---
https://github.com/pkshih/rtw.git


