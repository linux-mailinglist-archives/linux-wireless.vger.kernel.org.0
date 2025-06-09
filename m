Return-Path: <linux-wireless+bounces-23898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9AAD26BC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 21:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82667A2F7A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB7C21C18C;
	Mon,  9 Jun 2025 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXJMSY1o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815A145B25
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497321; cv=none; b=dwVgMkpnXAp3kFrPNmvAX/zXlrAGqh+IvZTLr1z8IvkNy7fYUMEen/W34SkTRc5RznQZeuu1mMNjTWEPwhiSX0dpl4T4E74a1F3t7baY1/DOEun+IIfXcpV33i61h4F5lmwFt2/4Md9qr8fJ8EYK5iAS7HogrPLdDfDqVCtK3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497321; c=relaxed/simple;
	bh=Zfgr0Z296aQfbpOah8WrjUUQbS8pWj91tIUZjzhX61w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mFBI7gCDATR6Jrdx3HQvhupwrv+lpJlMgpUOyihVuqyr2vARDp3PjjQ65/3LYU1rF15J3/8BUVFy5oaoUnk79E+T6zsEQbtv7WrKKY6JkM/1k8hpa8O+IhLaU9aAF6cNynG27qW/mERDIDjynHUzxwdyQR8VBvlpn05fmA7cSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXJMSY1o; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb2bb25105so743582266b.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749497319; x=1750102119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h6CFJ/B8tsyJkolJjYXN4fyoaWrWjgfH6qkJZE2W6s8=;
        b=cXJMSY1oVR9wVfs+10633renxp8+VxTGbzxrwiUv+MN9PdnB4/7M20N0efMnykP9+G
         Oo3i8hiv7tXU8tysSO8yUq3bAlVDo/6fRAYnZ95H/lIqPFvkupNb2VgQoRgI8vCQw9Sn
         BtJ9qPvTbBoVBTZCVs2H2LH96rPVPPgag4uQpyGgxBxfhW4FnPPuocSK/x1+xros/CHB
         at8PCg5uLbLII8/Fc8PP3g7bRiJ0Yjec5DxW0N05dcwzY6CSo5nsUJuX5VxG6ywSywsa
         xUEV5kwTLcJaGdOaqxB7x3fZmzQZgj/GGyeH59ujXgigamjN6n5ZG670aJz550HTwoi9
         VNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749497319; x=1750102119;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6CFJ/B8tsyJkolJjYXN4fyoaWrWjgfH6qkJZE2W6s8=;
        b=rV6UI8XqfpQA4kE9GxfY2rIGW8MOxNoqScd2movdgvCxPk3HgZZYJqPOmuS+OB+Vkr
         TRZzkT5TEA1xeM6Ezi95qCLO/e5/sZGi4Q2+o9Iw4KfssrGxlhF0O8nGDcBtAkDqywQL
         Eg5jnRJHszDJ3BEpBlIhDngrRPdEX0hyLDLoH0/Kz7XaB/sWASkDLGZc0sEbgtiHzSQ+
         DXhlyFb6bM+BnK+NlVNW/9a4/e8oF6B0N39wdrGuaDG8lAHRu7fCIhaKnFkK0nbkH0F8
         jzGXrUi+dDvD2piuQ4ylM3IJPXyqbEsNXZnev1QaswD8PFGqlq6DiUpT6rN1xjM65t12
         ATVg==
X-Gm-Message-State: AOJu0YxF6h3xIWrtscTbd3YvlkMQb5sJlWANp4B+A7JcaVBGCpjpZK8p
	Ln0r71pv+sCUT0uw5LFYfWTKxqQU9xyNw4hPgevRh98B4qx+PY1ogiyr3zh+2A==
X-Gm-Gg: ASbGncvJ3wQBJQgHpM13bcfOH7Q10bVPfxuqulXWu9+Rao/rXpTYnkXjNzwNNLZgdNU
	WCsHKBUeWTfmNx94s2fD7hnMOx9lxgT+r55jYAlL5Qf2GeLVf7JSNypG4MF3U6JE8zH81WMtWz8
	j3ozfn6FP49DPq8DSy3jyp8CoMRquQhIjezkwupkFtIG5iybemWQ36KwqWXpnrD427IQG1jzpIO
	xXx60AWLRWYohWbcPMPELo9MGU/yPnl1aReWs3NtEsd3mSJLNEajhRkzp8vkG2r+e6g4znihWQx
	3T8EgHllOgWATKUpe2hNLXhw6pLvgYVCOpYLj5661FeFoUouVUVQnUNlcoQF51Gn2eEy7soKVuX
	5h119
X-Google-Smtp-Source: AGHT+IGIhed4n07kk4QPt7OY4njF0LS/F6KILZLrQgO6ja4RV4sLN7ZqzoMaAToemApT0OSjJTHfUg==
X-Received: by 2002:a17:906:a409:b0:ade:7512:d9ba with SMTP id a640c23a62f3a-ade7512db89mr69661966b.26.1749497318702;
        Mon, 09 Jun 2025 12:28:38 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d754653sm592538566b.20.2025.06.09.12.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 12:28:38 -0700 (PDT)
Message-ID: <d15dc712-8b6b-40c0-a2e2-a1f9f3362121@gmail.com>
Date: Mon, 9 Jun 2025 22:28:37 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 07/14] wifi: rtw89: Add extra TX headroom for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Language: en-US
In-Reply-To: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In the case of USB the TX descriptor is transmitted in the same buffer
as the 802.11 frame, so add the required headroom.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 49447668cbf3..ce5c96eea769 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5473,6 +5473,9 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	int ret;
 	int tx_headroom = IEEE80211_HT_CTL_LEN;
 
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		tx_headroom += chip->txwd_body_size + chip->txwd_info_size;
+
 	hw->vif_data_size = struct_size_t(struct rtw89_vif, links_inst, n);
 	hw->sta_data_size = struct_size_t(struct rtw89_sta, links_inst, n);
 	hw->txq_data_size = sizeof(struct rtw89_txq);
-- 
2.49.0


