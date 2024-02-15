Return-Path: <linux-wireless+bounces-3651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B5085721C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 00:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EE0B24437
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9DA145B07;
	Thu, 15 Feb 2024 23:55:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-195.mimecast.com (us-smtp-delivery-195.mimecast.com [170.10.129.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D887AE5E
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041316; cv=none; b=TBgW0WaBgbFzhDLCsaUXtIn3gDMMD4vlOOuQmjtUE/3o80EczP7yjtIui0QItxLPFHoL2iMxChHFRrD7bOIrolmUUMYwAQA8bkCY/XLqGEBdAk6qF6kSdET5iXMgUnbfgYNBu26ns251oWBJBO4/OMLK1iQdmH0J6J44xml5b7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041316; c=relaxed/simple;
	bh=Ap6LTEeCsIJ7YInjFvp8nsHXxHIXWfsNlWeYNx04vjs=;
	h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type; b=phFbdamdU7cm4JY7icqdJk717Q17haNTvcT0KYWWF+/7vRUU8ku84PRP5942z1iYciJRrxdBdJnAYq9S2d1vv2yF71oj5FGicXYTCn8Wq/7Soq7Z4F0BandgN3GIlw5M0fhJOkS6ZUco3iphR+fhOvsnKevZ4bB5Kw6dEybM7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbari.org; spf=pass smtp.mailfrom=mbari.org; arc=none smtp.client-ip=170.10.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbari.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbari.org
Received: from sleet.shore.mbari.org (sleet.shore.mbari.org [134.89.12.10])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-tLjirnq9Nh-os6xyqdT4jQ-1; Thu,
 15 Feb 2024 18:55:11 -0500
X-MC-Unique: tLjirnq9Nh-os6xyqdT4jQ-1
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id BE8C681289677;
	Thu, 15 Feb 2024 15:55:10 -0800 (PST)
X-Virus-Scanned: amavis at sleet.shore.mbari.org
Received: from sleet.shore.mbari.org ([127.0.0.1])
 by localhost (sleet.shore.mbari.org [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 05twqRBJsMKX; Thu, 15 Feb 2024 15:55:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id A4EDC8128966C;
	Thu, 15 Feb 2024 15:55:10 -0800 (PST)
Received: from [192.168.6.194] (raven.shore.mbari.org [134.89.10.221])
	by sleet.shore.mbari.org (Postfix) with ESMTPSA;
	Thu, 15 Feb 2024 15:55:10 -0800 (PST)
From: Brent Roman <brent@mbari.org>
Subject: rtw88 driver support for rtl8723ds does not work on Radxa RockPi-S
To: linux-wireless@vger.kernel.org, martin.blumenstingl@googlemail.com
Organization: MBARI
Message-ID: <9f47e65e-35f1-b090-cad1-4d8333293b00@mbari.org>
Date: Thu, 15 Feb 2024 15:55:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:46.0) Gecko/20100101 Firefox/46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mbari.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Originally sent to linux-wireless on Feb 1, 2024:

The Radxa RockPi-S has a built-in RTL8723DS interfaced to a Rockchip=20
RK3308 A35 ARM64 processor on one of its SDIO busses.

I maintain Armbian's support this board.

The built-in WiFi works perfectly with RTL's 8723ds.ko driver.
Recently, the rtw88 driver got support for SDIO.
https://lwn.net/Articles/925940/

However, when we attempt to enable the rtw88_8723ds module, WiFi does=20
not work.

Specifically, the WiFi scan returns only the strongest AP while=20
indicating that AP has a very weak signal.
No connections can be made.

Unloading the rtw88_8723ds modules to replace it with 8723ds immediately=20
restores WiFi function without the need to reboot the system.

Has anyone tested the SDIO variant of this driver?
If so, on which board(s)?

I'd very much like to get this working.
Any tips for debugging, or just getting relevant info from the driver,=20
would be appreciated.

Thanks!


