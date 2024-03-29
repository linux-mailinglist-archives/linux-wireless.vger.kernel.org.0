Return-Path: <linux-wireless+bounces-5679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB840893306
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 18:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7CA1C2227D
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BD0144D21;
	Sun, 31 Mar 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="WLHI84jq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1314534D
	for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902454; cv=pass; b=PzB9DWNvq3BOls81dtt8uO/B5o8ewqXB9DIK7s30MYaDyPeMwBHYmtjLtDLWBiwv1pihDo3p1f4WdjJjxl0pUqM9H3w8kuX2fes2n/QJBE8siWoXvnj4FJLDB2dsYe/jlnDmtKkq8PxM2pRfccF83+33vOJrTRaLfVscsXYT19Y=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902454; c=relaxed/simple;
	bh=+NVxXRpcb5Eu5Xuis5cdwzL/CLDSHHEsOUJ6slCa1ZY=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=B8GxvzJqpSaAPGntQI858DVs4cmBtoqTfhKw4MpOHwS9K+sRnOILfViT3R2HUOatMoLBl0V5+oLAn0UzLeI7GeshcJUFXvbo7dmJJS1TFNrVBcPn7c7OuAfvo1vAUNv5SCBZCu1/PqK8fJYOZFNL0mVCDP6nQE0T9RF4pplAzxs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=fail smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=WLHI84jq; arc=pass smtp.client-ip=96.47.72.81; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=FreeBSD.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9BD9D208B5;
	Sun, 31 Mar 2024 18:27:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ywZ63kMgsoKA; Sun, 31 Mar 2024 18:27:31 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 42ADE208BF;
	Sun, 31 Mar 2024 18:27:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 42ADE208BF
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 36144800051;
	Sun, 31 Mar 2024 18:27:30 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:27:30 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:34 +0000
X-sender: <linux-wireless+bounces-5626-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAhZPp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBeAAAAjIoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 14474
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-wireless+bounces-5626-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 6E90A2032C
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="WLHI84jq"
X-Original-To: linux-wireless@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal: i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752030; cv=pass; b=oEKzSndGkTuyKgHpEXEf2AuJNWlohPfNSyUXAwG2EBsis7BF06ZVI2hiQonm1WcRIKeNteUsZYAx3pdG/+MbTKzgf2k2XZI/g446EImWDcIt7jNUpKLLr0noIbJYYfxK7TaXanCMsyAzajyZlZXf7VLo/+IYlwAq/SC45bV+m2U=
ARC-Message-Signature: i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752030; c=relaxed/simple;
	bh=+NVxXRpcb5Eu5Xuis5cdwzL/CLDSHHEsOUJ6slCa1ZY=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=RBPzSLWiwd6FkcH/abXzdMCzP21CgnSFpjg/80Odi6LgtpIkTzTwQAX0A2xlM9O7NWW8XuQOzsKRudVQpH4EaOdC2IBPbOzNP8NftcrTfcWZVskr1gsrapgCCZqqBcN5OEkr27BG6+ZCcs3wGo5TFobcYeiCQJ2fkea9eO2WlME=
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=WLHI84jq; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1711752021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0KWbc82XY20N6N4WAODbgFtVAzry/IwFpFWBfsmE4uU=;
	b=WLHI84jqi4rw6ZkSqLva7LEgcgjMDY0CuYLfmB469+0UEDtctCUlt3+mzg6VJP1zqpFdmq
	hCRVuuyyrM3Rg2a9XJeiyl3fJfQuEqMgR+9dHhwaiqbPOTcLhZSH5y2t5bygPVflabnfCd
	1FMXpGXYypiGBs2G2GTOrgiGw7FSpR76EF5RAnZP9/dzmhsqBJffB72GbuRvesFj2qNumt
	cCiAl7KlM6qWkHbuZm1zZj9/UaCvu8qpRbJb8SGJY3HIDKHdKXTtTRpwig35LmRonId2qF
	6FYdzL2entjgXbIAc+nlH41ovzKVSEHWSv7q70j2Fo+g4gsAV4Lx3PrxUreVJw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1711752021; a=rsa-sha256; cv=none;
	b=Z174SQvQR3nn/P4qswFJgahqkv5fsL/P4S6IXrxsObqa8mhUGeMEFn6txcLTUVEcCa58wa
	JvLSSFYnHyxuUSo0eNRIjS8QhRuVrvLoLuZZUDFa5afXixCzKYA/XtA1dhHIApvOYiUePy
	zJFcd1razys0FP6Mptp8BYPzJgn80HOXz2BgNFnTvlyynNz+u9sv6e7Hr3B9iU9iaYPrty
	GCPq0zS5+jIyosxVROpWxM3BtOuam3QFNHGmuXGlQWkX3/m9z4d/yTg2LYF5qLaEEyUSOx
	+ndbFdIfPjEvDZBu72wLlTW2NccI3PY7LCvjEnKXLGr4gQ6mFU/GjTpEJCImfw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1711752021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0KWbc82XY20N6N4WAODbgFtVAzry/IwFpFWBfsmE4uU=;
	b=mbEYFPMr302fUNkaUwIs75J4vIqOTsQFZjKyIDPjJKGqgPBZ/fjTKMIK586wtIYvNXnc6R
	hFfahOYL9+52H1kQvqDAGL7jGOKz9mC7LdE1ZiyTg5EgWEEvs6sC3gNqsu21zRaPJerBL/
	s5WUTJgbJdkyKZ3yNuwVAiScjsnK2HSZplH1T8c1mgqWpPaOOFnrXuQlmr8OmZEQOvqHnQ
	eIfcBwMCNyPjOjBHIvz8w8P6QJ0ZW7VfBJd/Ky3CErlLoLQ9wqzVejVfPdc2g/jC2reVoU
	V7vDg/AC0bQybNHtPp7FL+IYPq8rd+uGoqPerFjfZGKyHxBgR42cl0AFKYae0w==
X-Virus-Scanned: amavisd-new at sbone.de
Date: Fri, 29 Mar 2024 22:40:17 +0000 (UTC)
From: "Bjoern A. Zeeb" <bz@FreeBSD.org>
To: linux-wireless@vger.kernel.org
cc: miriam.rachel.korenblit@intel.com
Subject: [PATCH 0/3] iwlwifi cleanups
Message-ID: <431o2997-oqn8-p0ro-sq6r-pnr543164r85@SerrOFQ.bet>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Starting to reduce some local changes in FreeBSD against the
upstream Linux version of the dual-licensed bits of the driver.

These are three changes removing dead code or hiding code
behind the appropriate preprocessor check.

Please check the MEI changes accordingly with the multiple
compile-time options under Linux (hope your build bot will
do that).

Bjoern A. Zeeb (3):
   wifi: iwlwifi: mvm: remove dead code
   wifi: iwlwifi: remove function declaration without function
   wifi: iwlwifi: mvm: check for CONFIG_IWLMEI to be enabled for more
     code

  .../intel/iwlwifi/mvm/ftm-responder.c         | 80 -------------------
  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 --
  drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  4 +
  drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 65 ---------------
  drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 -
  .../wireless/intel/iwlwifi/pcie/internal.h    |  1 -
  6 files changed, 4 insertions(+), 155 deletions(-)

-- 
2.40.0


