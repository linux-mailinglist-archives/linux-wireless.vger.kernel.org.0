Return-Path: <linux-wireless+bounces-24680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592ACAEE878
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 22:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DFB7A5453
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E37235079;
	Mon, 30 Jun 2025 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQJRP1ez"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185123506D
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751316273; cv=none; b=eMv2DPWDNcW7xXuCRdx9UKHdQ9Iy26U2IOG/NB5lb3cP6G2FhhaBzYLHyK3I3fgrJGfKTWEmykBOknOWq7bCwfXVSgu3/SzeNvzkG/XOvkHUG9zaqD+/o/i43ZIvdOl0sJhExb4CwUgZk/d5xi+5mrcPHri4ySVr3Z6WMH3pGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751316273; c=relaxed/simple;
	bh=HS8xjxQzKXS8K0nEiQHo8rJZ3Yj6CzS4xzOAVxWElio=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J4/Dkt1j8O85av8hROFnvmvP7LNRe+Qokd1iGW2cpA3rpkgG6yK55HA25wyFPWlSbruCnOdfp+i4ouZ7YSU7wO4WzXMdSzGs66WMZymsD5v+7hicxe9hCjNzqPx5sId29E+8r20kwxAy4BunLsR4nopH5Na1pVfjdQuTsi/ydDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQJRP1ez; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453749af004so26627275e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751316269; x=1751921069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LASi7rgmoRvUmSgrB8BkHlPN+qq4C3OasX6gmm3oHn4=;
        b=eQJRP1ezrUe51sghWRJJIkMXHIdo8r+Y/L619TT33Yqc+wsn08tkwDtw9zIVDe2SwN
         TGHXmHuxI6wcwUAlRHFKk7OvFuZQ9COt9lcwR3YkI/dS0LDFCnj1pQ6k3uVyADIwoH8n
         sOg2+EWf33GIjKR/hI0vQrOJELjFRyUAoyvwbLV+ErW4/ylvG/2QuBhDdrGPHS3si4gC
         VDhAoKT4DxP/VJ9a1G7t8jak6Jg+v18X1lnMpEy7foghC9i/ZEeWCK11xPUAEQAn8Iu0
         wRWpjeLOZE35I9YyNmnAgPIzXe2JpI+tGic7nuOzaRPmD4GrDPX8BY4WvA03CK4rJ+wr
         c1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751316269; x=1751921069;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LASi7rgmoRvUmSgrB8BkHlPN+qq4C3OasX6gmm3oHn4=;
        b=Y0U91DOjw5nvbsbuFU5pHNqUizk+9J5waMaCvIN5G8/j78zqnjF6sdh3wl10Qu2Hq5
         etC52VeBqvdC0aIYTuAyyzzTpF6rFaDz/mFqF4VlxbfdQzDhd72tfWXnkYOemJ5JFrl+
         Nzl5VfEOGMHcHqkWgEWDHFPXbqOtbZHg5So//obxNTdcrjxtbv7c90oI+AyDtmrXU9nJ
         NZclsJv1RXV0FcWfDKVAOeKlqv6NN7cNLjNej/pAT8n1PYzPNgCGfArEKwHSOjJWGsAQ
         3HndpU4RiFzQYYhpxe9CmUkx9q8zwQRLU7y5WUP25aNKULxFHnGwZt8nyedQBUIFrSv8
         tXxg==
X-Gm-Message-State: AOJu0YxzTXZpzLSOUhdDgA5GVg8T5E6G3UGGmcxAMDkV6h29h5im8SNf
	sdSgFzHRI/toAiXX0YK9KySqNMiIO8Eryf4qLcVsit8p94GO11lxO74gjGbebw==
X-Gm-Gg: ASbGncsdkCqjOG9UN8hrANFNv/q1G/Xx2kDJJhAIpJ/uIsxoDl+tyb/KLLbNZsNiPqO
	pn/jc4UxAJDyn8JK/wGnGUwsH1oJTuXut5v3rzEm+QiBgNaOcnxDUCQbzBFGjeJKg8QY49iXuiy
	tTosWG0BqlqACqVCAqLCwFK2X1XBPSP4DWmpWhUxIX2rOJTBV8DtK07hsQHaCBEgrGFTLrSu0pH
	m891eSvfSZdULBpmzSOohp0AhjlXGQlf/FOjfQCravtA0ljowdDNtxe+C3jX+Clha0YwOUCK7lA
	obPC10YkyMW/etjzNmwKzcgvVsPa0NNRbHs+H3oWrZ0gs4Hy428ocMjnlH3q4+EMZXgIuQ==
X-Google-Smtp-Source: AGHT+IHp4l2wFFAJZ6pZTBn90JoogiOvpJ0mEtpr5iVA8Xg+srFuv/1aHgmZEXvFZCczlGjoLp2R9g==
X-Received: by 2002:a05:600c:699a:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-4538ee5570fmr165922255e9.17.1751316269139;
        Mon, 30 Jun 2025 13:44:29 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fab6esm11530341f8f.31.2025.06.30.13.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 13:44:28 -0700 (PDT)
Message-ID: <91fb7579-60e5-4a06-8007-3312639beea6@gmail.com>
Date: Mon, 30 Jun 2025 23:44:28 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 07/14] wifi: rtw89: Add extra TX headroom for USB
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Language: en-US
In-Reply-To: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In the case of USB the TX descriptor is transmitted in the same buffer
as the 802.11 frame, so add the required headroom.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.

v4:
 - No change.
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index fe6b19a078c5..776d2e5ce8a0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5591,6 +5591,9 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
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


