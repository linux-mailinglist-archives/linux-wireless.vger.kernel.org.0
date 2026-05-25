Return-Path: <linux-wireless+bounces-36882-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCRxBUBOFGqnMQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36882-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 15:27:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C3E5CB17B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 15:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFC813020A61
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 13:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8723383C74;
	Mon, 25 May 2026 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="rWwdl9Dz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA637F758
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715456; cv=none; b=MES25oNW+if0Bulx4k+j4O9+ql7uQT2E2ZtayWEyLMNaZnNosFIlSE097V7Fi5eScrWDXWe0kBkGnBbgwLFYWQBPOh5m7+7OO0lk+jUlADpFcV4C8s9wqqDiTSoglW1aq+eL5PLcYwZ8JZ7knB8TS/FhFLr5M2l5kB5SY0e0J5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715456; c=relaxed/simple;
	bh=fxRsoFne0DDbUjJFoVOgC2G/PdhDpxaCdKCmB1dh4qo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=dQCsV0jGVyIZ08tE2GybDb0MXHX236yse4dVSLMufCoy5D+9+SNYAFnluE+5yES3/dKMrLVpFSquF0d1LMGnkmZB/eOI3s9JaG1506r4exa0sS3PYYpyM1wJM2eKGuo71Q/EYdLOA3Dsw6OA0H8RGuydZqBBmkToANr0s5QouLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=rWwdl9Dz; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gPGmz624hz9tp1;
	Mon, 25 May 2026 15:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1779715443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9aNWWpQ+16cskdRqLSNbL+nh+J/jH+qNm9U4np8Wsd4=;
	b=rWwdl9DzOMQiwVWE9f/I4nFw7g7gjR+CCINHQFSf0e+yJ2m1ZJYhIeYSdY2rPPVI7cXTpM
	MXrPd+VoObpz7gT396192/PHv9ZuaLedUVQ0wQUe772JiGcrxAIbQxk3pQlvMtDnak/bFw
	ZqNMygcpv1ji2/+y7yJ0COx/dFyPdUTYqEzvBUtBeugskusb2SwTnbIBruf1NpSTl9haPe
	ZDhjRLme+BVApMY8L2hpNzjowN7PsRGrccFzHWreIu+Oc3wGtxLeXQgM0jGx2bKRIeNBFy
	K07q382vBbyw7vB5qx7f4gIXA0R7FK5HNhNQMZgf1E3X1P279UVAQWivvUpm7A==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of hauke@hauke-m.de designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hauke@hauke-m.de
Message-ID: <0fbb0b6e-c849-4e26-9c46-2ac4986f6b52@hauke-m.de>
Date: Mon, 25 May 2026 15:24:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: =?UTF-8?Q?ath11k=3A_WCN6855_WoWLAN_resume_leaves_RX_in_unrecoverabl?=
 =?UTF-8?Q?e_reorder_state_=E2=86=92_TCP_collapses?=
To: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, Baochen Qiang <quic_bqiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[hauke-m.de:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36882-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[hauke-m.de];
	DKIM_TRACE(0.00)[hauke-m.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hauke@hauke-m.de,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 87C3E5CB17B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I used AI to help me debug this problem.

On Lenovo ThinkPad P14s G4 AMD (QCNFA765 / WCN6855 hw2.1), ~1 in 10
suspend/resume cycles leaves the ath11k RX path delivering MSDUs out of
order (~16% of TCP segments). TCP cwnd stays at 1-3 MSS and goodput
collapses to ~3 Mbit/s; UDP on the same link in the same minute pushes
100+ Mbit/s.

This machine is in the DMI quirk list at
`drivers/net/wireless/ath/ath11k/core.c` that forces `ATH11K_PM_WOW`.
In WOW mode the firmware is kept alive across suspend; the WOW resume
path does not re-initialise REO HW or per-TID BA state.
The PM_WOW quirk was added as a workaround for unexpected-wakeup bug
https://bugzilla.kernel.org/show_bug.cgi?id=219196

## Affected components

- **Driver:** ath11k_pci
- **Chip:** WCN6855 hw2.1 (`17cb:1103`, QCNFA765)
- **Firmware:** 
`WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41`
   (fw_version `0x11088c35`, 2024-04-17)
- **Kernel:** observed on 7.0.9-arch1-1; also present across many
   earlier kernel versions over the past >1 year on this hardware
- **Machine:** Lenovo ThinkPad P14s G4 AMD, DMI `21K5CTO1WW` (matches
   quirk entry "P14s G4 AMD #1" at `core.c:961-966` via `"21K5"`
   substring)

## Reproduce

1. Associate to an HE AP (characterised at 6 GHz, HE-MCS 5/6 NSS 2
    160 MHz, -56 dBm, using MT7915 with OpenWrt 25.12).
2. Suspend, wake, test `iperf3` TCP. Repeat. On average within ~10
    cycles, one resume leaves the link broken.
3. In the broken state: `iw dev wlpXsY link` still reports ~1.3 Gbit/s
    "bitrate". Ping and UDP iperf3 look fine. TCP iperf3 collapses to
    ~3 Mbit/s with cwnd stuck at 1-3 MSS.

## Evidence

### iperf3, same link same minute

```
AP -> STA, UDP -b 200M -l 1400 -t 15:
   sender:   200 Mbit/s, 267876 datagrams
   receiver: 102 Mbit/s, 137290 received, 130585 "lost"
   (not real loss; iperf3 UDP counts out-of-window arrivals as lost)

AP -> STA, TCP -t 15:
   3.43 Mbit/s, 521 retransmits, cwnd 1.41-5.66 KB throughout
```

### UDP run: no real loss anywhere

- `ip -s link` delta: `+267,953 packets`, `0 errors`, `0 dropped`
   (AP sent 267,876).
- `/proc/net/snmp` Udp: `RcvbufErrors 0, InErrors 0`.
- ath11k `pdev_stats` delta: `MSDUs delivered to HTT +267,985`.
- `soc_dp_stats` entirely zero: no RXDMA / REO / HAL / TCL / backpressure
   errors of any kind.
- AP `iw station get`: ~1.3% retry rate, -65 dBm ACK signal,
   `expected throughput 1049 Mbps`.

→ Air link clean. Host data path clean. Firmware delivered every
datagram. No drops anywhere.

### TCP socket reorder (`ss -tin` once per second during TCP iperf3)

```
    t (s)    bytes_rx   segs_in   rcv_ooopack
    0        1,291,653       895          158
    1        1,717,365     1,189          210
    2        2,060,541     1,426          274
    3        2,519,557     1,743          335
    4        3,050,973     2,110          397
    5        3,446,277     2,383          450
    6        3,906,741     2,701          513
```

~60 ooo packets/s out of ~370 segs/s = **~16% out-of-order**, sustained.

### Packet-level pattern (`tcpdump` on wlpXsY)

Seq normalised to 0 at flow start:

```
22 ms     2896:4344
25 ms     4344:5792
27 ms     1448:2896           <-- late; fills gap from 5 ms earlier
28 ms     5792:7240
54 ms     8688:10136
55 ms     10136:11584
57 ms     7240:8688           <-- late
107 ms    26064:27512
107 ms    28960:30408
108 ms    30408:31856
109 ms    27512:28960         <-- late
156 ms    57920:59368
156 ms    59368:60816
157 ms    56472:57920         <-- late
```

Fingerprint: A-MPDU subframe lost on first transmission, retried, retry
arrives 2-5 ms later. Working REO HW would buffer the continuation
until the missing subframe arrived or the per-TID reorder timeout
(`HAL_DEFAULT_REO_TIMEOUT_USEC`, 40 ms) expired. Here both continuation
and retry pass through unordered.

## Diagnosis

- Air link healthy; host data path clean; REO HW error counters all
   zero — REO simply isn't enforcing order for this peer's TIDs.
- dmesg across 3 days of suspend cycles shows zero ath11k re-init
   activity (no `fw_version` reprint, no `wcn6855 hw2.1` reprint). The
   firmware instance is the same one from the most recent `modprobe`.
   `ath11k_core_suspend_wow` / `ath11k_core_resume_wow` neither power
   down the device nor re-initialise REO.
- `rmmod` triggers full `ath11k_hif_power_down` + chip re-init on next
   `modprobe`, which re-runs `ath11k_hw_wcn6855_reo_setup`. This is the
   only reliable recovery, so the corrupted state lives in firmware /
   REO HW that the WOW resume path never touches.

The non-WOW path (`ath11k_core_suspend_default`) does power-down + full
re-init on resume, re-running `ath11k_dp_srng_common_setup()` →
`hw_ops->reo_setup()`. The WOW path does not.

## Related

- Bug #219196 — unexpected wakeups; the WOW workaround was added to
   mitigate this
- `ce8669a27016` — introduced the WOW quirk table (2025-03-28, Baochen 
Qiang)
- `0eb002c93c3b` — added `21K5` / `21K6` (this laptop) to the quirk
   table (2025-09-29, Mark Pearson)
- `4015b1972763` — adds Z13/Z16 Gen1 to WOW quirk (Nov 2025)

Hauke

