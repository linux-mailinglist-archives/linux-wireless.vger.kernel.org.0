Return-Path: <linux-wireless+bounces-26037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE3B1425E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jul 2025 21:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C0E3BF2B2
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jul 2025 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1480F277CA3;
	Mon, 28 Jul 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1DmdMN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A382777FD
	for <linux-wireless@vger.kernel.org>; Mon, 28 Jul 2025 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729514; cv=none; b=kw0JfUvDLqoSVGTLg6CkVtMGyBliMwUcvfjVlUxM4iiXbM8FAf/Sgv+YguQGFu9HJxlx0RHwncIReijgnBL4mbs08Jfn/uQgEvRVW7KrBuABBXKkIdyqZoM2Dpt/9LiLXRAdFKdCEkDB/KAG04gHyR/ThHlW0kTKrSLhngKJsg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729514; c=relaxed/simple;
	bh=mzZYSGr95bf2Sl3OEtTgAMiRfiXM2zn1dBg/mFIoGlc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hNnes+LudYxogs2logKnP+4WgNmIM2a8nnfohtnxbrHPfThQ/v7IO+HaHhudWSj2YgHh8nlKTytW8ZESz4l7RCWWFwQoDoHpaD7yA97ykNLPedj3acbD5cOpJHNHEWNy4bM8Yt1+uBUXLgRWi4yBCPOoeOQIRQmlGbFWFofIfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1DmdMN4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso4494285a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Jul 2025 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753729512; x=1754334312; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f11K8Qimep45fc8PedwozctcjqT7mnaY4hn70LLLXDc=;
        b=E1DmdMN4klD6hZfHG71vLPF7G7TtWYA6HoMNK4vIDIFhYSBoMeRP2to+jqpnZnSQA6
         wL6zel1L3ug6qFaMJCIQfBYcc8XSkkdbQHiMJP3PSiKC+eP6M591E+0zvyX637W/2mXf
         VCUNidrjvZ9yMegDgYX5XNW3StnjNzG+yZFtTt4eZq5D0WMXm9eA4/sWsfZPqH7ekTkg
         zNMnicORpfYxd4k/bTQuizpP7cxfBm3uyU/D+p8VnYOVRuT5nOTM658pGiHJIaw61mm7
         AvnaQrRJtw4yfF9tZDPJmgsH3/NkQAcB2gwsvV4IW1lg5vGCuXqA33W5NsNDv0EYoO3l
         xdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753729512; x=1754334312;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f11K8Qimep45fc8PedwozctcjqT7mnaY4hn70LLLXDc=;
        b=uEOnRg4JRNr8P1C9AAzLEe4FSHrc4IJ3ICbGhA6BrRuGBtYwAdFTE/iOSFNIM3rmY6
         AJvnyUTKJWYXeu1lrDWn9waIqc8BlT24MRy0WFej/eHPQ8CFMYeRe9FxOOT3FxU1Npir
         OgjlwPGxqUDwHJ8Ap7/XhOECVPlkHuondSlXZp9V8UJXY+ZoDOTtvbgX7svPfDCESBY4
         kNB46i/gHWrptFwF7NHvRN+d24bvf+UkEk5xSn4sSmo4oiQM85U3bQEu1k+UFNPVqzc3
         Z1fomp2PyW3PQcHxH9VF06t1sCG8WB1yL6Ujfx3qlWdFvMtgPcA/rCHm95OI9UCwyYZ0
         yb3g==
X-Gm-Message-State: AOJu0Yy6q4Ptt8/NMGr/L5S+u866+HjRuOMfob0VG8GEPjVQW4TJvkVC
	DoQPun+PGy1XoGQdbkO11zsaCBdqQsIrjOnOkuOEXyT+TrN3uoeHzKM9N+yE1X8kk5bm+acAqJc
	3j6xugFBfjIpMwmimFcNY0+YsIr9wJHkGrUrp5gk=
X-Gm-Gg: ASbGncvOzmEfIWPit3sG052Z8CqO9uPt6ljMIZzxXm+KBEN8RXUpmtSSGC2oMs4qlaW
	VpJf76LFbymrAEV1poeRslWtcqhyACuCg0jYRJJ+fzh0uq1+IDof7k4wanC+iWNvbKnrSgPrJr8
	Irt7N+wJ6KEg2gEDoqlgyB+2lk/tQ+qxDIJduJj0HJFwovVUXy5hLXnXdkb3LnveAjFcBH3+DtW
	4wC/doQw2noZzP9cTLnWkg8ebp+8ix9WTLtOs2cqabgVf/JlA==
X-Google-Smtp-Source: AGHT+IEgrG/2aI+SJHUNOHjI2C6KDz7PLeSP9BvMrpBK8NAeVG+3FHupAl6+4Yk+oCrmxVmLugKgotO4L6chKiRVHL8=
X-Received: by 2002:a17:90b:4b8e:b0:311:ad7f:329c with SMTP id
 98e67ed59e1d1-31e778f7dcemr21057267a91.18.1753729511482; Mon, 28 Jul 2025
 12:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abdullah Aksoy <abdulksyy66@gmail.com>
Date: Mon, 28 Jul 2025 22:04:58 +0300
X-Gm-Features: Ac12FXzFFh1G3q__5UJLYBFdnrPzzMZrTcVWtC3TAQu9ZZvWE-UMAbaX5PV-wtk
Message-ID: <CACF+uw-S1n3hV3M8tJ=DjW8XuAHbg=X7EsRe5s+Mh+L-ZwZPdw@mail.gmail.com>
Subject: [BUG] mt7921u: TX path stalls and page_pool errors during VIF
 concurrency (STA + Monitor)
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I have been debugging a persistent issue with the mt7921u driver on a
6.16.0-rc6 kernel. The driver becomes unstable when a monitor mode
interface is used concurrently with a managed (STA) interface.

Hardware: MediaTek MT7921U (USB ID: 0e8d:7961)

Symptoms:

    When a monitor interface is created while a managed interface is
associated, the driver enters a stalled state.

    dmesg is flooded with page_pool_release_retry() stalled pool
shutdown messages.

    Logs also show timed out waiting for pending tx and wlan0: failed
to remove key (...) from hardware (-19) upon resume from suspend,
indicating a firmware communication failure.

    A deauthentication tool named 'Auth DoS' reports an impossibly
high packet rate (e.g., >300,000 pkts/sec) but has no actual effect on
the target, confirming the TX path is stalled.

Diagnosis:
The core issue seems to be a state management conflict. The TX stall
symptom that occurs in the concurrent (STA + Monitor) scenario is
identical to the symptom that occurs in a standalone monitor mode
scenario if the driver is not patched for raw packet injection.

This suggests that when the STA interface is active, its state
configuration interferes with or overwrites the necessary hardware
settings for the monitor interface's raw packet injection path (e.g.,
WCID configuration, disabling hardware offloads).

Patches Applied:
We have successfully developed several patches that solve preliminary issues:

    A patch to mt7921_set_tx_sar_pwr to correctly set TX power.

    A patch to mt7921_usb_sdio_tx_prepare_skb to handle raw packet
injection in standalone monitor mode.

    A patch to mt7921_add_interface to assign a dedicated omac_idx to
the monitor VIF.

While these patches fix issues in isolation, they are not enough to
prevent the TX stall in the concurrent VIF scenario. The issue appears
to be deeper in the driver's state management logic when multiple BSS
contexts are active.

Could the developers please look into this? This bug severely impacts
the usability of the mt7921u chipset for security research and
advanced networking tasks.

Thank you.

