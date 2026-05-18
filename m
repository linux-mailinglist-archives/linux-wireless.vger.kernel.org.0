Return-Path: <linux-wireless+bounces-36602-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDvwL5z7CmqA+wQAu9opvQ
	(envelope-from <linux-wireless+bounces-36602-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:44:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4856BD44
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44432304C362
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E653502AA;
	Mon, 18 May 2026 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="a2WscoGX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh16-2.aruba.it (smtpdh16-2.aruba.it [62.149.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D8D31F9A1
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104513; cv=none; b=SuSVAVByiKde0w/OpWICMFzISLmIHT0+BRIS7sbVTg93XbKE+6CeifQM3DAbyne3pcQtGg0Gf6cezoF1Hm8su4KRlhc0c+apfW4YN7hgYsUws5ahExU2czwDlGtMaAOul6wlj8lGXoxfI3XLDQHz2HYP8azEtoMUDwXTUC1HLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104513; c=relaxed/simple;
	bh=VogQrZOOWqWfWokkAXnhSSj/ebCdXQRFOyEi0Zc9ON4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cqj8XB3mVUqkWPgP+wxa3gnN/b8zf3kylcZ6freMeukriSmZntgstrQDgreUf+7bNT38xyIpzkXDU7gDHc5YM49Nm5m5fsMpEjPPpkbFu97tYZDD8WnNQJJheB2Rq2+n+5XpFC60o3HMOAoXbWne0WPd8fxDNlCeO3WJptGgacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=a2WscoGX; arc=none smtp.client-ip=62.149.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.83] ([79.20.159.46])
	by Aruba SMTP with ESMTPSA
	id OwM2wiiUd0dL0OwM2woRmo; Mon, 18 May 2026 13:41:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779104510; bh=VogQrZOOWqWfWokkAXnhSSj/ebCdXQRFOyEi0Zc9ON4=;
	h=Date:MIME-Version:Subject:From:To:Content-Type;
	b=a2WscoGXJwPa1LNneudzZvMOwyF3XiVhOhr4QEGlAOczR2qESH/uKTx169M0+lJPi
	 2Fo4YygFIhHq7L2OzMWX+7s2LGpHvXyPOKCgbLUJ4H+f5ef/OdSi5JfTn6fW+J/7EF
	 2pM/Ke8v1yspjWNWohXfRkmCexp9IYkm9KVikVm1AreKqLZAtg9fYSgGU2rA07Nc7x
	 7tmcRS6vmaiNE1FRlitoAdzubJn5zGnDOBKNKTYFBjt5Jai/Jq9Cgg6O2Durl09eii
	 IifFzVZGtg9q2aUUhDgs/RdTP8VTiHUB7ibSpjM41mcudfMkY9XyGF1xPg0nAyc6YN
	 +Kox01ijecfWQ==
Message-ID: <7a6ed9e5-bbac-41e6-a304-79072efcbe9f@mythread.it>
Date: Mon, 18 May 2026 13:41:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RFC 2/2] bcma: scan: allow SHIM-style mini-EROM wrapper-less
Content-Language: it
From: Alessio Ferri <alessio.ferri@mythread.it>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org
References: <3e236bf0-5269-4631-8e56-1bc199c2f643@mythread.it>
 <82d2ae7c-3913-4d1c-8e2f-f586c4196ce1@mythread.it>
In-Reply-To: <82d2ae7c-3913-4d1c-8e2f-f586c4196ce1@mythread.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJTdg26Wp0XYeeQcmF/owQ9LSig6VJ2SZcv1NPhDKr9xRyF/lp5v9LRigeBnWdZwJwYphJjz2uy7dHcX7M2mj2mmoiRI05G7Y0A+kKu4oglWyO0RIM1h
 aQ0MDy27pFiJ4zUGrRihWNMWpo1CLBUlEpopsevMP/msmQZblH3tOHMBVP5Chv+TTkEF9SNqz1WWwOMkLo51lLfHldE4/wSl8eGLssF3wkLssX18YRcIt0Eu
 r/RzRoMvPqMu+HfRNicqabiRRcmG1rCbAEoiX0PLOhg=
X-Rspamd-Queue-Id: 47A4856BD44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36602-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:mid,mythread.it:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

bcma_get_next_core() rejects with -ENXIO any component whose
component_B descriptor reports NMW=NSW=0 unless its core id is in
a short allowlist (4706 MAC GBIT, NS_CHIPCOMMON_B, PMU, GCI).

On SoCs that publish a SHIM-style mini-EROM (BMIPS xDSL family:
BCM6362, BCM63268), the WLAN backplane lists three components:
ChipCommon, IEEE 802.11 and BCMA_CORE_SHIM. None of the three is 
in the existing allowlist, so all three are skipped silently, 
bus->cores stays empty, bcma_find_core(BCMA_CORE_CHIPCOMMON) 
returns NULL, and a later bcma_chipco_watchdog_register() 
dereferences cc->core->bus on its first line and oopses mid-probe.

BCMA_CORE_SHIM (0x837) is already defined in
include/linux/bcma/bcma.h with the in-tree comment "SHIM
component in ubus/6362"; this patch is what makes the SHIM core
actually probe and bind.

Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/bcma/scan.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index 983a62dde..871baa221 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -318,6 +318,21 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
 		case BCMA_CORE_GCI:
 		/* Not used yet: case BCMA_CORE_OOB_ROUTER: */
 			break;
+		case BCMA_CORE_CHIPCOMMON:
+		case BCMA_CORE_80211:
+		case BCMA_CORE_SHIM:
+			/* SHIM-style mini-EROM SoCs publish CHIPCOMMON, the IEEE
+			 * 802.11 core and the SHIM core itself with NMW=NSW=0
+			 * because clock and reset gating happens at the SoC level
+			 * via the SHIM, not via per-core DMP wrappers. The
+			 * companion host_soc patch sets bus->shim_attached on
+			 * those SoCs from per-compatible quirks data; the strict
+			 * NMW=NSW=0 rejection still applies to PCI-attached cards
+			 * and to SoCs without that quirk.
+			 */
+			if (bus->shim_attached)
+				break;
+			fallthrough;
 		default:
 			bcma_erom_skip_component(bus, eromptr);
 			return -ENXIO;
-- 
2.43.0


