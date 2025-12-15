Return-Path: <linux-wireless+bounces-29750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B37CCBD151
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 10:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16DCE3015155
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8BB33033B;
	Mon, 15 Dec 2025 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZHtUnMGU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CCE330328
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788386; cv=none; b=R2NkZ8eN4wswI/6MpeVeSDMVXcqlMUKcXQqipMh902ZFW/Ys/YgYPRDurjxGo1G7SlZyC/x90DhmeYLdsVfdo6K6JdzBWKos3LJFKdcQgAhdYMwLy5dNENxmN15b9JGOqpNwMuXT4uQQY9TcEjKvkEkdSHM3IHov3kFemyYA6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788386; c=relaxed/simple;
	bh=iga33Yn5y5FJ9DFZKQpY3XudqCyVaSmZf7yOmV9Vihk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=st7Lnzxl7943s1dwHRyMGsZsKh/hE5xSdFYJh8jhX8D5OgD4XoHfYQQ3QMhCoD8Ib8zQTOpz7xGrnMEYzezqewKH3gDIDbF9M4AOgbIOpvD+OuI1E5/fcWQIvJGAy74btnLbQ3K8aunnOWw6FYdtPzietsnH48eIvwdiVJHYX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZHtUnMGU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BF8kJg151497534, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765788379; bh=lz46eXKUqjO6Trjyv/GSAq4av62fZXaKcsmAANGPFLs=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=ZHtUnMGU40lED7BBKgxhHCH1vGeCeyUt7GkINRRgU523ZGbr7H2vW0h0ywG3N48oo
	 MFgR2Xor9g3dBxZX1oftnXL65/+PapFmjVlICfi4J0MvnQlWBtJmnDIz1Iwqt7JPpq
	 2FnhRrlKx2G4eckxVP5J0RACUveAEGPmMud3ATlO/+9/zO3e1jFu3OC9eDMmawWihH
	 F9l9J4zhHjJLuBahTtiuzFMnQEHJFv+fFDsXbmRpRU03oBvDILcXF50nnoY+qjONuJ
	 AsNZZ1pcCYzdKsbyin57S6JF13cuC+KA9jLHOyB7y8i7tYXHkC+fD1j5E20o0WndiL
	 //dZMkIIg8Gvg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BF8kJg151497534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 16:46:19 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 15 Dec 2025 16:46:20 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 15 Dec 2025 16:46:19 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 15 Dec 2025 16:46:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <alexbestoso@gmail.com>
Subject: Re: [PATCH rtw] wifi: rtlwifi: 8192cu: fix tid out of range in rtl92cu_tx_fill_desc()
In-Reply-To: <1764232628-13625-1-git-send-email-pkshih@realtek.com>
References: <1764232628-13625-1-git-send-email-pkshih@realtek.com>
Message-ID: <5953ce3f-95a2-4a63-a2eb-7e8d6a71e807@RTKEXHMBS03.realtek.com.tw>
Date: Mon, 15 Dec 2025 16:46:19 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Morning Star <alexbestoso@gmail.com>
> 
> TID getting from ieee80211_get_tid() might be out of range of array size
> of sta_entry->tids[], so check TID is less than MAX_TID_COUNT. Othwerwise,
> UBSAN warn:
> 
>  UBSAN: array-index-out-of-bounds in drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c:514:30
>  index 10 is out of range for type 'rtl_tid_data [9]'
> 
> Fixes: 8ca4cdef9329 ("wifi: rtlwifi: rtl8192cu: Fix TX aggregation")
> Signed-off-by: Morning Star <alexbestoso@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw branch of rtw.git, thanks.

dd39edb445f0 wifi: rtlwifi: 8192cu: fix tid out of range in rtl92cu_tx_fill_desc()

---
https://github.com/pkshih/rtw.git


