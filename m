Return-Path: <linux-wireless+bounces-23801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF8ACFE4E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 10:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0B516509F
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B5028642B;
	Fri,  6 Jun 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SQYHhc1K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB88286428;
	Fri,  6 Jun 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749198571; cv=none; b=M59n+j6LOP3AAGcBGR4ZLQxOdhOLrioDpzhhQ2nm0ATKiNG1blD1f9HRv/ywcmAXETEDErdRgpE70nEuTaQRez8K1yrgPYiBJQQl/w7IOpp7VG02HX8/XGjPRf2bNEGZVyVGsJngWZe83CRNJNS/dJ5SKs9fQxpDlVMCjbt2kAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749198571; c=relaxed/simple;
	bh=49DaA8DXyMY6i18x5JEvk8p3lLkcvagYTP8QF3EeKtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rg7ArlOh2MjDCtc7JG/tHmnrx9xKO9g/mRELvQaZx/Rso85fwYUXbgQjLJz4G7e0qV8NLiKBGZ0zSubZpUv46Rnikr5ksfqTwUyN3mIa4M9GWfgr09h8Vaa9GdhwpFBGAJM4PkK0Jhnf7R1mDOBFU7YV6p9QfuyKoeQHJePP06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SQYHhc1K; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IAvmuB1cMZPHO9Dy/0EcZda6EBM6yEw8n1PRljLtuUo=;
	t=1749198569; x=1750408169; b=SQYHhc1K7x/Rnx05lyg0o5tsElVEY4TssbdTCakrE+R6RJa
	wHUqshpMAYDls7fS1JQSk5dMKqGBNRNz6bABwsI1MM786Maxb18oroonPUiwuAEwjWK7RUci6+iIP
	ASnUXR85XD1FJB/cRTyL/kj2zdTLa8tNU4iAo3EaUvgqIV6BJOtLOUWALkW/pYvEalIOEQzc4dhvA
	A7TUIXxN0RQRW7HwFcV1t5MMt0BOafD6kOlStlL+96690Gk53utjhpUjKS3fq0q/wXnAFuCdtzMTS
	l7dwn9zGqkSifmaCCG5o5HMqJ1GhWRYGV1+ni9sTXVX4cAfd+p5QSlU2nnoBSfDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uNSS6-00000007Tvj-1nuC;
	Fri, 06 Jun 2025 10:29:26 +0200
Message-ID: <a83d4f351e1c6b676ec19460a2800e5eb9fe7163.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/4] wifi: brcmfmac: don't allow arp/nd
 offload to be enabled if ap mode exists
From: Johannes Berg <johannes@sipsolutions.net>
To: "Lin Ian (CSS ICW ENG WFS SW WFSW 1)" <ian.lin@infineon.com>, Arend
 van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	carter.chen@infineon.com, double.lo@infineon.com,
 vinoth.sampath@infineon.com, 	gokulkumar.sivakumar@infineon.com
Date: Fri, 06 Jun 2025 10:29:25 +0200
In-Reply-To: <5ea555b2-d952-42dd-baad-11acafad5697@infineon.com>
References: <20250604091629.3943-1-ian.lin@infineon.com>
	 <20250604091629.3943-2-ian.lin@infineon.com>
	 <1122ef86-c43b-4d39-aebb-e69a1150f61b@broadcom.com>
	 <5ea555b2-d952-42dd-baad-11acafad5697@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-06-06 at 16:08 +0800, Lin Ian (CSS ICW ENG WFS SW WFSW 1)
wrote:
>=20
> May I ask if this one is regarded as ack to merge?
>  =C2=A0- [PATCH wireless-next 1/4] wifi: brcmfmac: don't allow arp/nd off=
load=20
> to be enabled if ap mode exists

You will need to resend though, I'm not going to get into a business of
trying to poke into patch series to apply them partially.

johannes

