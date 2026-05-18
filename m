Return-Path: <linux-wireless+bounces-36615-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QApeJUCeC2p4KAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36615-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 01:18:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA67574EDA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 01:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 172AB3013A41
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 23:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA3F2EA468;
	Mon, 18 May 2026 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey+XMnP7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8534405C5C
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146301; cv=none; b=V4lFB27Rr4j2gv/usDVa0+EuIrlvRnVwr7JyUjY2ICAc3pC+69GEVkGG8KdDZV0pjeCXic0do+/JJ3OYQEs/4gTtaneUkkQ3oObj+OSpxtW6MFLgihpXh/RzExgO+kMmo6U6lpAcz6HIWNCm5vt9tRnGj8Unwd9S0oY5Xh3SoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146301; c=relaxed/simple;
	bh=TZgxt2jG0f9fHoBL5FD2fb7SGXV5ShMV1vLVhYBy1/o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject; b=uUT5pD3TmQiEjX0r74Hn1vVApxAKvFSNv7b/KRH6m+XWzGhoEJjhTkV9IjsUMkUzxP0+TLMBwyDxIIz4REvVuc72i2H4jvPLmiq1d+goUG0P5Iqb30mfb6My4B4Lno853Nk6fk0id2Z1Y1kuS8uQcanmMRASidVsFDFj84qLvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey+XMnP7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b150559bso22284765e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 16:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779146298; x=1779751098; darn=vger.kernel.org;
        h=subject:cc:to:from:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MwQ4+T8/IHn57ekqGl0FuTuuwxp2E9CrynR+1mutik0=;
        b=ey+XMnP7LoI1V4lkeX54ZL74latFA2ZgFYff6E0RyIr1MbSD7ZOYgKHNMWtRjz1MQH
         vzPFr6P7gAG8MYltaz61PayZtpjxYYWjUH5488YbSTG9KHSa1L3LrxPt5LYSU3jVwNFr
         VeZ13EksN9QYkuQ7BQvwtj/lU1kJJhGtWGnhsNIlNqUmU31ytXbdR3DVw1GRTDxYi/Ux
         p/FC+OuSLAcRa3zbU4tAoKPpPlL/bNVbBiuybaBT6WmaUIpheV8kdhEtltcEIZsxS6dV
         RwG+X4M82BqBjsvefsjDU2uCPw/qpXwj44tuKufAZnlAvYgnm9ICo8V/c94lZg5jCRFa
         tEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146298; x=1779751098;
        h=subject:cc:to:from:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MwQ4+T8/IHn57ekqGl0FuTuuwxp2E9CrynR+1mutik0=;
        b=F83sZR60m0zPbRikMDyVwDOiIGmmPjGKj2rqWfUaf7MPuEhigAaUpZ0AXke/WCL7K9
         WOVxKRWcsjFNTi3xEiTNBVm5tcI9j7AbyYC5l3LyvQgW8KgFOmhHA2XIvRFKLlvJS9vF
         rK1/xg8U+G1cHLk0zuwqxt5rUJGwD9o3y6yd+XLroXI82wQTPwxdyoI7VMqbuZ3BYirl
         ks8u8QUqAPbKLSdfwS+9FDmQ1pI8AXZEIa0mKNICW/UoPCvivPveOU4Mnn+PmFSS2V5U
         WZActtiNUTNtIpDhAZiHtpD28TwusYwN0xoEGRmf7uwd0ho9BNqIlTH3oI3iMuraM8UM
         +hQw==
X-Forwarded-Encrypted: i=1; AFNElJ+iiBHH/FHzbbA3yDT799rdyZaOOz30o4wY58+n9MVuSz43lmrWYumE5qDC7oW/x+WZUmTWxNmdMIOycC4I/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ATflvmwErHX2cA9D1HPagglLE6Ago05+rSHtq5InoE3Rt/AJ
	4Moiit8zfWmjS1yYxSPDUOrfdLE5Clu6uIDCCgKfr2M5RO99lqONH5v0
X-Gm-Gg: Acq92OGgd1OGlCkzmezfYrVVRI7Ced2l9Xs3nAGp2Rk5mGlYNUPs3VwWqfdneoTIHzy
	W/9f1Zx2u0YVuAJ80DBbShre2KBc7akxi+5NTfNziqlXHdNe73Mo7r47IUnP6kNSn2T9Jt/LBSV
	hEaQ0T2veh4Ewl2JbTnmodbU+lalK6tc+ckfzRe1KkIuY6C5CiRN/LiQ1Hn64WmT5ey2hJDJrQH
	MVgnTQEyqNJvQTRhael+xApBDaA2jDw4wx/jipVAkbZvfmr0Q7OjjcZdu9tX/9a60bx/J3keq8y
	UfclWT6vUTwv0krD/DA8arRhvTJFnkCHloHTn9d9y5wTh8pMrfUrVIbWJrT80hBCSVPacaaij0B
	HDg9/TCGwzzgep1m6ctNlIrn8LJz8NetDsku3ms8hqCE+uRLqXSJC0GBB2YGJP1rwJ9kP13fyI+
	QZlxXiiWi13YqLIrLGTIZhnag0cK8O+mSJMr2Lvp4Zqg68ClHyiT8=
X-Received: by 2002:a05:600c:698d:b0:48f:e230:2a1c with SMTP id 5b1f17b1804b1-48fe6631158mr275019155e9.31.1779146298231;
        Mon, 18 May 2026 16:18:18 -0700 (PDT)
Received: from smtp-relay.insalata-fresca.ch ([91.84.77.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c62dsm90310455e9.11.2026.05.18.16.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 16:18:17 -0700 (PDT)
Message-ID: <6a0b9e39.87c5160c.1d1e38.353c@mx.google.com>
Date: Mon, 18 May 2026 16:18:17 -0700 (PDT)
Received: from claude-maintenance.insalata-fresca.ch (claude-maintenance.lan [10.42.0.122])
	by smtp-relay.insalata-fresca.ch (Postfix) with ESMTP id 13A3E80BC;
	Mon, 18 May 2026 23:18:17 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============4304209518966126559=="
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: insalata.fresca@gmail.com
To: jjohnson@kernel.org, quic_rajkbhag@quicinc.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, quic_bqiang@quicinc.com
Subject: =?utf-8?q?ath12k=3A_QCN9274_hw2=2E0_single-band_cards_on_IPQ9574_=E2=80=94_firmware_RDDM_after_WMI=5FINIT=5FCMD_=28WLAN=2EWBE=2E1=2E6-01243=29?=
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36615-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NEQ_ENVFROM(0.00)[insalatafresca@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mx.google.com:mid]
X-Rspamd-Queue-Id: EAA67574EDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============4304209518966126559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Jeff, Raj Kumar, all,

I'm bringing up mainline OpenWrt on a Wallys DR9574 (IPQ9574 SoC + three
QCN9274 hw2.0 M.2 cards: one 2.4 GHz, one 5 GHz, one 6 GHz, all single-band,
all single-mac firmware). After working through two host-side bugs I've hit
what looks like a firmware crash and would appreciate guidance.

Hardware
--------
  Platform : Wallys DR9574 (Qualcomm AP-AL02-C4 reference design)
  SoC      : IPQ9574, soc_id 0x401a2200
  Cards    : 3x QCN9274 hw2.0 M.2 (DR9274-2GK / DR9274-5GK / DR9274-6GK)
  Firmware : WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1 (linux-firmware 20260410)
             fw_version 0x160484db, built 2025-12-09 19:48
  Kernel   : 6.12.89 + ath12k from current ath-next + backports-6.18.26
  OTP      : slot 0001 board_id=0x1 (2.4 GHz card, programmed)
             slots 0002 0003 board_id=0xff (5/6 GHz cards, unprogrammed)

Two host-side fixes required (separate patches)
-----------------------------------------------

Fix A -- single-mac cards must not request WMI MAC1:

  Without: HTC service WMI MAC1 connect response: status: 0x1 (NOT_FOUND)
  Cause  : hw_params.max_radios=2 for qcn9274 hw2.0 unconditionally drives
           ath12k_htc_init() to open two WMI endpoints. Single-mac firmware
           (dualmac OTP bit clear) does not advertise the MAC1 WMI service.
  Fix    : read dualmac OTP at MHI register time; scope wmi_ep_count to 1
           when ab->dualmac is false for qcn9274 hw2.0.

Fix B -- DMA ring capability parser must tolerate unknown module IDs:

  Without: "Invalid module id 3" -> "failed to parse tlv -22" -> WMI ready timeout
  Cause  : WBE.1.6 sends capability entries for module_id 3 (and possibly
           others) the host enum does not know. ath12k_dp_get_ring_num()
           returns -EINVAL for unknown IDs, breaking TLV parsing entirely.
  Fix    : warn-and-skip on unknown module_id instead of returning -EINVAL.

Both confirmed working on this hardware. Happy to format as [PATCH ath-next] if
useful -- they get all three cards from "won't init" to "init proceeds cleanly
through WMI SVC_READY_EXT".

The blocker: firmware RDDM ~316 ms after host sends WMI_INIT_CMD
-----------------------------------------------------------------

With both fixes applied and CONFIG_ATH12K_DEBUG=y + debug_mask=0xffffff, boot
is clean through service negotiation:

  [19.482] Control service: ul pipe 0 dl pipe 1 eid 0 ready
  [19.485] HTT Data connect response: status: 0, assigned ep: 1
  [19.485] WMI connect response:      status: 0, assigned ep: 2
  [19.486] wmi_ext_service_bitmap 0x5e45be01 0x2d94d02 0x1c7010c6 0xee7d5c14
  [19.486] num hw modes 1  preferred_hw_mode 0
           slot 0002 (5/6 GHz): supported_bands 2  freq 5 GHz [4890-7125 MHz]
           slot 0001 (2.4 GHz): supported_bands 1  freq 2 GHz [2401-2495 MHz]
  [19.486] unsupported dma ring cap module id 3, skipping       (Fix B)
  [20.408] htc ep 2 consumed 1 credits (total 1)  <-- WMI_INIT_CMD sent
  [20.724] ath12k_pci 0003:01:00.0: mhi notify status reason MHI_CB_EE_RDDM
  [20.883] ath12k_pci 0001:01:00.0: mhi notify status reason MHI_CB_EE_RDDM
  [24.517] ath12k_pci 0002:01:00.0: failed to receive wmi unified ready event: -110

MHI_CB_EE_RDDM (RAM Dump Debug Mode) fires 316-476 ms after the host sends
WMI_INIT_CMD. The crash hits all three cards on every boot. Card 0002 does not
crash but times out waiting for WMI_UNIFIED_READY, presumably because the
firmware group is stuck.

I also attempted two host-side patches targeting the post-INIT path: a
NULL-ptr guard in ath12k_core_start and a DMA ring config timing fix in
ath12k_core_hw_group_start. Both were confirmed to have no effect -- RDDM fires
before either code path is reached, ruling out those theories.

A 21013-line verbose ath12k log (multiple consecutive boots) is available on
request.

Questions
---------

1. Is WLAN.WBE.1.6-01243 known to work with current ath-next on QCN9274 hw2.0
   single-band cards? Is there a known-good firmware version to try
   (WBE.1.4.x or WBE.1.3.x)?

2. Is the WMI_INIT_CMD payload format expected to differ between single-band
   and dual-band QCN9274 variants in a way current ath-next doesn't handle?

3. Is there a way to extract an RDDM dump after this crash (debugfs, PCIe BAR,
   MHI API) to identify the specific firmware fault?

4. Wallys vendor documentation says "only single band modules can work with
   current ath12k without extra development". My cards ARE single-band yet all
   three crash. Is there known additional host-side work beyond Fixes A and B?

Full verbose dmesg on request. Patches A and B are ready to post in proper
format if useful upstream.

Thanks,
Stefano

--===============4304209518966126559==--

