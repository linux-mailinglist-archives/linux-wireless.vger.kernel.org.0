Return-Path: <linux-wireless+bounces-36600-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJknO6H8CmqA+wQAu9opvQ
	(envelope-from <linux-wireless+bounces-36600-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:48:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1148A56BF0D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69B66300C3A0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 11:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7303F166A;
	Mon, 18 May 2026 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="neqiViK/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh16-2.aruba.it (smtpdh16-2.aruba.it [62.149.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3E27A462
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104330; cv=none; b=Q72dWUfFmS6UBPCKS+Qb2euSJspzUqt126g4VhEaN38EZ6RREKSvRJqdQfH7h0YWSOlDrjt6ZfU5O7ixuu5EaPNt3padcUGa3jl3Loy6eS5GIMtPKtj8v8UT9fNaNmmeDe1zZz7ZoTEAm+qiCwrqXVxRBWSpYSk/MeHZlNGSJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104330; c=relaxed/simple;
	bh=UzMjGgTLP3VkpTJJAKFMLOoiMzIHogWPPkCKM6ObdI8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Agk++URtHWCT/8AqTgFTjwf8UdVaTV+zAf1OF0RhAxLLUBKms/2LDqsIldxMKXB8/WlzHXYX3cMMql5trOtjRwmY5+6TxkB5zw7b+kcmIHDSvFAw+KRPSHEvQAgQHynzlEyBRoCDPMIUmJdz8Cy8xNFwMVZFjNu3TNar05txGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=neqiViK/; arc=none smtp.client-ip=62.149.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.83] ([79.20.159.46])
	by Aruba SMTP with ESMTPSA
	id OwFxwicFb0dL0OwFxwoONl; Mon, 18 May 2026 13:35:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779104133; bh=UzMjGgTLP3VkpTJJAKFMLOoiMzIHogWPPkCKM6ObdI8=;
	h=Date:MIME-Version:To:From:Subject:Content-Type;
	b=neqiViK/Eq42zl4ABKS0BgLXLTqT6LeT/j/dE+ozv9V4ILMf3oP0+b3axOW29JBYM
	 n3Fc8QGTkBLiXH5XMIAmXHUOb8+mTJfZ4FY0yR919eTBNM4KJc4LiLpZP8JvXwMjnn
	 D7mq0RqM/umlmGFO0TCaEXmy2l2z5KKk95H+XcqL8uaTFCqJEMEpFObApDzT5iZ1oE
	 PUR0pTT6AV6Ng2mK+hfK0RlSZu3puaHvMff7AAlHstfKj4iodlkkKQQLNfsey4bcd4
	 RPcym7F8b0B1zzBI3Kd1G5SE7LeVSK+kAPrTOTZ3QO55elA75RZ3UZr1/2w+XSjXrw
	 fg4ONlRzCMe2Q==
Message-ID: <3e236bf0-5269-4631-8e56-1bc199c2f643@mythread.it>
Date: Mon, 18 May 2026 13:35:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: it
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org
From: Alessio Ferri <alessio.ferri@mythread.it>
Subject: [PATCH RFC 0/2] bcma: support for SHIM-attached SoC backplane
 (BCM6362)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOmHSt0svW0gf3BTzzog3i0iry0KL4XHFW5gSrtpbA0otzY8kqGxGD+eK1mLzqWPT6eydVDrpnpkVB/8guTzVpenZWXE29m3WDdtcJ+5RDCTBn9NvOhw
 u4suoppnO3QW0vqcLqFcyLHjy1hUnGN6T8iqMuWAKt797aKsfyGgC5JXnGw47K8Ej026aLST/kglpkx1AkOskE2abDI2/x5bk0+hAN8uayTsuNyH6Vu3JR2n
 HZCovsNCHENqOnPJ/F5sJWe+HeELVjll8cOL+h5ygXg=
X-Rspamd-Queue-Id: 1148A56BF0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36600-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[mythread.it:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mythread.it:mid,mythread.it:dkim]
X-Rspamd-Action: no action

This RFC introduces the minimal infrastructure in bcma to support
SoCs that publish a SHIM-style mini-EROM: a backplane on a big-
endian peripheral bus where ChipCommon, the IEEE 802.11 core and
BCMA_CORE_SHIM all report NMW=NSW=0 because clock and reset
gating happens in the SHIM's per-core Control register rather
than in per-core DMP wrappers.

The two patches:

  1/2  bcma: host_soc: support big-endian SoC backplane with
       wrapper-less core synthesis
  2/2  bcma: scan: allow SHIM-style mini-EROM wrapper-less cores

These two are infrastructure-only and don't interfare with
existing SoC: the default brcm,bus-axi compatible
keeps the existing behaviour, and the new code paths gate on 
bus->big_endian and bus->shim_attached, both populated only 
when DT compatible is one of the new SHIM-quirks ones 
(brcm,bcm6362-bus-axi, brcm,bcm63268-bus-axi). I didn't
include the DT bindings YAML for those new compatibles 
from this RFC - the binding design depends on the feedback.

Context: this builds on an earlier design question to the list
that did not draw a response:

  https://lore.kernel.org/linux-wireless/CAHDv23WJLBEp3ETscVT4Z6E5PQfzTDcofxbZ6jAezZNYde7C0w@mail.gmail.com/

The companion b43 series for the same hardware (BCM6362 single-
die N-PHY rev 8 + radio 2057 rev 8) is in review here:

  https://lore.kernel.org/linux-wireless/4581a48e-a6e4-46b1-853f-16db445d6890@mythread.it/

That b43 series stands on its own (b43 dispatcher gaps for a
PHY+radio combination already partially supported in tree). 
This bcma series creates the conditions for b43 to
bind to a BCM6362 d11 core, but does not change anything for any
other b43 user.

Open design questions:

  1. DT bindings for the new compatible strings. I added
     "brcm,bcm6362-bus-axi" and "brcm,bcm63268-bus-axi" as new
     compatibles alongside the existing "brcm,bus-axi", each with
     its own quirks data block. Is it ok?

  2. SHIM peephole base address. The brcm-shim quirks block
     hard-codes shim_base = 0x10007000, which is the address
     used by both BCM6362 and BCM63268 per the OEM SoC map
     headers. I left the hard-coded value in place for the
     RFC since i think it is fixed, but i'm ok to move it 
     to DT if asked.

  3. Accessor set duplication. The BE variants in patch 1/2
     (read16_be / read32_be / write16_be / write32_be /
     aread32_be / awrite32_be) are direct duplicates of the
     existing helpers with the underlying ioread/iowrite calls
     swapped.

  4. The allow-list extension in patch 2/2 (CHIPCOMMON, 80211,
     SHIM) is gated on bus->shim_attached at the point of the
     check.

If this design is acceptable in principle, the follow-up work
that depends on it is:

  - DT bindings YAML for the new compatibles;
  - A SoC-side wlan-shim platform driver to take the BCM6362
    SHIM out of reset before bcma scans it (currently handled by
    an out-of-tree driver during my bring-up; will upstream);
  - A SPROM fallback driver that registers via
    bcma_arch_register_fallback_sprom(), BCM6362 is spromless
  - DT nodes for BCM6362 and BCM63268-class boards under
    arch/mips/boot/dts/brcm/.

Tested on a D-Link DSL-3580L (BCM6362 SoC, single-die N-PHY rev
8 + radio 2057 rev 8). With patches 1-2 applied plus the
out-of-tree wlan-shim driver and SPROM fallback, bcma scan
enumerates the three SHIM-attached cores, b43 binds to the
802.11 core, and the d11 reaches firmware load and PSM run-up.
If asked, i can provide the full dmesg to verify working status.

I also own a NetGear D4220 and some other broadcom routers 
that i plan to bring up after the BCM6362, they are BCM63168 
and BCM63268. 
The shim_base in quirks block already covers BCM63268 per the
OEM SoC map headers, and i expect the same SHIM-attached 
backplane shape for the BCM63168. 
I plan to reuse this infrastructure for their bring up.

Alessio Ferri (2):
  bcma: host_soc: support big-endian SoC backplane with wrapper-less
    core synthesis
  bcma: scan: allow SHIM-style mini-EROM wrapper-less cores

 drivers/bcma/host_soc.c   | 243 +++++++++++++++++++++++++++++++++++++-
 drivers/bcma/scan.c       |  19 ++-
 include/linux/bcma/bcma.h |  10 ++
 3 files changed, 269 insertions(+), 3 deletions(-)

-- 
2.43.0

