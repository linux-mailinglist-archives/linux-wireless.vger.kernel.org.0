Return-Path: <linux-wireless+bounces-23772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79040ACF1E3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 16:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D23C189966C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A0A27A454;
	Thu,  5 Jun 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEd8Oia2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C6279798;
	Thu,  5 Jun 2025 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749133480; cv=none; b=l47dzMU+rc4c98axbiQl0AfZYSFYsiTg0Eam67gScuZgWqaLSEn8NBjsGoZ/wlCLnrKhBzqm86UL01sRnC/CVZpzr/TPkYok8VVYWg+KrKs73zBNoJxcbGFmyrJl8lFMBm2z1Ho0Npuf2wZbmFavrONEr5hgvSlyQLm5M97SiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749133480; c=relaxed/simple;
	bh=G6SikWPVN+nNCnuFqQSClA7U+4/eFe6bDbTcXuJR310=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CK1QXUG7+7ZjlJaOqBFzU1M+PAmnKb72m2RXhvNJiZSQIKkZPw/EOfvCPUQ4D9FX9MZFNBycHl2fpbOj5WbaQ5DVV/BnCzqjW53GvoO6RloZwHcAITDwM8IULVa+P2oOPDapCsFAdPmqrcoOCKL0sEgR0iR2bOnKLBRNjdrwZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEd8Oia2; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3292aad800aso10621751fa.0;
        Thu, 05 Jun 2025 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749133476; x=1749738276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWrNnSRHAlUi7PefYVVS1cpe8fmIghTBMM3bYq3hKps=;
        b=cEd8Oia2qD0Nspw5o+kzQZ/FoLC1XWatG02tkDpD6jmP5dSfLpRscBa5NgcRA7ZxZq
         4pAPYwrUY0txOJN+xW5BO8Jq64Gx3Lll7WM1z2LY1srqSCDQWbEB+Af9UGn6RvuDVOkM
         JVYKo5R3l36+dDmTMsYbvzl2JJpr2Hb4zXGHuxPRt/v2ZZMyUsdlOnEq1aIhMUQx3INt
         0txW4kGwznEM2GDZQQmoNbP52F/0UTDz6LTPBhhFkIOZzxioL9v7X7rbCZGG0LS/PoT6
         w2V/HvaYed3ftOziCwMiImVedyTpRoH7QLh3t6aZJ43fpiQNfoKwPU5/Cs76IzfGks/1
         eUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749133476; x=1749738276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWrNnSRHAlUi7PefYVVS1cpe8fmIghTBMM3bYq3hKps=;
        b=Rpifenc3XrkF7OgKHJ3RVWTMxsncl0rHffKEy/Db6jc0TJz3iu3Uh0VHCZ1hbTidUz
         L1EItQH/SQZAGuHMEVAQ7DuuyQ7aiRx3MuOKLDxKnueUWkmkpBeT7ADIBWc41KvODHcg
         ijF/2VhycrAEt/7lf/UY1vjPLoIYJcoxM/zCvoNEc2UZZjEfapV559SoCPSKIST/nunL
         uhfEdl82sBKftmQJ5Cb69pIxC9955Gf6v21K5U5tFjCupbqzcuk+EW2lWK/NxX2SEJME
         r6+OwRQ3830FIHxhs8g3Blp262+d2gSv1o+k2ZXxKS4yWtSwkwwPXZol33asf958ZYg1
         DbHQ==
X-Forwarded-Encrypted: i=1; AJvYcCULN3lZj6lY4hJfndQ3mz9tjrG+DJydtpwFLYvKDFuOCyeo05XwarX+sNbPiiH05kEgg/JSlzDOZpdyEd8pXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LilON8AXW87d7SjCfqhjG4Q/2Q169Oy9HsgTJfWCfx28eZ5q
	9yYbI2eRvvwazEcCYbFPIVCkU8nYKDxcBksG7ITNykkggabS2g5sZ2gY9rfu/GBrIejl7oKhET9
	XubpEWnsbAFNMWqqWW5duDmlBOebPKIA=
X-Gm-Gg: ASbGncvwDWSUXgbYt1POP0LRLH3SJnx8g3IdwnEbdXmeI0ojzaoJOrtxmrk3vepgYZy
	lB6I8Qft75UVL3CDyy5faDFocMedI714RLrMELTz8pKpX2/fOrTyTtnld55zPi2hOCI1sjt/srK
	tKWcybvnFloUy3WBv+iUkPVI+A8uzubSY=
X-Google-Smtp-Source: AGHT+IF9munhCdQhh9vF4PCSa8O8tJPf3Bvk29RZUnUbBLX74gfe2ztpUonEWpTBRmmwr0Wbjg3phl3Pt2xqT08fOtc=
X-Received: by 2002:a05:651c:2211:b0:329:136e:300f with SMTP id
 38308e7fff4ca-32ad131055emr11752111fa.13.1749133475737; Thu, 05 Jun 2025
 07:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADiockAtCnLdN1rWTRuMeyuQisAWRyosG_K64AQSdVr-k7CLug@mail.gmail.com>
 <aED3gmw0xqm_lMRQ@archie.me>
In-Reply-To: <aED3gmw0xqm_lMRQ@archie.me>
From: Alex Davis <alex47794@gmail.com>
Date: Thu, 5 Jun 2025 10:24:24 -0400
X-Gm-Features: AX0GCFswxPLHD_JTUy203jIJcOyB8Cf8muljbOHh7M-YrY30YvXzp56fZAEMJCM
Message-ID: <CADiockCOpPuWxYB6-Rz30vcZhXDFK8ruD9ozDSg5BS4ncmtR8A@mail.gmail.com>
Subject: Re: Latest kernel firmware update breaks intel wifi card.
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Wireless <linux-wireless@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The working version is commit id 3fbaee2; the non-working version is
commit id 167118c

On Wed, Jun 4, 2025 at 9:48=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> [also Cc: iwlwifi folks]
>
> On Wed, Jun 04, 2025 at 05:20:31PM -0400, Alex Davis wrote:
> > I have the following card:
> > 2f:00.0 Network controller: Intel Corporation Wi-Fi 7(802.11be)
> > AX1775*/AX1790*/BE20*/BE401/BE1750* 2x2 (rev 1a)
> >     Subsystem: Intel Corporation BE200 320MHz [Gale Peak]
> >     Flags: bus master, fast devsel, latency 0, IRQ 19, IOMMU group 16
> >     Memory at aa800000 (64-bit, non-prefetchable) [size=3D16K]
> >     Capabilities: [40] Power Management version 3
> >     Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
> >     Capabilities: [70] Express Endpoint, IntMsgNum 0
> >     Capabilities: [b0] MSI-X: Enable+ Count=3D32 Masked-
> >     Capabilities: [100] Advanced Error Reporting
> >     Capabilities: [148] Secondary PCI Express
> >     Capabilities: [158] Physical Layer 16.0 GT/s <?>
> >     Capabilities: [17c] Lane Margining at the Receiver
> >     Capabilities: [188] Latency Tolerance Reporting
> >     Capabilities: [190] L1 PM Substates
> >     Capabilities: [1a0] Vendor Specific Information: ID=3D0002 Rev=3D4 =
Len=3D100 <?>
> >     Capabilities: [2a0] Data Link Feature <?>
> >     Capabilities: [2ac] Precision Time Measurement
> >     Capabilities: [2b8] Vendor Specific Information: ID=3D0003 Rev=3D1 =
Len=3D054 <?>
> >     Capabilities: [500] Vendor Specific Information: ID=3D0023 Rev=3D1 =
Len=3D010 <?>
> >     Kernel driver in use: iwlwifi
> >
> > With the current firmware, I get the following error in dmesg:
> > iwlwifi 0000:2f:00.0: Detected crf-id 0x2001910, cnv-id 0x2001910 wfpm
> > id 0x80000000
> > iwlwifi 0000:2f:00.0: PCI dev 272b/00f4, rev=3D0x472, rfid=3D0x112200
> > iwlwifi 0000:2f:00.0: Detected Intel(R) Wi-Fi 7 BE200 320MHz
> > iwlwifi 0000:2f:00.0: Direct firmware load for
> > iwlwifi-gl-c0-fm-c0-93.ucode failed with error -2
> > iwlwifi 0000:2f:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.182.4.1
> > iwlwifi 0000:2f:00.0: loaded firmware version 92.67ce4588.0
> > gl-c0-fm-c0-92.ucode op_mode iwlmvm
> > iwlwifi 0000:2f:00.0: Detected RF FM, rfid=3D0x112200
> > iwlwifi 0000:2f:00.0: loaded PNVM version 71864399
> > iwlwifi 0000:2f:00.0: Microcode SW error detected. Restarting 0x0.
> > iwlwifi 0000:2f:00.0: Start IWL Error Log Dump:
> > iwlwifi 0000:2f:00.0: Transport status: 0x0000004A, valid: 6
> > iwlwifi 0000:2f:00.0: Loaded firmware version: 92.67ce4588.0
> > gl-c0-fm-c0-92.ucode
> > iwlwifi 0000:2f:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
> > iwlwifi 0000:2f:00.0: 0x000002F0 | trm_hw_status0
> > iwlwifi 0000:2f:00.0: 0x00000000 | trm_hw_status1
> > iwlwifi 0000:2f:00.0: 0x002C43D6 | branchlink2
> > iwlwifi 0000:2f:00.0: 0x002B89BE | interruptlink1
> > iwlwifi 0000:2f:00.0: 0x002B89BE | interruptlink2
> > iwlwifi 0000:2f:00.0: 0x00015ADA | data1
> > iwlwifi 0000:2f:00.0: 0x00000010 | data2
> > iwlwifi 0000:2f:00.0: 0x00000000 | data3
> > iwlwifi 0000:2f:00.0: 0x00000000 | beacon time
> > iwlwifi 0000:2f:00.0: 0x0001A67A | tsf low
> > iwlwifi 0000:2f:00.0: 0x00000000 | tsf hi
> > iwlwifi 0000:2f:00.0: 0x00000000 | time gp1
> > iwlwifi 0000:2f:00.0: 0x00046F7B | time gp2
> > iwlwifi 0000:2f:00.0: 0x00000001 | uCode revision type
> > iwlwifi 0000:2f:00.0: 0x0000005C | uCode version major
> > iwlwifi 0000:2f:00.0: 0x67CE4588 | uCode version minor
> > iwlwifi 0000:2f:00.0: 0x00000472 | hw version
> > iwlwifi 0000:2f:00.0: 0x58C80002 | board version
> > iwlwifi 0000:2f:00.0: 0x800CFD1B | hcmd
> > iwlwifi 0000:2f:00.0: 0x00020000 | isr0
> > iwlwifi 0000:2f:00.0: 0x20000000 | isr1
> > iwlwifi 0000:2f:00.0: 0x48F00002 | isr2
> > iwlwifi 0000:2f:00.0: 0x00C0001C | isr3
> > iwlwifi 0000:2f:00.0: 0x02000000 | isr4
> > iwlwifi 0000:2f:00.0: 0x00000000 | last cmd Id
> > iwlwifi 0000:2f:00.0: 0x00015ADA | wait_event
> > iwlwifi 0000:2f:00.0: 0x10000004 | l2p_control
> > iwlwifi 0000:2f:00.0: 0x00000000 | l2p_duration
> > iwlwifi 0000:2f:00.0: 0x00000000 | l2p_mhvalid
> > iwlwifi 0000:2f:00.0: 0x00000000 | l2p_addr_match
> > iwlwifi 0000:2f:00.0: 0x0000000B | lmpm_pmg_sel
> > iwlwifi 0000:2f:00.0: 0x00000000 | timestamp
> > iwlwifi 0000:2f:00.0: 0x00000024 | flow_handler
> >
> > When I use the file iwlwifi-gl-c0-fm-c0.pnvm from the previous
> > version, it works. I'm running kernel 6.12.30 in Slackware current
>
> What firmware versions?
>
> Confused...
>
> --
> An old man doll... just what I always wanted! - Clara

