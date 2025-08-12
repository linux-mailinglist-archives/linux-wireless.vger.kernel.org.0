Return-Path: <linux-wireless+bounces-26301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64AFB221BA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F03C6E2A0D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74EC2E92B8;
	Tue, 12 Aug 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jDJYAjVO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBEC2E5427;
	Tue, 12 Aug 2025 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987878; cv=none; b=rYi+J6GRbdhyc67U9e8RsCU8uoO/XBK5OUaWA6UGqNu+GGUcq2qWtsmY1CX/J+Nk00pG/GTpUvt5QBFhLEjcIjMGHTT+7eAPaSQRQHCJvonQnMroOsd2FSx/HuHAiV1nejTSsFlb7mI9qhGJg97vDeJ5ZkGJoIwmVzkjvJ4Ve1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987878; c=relaxed/simple;
	bh=JzIjx5HOhi35zcABtX2iNzJDkPZfgpaG4urhr1fGcos=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=rav4NDBnwYgq49mXvFctuDL5xBLtGUas3mvmloCY7Y7PJkvLPkPgUzda2e0ceFKxQWyhHgtwViZ7s62YBzZIg8xcHSsVLdNxNohTkNwP/+ph+iKHU1M4h4O7FmosPnENqMukyqfu/770Sct8RJ92WmxXK8QEd/rR98PRVKiZLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jDJYAjVO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57C8bVplD2162889, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754987851; bh=sL36lQzC+LJodbbZFuOzhUOKRsYBza+K018ddfdXCeU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=jDJYAjVOu6JFMPXJIiHMQePdmpMPzPY288j3zAoiAg/e3M9AWerQ+4eC2+PYRDygm
	 lO26cy/QRgpQ21Bq+wlLrottMtRgHRV5O2QRIpzIGFfhFJ0IcSnSB1ZNEYZCkW79EZ
	 FlTND/v2FItODEuxku2LAAB1VrEzOpQuqQRPBJauX2qPKQ3cSNCIz1eOeJE4dxU+CS
	 tppTsDDnGGd0sD9hcq39rRKWtW0fVkRnG2malwwr+dtWAf8fdkrYHHIVQg5Uz8kmQv
	 mNFDsPdq3MDwTQPJyZ05TqK3AJ3jv30y1j0HLm5ZsQnLjARLm3pVBVjI5YqWXkcZC0
	 QZBq/nCB5cHog==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57C8bVplD2162889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:37:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 16:37:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Aug
 2025 16:37:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, <pkshih@realtek.com>,
        <johannes@sipsolutions.net>, <rtl8821cerfe2@gmail.com>,
        <kevin_yang@realtek.com>, <ku920601@realtek.com>,
        <gary.chang@realtek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <akhileshpatilvnit@gmail.com>, <skhan@linuxfoundation.org>
Subject: Re: [PATCH] net: wireless: rtw8852bt: Use standard helper for string choice
In-Reply-To: <aJWNhu9bAkcjEyb4@bhairav-test.ee.iitb.ac.in>
References: <aJWNhu9bAkcjEyb4@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <6140ffcd-67cb-461e-a818-2a97ab6b2677@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 12 Aug 2025 16:37:31 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:

> Use standard helper str_on_off() defined at string_choices.h in
> _dpk_information() to improve code reusability. Reduce hardcoding
> of repeated use of the same strings to save code space.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202507282341.drTGfLWA-lkp@intel.com/
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

584615412654 wifi: rtw89: 8852bt: Use standard helper for string choice

---
https://github.com/pkshih/rtw.git


