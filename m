Return-Path: <linux-wireless+bounces-28863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A6EC51317
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 09:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EA0934D996
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 08:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCC82FD661;
	Wed, 12 Nov 2025 08:51:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C522FDC36;
	Wed, 12 Nov 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937506; cv=none; b=Lmfx65dA3cjxzIHftdn4S1tVKbiAu26+yu3TKYFQgrx95jaqAbmD9WNaNh43KzwaTwv4qU2UDRRMKHB6OCYYMmTpQEDZxz/WW9WSeyWxvkGZWtlDc4z7BOM6TnyFc8OQZIPj/jyNFS4dbkitewf9XL4MpkFWHr4/HbI+UFbk8ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937506; c=relaxed/simple;
	bh=9Sf+DhOWkxWlV6w51Zjg8J1gB3EGv+YwAqQzAgcPRsU=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=H0VC6woyEgIHjE86WGfb5eH7fPXsYqQ7ETYNVRPDq9IBf7sXjsD3Y0ukVCbvm646CIPRa/R7uKm9MMmQRwpRsGqTUIK0BRST8ASjmReUIptSVLWh7HcsO2HaCaHKGxxxJrdBybIaaJ9yUT9ZzKQHiiV+9i2H9przDpeUAVotNI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4d5xwG2Grsz5PM4C;
	Wed, 12 Nov 2025 16:51:42 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 5AC8oc6E094908;
	Wed, 12 Nov 2025 16:50:38 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 12 Nov 2025 16:50:40 +0800 (CST)
Date: Wed, 12 Nov 2025 16:50:40 +0800 (CST)
X-Zmail-TransId: 2afb69144a6064e-a9d70
X-Mailer: Zmail v1.0
Message-ID: <20251112165040828QPfTMyxpU6TF3SvlWuQdq@zte.com.cn>
In-Reply-To: <494afbf2ca5b18f230b02b03f122c4d427dd08ee.camel@sipsolutions.net>
References: 20251112163750463kAkOIyBxvHkYWh9Cgdypb@zte.com.cn,494afbf2ca5b18f230b02b03f122c4d427dd08ee.camel@sipsolutions.net
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <johannes@sipsolutions.net>
Cc: <kees@kernel.org>, <concord@gentoo.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <qiu.yutan@zte.com.cn>
Subject: =?UTF-8?B?UmU6IHdpZmk6IG1hYzgwMjExOiBtYWtlIG5fY2hhbm5lbHMgdXBkYXRlZCBhYnNvbHV0ZWx5IGJlZm9yZSBhY2Nlc3NpbmcgY2hhbm5lbHNbXQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5AC8oc6E094908
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 12 Nov 2025 16:51:42 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69144A9E.002/4d5xwG2Grsz5PM4C

> > From: xu xin <xu.xin16@zte.com.cn>
> > 
> > The commit 2663d0462eb3 ("wifi: mac80211: Avoid address calculations via out of
> > bounds array indexing") said that req->n_channels must be set before
> > req->channels[] can be used. But there&apos;s still the case that req.channels
> > accessing was prior to n_channels++.
> > 
> > This does not fix any visible bug, just making n_channels updated before
> > accessing channels[] absolutely, to avoid potential UBSAN out of indexing
> > warning.
> 
> I reverted the annotations, so this isn't necessary.

Excuse me, what is the annotations you reverted ? Maybe I missed somthing.

