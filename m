Return-Path: <linux-wireless+bounces-17361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4FDA0A6DE
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EAF3A8DF0
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 01:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5A79E1;
	Sun, 12 Jan 2025 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Xb1sCxQK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138763CF;
	Sun, 12 Jan 2025 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736646657; cv=none; b=sYMGh9uNvSItUBne6XIRyagMuVygebn61daO1JoWsqAq7rFw6IsDK5MKdm+Hf4ggrbtPvkV2MAEdIVRHXn/U8GhLagN0N0bU/mDP6L3Z8+tHOZgecnHCoiv28904m16MIZAqiGaFbUAFGRiDfSAXhLGVnYXyYXsH7dfawk3xId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736646657; c=relaxed/simple;
	bh=6M0iLCz8S5DxPypVCA8TqI6CK7SZgoi405fNlVoTdNU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=N/0mv+wZd9nPMBjRcNL/YdPpJnfC8uHobDYHTudhvBwW+iAH+sDPGHZnNZo3GsskTXFTRVMejp7oO+dw4sYeSckeXNzlzwg8ThHGfEue50CdaeCfRYX33RFwsVy3ELJqXUGet0PasALvwE9Gdor6V3VOHzcGpsW6moVmadFBAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Xb1sCxQK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C1oXuhD1596249, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736646633; bh=6M0iLCz8S5DxPypVCA8TqI6CK7SZgoi405fNlVoTdNU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Xb1sCxQKB7KM5X0Gzc9ZGjotHeejCtaA+9o9HB0qoYeq6YN/Mq8jlmJOG/mIAYczB
	 BP6bwvcLztJpN2/h3Ip4+5aGz+29PFkrR8Y2Nz9esAyNGspWSspdxBe0nYcxc+P9gG
	 DEJayJ/5r/giQ4ake6koENDwDMIP9kUPkyPYCZ9C8T3HET5wWJNi1MWZbaH8Wzxz/3
	 4ARYaSPYIreN9uQHcl3MxVe+efF8gmqSc+rmyuibpm7CjJIvNTh1EOdYN/4aCyg4KQ
	 jZmEowxhX1/OaB2L1rLYgK16d9YI3CwuXW0he3p6QbS/cDxDzADWsz/D6837P9HC8s
	 pWn/kGbZuBXIg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C1oXuhD1596249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 09:50:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 09:50:34 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 09:50:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Liang Jie <buaajxlj@163.com>, <pkshih@realtek.com>
CC: <kvalo@kernel.org>, <phhuang@realtek.com>, <fanggeng@lixiang.com>,
        <yangchen11@lixiang.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Liang Jie <liangjie@lixiang.com>
Subject: Re: [PATCH v3] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
In-Reply-To: <20250109022557.1143215-1-buaajxlj@163.com>
References: <20250109022557.1143215-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <61e0a972-75d3-4acb-ba73-fcedd1ee4a69@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 09:50:34 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Liang Jie <buaajxlj@163.com> wrote:

> From: Liang Jie <liangjie@lixiang.com>
> 
> Ensures the correct calculation of `cfg_len` prior to the allocation of
> the skb in the `rtw89_fw_h2c_scan_offload_be` function, particularly when
> the `SCAN_OFFLOAD_BE_V0` firmware feature is enabled. It addresses an
> issue where an incorrect skb size might be allocated due to a delayed
> setting of `cfg_len`, potentially leading to memory inefficiencies.
> 
> By moving the conditional check and assignment of `cfg_len` before skb
> allocation, the patch guarantees that `len`, which depends on `cfg_len`,
> is accurately computed, ensuring proper skb size and preventing any
> unnecessary memory reservation for firmware operations not supporting
> beyond the `w8` member of the command data structure.
> 
> This correction helps to optimize memory usage and maintain consistent
> behavior across different firmware versions.
> 
> Fixes: 6ca6b918f280 ("wifi: rtw89: 8922a: Add new fields for scan offload H2C command")
> Signed-off-by: Liang Jie <liangjie@lixiang.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply patch:

  Applying: wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
  error: patch failed: drivers/net/wireless/realtek/rtw89/fw.c:5171
  error: drivers/net/wireless/realtek/rtw89/fw.c: patch does not apply
  Patch failed at 0001 wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be

Please rebase on the top of rtw tree.

Set patchset state to Changes Requested

[v3] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be

---
https://github.com/pkshih/rtw.git


