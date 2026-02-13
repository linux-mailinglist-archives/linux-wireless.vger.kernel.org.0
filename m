Return-Path: <linux-wireless+bounces-31819-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG/GIm9aj2lxQgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31819-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 18:07:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D97AC138814
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 401FE300638A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5731C36402E;
	Fri, 13 Feb 2026 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z2S+5fEY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8D1A5B84
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002406; cv=none; b=uFDYUrdFOBo2dey4XHu4VGQbQTeka9AVGHcz8TJjGVkZ8U7ae+vvlbX6X2Thrd+vZkNM+LD6+5j949WAzP5jcAX7Oe1NIC+sXfDZEhe+/EtyYu8kCioUVhOJA923M+dpiLZkDfQq6nskpaKxmAO6F4Ikq2YovUsGp+zvY9PVbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002406; c=relaxed/simple;
	bh=OXq0xSQyB7az4nabFzi2dTTn6764v4VJfM5O1wwvcYo=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type; b=n7EFhbhVFynLR4ppCV8vNv95/2p50/YEu9GJDf10KziIqCHrEf/nOop/RUQBILbWzxPia2Gp/H3eWX0ghe3flsO6ez2SG0AkAB9MxzOxwRhDQhrDbvtfn08H97OClY3Fv8bVlXEUGVyFB+qZlUa/nidmDREle/ze2N798JZaEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z2S+5fEY; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 13 Feb 2026 18:06:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771002401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OXq0xSQyB7az4nabFzi2dTTn6764v4VJfM5O1wwvcYo=;
	b=Z2S+5fEYAjneUfn4lEtJx93iiT5sbyqd45fKPMbG6zH0p80PWV2N1OU0a+iNvtkezVbinX
	DvhgIg5N0AWjYlrRK4HzYo42QvdmvctF/vVvrw6cgRFtKnVj2yPZ5K7N341Gmm7GLEUWUj
	8cZGIj5Ozq+FaiM3BzhonzYl4PBaUoA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: linux-wireless@vger.kernel.org
CC: kvalo@kernel.org, pkshih@realtek.com, lukagejak5@gmail.com
Subject: Subject: [Call for Testers] Modern rtw88 port for RTL8723BS (SDIO)
Message-ID: <92D9345A-34A1-4255-86A6-C31A5E0DE008@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,realtek.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-31819-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D97AC138814
X-Rspamd-Action: no action

Hi everyone,

I have been working on a standalone, out-of-tree port of the rtw88 driver =
specifically for the RTL8723BS (SDIO) chipset=2E As many of you know, the R=
TL8723BS is still technically in the "staging" directory in the mainline ke=
rnel (rtl8723bs)=2E My goal was to bring this hardware into the modern mac8=
0211 framework by backporting the rtw88 core and implementing the 8723B-spe=
cific PHY logic=2E

What=E2=80=99s implemented:

Full integration with the rtw88 core framework=2E
PHY/Calibration: Implemented IQK calibration and thermal-based TX power tr=
acking=2E
Build System: Clean, standalone Makefile that supports automated KDIR dete=
ction=2E
Validation: Code passes make C=3D1 (Sparse) and includes a basic validatio=
n script=2E

The Catch:
I do not currently have the physical hardware (RTL8723BS) to perform a "li=
ve" test=2E I am looking for volunteers who have devices using this chip (c=
ommon in Intel Atom tablets/sticks) to see if the modules load and can succ=
essfully scan/associate with APs=2E

Repository:
https://github=2Ecom/MocLG/rtw88-rtl8723bs

How to help:

Clone the repo and run make=2E Follow the loading order in the README=2E S=
hare your dmesg | grep rtw88 output in the GitHub Issues=2E
I'd appreciate any feedback on stability or range compared to the legacy s=
taging driver!

Signed-off-by: Luka Gejak luka=2Egejak@linux=2Edev

