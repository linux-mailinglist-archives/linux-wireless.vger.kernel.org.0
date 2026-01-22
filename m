Return-Path: <linux-wireless+bounces-31054-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLbTD7CFcWk1IAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31054-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 03:04:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C960AD3
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 03:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAD01807984
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 02:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1223352FB8;
	Thu, 22 Jan 2026 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i+fwUlna"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB70330668;
	Thu, 22 Jan 2026 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047361; cv=none; b=gZG8QrWZDTZPFwQ+iNMyYuJ4saHSYqXiqJeD6iIoLaaZuQtojU74q2EdbRGR1ZU0V7piR/CcTk71wwgBLyYJMxRIPrC2WU/pyjJ73JeHaa1EBfzO1HF5XoJjgRNHfuZyDeb1Zci3Z9GQJ+OWe6HxvfW9q5OF71PJ00/JipHAHoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047361; c=relaxed/simple;
	bh=LxIu0lsQehb7g6iEFX1+f9XxUFTJPKJQYl3Dpy8Skm0=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=Yp71afXKnTcJcYviHRZGWo0Ds6tGAImHG7GVVk1dAk3WXfGzuSlrR7mGDXltaKmgPLG/nWIO3OKzDlmLSCYdIPfqRUK6oeZ0IVb9YD3qF4EOmsMExS+69CjliEpvR+jU6EmPjYkgrHGIqNDkFb2/UvBCaYQFLlfLfYEP2BaD33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i+fwUlna; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60M22ZmyC108566, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769047355; bh=g/miE1dO+azRTIt7TQpeeBnWnfJOCUHCHnHRCpVDquo=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=i+fwUlna6xALZhXbfTiVk5i4oO0uKka+4W2caEqqXhKuPBQEmpf7GA3wCVqUWizKf
	 iU2zrBYiT3G8EeC1x4k3A5v38CCQFktlRG8VDg4TAB5nkoSpACWEQiNILd+3okVoUd
	 D98MP8EZsukuA6dKnUsB1iqUjzcfQ3TnQU0MFhqBGJmumAKRQJzJ4Ma+PyCQorKI8S
	 LJs2eXrrOaV3ZtYiY9pV1HG8meJLwaacHQUWmTHgNlak7iak/NWLMbGDzczTGTBAtC
	 su4vAusqymkSdleyiTNc27Hs7lJmPDtWSQyTBELJBYeK1TQtV2SSjUz132zc82f56L
	 KxpjN+/WSMIlw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60M22ZmyC108566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 10:02:35 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 22 Jan 2026 10:02:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 22 Jan 2026 10:02:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zilin Guan <zilin@seu.edu.cn>, <pkshih@realtek.com>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jianhao.xu@seu.edu.cn>,
        Zilin Guan
	<zilin@seu.edu.cn>
Subject: Re: [PATCH v2] wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()
In-Reply-To: <20260116130834.1413924-1-zilin@seu.edu.cn>
References: <20260116130834.1413924-1-zilin@seu.edu.cn>
Message-ID: <565d54c7-a2d2-4aed-8389-9df4303afae7@RTKEXHMBS03.realtek.com.tw>
Date: Thu, 22 Jan 2026 10:02:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[realtek.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31054-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,realtek.com:email,realtek.com:dkim,RTKEXHMBS03.realtek.com.tw:mid,seu.edu.cn:email]
X-Rspamd-Queue-Id: 805C960AD3
X-Rspamd-Action: no action

Zilin Guan <zilin@seu.edu.cn> wrote:

> In __print_txpwr_map(), memory is allocated to bufp via vzalloc().
> If max_valid_addr is 0, the function returns -EOPNOTSUPP immediately
> without freeing bufp, leading to a memory leak.
> 
> Since the validation of max_valid_addr does not depend on the allocated
> memory, fix this by moving the vzalloc() call after the check.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
> 
> Fixes: 036042e15770 ("wifi: rtw89: debug: txpwr table supports Wi-Fi 7 chips")
> Suggested-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Reviewed-by: Zong-Zhe Yang <kevin_yang@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

6070a44051b1 wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()

---
https://github.com/pkshih/rtw.git


