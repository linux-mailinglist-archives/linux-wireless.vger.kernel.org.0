Return-Path: <linux-wireless+bounces-2994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E7584676C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 06:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D811C24D5C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 05:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1AB171BF;
	Fri,  2 Feb 2024 05:14:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-195.mimecast.com (us-smtp-delivery-195.mimecast.com [170.10.133.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB3171A0
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 05:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850856; cv=none; b=NJJJ+F+5AGiqwCXnmi3bq1jjHQ490l6pfaNaNitHp+FP2gNfYsCIBRydmh6N2KWfGuVOV/+Q6TQ9xEAZiSEVs1AOvgl93taZJ3DToRi/5Qcs+0+atgyuFSBoCQW1kHDarIbAPXeMFzD6VJYw9UFilNDlRRGJjKnmsiwRlh3IMY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850856; c=relaxed/simple;
	bh=r/wmNrUxHCkH/vAn75d127Ad24I4g8B5z7mJhzsX7/8=;
	h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type; b=cSKAY10J/OYCYdxX3H6kcAowlZPsSe0OChC1NcLTDHDYLFtBadzOLI7xZ6QHGoJGDMIj5W5a8P7nQMzRqU0t3QNazZ7g00FFryztEdEHvq8q8pEhU+WJ6upSRgl1w3FaaKNf8ia2xofjXCcHIbfdhaE9mnh5Wmi+0cDHQaObaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mbari.org; spf=pass smtp.mailfrom=mbari.org; arc=none smtp.client-ip=170.10.133.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mbari.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbari.org
Received: from sleet.shore.mbari.org (sleet.shore.mbari.org [134.89.12.10])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-_mLI0zMCNbSK6cBi5JXG5w-1; Fri,
 02 Feb 2024 00:14:11 -0500
X-MC-Unique: _mLI0zMCNbSK6cBi5JXG5w-1
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id AAA2F80A3F4F5
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 21:14:10 -0800 (PST)
X-Virus-Scanned: amavis at sleet.shore.mbari.org
Received: from sleet.shore.mbari.org ([127.0.0.1])
 by localhost (sleet.shore.mbari.org [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Hw1RBvsPCV_u for <linux-wireless@vger.kernel.org>;
 Thu,  1 Feb 2024 21:14:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id 7347281288C7C
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 21:14:10 -0800 (PST)
Received: from [192.168.6.194] (raven.shore.mbari.org [134.89.10.221])
	by sleet.shore.mbari.org (Postfix) with ESMTPSA
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 21:14:10 -0800 (PST)
From: Brent Roman <brent@mbari.org>
Subject: rtw88 driver support for rtl8723ds does not work on Radxa RockPi-S
To: linux-wireless@vger.kernel.org
Organization: MBARI
Message-ID: <046a54c9-43ef-08e5-8d5a-f2751d955369@mbari.org>
Date: Thu, 1 Feb 2024 21:14:09 -0800
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


