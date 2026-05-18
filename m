Return-Path: <linux-wireless+bounces-36567-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHbmJ9u0Cmpp6AQAu9opvQ
	(envelope-from <linux-wireless+bounces-36567-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 08:42:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E001566DB2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 08:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 049E43005EA9
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9883C9EE7;
	Mon, 18 May 2026 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="K4p5WVAj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBB3C81BE
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086357; cv=none; b=q+r+KCiTB1E3BrZw/za72H0whhGkdLXSowDgu1IOEsy4X/00s6GKS9GgiA6fnXWDzFZR9rnPLVuZ4MSBuRfL9KAWgonFnyxmeIKc0Vr0L54pxMXgK0NyjqGxgwe23ggOVzSH/GZq3Oc/8Y6MbS2scCIibGFimWhMy0qibZWD8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086357; c=relaxed/simple;
	bh=buANpIYhImCPh66p/SAEazuwt0SkK6rVfe03JFcoyaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUo8xPmBN0tDlzalcNvRozn/tJ/RRpWqE4jJpC+RQbfbdiQ3copx5eeykTE81wsM2mk9OsH3gLMgpKIqT7IFs+lfjuFXyD34gMBLM6Nh3CUtlZqdBEFoNwL2XArJxfKnO09Iu2Nnv+9N/PsxcxNpS2yym+OJCbD7rPWUnqZ7OTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=K4p5WVAj; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1779086340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZmlGCP7iSzr3ZczH67y0FAPPISnKn0z/q9xwzrmevE=;
	b=K4p5WVAjRlJX0el7XwN0gkNfkGwAlVArvFv28J6f8v5FOVZZjG57JqRKIYu01+0+751qQP
	trbTPhXEOokt1Te+w91gw9XzwHGPNKqeWhFEPuWJD9K2BkoGDxbb8GiTGovnl0TIl0JcP0
	QoUwdeQy0563fZ6X+wek8HG7NoLtzKRIzhqD6MinErs/7ieJXY1d5nY58yKrDEmnhiRv8d
	nb25pWMhLDo45+DWjK/Cs1cTpCF+7O1MRmstD+CVKIVKVNysTU4ztKiTW6/sQoA6Lmsb1g
	xL0HzPFeNmlbEY1QdUC+tBR+P90ijxPh66BB3xH76TJmC13sIqhs4g/AEtCTAg==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>,
	fjhhz1997@gmail.com
Subject: [PATCH v2 0/1] wifi: mac80211: fix monitor mode frame capture for real chanctx drivers
Date: Sun, 17 May 2026 23:38:52 -0700
Message-ID: <20260518063853.96384-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260308164510.5927-1-fjhhz1997@gmail.com>
References: <20260308164510.5927-1-fjhhz1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1E001566DB2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[sipsolutions.net,nbd.name,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36567-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,justthetip.ca:mid,justthetip.ca:dkim]
X-Rspamd-Action: no action

This is v2 of fjh1997's patch, carried over at his request after his
reply on morrownr/USB-WiFi#682. Compared to v1: the substantive
change is the list_is_singular() guard agreed on in the v1 review
thread, so the fallback only fires when the chanctx_list is
unambiguous. The surrounding else block is also collapsed into a
single else-if matching the shape d594cc6f2c58 used for the emulate
case, and the v1 local ctx variable plus inline comment are dropped
(the rationale lives here in the commit message instead).

On the hang reports against the previous attempts at this fix (Oscar
against v1 in his March 19 2026 lore reply, and Johannes's Dec 2025
v2 at 20251216111909.25076-2-johannes@sipsolutions.net, held back for
similar reasons), I reran the airgeddon evil-twin flow (hostapd AP +
monitor VIF on the same phy + aireplay-ng deauth from the monitor) on
three setups:

GMKtec NucBox K8 Plus (MT7922 PCIe, in-kernel mt7921e, kernel 7.0.5):
  Stock and patched: no hang on 2.4 GHz or 5 GHz. dmesg clean.

Pi 5 (Alfa AWUS036AXML USB, OOT mt76 carrying morrownr/mt76 commit
903b05918523 "mt7921: assert sniffer enable on chanctx change",
kernel 6.12.47):
  Patched: no hang on 2.4 GHz or 5 GHz. dmesg clean.

Kali Linux 2026.1 VM, kernel 6.19.14+kali-amd64 (matching Oscar's
reported environment: Kali, MT7921U via USB passthrough of the Alfa
AWUS036AXML to a KVM guest; airgeddon 11.61 installed; v2 mac80211
built in-VM, installed, and loaded as the OOT-tainted module):
  Patched: no hang on 2.4 GHz or 5 GHz. dmesg clean (0 errors,
  0-1 warnings). Slab delta under 2 MB per 30 s run.

Patched did not hang on any of the three setups; K8 Plus stock also
cleared the same flow on both bands (Pi 5 and the Kali VM were
tested patched only). The prior reports look environment-specific to
Oscar's rig rather than kernel-side. If Oscar sees a recurrence on
this v2 I will iterate with him on the thread.

Discussion: https://github.com/morrownr/USB-WiFi/issues/682

傅继晗 (1):
  wifi: mac80211: fix monitor mode frame capture for real chanctx drivers

 net/mac80211/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

--
2.43.0

