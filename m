Return-Path: <linux-wireless+bounces-33991-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIiLKIJpxWl1+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33991-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:14:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C1A338FA5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 476B330D5C73
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521BF3ECBDA;
	Thu, 26 Mar 2026 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="jJHpo35c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68641C2F3
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544660; cv=none; b=PpNQ5mgyOBzi1KPbCwY15MbgjFAxLckyDhKq1/vysViuCGVyc3x3TlbIRiyqcU5ca9Ak+nAwkxnNs80x3QzsPUfsAs+BS0nXBi9KnEaU3q+TeEO+x/o5fWUfXyTQoMS1aJbuk8TzwTTKD61YoH6ccdiVDa7xXLGoi8ZicuU+XHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544660; c=relaxed/simple;
	bh=6O+Fb4y6hZGC1Ii/vWaybHRB6+JV10GYTuqP7uR3g5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wkwf6HbnHshilmD6mg6TJo6qNndZb8CYDxrjh0y+Y/llB9KACChOMwiWMgkBV6IZ0P7XK26eGa4IY6w8tvYIJr0evPuNPh0hVOyAppkx7lYQPOnmsPqA8Dn3dusir0/qq6syqhz11fd1RNgXIsSIR6DZy2Ehs+XPObmpnjhpxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=jJHpo35c; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1774544655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPLbETzywDZ/LXKktaa48OxW8xTevcANb3hp9TPiGq8=;
	b=jJHpo35c6UoaYo0r2PqWNFsmNOrlCcnvuMLHUiaa7MH9jgeBIdS89t1NeuCeuPCPpMgYsm
	IPbT/ufWg6suIGeNhKkzdMgB0WGk7qsn4JNaKiiNKCinNjz843LXNNcAc7LzbVCF6BQQe9
	xiczeHZbn/cZoLfLbcuqbz9bPmc4bx1Mx9a5X1xlmmBap+SSjuzk/xETD4RrmaCSAxjmHc
	GfjHRsplTQ5BXyAt7Ap6iQACQOwL6Yj6StAUAz5MNfWtW1gauRV26/89tBR1eeR9RlREb+
	hFX6QqEAx218F6IqDiWKaKDmmUxFJjfzSVm9/3XCkUWV6rh0R6pAUkOzLtC5ZA==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: sean.wang@kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi@redhat.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	morrownr@gmail.com
Subject: Re: [PATCH 1/3] wifi: mt76: connac: use a helper to cache txpower_cur
Date: Thu, 26 Mar 2026 10:04:07 -0700
Message-ID: <20260326170407.406431-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260325043318.13298-1-sean.wang@kernel.org>
References: <20260325043318.13298-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33991-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,redhat.com,vger.kernel.org,lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,justthetip.ca:dkim,justthetip.ca:email,justthetip.ca:mid]
X-Rspamd-Queue-Id: E2C1A338FA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sean,

Tested the full 3-patch series on MT7921AU. All three bands working
correctly -- txpower reporting is fixed.

Test environment:

  Kernel:     6.19.8-200.fc43.x86_64 (Fedora 43)
  Device:     MediaTek MT7921AU USB (0e8d:7961)
  Firmware:   HW/SW 0x8a108a10, WM 20251223091148
  AP:         Tri-band (2.4/5/6 GHz)
  Regdomain:  CA (DFS-FCC), also tested US, JP, DE
  Note:       Internet maintained via separate USB ethernet
              adapter during WiFi testing

Baseline (stock 6.19.8, pre-patch):

  txpower 3.00 dBm on all bands

Post-patch txpower:

  2.4 GHz  ch 1   (2412 MHz, 20 MHz):   36.00 dBm
  5 GHz    ch 100 (5500 MHz, 80 MHz):    26.00 dBm
  6 GHz    ch 5   (5975 MHz, 80 MHz):    12.00 dBm

All values match expected CA regulatory limits. Connectivity verified
with 0% packet loss on every band.

Stress testing (28 tests, 28 passed, 0 failed):

  - Connect/disconnect: 10 cycles per band (30 total), txpower
    correct and ping 0% loss on every cycle
  - Band switching: 30 sequential hops (2.4 -> 5 -> 6 -> repeat),
    txpower correct on every hop, ping 30/30
  - Module reload: 15 full rmmod/insmod cycles of all mt76 modules,
    txpower correct after every reload
  - Throughput: 100-ping per band, 0% loss on all
      2.4 GHz: avg 2.4 ms, max 23.6 ms
      5 GHz:   avg 1.9 ms, max 8.0 ms
      6 GHz:   avg 2.2 ms, max 3.3 ms
  - Soak: 20-minute continuous test per band (60 min total),
    txpower sampled every 30 seconds, never deviated
      2.4 GHz: 40/40 samples at 36.00 dBm, slab delta -4 kB
      5 GHz:   40/40 samples at 26.00 dBm, slab delta +16 kB
      6 GHz:   40/40 samples at 12.00 dBm, slab delta -16 kB
  - Memory: 50 connect/disconnect cycles, slab delta +64 kB
    (negligible, no leak)
  - Band-hop marathon: 200 random band hops, 200/200 pass,
    ping 200/200 OK, completed in 1232 seconds
  - Concurrent managed + monitor: txpower stable on all bands
    with a monitor VIF present, ping 0% loss
  - Regulatory domain switching: txpower correctly adjusts
    per country on 5 GHz
      CA: 26.00 dBm
      US: 24.00 dBm
      JP: 23.00 dBm
      DE: 26.00 dBm

Zero kernel warnings in dmesg throughout all testing.

For context, I originally reported this bug and submitted a fix in
January (v1 through v4 on linux-wireless, as Lucid Duck). Patches 1
and 2 in this series address the same core issue -- capturing the rate
power loop output and subtracting the path delta before caching
txpower_cur. Patch 3 (the per-vif-link get_txpower callback) is a
good addition that was not in my series.

Reported-by: Lucid Duck <lucid_duck@justthetip.ca>
Tested-by: Lucid Duck <lucid_duck@justthetip.ca>

