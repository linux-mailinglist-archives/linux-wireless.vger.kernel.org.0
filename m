Return-Path: <linux-wireless+bounces-31505-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J98GqREgmlHRQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31505-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 19:55:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5934DDEA5
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 19:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AE1E305F4B3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50E308F03;
	Tue,  3 Feb 2026 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5OPusQ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7525E17BA2
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144869; cv=pass; b=XSEuoaEmliFeo3fLLxbYQEvMVB6S8t1BZv9+nNRqBNTM9rykDL0rPfMUKrJbbnO4g6SHEGR4j9WMaXz1bS7tt2+OAcXgX9cdLp82yMOIUqa5IgPiEdHkXeaVZJ6UY8YFwgbQvUjHfL08KP2FoTk6nkZ2b7pLZr0MlAwYY0IhX5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144869; c=relaxed/simple;
	bh=dyqIXjM0Kxcl3NRLz2hh4Qw4gkUEgOEfLISPwamEEgE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YfW9OUJnl/Kvxl2u675KV7ZKptQpCz5MTPHVstDtYoYCiEAAJPkaXlVdtk4D1aau0DSFuUrj8EbSR34UdmK1O0+ctt6/vpoyPBX/lX/MXFPRXEHzTsU30NMDj/qqZKVshCrqqn0l1dzsiWgjYZSPts+dqRAzcO2M4lFD/cfYOPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5OPusQ2; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5636b2fde95so1723847e0c.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Feb 2026 10:54:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770144867; cv=none;
        d=google.com; s=arc-20240605;
        b=a4zX1rRhIr9skOwh4t82hqEHNnpaNCRHJGNx0bq85gaa7t4g005b7bXRj+ZuwfXCeC
         Yyb59Jt2k2ykoxb14t0Sa8CKqQ2E/X40XAecMb6P3m9jt2yCOfY6GuAChIiSJ65No8T+
         LrRqrptKzCRG5Ng1lDQsEAFDtuABQB5B72bgdOU4+ltc0T9IEy4R7QZMNIjUiI9Vpf93
         G8Ly0id0il9MRBUt21eIGkl3N4bMiYbZOCpWVXHZlDLSTtHdFFaMRaxQNosqox9GNJOe
         iJNh0T6cHx7LYyGdmmYd7e22adOxMA6yNBLgxkt42RXProPcS5VtWOu76kJEyZMdJuy3
         DZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CmtU7RT5ENPxTg0z+Iwqyn5/DF9ojToNvTX2vIIjWYg=;
        fh=hQUEiiksHvYN/EFmEKRXMJqwCC0zT2cV3viCNHAv7Ok=;
        b=Y2AhGdvq7+OEVhCVZpSFpW9PKE0LY6qRyGvLxYmDracJIbL6xvSEegQyAGOJL+g30U
         EYWCHKf6Ch9QIlc6cuy8mVoY7Ob72wm5MHOYDuK7g2J+U0WadZmb+6UapfNH6ChwyOR3
         xiR9GHTj3ppK5ELQEKDzKeshsRIjTqoeKH2zLOVFDT9Ws/tNbSnVNQg0OrgdPFlh95TQ
         TjXQl6e9XhGIT6itara5nuGceOd1VWXak/kWrcQccwbzo+z54lk21PXnmyjzNVrk/mTy
         lGAnL804cUzTI/8HXMgqvpuRX1kv9O/4i9ndkBohUMSEFYzaTTOb0FoPnnHPixVI6RaQ
         Vx8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770144867; x=1770749667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CmtU7RT5ENPxTg0z+Iwqyn5/DF9ojToNvTX2vIIjWYg=;
        b=L5OPusQ2I+rTWmDf/hQDegwudk9pah0M88CKCGV02//6dnZvsmIzk97DmsOj1QoAgm
         m7tgmCiUZGCuhVe3ElZG8afYC0hrN+3pXtHlmsMUkWDajosRI/5ZwIIMq0Gs6jSqGEeS
         Xc/1ESD2HQ4391AwKS248ZY/uAmp/CGpzgwQSjVE0FvWbFCF0EDxHKCHVMzQ/elkgz8M
         paPnVUiiaH5TtnI87cCwWVdYoIdRUeh2tZWsrD9ZXIK6k0u7k/rS5P5Nu0U0p8M38e1b
         dp/J9jm15oEAG5RrIuTPk4ks9/16Sfaaw315ivD/x1wofw5C+BGi2SuwRpxdZlEy3o8X
         BI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770144867; x=1770749667;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmtU7RT5ENPxTg0z+Iwqyn5/DF9ojToNvTX2vIIjWYg=;
        b=H63ubzmdTXhp3of+5Qb+35fqkTOKm7kBZLjHwA0WPfF3TlkapFrkFXz5/XVpNB+6Nj
         RFqYxBPXmG9qYXdhtvrx30r+WHShzQ4wMT/oWGVI/a99o9BU/kNs95J52n2ox1t2fL3T
         yxTbRkwivVNrPoZhWKHoByGQxpUh0tt6IYm7kRFjPpw4eRMdPdbcNd/I2LmgQOfoQ28l
         4XJUOsg0507SybmpW4ohxLybmUSbzUmyVcyN0p6/Rs9lZ0TW5Jvsuk7DDhxEmYFNQuGI
         dqkI/lVIVBb9TWWn/Gj2C0WltY9PRXUU+nw0v42YqA9k6Jh7JMtyIW0F/FgFwsjx4LIG
         4DvQ==
X-Gm-Message-State: AOJu0YxrlouYBTsGRrAALxnHQRvRlbVx1Pd8TU9RWkrFRHX8+w1BSwsD
	32yPl8VUl4Y56g1IKF14cC2QqCfDcnbflOoQewCPcjYTLgwfgopoxfeJq1Tw6a3mSdvNdTO/KS8
	uykYaRoDWuOs2hFjGbPgH31G82iKDSbz/ABBs
X-Gm-Gg: AZuq6aKl3C362uVR2ol9onvO3POPaS4IWZ9XHCE/CJOrS/UR/MmNVsbjRuV0+QwezKZ
	McSrpbtXCVB1sruH2RJ7vnShbZMRBpsBCUDm7ML7kqxLURIK43ATbUam+HKpq6aWKmD3cGb1Zc3
	U4C5gKRtLwN7Wj21ZOj/SQdekgbBa40eG9bFeb9b661ouyGGvAjKfJ7sqfAMQDV8MBdNEA0slyf
	3PnMAUDlueR1GEGVb56mtGyJKX78PubBYtsZfZaZcgxqvpCSiKI9Vfb3dPXakc8SXeMh0ZkkUlc
	Nqo9IA==
X-Received: by 2002:a05:6102:3f06:b0:5f1:72a7:f879 with SMTP id
 ada2fe7eead31-5f9395bcab9mr235560137.28.1770144867118; Tue, 03 Feb 2026
 10:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mohamed Sallam <sallamx99@gmail.com>
Date: Tue, 3 Feb 2026 20:54:00 +0200
X-Gm-Features: AZwV_Qg0zuNmPc-RqUWYuxa9iWC_QTz_O_laHPZvXVqGcvd4Yt-VLU3RSIMP37o
Message-ID: <CALOnm7APGpVWcx45O78fa4hOCUGDc0-ywGoqicr51YtpxNueLg@mail.gmail.com>
Subject: Potential firmware selection issue with QCNFA765 on ThinkPad P14s Gen 5
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31505-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sallamx99@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5934DDEA5
X-Rspamd-Action: no action

Hi ath11k maintainers,

I'm not very experienced with Linux - I'm an end user who noticed something
strange with my WiFi and wanted to share my findings in case it helps others.

Full disclosure: I used AI tools to help me investigate this issue and
understand the driver behavior. If I'm misunderstanding something fundamental,
please let me know.

WHAT I OBSERVED
===============
I have a Lenovo ThinkPad P14s Gen 5 AMD with a Qualcomm QCNFA765 WiFi card
(PCI ID 17cb:1103, subsystem 17aa:9309). I'm running Arch Linux with kernel
6.12.68-1-lts and firmware package linux-firmware-atheros 20260110-1.

I noticed that channels 149-165 in the 5 GHz band are marked with (no IR),
preventing me from using them. This happens consistently on my system.

WHAT I FOUND
============
While trying to understand why this happens, I discovered that the
linux-firmware package contains two different firmware files:
- Generic: ath11k/WCN6855/hw2.0/amss.bin
- Card-specific: ath11k/WCN6855/hw2.0/nfa765/amss.bin

When I manually create a symlink to use the nfa765 variant instead of the
default, the (no IR) restrictions disappear and all channels work normally.
This suggests the driver might not be selecting the optimal firmware for
this specific card variant.

The AI analysis suggested that:
- The driver looks for firmware at ath11k/<chip>/<hw_rev>/<filename>
- There's a "firmware-name" property that can override this, but it seems
to only work on ARM platforms with device trees, not x86 laptops
- The PCI subsystem ID (17aa:9309) might be available to the driver but
isn't being used to pick different firmware files

I don't know if this is accurate - it's just what the AI told me based on
looking at the driver code. The key point is that the firmware swap fixes
the issue for me.

REPRODUCTION STEPS
==================
On my system, with the default setup:
1. Check channel flags: iw phy | grep -E "5745|5765|5785|5805|5825"
2. Channels 149-165 show (no IR)

After applying the workaround (symlink nfa765 firmware):
1. Same check shows channels without (no IR) restrictions
2. WiFi works on all channels

TECHNICAL DETAILS
=================
Hardware: Lenovo ThinkPad P14s Gen 5 AMD (21ME001MUS)
WiFi: Qualcomm QCNFA765 (WCN6855 hw2.1)
PCI: 17cb:1103, subsystem 17aa:9309 (Lenovo)
Kernel: 6.12.68-1-lts
Firmware: linux-firmware-atheros 20260110-1
Firmware ver: WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Logs from my system:
$ dmesg | grep ath11k
[    2.845632] ath11k_pci 0000:02:00.0: chip_id 0x0 chip_family 0x0
board_id 0xff
[    2.845778] ath11k_pci 0000:02:00.0: fw_version 0x1019B0E1
fw_build_timestamp 2024-12-19
[    2.845789] ath11k_pci 0000:02:00.0: fw_build_id
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
[    2.845806] ath11k_pci 0000:02:00.0: qmi failed to load bdf
[    2.845809] ath11k_pci 0000:02:00.0: qmi failed to load cal data,
fallback to 0xff

$ lspci -vnns 02:00.0
02:00.0 0280: 17cb:1103 (rev 01)
    Subsystem: 17aa:9309
    Kernel driver in use: ath11k_pci

With default firmware:
$ iw phy | grep -E "5745|5765|5785|5805|5825"
* 5745.0 MHz [149] (14.0 dBm) (no IR)
* 5765.0 MHz [153] (14.0 dBm) (no IR)
* 5785.0 MHz [157] (14.0 dBm) (no IR)
* 5805.0 MHz [161] (14.0 dBm) (no IR)
* 5825.0 MHz [165] (14.0 dBm) (no IR)

With nfa765 firmware symlinked:
* 5745.0 MHz [149] (23.0 dBm)
* 5765.0 MHz [153] (23.0 dBm)
* 5785.0 MHz [157] (23.0 dBm)
* 5805.0 MHz [161] (23.0 dBm)
* 5825.0 MHz [165] (23.0 dBm)

MY WORKAROUND
=============
I'm currently using this workaround:
  sudo ln -sf ../hw2.0/nfa765/amss.bin.zst \
      /lib/firmware/ath11k/WCN6855/hw2.1/amss.bin.zst

This fixes the issue for me, but I understand it's a hack, not a proper
solution.

QUESTIONS
=========
1. Is the driver supposed to automatically select card-specific firmware
   based on PCI subsystem ID, or is this working as designed?
2. If it's supposed to work this way, could there be a bug in the firmware
   path selection logic?
3. Is there a better workaround than manually symlinking firmware files?

Thank you for your time and for maintaining this driver. I appreciate
any guidance you can provide, even if it's just to tell me this is
expected behavior and I'm misunderstanding something.

Best regards,
Mohamed Sallam

