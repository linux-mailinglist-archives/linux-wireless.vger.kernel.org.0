Return-Path: <linux-wireless+bounces-22995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D8AAB8321
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6988A3A2B67
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4BEBE;
	Thu, 15 May 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="IrKcFo/v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB3D1F2BAD
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747302330; cv=none; b=iD8pwt32feLZEJqqVFMoN1XQZnnBKfeyw33PnRdywaJ6UDxNLOYwuUHqO0XIcoX12D2L40/UMnwHugMXiTmKe0V4Yi076IVEKNJ5qjHlj1dTrUqMl9yjbm8yCm/upB6NLB5j8PtTmBS2Om90GK949ctpX1iP/u1iVnbmw0doiTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747302330; c=relaxed/simple;
	bh=EtEWVBgGhpQEWmUPQivTmhUR1suADTuweZvtxFbYREM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=L8nWLX8ljNeUGh+pPuZlpxFtDLpHz67pdluFPEH00s1EZZe4bKxWQT8/Z+nJKQJzxhe2pQ11F9pvFMR8IShdaKwUMk7PDP0hxICQDC71JqwzV20MNEJgwgQtJi3JKZ93GkyubAkR3lIp5/HVC8vC8POBZeGmgxSB4BeG4HEMw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=IrKcFo/v; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OjNbXp4o+d5z4qmhOicoXHTWTVITnOM/szBBVuA79ZQ=; b=IrKcFo/vadQxQlMJBnoGmf8KLt
	yQ4Y7WZOIJiDM65EM6xZkwLGQ/yEYPOXZu87dzzY+aTlepqor4V3LdWxlPWHVfXwKvqzR9Bl08/nX
	gdLSgltZG1keV8K/OsKxPiOJo8jUb2zNg+NIMW5+j8ZZPlNhJWaqu8EmJ9dA3jHxE1u8=;
Received: from p5b206e31.dip0.t-ipconnect.de ([91.32.110.49] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uFV9Y-004egR-2w;
	Thu, 15 May 2025 11:45:24 +0200
Message-ID: <3b526d06-b717-4d47-817c-a9f47b796a31@nbd.name>
Date: Thu, 15 May 2025 11:45:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76-fixes 2025-05-15 v2
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Content-Language: en-US
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

Here's an updated version of my mt76-fixes pull request for 6.15

- Felix

The following changes since commit 2c89c1b655c0b06823f4ee8b055140d8628fc4da:

   Merge tag 'net-6.15-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-05-08 08:33:56 -0700)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-fixes-2025-05-15

for you to fetch changes up to 0aa8496adda570c2005410a30df963a16643a3dc:

   wifi: mt76: mt7925: fix missing hdr_trans_tlv command for broadcast wtbl (2025-05-15 11:42:12 +0200)

----------------------------------------------------------------
mt76 fix for 6.15

- disable napi on driver removal to fix warning
- fix multicast rx regression on mt7925

----------------------------------------------------------------
Fedor Pchelkin (1):
       wifi: mt76: disable napi on driver removal

Ming Yen Hsieh (1):
       wifi: mt76: mt7925: fix missing hdr_trans_tlv command for broadcast wtbl

  drivers/net/wireless/mediatek/mt76/dma.c        | 1 +
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 ++--
  2 files changed, 3 insertions(+), 2 deletions(-)

