Return-Path: <linux-wireless+bounces-30806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FEBD1C4FF
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 04:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43122300ACA0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 03:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63727FB21;
	Wed, 14 Jan 2026 03:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="jxewuAx8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4524239E9D
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 03:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362961; cv=none; b=i4Y7Ic9JEmMOwmaYvOOv1Jz64rqZuojb5chiTxb/mSyTOuiXL4/v6AupOlJ1qVuhFclN4pX+FpEz6U8WloWx9B6DTOyeyOdm9oGa0oDvLmaECohstLhSmJ6fG12+2o4WNhRWD7Pqat/j6CFgxvJp+r1kw1k3G6BoewpzmIon3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362961; c=relaxed/simple;
	bh=Xl0cI+rW6U0e4XdE2Al+eP+WSefG0YI572BsL4tLXfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJ42VCbhWRSfnVzyT6o3TMgVJtAmFHBBW8eUUOp++VrkdKcn3EiDGlR8eWRX0eNuFAooNHbLSIaz4ylVBBk+iX6/EMLAZvYsNOD2HNCB+qRj6g5cWIyRec+PW/Y8ynGd/uUhaPAsU/XKU7w9I4d+crjpnv3GeTBaQVVXyr+5rPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=jxewuAx8; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BC3510DEC5;
	Wed, 14 Jan 2026 04:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768362951;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SE7m26Kegd18IvpzjThoP1ZAfyO7L0cAMdaDRsYCG3s=;
	b=jxewuAx8Yi4A4nROk374Lkv3MZJhiteLhqyKff/R0KNLJ9O7krKMNv/x32+auDChxVYFc7
	aMe1TYJxMOr1GskraY7MIrimfLsCsfjJutEUdYqFItwoCK5XUt7W1s44xEdW6YvmCVcrTX
	s//29A/RuReUzBXDDLe4F8ewsPqs9/rM8UuaCZB5sNYXNDETsFJywsGNo1TOJ3KyjaGyKg
	g9Mahpi3VTIc1VOS+GHZLbjBAThPbQGMLZ9x867k74cUu6sdVoyoUEWFjc27u5DSqc4yvj
	b9DuvzqHM8zrf4JFfbuO9ljlXvULtwmXK69yAKnt9FnFRWlJF1+FFHhLqjWjsg==
Message-ID: <43acfb38-9dbc-4544-b429-dfd43afbf2b6@nabladev.com>
Date: Wed, 14 Jan 2026 04:22:57 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 00/34] wifi: inffmac: introducing a
 driver for Infineon's new generation chipsets
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
 linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 wlan-kernel-dev-list@infineon.com
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 1/13/26 9:33 PM, Gokul Sivakumar wrote:
> Infineon(Cypress) is introducing a new INFFMAC (WLAN FULLMAC) Linux driver
> specifically for its new-generation AIROC family of Wi-Fi Connectivity
> Processor (CP) chipsets (CYW5591x), Wi-Fi + Bluetooth combo chipsets
> (CYW5557x, CYW5551x, CYW5591x, CYW43022), and also for all future chipsets.
Support for the CYW55572 can be easily added into the existing brcmfmac 
driver, I already posted a patch over a year ago [1], but it was blocked 
by an off-list email.

Frankly, I do not see any good reason why the brcmfmac driver shouldn't 
be extended when it is clearly easily doable. Adding new fork of the 
brcmfmac would only increase maintenance burden and prevent bugfixes 
from reaching the brcmfmac.

[1] https://lore.kernel.org/all/20240909203133.74777-2-marex@denx.de/

