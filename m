Return-Path: <linux-wireless+bounces-26842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649DFB3AF7F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 02:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F7F7C5269
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 00:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72263189F20;
	Fri, 29 Aug 2025 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iOe1/7PA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F72AEE4;
	Fri, 29 Aug 2025 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427473; cv=none; b=GJA35zSJQDVAozgauVzVn87fD1YCaKF0b+rwJhLp1heFEQ1Hj/OD6oOXQGUWJSrxSI8ZdlAMFLl9HSVcbuZW6tEDcxZ5/I1N20CA6eqMkZDWzDH/eAp+bLNTckIg7nWWkSbciq0+i24uDbcFVDfo1X3cSRL6V3p6OM61svWshbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427473; c=relaxed/simple;
	bh=uSDs2rKdOmYCY35+Nc3GkM5OTcSOBRpji5AQL7yvohg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hJ0En5c5hU7OewwkgLeP0MAoaSTFAFnGPP764VaY/+dV4dRn81eJhW02ku+w5N163Vse9iLoZ7STTqqVK5tLwK0qbXhHLBUHczUv7LRBkZ5oP5pNHMs1ZsAotwf9PXzTyA1S+IQ+iDTpemuLbLEqZ5TN6NWfdidIXu8WwneOn3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iOe1/7PA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57T0V4VL02652470, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756427464; bh=bk2iRVuOqYto1ncTDMRV9JXFh+DQ60Dl7EGWdWE+sUs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iOe1/7PAUlLEKt/jW/G/da26oGlOhgRkISdcqgvQUEAVu8JAsoFbMK0XCDyWla6Si
	 JdtL4R1zlFT/ekDnl8NrCADbbqCRrmjWNxetSGDnuOpMmvlTMjHQAPUsdDNSciMq4m
	 Am6SJc56cWymepbv6AjeFdhuOFA9GS5ZrAwZIvea2fBuBB4wtgi86FmQIA5KwJa8Ym
	 mFUUUmIVqKKfWp4lkwD10zq9eJqJC53zZ7dF8qThCeyp/A84l1WfTMByzL1+ACpIiL
	 YOLxx4ZvJAIM9+z3U943HQgXh8OO6wRk4JyGpZJR4hURm4rQivlTxXm03bI744GHm5
	 wImEX0OOqO0zg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57T0V4VL02652470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 08:31:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 08:31:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 29 Aug 2025 08:31:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw89: use int type to store negative error codes
Thread-Topic: [PATCH v2] wifi: rtw89: use int type to store negative error
 codes
Thread-Index: AQHcF2QtD1hZZLXj70mOUB2IMNLPWLR4yYRw
Date: Fri, 29 Aug 2025 00:31:04 +0000
Message-ID: <872a02f45c5241eaa124f0899d9946b2@realtek.com>
References: <20250827150620.550641-1-rongqianfeng@vivo.com>
In-Reply-To: <20250827150620.550641-1-rongqianfeng@vivo.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Qianfeng Rong <rongqianfeng@vivo.com> wrote:
> The 'ret' variable stores returns from other functions, which return
> either zero on success or negative error codes on failure.  Storing
> error codes in u32 (an unsigned type) causes no runtime issues but is
> stylistically inconsistent and very ugly.  Change 'ret' from u32 to
> int - this has no runtime impact.
>=20
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



