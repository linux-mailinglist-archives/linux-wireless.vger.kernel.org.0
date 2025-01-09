Return-Path: <linux-wireless+bounces-17203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493D6A06A29
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 02:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AEF164F0B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 01:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB6259484;
	Thu,  9 Jan 2025 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b5ezz/7J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A7747F;
	Thu,  9 Jan 2025 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736385861; cv=none; b=vFc2CjPgowCQnCR0ximuXLpPtchDLOkzFv/cbkLXLNi8tKFvccHtdP7P/r7yp+pS6Ce7V5C+dS1xz+ppwXYbGjid0FUmmfvvN9TbOjLMaAufhWDh4eTYEJphPCRAVHaDThdZNSmCPnQT77KUHXjn9/JYlghBu4tcYvXiyLZIrFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736385861; c=relaxed/simple;
	bh=1qVlc2UtN83V9IwbxC/bb2s4Z7TyRjJ+lNGzGA7vs5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LJ0yrTSPINcZ9oR60n8YHdytp7dfvBXwxywsYaj1mNC/4vd0KKk6ETqKZ9VUlArURo33RsCTRYIsk6c0AyKKy7820yOAnckljy1RsVBjTEoL7hRf9EBAIkp0e5fajX8Y6qDoXwV0grVYwVhwlHvSF+sg1rNQP8FTihL7+AIFCa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b5ezz/7J; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8Yje0
	cuay58T5k/vIzFfWPCiJUQl6214LOVekJsh/uk=; b=b5ezz/7JMXtq4jykx3SnF
	S4+ZchQC09FJ6p3x4uXdaITzcKgDPtvlVqFYi3/f1vXnuIVQFO9gWpWEAwuffTBr
	v0C0t44MgLhFlulfL7ARBw/z8F7BKafHEiVs7zp5dcg8KG/tYEFay6YrC16hkLGu
	jZZaXRnvtT5ZBfE6sBueXI=
Received: from hello.company.local (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD33+otJX9nN352Ew--.38817S2;
	Thu, 09 Jan 2025 09:23:57 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: pkshih@realtek.com
Cc: buaajxlj@163.com,
	kvalo@kernel.org,
	liangjie@lixiang.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	phhuang@realtek.com
Subject: RE: [PATCH] wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be
Date: Thu,  9 Jan 2025 09:23:56 +0800
Message-Id: <20250109012356.1015198-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9d4e83ffc0d348f2965390e8dab4f25e@realtek.com>
References: <9d4e83ffc0d348f2965390e8dab4f25e@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33+otJX9nN352Ew--.38817S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrW5Zw47XF43CF17Wr15Jwb_yoW8GFy8pa
	y8Ga1UtFZ5XrnrJF43uF4IyrW5K34kGr4rJrW3KFsY9rn8Xr17JFsrKrZY9w4Iqr1kZayF
	9w10v34rWan8AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUvii3UUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbBZwvPIGd-IysrsQAAsJ

On Thu, 9 Jan 2025 00:35:38 +0000, Ping-Ke Shih <pkshih@realtek.com> wrote:
> Liang Jie <buaajxlj@163.com> wrote: 
> > From: Liang Jie <liangjie@lixiang.com>
> > 
> > This patch ensures the correct calculation of `cfg_len` prior to the
> 
> No "This patch". Just in imperative tense -- "Ensure ..."
> 
> > allocation of the skb in the `rtw89_fw_h2c_scan_offload_be` function,
> >
> >   ...
> >
> > behavior across different firmware versions.
> > 
> > Fixes: 6ca6b918f280 ("wifi: rtw89: 8922a: Add new fields for scan offload H2C command")
> > 
> 
> No this blank line. 
> 
> > Signed-off-by: Liang Jie <liangjie@lixiang.com>
> > ---
> >
> >   ...
> >
> >         u8 probe_id[NUM_NL80211_BANDS];
> > -       u8 cfg_len = sizeof(*h2c);
> > +       u8 cfg_len;
> 
> In fact, SCAN_OFFLOAD_BE_V0 means `old` format used by `old' firmware version,
> which isn't a main flow. I prefer to keep here unchanged, and modify cfg_len
> along with SCAN_OFFLOAD_BE_V0 for v0 firmware. 
> 
> As existing patterns, this will be
> 
> 	u8 cfg_len = sizeof(*h2c);
> 	u8 ver = U8_MAX;
> 
> 	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw))
> 		ver = 0;
> 
> 	...
> 
> 	if (ver == 0)
> 		cfg_len = offsetofend(typeof(*h2c), w8);
> 
> 	...
> 
> 	if (ver == 0)
> 		goto flex_member;
> 
> 	...
> 
> 
> >         unsigned int cond;
> >         void *ptr;
> >         int ret;
> >
> >   ...
> >
> > 2.25.1

Thank you very much for your suggestions. I will incorporate them and submit
[PATCH v2] accordingly.

Best regards,
Liang Jie


