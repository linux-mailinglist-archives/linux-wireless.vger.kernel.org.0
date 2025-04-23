Return-Path: <linux-wireless+bounces-21911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87298A98A6F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305BE1B674F5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175AA33F9;
	Wed, 23 Apr 2025 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YhQSBx+H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBAB45BE3;
	Wed, 23 Apr 2025 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745413557; cv=none; b=K7ToC/GinfQDJcpvRVBb1PSfcPcMevmcuXULJcDXL49u8npRWK/GaScLGK0ll1/zJ22sB2JcUFQpHH5Lq5XC7dBU9k+k0+zB5xvgSyVf7VwtBhXaACNL3UaqGwEY1yDLs3wcUSTedAHY8df20N15HujdcORP0+EoOZzwriMX4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745413557; c=relaxed/simple;
	bh=CNFUHid4rWe1ZBysd77LLAsmV8SWOymH2X6fZMoAoqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a4D1l/CdFi9WKHVgtKGEcqNUF+6FJUNuPl3xfBIyYuQXJiO/tfGUb99XtDQqp5TLoD/xOld+Xams7eF/bN7O2zAyygmq2RsCrHnqikzgelziHiuUEx+YcV1xep2L41ex7t+ENtfG1aIPrMGseOdDrX2Rd/lxuxPKwrJ8Ym6rHrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YhQSBx+H; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CNFUHid4rWe1ZBysd77LLAsmV8SWOymH2X6fZMoAoqo=;
	t=1745413555; x=1746623155; b=YhQSBx+HV/bFRqbFkLnYQIipyoLbG/IOVNltksCzcdLdulb
	IxULuXpdMui8wyukQzo/FMms82JQ5l53YSMukEf7fzJNjTeDSQzMfwG1VAxj49r7rcUKEQVvXX2xA
	FJnGTId9EuMashjKCaTjTTpk3cQO2/aayrSN6H0DU3qjf/Zzd3p4BQjwrTk3IpIHyPim7dSheGY2e
	1TiTaes/swxaKsm2j5EnBd8dicXpUoZCDuysLjoLbxmVtDpvGpG0ZdrZ+XR1kO98mgG16+Zl65t6O
	L9+fyHltbqtf8pRUbFj1yGRL/6TQvtY/gH++kO/Ena0x4Ujqs1NkejK3s0i+dwpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7ZnU-0000000EgAy-2EZN;
	Wed, 23 Apr 2025 15:05:52 +0200
Message-ID: <4966b4893821f5d2f8748dc2e04e6f81a7adaa39.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] wifi: plfxlc: Fix usb device interface
 deinitialization
From: Johannes Berg <johannes@sipsolutions.net>
To: Murad Masimov <m.masimov@mt-integration.ru>, Srinivasan Raju
	 <srini.raju@purelifi.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Apr 2025 15:05:51 +0200
In-Reply-To: <20250321185226.71-1-m.masimov@mt-integration.ru>
References: <20250321185226.71-1-m.masimov@mt-integration.ru>
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

On Fri, 2025-03-21 at 21:52 +0300, Murad Masimov wrote:
> These patches fix issues during the process of deinitialization that is
> done when a device is disconnected or when probe fails.
>=20

I have no idea why you had CC'ed so many people ... reduced.

How did you test this, if at all? The first patch seems obvious
(applied) but I cannot judge the other.

@purelifi - are you guys still interested at all? After all it's been a
month and no comments.

johannes

