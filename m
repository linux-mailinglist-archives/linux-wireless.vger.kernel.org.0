Return-Path: <linux-wireless+bounces-17208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B7EA06AC0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 03:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C6A3A78DA
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 02:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DD52B9A8;
	Thu,  9 Jan 2025 02:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i2IUR5Yn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D6D15E97;
	Thu,  9 Jan 2025 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736388745; cv=none; b=YpiW7fg0G17Lz5lGYF4B3vrzIkWNIk5ycB8NJbcd+IZJsP+XCBn0W7ZXGRgUBcUwlSqNlPKuw5oRDRoPigMspw6bGp4CN4o9AIFyzh1oLU7lFJR1jJpgi9Ee4118cvj3X+/Mx/2eoN5hk9tcreX8GCf1v6IMhuSVRuR6XmlkGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736388745; c=relaxed/simple;
	bh=dcyybSuyV97aLwbjlLOyJ64bS4+T7sMxd9SkVm2zDLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W5kgu1rJqvPfAwrv6/K6uwlmmigW2sqJZU5uFPoVaU8snhkza02CucD1PRTQhFen/GHed8lMubyd+SuLj9kbF7bEjKVh8VjicYUa9DosuZx9CfJq6ZfqZs+JuQ9aX1ZMBWqVs+Inu6gRIhj9FYSjaq1WCkNQRqBkebkw9PTFkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i2IUR5Yn; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wF+Tr
	+gBaiG/Fr8GDA9AKwdoxsaQX8KwA1K3uvYhGX0=; b=i2IUR5Ynyihvi+XWC8X+m
	0+yfznQ5kO/vuCTu3KMbAg7MFaucmQLz9QaKQ8Juedk1JWbaS8zBUZiu19l4Hfxa
	Sif+OnhvKaWY7GvyITqLObCK3/RinrxQabcNyLtNe8LcMoOMe0cC2+fySvdkXbX5
	Md+7jPcOnsYpJFvi+V7+70=
Received: from hello.company.local (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3t1VlMH9n7Lu4Ew--.13607S2;
	Thu, 09 Jan 2025 10:11:49 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: pkshih@realtek.com
Cc: buaajxlj@163.com,
	fanggeng@lixiang.com,
	kvalo@kernel.org,
	liangjie@lixiang.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	phhuang@realtek.com,
	yangchen11@lixiang.com
Subject: RE: [PATCH v2] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
Date: Thu,  9 Jan 2025 10:11:48 +0800
Message-Id: <20250109021148.1114317-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <752e62938a254fef863eebdf4d85e759@realtek.com>
References: <752e62938a254fef863eebdf4d85e759@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t1VlMH9n7Lu4Ew--.13607S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry8CFW8XrWfur1DJw1UZFb_yoWfAwcE9w
	40yFWxG34jy3Z0ka1YkrZxC3yjyF4vgr1kW3s2vrWftrW5AFWkAr95u3s8JrZ3Jw1S9r98
	Xrn8JF18K3yF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VU1Bc_3UUUUU==
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbBZxnPIGd-LrEfhgABsO

On Thu, 9 Jan 2025 01:55:23 +0000, Ping-Ke Shih <pkshih@realtek.com> wrote:
> Liang Jie <buaajxlj@163.com> wrote: 
> > diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
> > index 2191c037d72e..2be1bee724ca 100644
> > --- a/drivers/net/wireless/realtek/rtw89/fw.c
> > +++ b/drivers/net/wireless/realtek/rtw89/fw.c
> > @@ -5170,6 +5170,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
> >         u8 opch_size = sizeof(*opch) * option->num_opch;
> >         u8 probe_id[NUM_NL80211_BANDS];
> >         u8 cfg_len = sizeof(*h2c);
> > +       u8 ver = U8_MAX;
> >         unsigned int cond;
> >         void *ptr;
> >         int ret;
> 
> In reverse X'mas tree. Otherwise, looks good to me. 

Thank you for pointing out the "In reverse X'mas tree" issue in the code structure.
I will address this and submit [PATCH v3] with the necessary corrections.

Best regards,
Liang Jie


