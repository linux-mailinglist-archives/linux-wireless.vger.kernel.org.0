Return-Path: <linux-wireless+bounces-28478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A748FC29DB9
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 03:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5383AFB31
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 02:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320F27E056;
	Mon,  3 Nov 2025 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cnj/HQPd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A771158DA3;
	Mon,  3 Nov 2025 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762136785; cv=none; b=pQiHdXjtkCbvu9cHTztPEsMXzEzw1/lvpXT9bME5i6ImO4oUP7hTVpZzvXsmiz5K/Qjvx1UNup3mBpdic+SuvA/ZdMHEnBj6t0HvEbnD9QY8+/I6Mda7K6psFy2MdmwrPzfnJvC8tSZoRx4cDSdSkFgCuc/74fgDMLogI1+FqMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762136785; c=relaxed/simple;
	bh=nr8/r0C+0pwe9VyAx9KZOQGU0RHUceyaHhxyWmVQU9o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h14k/x6DYcm3N4kZUQ8JyAtopC7vkRyx3XYdPeVLNfEc1JDVNMP9t8eh9fctkgIDNIaGV8QoBzU05apyYA6XnI+HTRuwjTbKXMaY/HXcNA27T6vnvJPDQCE4XtnkQ2fJ1kC87BOlnqSkFRiJawYCkWnlLNrlvhN9xKFZ9IZX/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cnj/HQPd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A32Q8bJ4644699, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762136768; bh=oj+q97ag4dtNwr6hbrp5P6LowNp0H6evQ4pSm12UUR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cnj/HQPdDNvF+Q7W8HzqBcHH/gbHh0cA7k8b+x0OysdoMmtGpCpQtUE3qfvWJ5i07
	 sfORXV2Uwp9n+w9vlujyJuBcLyiTlAPZu55j/pv8iVL9kJcHKYkwGuVFG1+285dSfx
	 RV2S8vRGHpXaJ8vl/Da+aG7GR/GuhkMshg/OqOn155+5J5Jy/iMY7maE7AFyQ4mby2
	 dFWOzhjOXW/w+bW4fbtHa9LxURyHAudDCjLLr9ylrAOeNIIUndgG6QG8XL/ffY8Yg0
	 ZuPVYwTrOvqx8JjKek3hbjDC+Qc8OHcGQe/b9aYiaCrgSRu3adcl/ZlUvO2ebn2DKp
	 Hqhb8PI4vDq8Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A32Q8bJ4644699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 10:26:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 10:26:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 3 Nov 2025 10:26:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 3 Nov 2025 10:26:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bernie Huang
	<phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v4 07/10] wifi: rtw89: usb: anchor TX URBs
Thread-Topic: [PATCH rtw-next v4 07/10] wifi: rtw89: usb: anchor TX URBs
Thread-Index: AQHcSQcNKxbNzOriQkaLAO5YlQ1BabTgQEZA
Date: Mon, 3 Nov 2025 02:26:08 +0000
Message-ID: <e0c74479f923460ca871719b79e3a171@realtek.com>
References: <20251029190241.1023856-1-pchelkin@ispras.ru>
 <20251029190241.1023856-8-pchelkin@ispras.ru>
In-Reply-To: <20251029190241.1023856-8-pchelkin@ispras.ru>
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

Fedor Pchelkin <pchelkin@ispras.ru> wrote:
> During HCI reset all pending TX URBs should be canceled.  Use anchor to
> keep track of them and have an ability to cancel them synchronously.
>=20
> Note however that canceling RX URBs can't be done here in
> rtw89_usb_ops_reset() as it breaks driver initialization.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


