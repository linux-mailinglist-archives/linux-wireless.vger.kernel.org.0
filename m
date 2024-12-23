Return-Path: <linux-wireless+bounces-16727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B133B9FAB50
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 08:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F3718845E9
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046D9156C6A;
	Mon, 23 Dec 2024 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="RHh2whYw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2A18BC19
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734940523; cv=none; b=PbnvkLA2JwQTmCyC/A1opnhBrIBw6PI2bjj7b+sWo78SYtVypHfBsjCVxD5PderdgUikwIptvicIeVOlVyyD1l1UPG/u/hW29wI4t816WNvJDXo79FYRXCIu2LN68d9ZOsZp3mipin8g81HY40uaubRcHcaijDGtpfJZwSTXw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734940523; c=relaxed/simple;
	bh=RGilOL4OPOqvLjeXyNGXFVcBpt5+xovtlh+P1jyzI1I=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=mVux8Oyt12eBwA4HJ1oiipJEvkRGm9ZoxfUwdBWNIlULiWYnYypTgyi9Muf4SthMhYOR0Qf5UlqScI+pssDO5s1CUZk3f8SqHAd4KxehpwbjpqkO1DW9mqZObUs4P+fGJ8aU8AXrcYArsQGmlyvqA/WDhPSNliIpGjQR0mXexeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=RHh2whYw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BN7tEPF11475155, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734940514; bh=RGilOL4OPOqvLjeXyNGXFVcBpt5+xovtlh+P1jyzI1I=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=RHh2whYwX0ydkD53SSdOll33MeBpCxhE++j4PnOQPtJufMDXVwH/HD7FLOCUdV0yr
	 oRaFHoWp0h3ZXfmV43IdZL639HLBniiXzZITV4Nd4Zd982uo0uKXiukQxiUWzx0A1R
	 8oFWKhcs8zU/wKuRWqxiyPpvmxrL80hmfCz2w03aLCQD2QCaAAbu2omBsCv6U3fhP2
	 A+LCKxLhMH4m25ZDaBu81j/iL6I5UV7hXEH2VuxDxajmmgzLEKvIjkrYc3EoxelHYC
	 00aHEakxUDUNLtQdgJw6idiPWSH9KcRvSCbNTkerhaZG1MknQXNIECqUFhV5GMfTzm
	 rZ2Jxq6w57hgw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BN7tEPF11475155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 15:55:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Dec 2024 15:55:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 23 Dec
 2024 15:55:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: add __packed attribute to efuse layout struct
In-Reply-To: <20241212054203.135046-1-pkshih@realtek.com>
References: <20241212054203.135046-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <660f5276-9e44-4d02-a3d9-95b20411b839@RTEXMBS04.realtek.com.tw>
Date: Mon, 23 Dec 2024 15:55:13 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Compiler should not do address alignment on layout struct of efuse.
> Otherwise it leads unexpected layout and size for certain arch suc as arm.
> In x86-64, the results are identical before and after this patch.
> 
> Also adjust bit-field to prevent over adjacent byte to avoid warning:
>   rtw88/rtw8822b.h:66:1: note: offset of packed bit-field `res2` has changed in GCC 4.4
>    66 | } __packed;
>       | ^
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412120131.qk0x6OhE-lkp@intel.com/
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

0daa521a1c8c wifi: rtw88: add __packed attribute to efuse layout struct

---
https://github.com/pkshih/rtw.git


