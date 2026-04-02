Return-Path: <linux-wireless+bounces-34299-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FlmFITozWkLjAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34299-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:54:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B17CC383461
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 05:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB8E4300E3D4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 03:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34013227B94;
	Thu,  2 Apr 2026 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FPDM6gV1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F341A294
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775102054; cv=none; b=qgbeiJbgK0YfMsABY4krRas1uWBLam1HWtmsdo741uy+WujCKjJUQFDetVVE2f6dd4oV0zIO1rML9DX+O18N+HGl+QLcZRyazyxiZapGW9hOBYDQOEVZtBjTOe+NTj7fX3S+mpvbLBN2Xzh/oktFf0JwyMT/5ZC0JIzzmI0a2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775102054; c=relaxed/simple;
	bh=pN0VVALsz+bW30huGyPbSBdYFi8DDtkJ2H9YH4cMNPs=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=ukq1Q51u5iTiDsaDRBQz/g1lVt5jtS5008XG5TV+TC8MvlYUHRhtouDgnUtTiUsKmsUMuvW3p2VDfurvYlPgNbJye9BjOEPrGb24x6oBGfC2WPM2eavZ0ZOyt6ylxAUVBbaSGliCMWgqxz81Dj+Do1HG/Or9sFyGJnd9Hc0N9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FPDM6gV1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6323sA7Y12390805, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775102050; bh=9twuLJGhGlxKLOxXwnhELfMEZmgl97XsuR4oGr9L/yo=;
	h=From:To:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=FPDM6gV1oWmiDqa8PyOHiAtnyviZe6eOXheyov7CqgjJn3+WJ4CYdMjTvtA3wxomB
	 saR1y32sulzVlCBhwec4fQIb2HJ5now4SF27zursggbSIEXEddDHqGIXZUWshfeRe6
	 H3VpJ8c/6wdk7LFKFhving3MM7UtAMmCxI5aPr0fVFBZa7LMj2ZEoe+6DIRwq9g/17
	 INk0nmOUPD0kaBhq1JA0mCQZHWA7+Os97rNBvpBhyEp2U4vZxHM2+Y0nwPtym/knPA
	 cZQhjRKMt/47r8TiXww9Ub7sBnP2D+RIMATIK/TglFDWnT3luDW+1KyDvdbuDBFRYc
	 NT2tnMCZWusjA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6323sA7Y12390805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 2 Apr 2026 11:54:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 11:54:09 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 11:54:09 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 2 Apr 2026 11:54:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH rtw-next 1/9] wifi: rtw89: 8922d: BB hardware pre-/post-init, TX/RX path and power settings
In-Reply-To: <20260330065847.48946-2-pkshih@realtek.com>
References: <20260330065847.48946-1-pkshih@realtek.com> <20260330065847.48946-2-pkshih@realtek.com>
Message-ID: <37d3c9b4-7282-4e7f-af86-b0a21dad28f4@RTKEXHMBS05.realtek.com.tw>
Date: Thu, 2 Apr 2026 11:54:09 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34299-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,RTKEXHMBS05.realtek.com.tw:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B17CC383461
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ping-Ke Shih <pkshih@realtek.com> wrote:

> More settings related to BB pre-/post-initial settings, the TX/RX path
> settings, and digital power compensation.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

9 patch(es) applied to rtw-next branch of rtw.git, thanks.

347fbc602795 wifi: rtw89: 8922d: BB hardware pre-/post-init, TX/RX path and power settings
edf9f583c05c wifi: rtw89: 8922d: add set channel with pre-/post- helpers
2ef4363f1388 wifi: rtw89: 8922d: add RF calibration ops
baa6ea4e5e03 wifi: rtw89: 8922d: add set TX power callback
2b19199952e6 wifi: rtw89: 8922d: configure TX/RX path assisting in BT coexistence
9c2f79b4d912 wifi: rtw89: 8922d: add RF ops of init hardware and get thermal
553fd44ce8ce wifi: rtw89: 8922d: add ops related to BT coexistence mechanism
0737a803bae4 wifi: rtw89: 8922d: add chip_info and chip_ops struct
a16ca7d91e4e wifi: rtw89: 8922d: add PCI ID of RTL8922DE and RTL8922DE-VS

---
https://github.com/pkshih/rtw.git


