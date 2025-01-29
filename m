Return-Path: <linux-wireless+bounces-18139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11296A21BDC
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 12:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFA93A327C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA771B415C;
	Wed, 29 Jan 2025 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="m0KhAh/m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B31AB6D8;
	Wed, 29 Jan 2025 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738149183; cv=none; b=YK7vhTWcwf4gg5UZPs4Qbc7X1YwZjLWK3xZJnG49LIUNho3HlLqKCAF+lwoiP4u5TXw6TxQNbgelp92sldAbLALkmO5jlMrpbLh4S+/J/EnKg2coknViglGBOohl8AWB9UQcp812zqbCRkTHvtRbeRNxp5PkoU/01U1/UHHnu8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738149183; c=relaxed/simple;
	bh=QxAVoLmftN4EymphVfBfD7Nk364kzNUU2g3490kLqmE=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=ZxvKl87NW/rlKkBOUBfEUdhm9VK7w9I/rygZx+XpvkANm45BNKbBfq9baJqL9JGzcGOd/WWbo+cYPxDRfywN4ZxuwrCLvn8QJIeHPc+TLJ472baQJ3XH7pYAWkrX9Gj1AeF4JxATPeVg6XihIP0P59/QGnRzTKbJh+PoeWCFRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-proske.de; spf=pass smtp.mailfrom=matthias-proske.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=m0KhAh/m; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-proske.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthias-proske.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id A81AC100569;
	Wed, 29 Jan 2025 11:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1738148712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h3f9LbXRtSCdNMd0f5+4b/pF8FHO8PF7pHBNKayw4QA=;
	b=m0KhAh/mNVSMU5Ijc9cmnf3DLmQbkdRnBQGHUo4y4zadxfLJMJ3yjTfxLOB6Q8QXqhQ19N
	s6EEoljpcJIBOnV3bm4tWe42nCavWHvo7kN0BBseuara7Jaj2P/O+CylpUecQruX3clCUK
	cT/uwWykwtH5/76jM4Y8WJsuSh1DaCY=
Received: from [192.168.178.89] (unknown [113.30.222.34])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 1E8A41002C8;
	Wed, 29 Jan 2025 11:05:12 +0000 (UTC)
Message-ID: <cd1b13d4-b01d-4237-813e-bd48c55d9ca9@matthias-proske.de>
Date: Wed, 29 Jan 2025 12:05:06 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Matthias Proske <email@matthias-proske.de>
To: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: DT property keep-power-in-suspend and how WiFi drivers use it
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 210eb5dc-780b-4c8c-a09c-37c30dd157e2

Hello,

I have a question regarding the usage of the Device Tree property 
`keep-power-suspend`.

In the Device Tree documentation it reads:
"SDIO only. Preserves card power during a suspend/resume cycle."

Does that mean that the SDIO Host Controller will remain powered or 
should this equally apply to anything that is connected to this SDIO 
Host Controller?

To give a bit more background:

I have an embedded board with a brcm_fmac WiFi module. It seems that due 
to a hardware limitation we are not permitted to switch the module off. 
It simply cannot be re-probed afterwards.

The property `keep-power-in-suspend` was used and that used to work fine 
until 92caded ("brcmfmac: Avoid keeping power to SDIO card
unless WOWL is used"), which made the wifi adapter by default turn off 
on suspend to be re-probed on resume. Not working on our board...


I have also looked at other WiFi drivers with an SDIO interface and it 
seems that none of them are really honoring the `keep-power-in-suspend` 
flag. Is this flag for the SDIO Host Controller only?


What would be proper way to implement it so that the brcm_fmac return to 
its old behaviour if necessary?
Add a Device Tree property directly for the brcm_fmac driver..?

I would like to write a patch, but I would like to know in which 
direction to go.


Thank you for any feedback

Matthias

