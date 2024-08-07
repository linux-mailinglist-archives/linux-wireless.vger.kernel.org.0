Return-Path: <linux-wireless+bounces-11049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A332A949D25
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 02:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC66D1C22119
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 00:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40292BA33;
	Wed,  7 Aug 2024 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="D6P474zn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB55801
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722992241; cv=none; b=LvzQ3wozO5xyu6Di69gsehuJRCzTOP8N3/rd43SWAAx5petToAC+0SvetNZrQcMyRqsw1jffSqt0jk0PUpyX6ZsKPUgaiaNKatOH5Zlis/+kebYr5NMb65mpsKVnWURHRJVpkq/3ZCXxujz2LPM1fU7DTxq38DCQ/T/JgQzM0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722992241; c=relaxed/simple;
	bh=kIIURNPuU9LBrQLFGcnKwXrreR8Vhq4WvKsAHXPBwY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0Z8V0APkGy5JkYWLwn0/mrw6MxqNk+g7IQ/9Enya4xb+QTN8pnjDqFq+PcffxJL9d4Qq03Hwn4EO4UMjS26WVf/ZzKsDX+zca9g4jH/hSyo0it26Bdf2cOTV0uAW2qNNz8jjxrRwmZ6sfgBwuUpm0h0zFRt9q9F/Kg3rkuU168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=D6P474zn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4770vAQQ11739879, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722992230; bh=kIIURNPuU9LBrQLFGcnKwXrreR8Vhq4WvKsAHXPBwY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=D6P474zn4EywW+4rmprvRoc4zXEIQUICuZicsnlKMc0vVFjrUK/57cTAlJjTaFu0Y
	 RXroatxXbTnH3JZlkGafuS0to6zc42OHUFtZBv87W67g6q114XBN9UeGvcxBs7lbTz
	 Ofx0LjFDtlF888otOJ7wd03G9v/1O84HGwB3MGh9XxUtDH1oOhy/tSi+tG1/79e4a2
	 t02/iMFZ9UJddwtriqTdigGM8GJvkTgqJqK5jUnh3RBK8z7F5Mjz1Z7xrBIrnkq/Qn
	 U+3PfpaRdXchV+RC/aVOVHWFl97WJ2ThzryEivk+fj58TRciUq8KVy6ZUE9aYrbRDu
	 riTW0mjfomJhQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4770vAQQ11739879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 08:57:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 08:57:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Aug 2024 08:57:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 7 Aug 2024 08:57:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>, Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192du: Initialise value32 in _rtl92du_init_queue_reserved_page
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192du: Initialise value32 in
 _rtl92du_init_queue_reserved_page
Thread-Index: AQHa6ByIWgeYzNX+Y0qHUhD38cFNerIaa51wgACMCeA=
Date: Wed, 7 Aug 2024 00:57:10 +0000
Message-ID: <2da8d5ccb0f84d37ad793e5ee15931a0@realtek.com>
References: <2a808244-93d0-492c-b304-ae1974df5df9@gmail.com>
 <87a5hp62cv.fsf@kernel.org>
In-Reply-To: <87a5hp62cv.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> wrote:
>=20
> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>=20
> > Kernel 6.11 will be the first one to include this driver.
> > Should this patch go to the wireless tree?
>=20
> Yes, compiler warning fixes should be always sent to Linus ASAP. Ping,
> if you agree please assign the patch to me.
>=20

Assigned. Thanks.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


