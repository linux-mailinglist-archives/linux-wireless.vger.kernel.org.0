Return-Path: <linux-wireless+bounces-23047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D0AB9361
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 03:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B6FA2054A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 01:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0731D63C0;
	Fri, 16 May 2025 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="oCf4nrR5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8A2E628;
	Fri, 16 May 2025 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747357320; cv=none; b=h9l2ajIAybiIOVfgERug2hD5lVWs+vnNGzVeQkOBhGMVLf+HFeVJUSG7kwNDwBUa/pVYug3PYZEYd6dCzagb3teGsl9wg0GTdbdSQuaAWvtS69w6/36R8mnltH4NkUpILJ2aEBdaVJG1lvonNXBPJNnSJHD4cIpXqYD/pj3ZZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747357320; c=relaxed/simple;
	bh=vo9tsHJNZFegfZa90XHjfcKXw62ztWhwEq7TJ3MNsro=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Q/Cr0y8wXiDsSYARtRMVCI/tqXErsWttQwshzvt0yqf7SBr/ONUgjo1+DWbh15cQO75WLmru3lSdajnJKA1V/V16rsg1FyPr/6wiKBqb5I6PSFtuiZuAUupmXeWMr3wMP9KV47FVVuxAj4khgP3REg0b3r2k977S79iaZ/Pftus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=oCf4nrR5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54G11nwJ6075015, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747357309; bh=vo9tsHJNZFegfZa90XHjfcKXw62ztWhwEq7TJ3MNsro=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=oCf4nrR5TTMCnAQxkiiM+Cx5wvomN/WpEkwGsDNpXJjWmWJ8iT8KEAhaNF1NbW9O3
	 fXtROXfNjFYzLGa9iovlbGOMIp9ng1XJ+9hns/gi791JVcnqrN7ordNy0buHZ9EeZH
	 Bd3rBVBkNzagGhhYyhZtj/AngoJdUOsrnRIYXnFzHVUeQS9GARVGWQysu6V3X6K9KK
	 vKeB0ZW3D81754dYoRnJ+ANA9YMHLjq/8TtZI32OzvhY4ykm4e8PrzbZeu7fUCWy78
	 D/vtpCLvyG6PnNar7HNa+e8LD6kBszPAehWFNlpKWVHjHzJAhTHXfTda+PEXwDbQPs
	 +5/RmGG8W2+jg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54G11nwJ6075015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 09:01:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 May 2025 09:01:50 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 May
 2025 09:01:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        <linux-wireless@vger.kernel.org>
CC: <netdev@vger.kernel.org>, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo
	<kvalo@kernel.org>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: Re: [PATCH v2] wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds
In-Reply-To: <20250513121304.124141-1-aleksei.kodanev@bell-sw.com>
References: <20250513121304.124141-1-aleksei.kodanev@bell-sw.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ccf67349-0bb6-4944-8571-e6707a206eaf@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 May 2025 09:01:49 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Alexey Kodanev <aleksei.kodanev@bell-sw.com> wrote:

> Set the size to 6 instead of 2, since 'para' array is passed to
> 'rtw_fw_bt_wifi_control(rtwdev, para[0], &para[1])', which reads
> 5 bytes:
> 
> void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data)
> {
>     ...
>     SET_BT_WIFI_CONTROL_DATA1(h2c_pkt, *data);
>     SET_BT_WIFI_CONTROL_DATA2(h2c_pkt, *(data + 1));
>     ...
>     SET_BT_WIFI_CONTROL_DATA5(h2c_pkt, *(data + 4));
> 
> Detected using the static analysis tool - Svace.
> Fixes: 4136214f7c46 ("rtw88: add BT co-existence support")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

4c2c372de2e1 wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds

---
https://github.com/pkshih/rtw.git


