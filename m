Return-Path: <linux-wireless+bounces-17356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC217A0A6D1
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D65188972D
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 01:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBEB4C9A;
	Sun, 12 Jan 2025 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Oa8DWAPc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CF322B
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 01:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736645261; cv=none; b=S+NX4cNCD59WMEPzTv0OBk7agGIfQx9gtRGZQlw1q5AZ1cQUdnxZuk5aGX8JnGlyf2jgUAWAV72Rb18pYLAUMon74eiC4IWIXYK4hWn/thIkFWZNyLXz13TDjKO2cXtHxIrdP8PPha0iKqI1H4S/+zfm5kE5guUv0IGx9vg1YK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736645261; c=relaxed/simple;
	bh=tafkdZifcA5eGjPRthk3GVkAm4/KUSREIHFBDV5FwZA=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=p6iBzeinhAuAzqLusXnRGWW2HCBPutBSoXM+nEdRcMm4PBgpazQCLHALjcaGS9K7ockuwYxlWynHWRSNL4syh7saaMVCGvZE+HENbG5djkzbn+wt9LQfyG/32wosnvhJGIIIeE24ag6MMamj97uOOTub2g+1AiJnWHljlBapR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Oa8DWAPc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C1RayQ61563006, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736645256; bh=tafkdZifcA5eGjPRthk3GVkAm4/KUSREIHFBDV5FwZA=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=Oa8DWAPcU4yHJleiV6IOEYas3M0XH/4GqLYK+NO7m6PysLv4Nsj1XYVfXbEGBYGHn
	 Alknq3cyn4Z0jEzlEpPE20PV0Wkw6714EwMag5IZNbJb+gY/vnPWnfN3rU9kznXwho
	 s7C9yxNQML0FPMTqbWEEwGGe5VxjaIDDODc2YYT/yXqx/aAcM9qYub8Qlm2UQX5IPm
	 Z+JddvFWdRWC0CqWfRk4Rru0w3uWk2OuTMAO8gMFYtzzoIZSyqnHw/Rp8lSLgMAP3e
	 GVUS+GxZ3XQbuU3GtQbVOvWm1nCPdv4f7WwG/yz11iLWVZ1B4a0oJxFuXv700jS0DE
	 aGKcOm0iVC/Mw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C1RayQ61563006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 09:27:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 09:27:37 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 09:27:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: rtw89: pci: treat first receiving part as first segment for 8922AE
In-Reply-To: <20250103025126.15378-1-pkshih@realtek.com>
References: <20250103025126.15378-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <8df59999-8e54-499f-9fc0-968bf0fcec1d@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 09:27:36 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> For early chips, the RX BD info contains FS/LS bits for first/last segments
> of a receiving packet. For 8922AE, the FS bit should be ignored, or it
> may throw warning:
> 
>   rtw89_8922ae 0000:1a:00.0: skb should not be ready before first segment start
> 
> To have compatible logic, FS determined by what pending skb is existing
> (!new) or not.
> 
> Since we expect every single receiving packet in single one segment,
> enlarge 4 bytes for RX BD info, and add a debug message to note if
> RX buffer is possibly smaller than expected size.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

6ab452d458fd wifi: rtw89: pci: treat first receiving part as first segment for 8922AE

---
https://github.com/pkshih/rtw.git


