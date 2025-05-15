Return-Path: <linux-wireless+bounces-22996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38660AB8360
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1D09E0734
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831529615A;
	Thu, 15 May 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="dIlwThY8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433EE1FCFFC
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747302965; cv=none; b=MjI5agnrQdztrdRhQxH80o1Nc7/GrpCPMRusAsO5NB2M3/+K50/Tvoga28K5A6vUZzhx0WsEfz1mES7lnfrBPhT4Tzax/yZMiwlNQafaXkKziKqlH3neG+b+Xbl/PkhFsDeRRz+c+bmHiFHTE2FDrjgwYUjQOiOIK9liZqUmheM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747302965; c=relaxed/simple;
	bh=HFjFiRxebsClyeFgsBdJmFhbbMXE9hiSk2rGcIZe1ug=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=JwtvajmpX4qUyT8x/fxoCu4RlG1/GYuw+sFl/REBLBHlNFIsZ+MEtLIgWzA9E5hmmYgZjeeRP9+X5+UE6vFPyJ2yIeADqmqiEexSQLlgu2dBO8wCdsrZT3USxk+JOAK3JaGaSwqauobRu+JBZ7ROhIcq5bbXWBI2fpUXUU/ZWqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=dIlwThY8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=czbSEk6aan1ZweJ18iqWzDGP7KorHUieh0vLuUipyTw=; b=dIlwThY8Gr//P2Sq4jDmBn9WB/
	EIRs0xx2C2Z3Rer/3iWhW5F0tj4S94gJnk05yYXD5kHYqcRBAq8fOLedNb1DnSTx88YOw0mGQcNbo
	uZmC+VoaQQ+6QG1cIP1nzcF6HNhwY6VJS6l89lO0DFgL6EQZPVnGifnK0XY/KnhvgnuU=;
Received: from p5b206e31.dip0.t-ipconnect.de ([91.32.110.49] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uFV2l-004eZ4-2n;
	Thu, 15 May 2025 11:38:23 +0200
Message-ID: <8835e42c-e6d8-4025-ad91-cd81915a5912@nbd.name>
Date: Thu, 15 May 2025 11:38:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76-fixes 2025-05-15
To: linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Cc: Johannes Berg <johannes@sipsolutions.net>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here's my mt76-fixes pull request for 6.15

- Felix

The following changes since commit 2c89c1b655c0b06823f4ee8b055140d8628fc4da:

   Merge tag 'net-6.15-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-05-08 08:33:56 -0700)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-fixes-2025-05-15

for you to fetch changes up to 78ab4be549533432d97ea8989d2f00b508fa68d8:

   wifi: mt76: disable napi on driver removal (2025-05-15 11:22:41 +0200)

----------------------------------------------------------------
mt76 fix for 6.15

- disable napi on driver removal

----------------------------------------------------------------
Fedor Pchelkin (1):
       wifi: mt76: disable napi on driver removal

  drivers/net/wireless/mediatek/mt76/dma.c | 1 +
  1 file changed, 1 insertion(+)

