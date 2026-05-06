Return-Path: <linux-wireless+bounces-36047-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNnRBuzT+2lxFAAAu9opvQ
	(envelope-from <linux-wireless+bounces-36047-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 01:51:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB64E19DE
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 01:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35052300228E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 23:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF93165F16;
	Wed,  6 May 2026 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB9F4exD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31758358388
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778111465; cv=pass; b=UmmzlRu9rfvOjlDW6GdG+dBrEy4XhbV47K0Dcy458yIvxcuwmiD7n/c1wz//zRuP3BDwW6yNuidUOvqjlCMwQ5E7QjZ/LnY49eqwytMdnonRBQ6WVkoA4MjOglBs2LwVqWqqtEzuScT0oVWSf/mxDHhDz+sUaE6PdcT/q8ahBvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778111465; c=relaxed/simple;
	bh=0tZRjA+HkWL+7W3bjd7GqUJrQhMztyucdH65AZ/9jEw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I7zErEmWvNSUxtGApvHPjh+7fASNmaq72bwcYb8Th01u4VhqDfjQ8rOINHebaFmrSQUykYmAZJRSkW9EB9XZ4Fw92hvq4kb3Vmd5kvme7wMZJIea46MxdHxmF+Ut/B51mA4QB2p1iNxLTcNXEibb92P7kvVv+avQvdy7tGQsBi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BB9F4exD; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a877510541so161749e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 16:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778111462; cv=none;
        d=google.com; s=arc-20240605;
        b=eOF+IcNJETVj+W4npKZAI0m3vi3F+7dL7U2OUDE+Irv4obv/2pYJgyqXZ3u8d5x77g
         U01IDMy3pBp5PNV++rmeoFyXLh8njNY47rVIx2TqysuFWFO4dd4gz5hAvRnWGg4qdvoB
         BSPn8MJINJS0GeLg9s5bHrrFgEcnMLlwbLdqu8tYiRITIq/nO97AjX/ntVXU8b0/oHoG
         zKruLfYBOTDxrZPcWsl76FX6yGejfS9Pd2C/x7sqhXqLEpwmtlUT28Jr7jOSxc7HoDS6
         iMsu/RJl0Yqc0zD/keBLyJdRxK/RZjGab2JYPLucR+NykB8DwvjD5mS3x9I3bhYajBEG
         wzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xUu/T2ghLNEjslGMq1SHR6tUY57TBC3vo5/ckBQOZ+w=;
        fh=VNaEs4UO1k1hXjJiaHgDIiqI/Ol+NWuuwGcE5/rgCNA=;
        b=fVEe9PoaXnsMjRnFIkITXsx6FTlZCCSjpDDSAict/EswRDDhNpZBwgFPG7WP8BQ/5d
         zFSJivWMh/zmbJFWvk165guhrAOs5yEdMBG0+VjRFRJXAgp7jBaysDvvwLk7ug84QtlE
         rhX2/oyRAVw1Ahje94UQr8qVd738rhRLO2uCmwIojcadfGOi059kOX/yostlOGP+lVX/
         HI2H63nD0PI51HmVTS4L6k1/Z8KwCTKuk8LgYI4tFtxO+jPXZfpxi296XkJKT88kFuKK
         EhSoftSIuyZjhxYbgTrVxhfXsfXDb9p4VU11N9me+ujbr3VRgPiajrW11IZ2J2Ld3k5q
         +QMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778111462; x=1778716262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xUu/T2ghLNEjslGMq1SHR6tUY57TBC3vo5/ckBQOZ+w=;
        b=BB9F4exDVNbG/by4p8TWBwKLShye07/ETclW1z68dDoIbn3Qz7YRmY3bRhdVx2nzLp
         rJtwjoyHk1PzzH1yjBNxR9MF3cUhVDSbU4iiVDrAnWihuiMSAwezPqcbMDKiJ+T09Kog
         bvELCcbxUZx+ovnFaw8DZf5kCZdCJQdbwf49FCJsCC6f9fJfbt3znEBUcZmZLsqOuZl6
         eS2VoUciKtAviD6JEpGMCN0r90uUp/DYV/NoRUT1VS0Qc6b27G3oVNWeoGNq5NSlYaRk
         bBtYivR/2jrs9bPRQnuldYC353IhcJCdiiYtH9uX3hvg5LDPfUCu7Ocn3l6hP8SArkPw
         uu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778111462; x=1778716262;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUu/T2ghLNEjslGMq1SHR6tUY57TBC3vo5/ckBQOZ+w=;
        b=aPL/b9o/1d5iRS+vPfxlrmDVZIPnX1Pohm2EvCFeBmHqvGm7Zm9dckV+L4IOe4VIwE
         CAadwP4D5GhlqbhN81bmHuAuEboclPR3fviYhR6drgZDNc5xhVUxrxZTQ3RB+tONBwOm
         n/OCSWcBqb4/3/ZqgD57ZwLhhhNxoMXp5j1C8yKBjur7X4mqebYJKkIcTpWrYXvSSCkS
         nOgYKUC07Wq/S3Tt6tnGcY6nope0HbK1djKMm9npNvoC9IYnQzPcMJn4IeubIldCnG4R
         NMwhHyTbrwr+CZ0GEDuN4P86atAuLCVv7oaxNuFPQQkZ1gMl3VZfG1QypaEq/FBRm2S7
         9foA==
X-Gm-Message-State: AOJu0YwESRAY79g31DfC9nzBBndM9mTZ1doLpPqXT9mycxzU1DmjFlUf
	mGVpBoS8zgvRzclFix1T0iZaDboKgOkf1axoJr6htFom3Vqw2Hr1WTK6xCWdrtpMnhZrYYylwWX
	vQ9Xjeb023zCpS2wePaXy3iY7dTOfoZOPylJJ
X-Gm-Gg: AeBDies53WizeaV3RUgg7D5vd/s0nUC+25fTJ0h+X0dU7DWlKKL8OOmOrAg00Cquvb2
	JSdfhiohvHJmUZNMiYWXWYZnEow0pLy35qizW1+QnLOwhydkUxGPc18avNYhLW+lWd2NpjC8nU6
	FZRvJ8khiaakijidgrvZxx/4FHYMg9eBBGj/cCqHgz1sWceKdCLKbVHDxmPb5CNg+UpKUamRjrN
	1focCXXXNNEqGd+oeSU4r7Dbt6Kpdx5qF+vCyAPsy/0cBJpRdtVKjtEOEysC/Eio+cDId1QCMwT
	u84R00oyW5V1E9v02w==
X-Received: by 2002:a05:6512:1389:b0:5a8:7f52:62d1 with SMTP id
 2adb3069b0e04-5a887ada968mr2423489e87.1.1778111462091; Wed, 06 May 2026
 16:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Henry <jshenry1963@gmail.com>
Date: Wed, 6 May 2026 19:50:50 -0400
X-Gm-Features: AVHnY4LSJ6brkES7aR5l3ozN1EAWR3kAPHuDmDuS8GZ74Jd143xkxDa32vQTY2Y
Message-ID: <CAN6xzWeKNrQ_WfCQnM7C2ggy86uAwpp7nDEPatdfOEKN_8+reQ@mail.gmail.com>
Subject: mt7921u: monitor-mode per-channel retune emits narrowband RF burst
To: linux-mediatek@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6FBB64E19DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36047-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jshenry1963@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

Hello,

We have isolated a reproducible RF emission from MT7921U (MT7961
silicon) that occurs only when the device is in monitor mode and
being retuned across >= 5 distinct frequencies. The same chip in
managed mode, retuned across the same frequencies via the kernel's
scan API, produces no such emission. The behavior is reproducible
using only stock iw commands - no custom code is required.


Environment
-----------

- Adapter: multiple mt7921au-based adapters tested (custom in-house
  board and retail ALFA AWUS036AXML); identical behavior on both
- Chipset: MT7921AU, ASIC revision 0x79610010
- Kernel: 6.1.0-40-amd64 (Debian)
- Driver: in-tree mt76 (mt7921u.ko), module timestamp 2025-09-20
- Firmware:
    WIFI_MT7961_patch_mcu_1_2_hdr.bin
    WIFI_RAM_CODE_MT7961_1.bin
  HW/SW Version: 0x8a108a10, Build Time: 20241106151007a
  WM Firmware Version: ____010000, Build Time: 20241106151045
- Regulatory domain: US
- runtime-pm = 0, deep-sleep = 0


Reproduction
------------

Setup (monitor mode):

    IFACE=$(iw dev | awk '/Interface wl/ {print $2; exit}')
    iw reg set US ; sleep 1
    ip link set "$IFACE" down
    iw dev "$IFACE" set type monitor
    ip link set "$IFACE" up

Reproduction loop (this triggers the emission):

    FREQS=(2412 2417 2422 2427 2432)   # five 2.4 GHz frequencies
    while true; do
        for f in "${FREQS[@]}"; do
            iw dev "$IFACE" set freq "$f" HT20
        done
    done

With a fast spectrum analyzer (real-time / FFT-based), a narrowband
RF burst appears at the tuned channel on each retune. There appear
to be several bursts around the channel of varying strength.

The same loop with four frequencies (any subset) produces NO emission:

    FREQS=(2412 2422 2462 2484)        # four frequencies
    # ... same loop ...                 # no emission observed


Emission characteristics
------------------------

- Narrowband peak, ~800 kHz wide at the base, with skirts that
  fall off toward the noise floor and reach approximately the
  full 20 MHz channel width.
- Amplitude: -30 to -50 dBm measured over-the-air at close range
  with a fast real-time spectrum analyzer. Most around -40 dBm.
  Sometimes stronger. Usually stronger than normal WiFi signals
  from other standard WiFi connected devices within feet.
- Brief, on the order of hundreds of microseconds (not precisely
  measured). Too short for full OFDM spectral shape to resolve
  on our analyzer.
- Appears in 2.4 / 5 / 6 GHz, with band-dependent amplitude
  consistent with per-band PA characteristics.
- One or more burst per retune. Tick rate scales with retune rate;
  presence/absence is independent of dwell time (50 ms to 5 s
  tested).
- Independent of which specific frequencies are chosen: any 5
  distinct frequencies reproduce the behavior; any 4 do not.
- Reproduced in an RF-quiet shielded environment with no other
  802.11 / Bluetooth devices present.
- Identical behavior on multiple adapters (custom board and several
  retail ALFA AWUS036AXML), ruling out board-specific layout effects.


Mode dependence
---------------

The emission is monitor-mode-specific. We tested multiple paths:

  monitor mode + per-channel "iw set freq"  -> emission present
  monitor mode + SIOCSIWFREQ ioctl          -> emission present (same)
  managed mode + "iw dev scan freq ..."     -> emission absent
  managed mode + "iw dev scan ... passive"  -> emission absent

The kernel-driven offloaded scan path (NL80211_CMD_TRIGGER_SCAN)
on a managed interface does NOT exhibit the emission, even when
sweeping the same set of >= 5 frequencies repeatedly. This
strongly suggests that the firmware's scan path is using
different RF logic than the per-channel-set path used in
monitor mode.


What we have ruled out
----------------------

- Not transmitted as a 802.11 frame: a second mt7921u in monitor
  mode placed nearby does not capture any frame from the test
  adapter's MAC during the emission.
- /sys/kernel/debug/ieee80211/phy0/mt76/tx_stats counters all
  remain zero during both 4-frequency and 5-frequency monitor
  mode sweeps.
- fw_debug=1 produces no mt76-related dmesg output on our build;
  the firmware does not log this event via the standard debug
  path.
- Not active monitor / ACK behavior: explicit "iw dev set monitor
  none" does not suppress the emission.
- Not a USB transport issue: the only USB-related dmesg activity
  during testing is unrelated xhci_hcd HCI errors that are
  present whether or not the test is running.
- Not active scan probe TX: "iw scan ... passive" with managed-
  mode interface produces no emission, confirming the absence of
  managed-mode scan emission is not just probe-request elision.


Hypothesis
----------

Given that the emission is real PA output (visible amplitude on
external instruments, not visible to driver counters or peer
captures), is monitor-mode-specific, scales with retune count
rather than dwell, and triggers only above a small fixed
threshold of distinct frequencies, our best guess is that the
monitor-mode per-channel retune path triggers a per-channel
firmware operation - possibly a TX or PA calibration/trim
sequence - which is suppressed or differently scheduled in the
offloaded scan path.

The threshold of exactly 5 (any 4 channels are silent, any 5+
emit) suggests a firmware-internal cache of size 4 with cache
miss triggering recalibration on revisit. We have no direct
evidence of this; it is an inference from external behavior.


Questions
---------

1. Can anyone confirm what firmware operation is triggered by
   the monitor-mode per-channel retune path that the offloaded
   scan path avoids?

2. Is there an MCU command, debugfs knob, or driver flag that
   can suppress this firmware operation when the chip is being
   used as a passive sniffer?

3. Could the monitor-mode channel-set path be modified in mt76
   to use whatever optimized firmware operation the scan path
   uses?


Why this matters
----------------

For passive RF survey and security-assessment use cases, a
sweeper that emits anything during a sweep contaminates the
environment it is supposed to be measuring. At present this
limits practical mt7921u-based sweepers to <= 4 channels per
list, which is impractical for full-spectrum work and is a
significant usability problem we'd like to address in a clean
way.

We are happy to provide further diagnostics, additional test
results, or test any patches that might help isolate or
suppress the behavior.

Thanks,
John Henry

