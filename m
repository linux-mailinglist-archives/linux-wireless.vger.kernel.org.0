Return-Path: <linux-wireless+bounces-24380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547D9AE5A58
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 05:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73152444DE7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 03:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828CE6DCE1;
	Tue, 24 Jun 2025 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MEn5c/Rv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577724D599;
	Tue, 24 Jun 2025 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734448; cv=none; b=EiegYMobqqCoTP9E/UNByOKTjsQiBaIPEH5MOFi7Aa3hcnZaAE40qdo2HvCstRcyPZhmW0zb9eR7AnCshq09074IaHF7lndULmPhbqj4+Oz91raY2KWOWn2/OV/+DZBXtWgkLoCGmA10+eguJm8xdybHhQPFG9wPMU70ZmbQ3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734448; c=relaxed/simple;
	bh=BeLYXPQX/et3xzlOk1BCgYSS98hUfyASbxgFvu6K/AM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ki81dbdLaa0rqvqNu8EQigWBi0A2Y7iqNmIx1PbbZW42wUcDDprfM4YK4MQN2OFIsLn6v2/RFogcOtAF8tBP73p4gJdFAO+Fcd7uhkfvsZZoBpZhxe2LKMDxsUcOsqcrrhYqeoBrcr9PBmBI33c4/R/LVZV4w2y6lqyNllRUYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MEn5c/Rv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O375j142912132, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750734425; bh=P+nmYdlqh/JQZIk06vScCggKsZXNfGUU+0k8b7QU5fk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MEn5c/Rv4cpjAhWCU5FGiWK5vMK9dmfQxSIrk9EffKFd/Onjuk65PXFWnJCsyROOT
	 gPjpbeXSVl0yWwvQYw4rkQJVqXQ7ayndkmYn6/ik/3e5OlZa3bDNcFJtEenJSBVMQF
	 zXxx2LfSoxqgB1rXkvNe5Dxhuf9jjjXpgXFLQEyqUbFmOiWK4cQNIJYCZwekmhGnkp
	 BukK52PCAklrCTL2KOW+PYOyee1TM7lgnOF3D1sUTkzwHBfgqzdpNHduHUgNdlbDu8
	 lxPI7ReDbU3To+nSXWhQaL/pxhlcTd1N2l/6NO0mlxTNBLNXf9A3sn9+BmiUc+6OKS
	 8leYVfWJFCz6Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O375j142912132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 11:07:05 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 11:07:19 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 24 Jun 2025 11:07:18 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Tue, 24 Jun 2025 11:07:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Pei Xiao <xiaopei01@kylinos.cn>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw88: coex: Use bitwise instead of arithmetic operator for flags
Thread-Topic: [PATCH v2] wifi: rtw88: coex: Use bitwise instead of arithmetic
 operator for flags
Thread-Index: AQHb5LMfF1J/qz6ue06IEfKwyZeJGLQRoJPw
Date: Tue, 24 Jun 2025 03:07:18 +0000
Message-ID: <0b325588905144c48d035ca790eca7b5@realtek.com>
References: <c68a8642c325f626ac34ccee71d9d9aa69f0c92c.1750733428.git.xiaopei01@kylinos.cn>
In-Reply-To: <c68a8642c325f626ac34ccee71d9d9aa69f0c92c.1750733428.git.xiaopei01@kylinos.cn>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Pei Xiao <xiaopei01@kylinos.cn> wrote:
> This silences the following coccinelle warning:
>   WARNING: sum of probable bitmasks, consider |

I will add "Compile tested only" during committing.=20

>=20
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



