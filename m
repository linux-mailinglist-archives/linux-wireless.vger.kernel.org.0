Return-Path: <linux-wireless+bounces-34874-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBAVENCf4GlukQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34874-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 10:37:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFC940BA89
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 10:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 652DC301B8EC
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384B38CFF0;
	Thu, 16 Apr 2026 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcGbp7+T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6678F39
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328652; cv=pass; b=eB1COoxtiJn0R0MfLItbzXI+M2Lz8+ObSUXmJWOCYBefmmQa+iw/LCYLx3CtZopRyJT3HAcb/BvtZUPS9/2dDDielPvZF5CAoPGZfvYrABBO5TzMaga1Ajn2DhF2JjX83GejrP3ql0A2fE+jsu+IfMprTocqqoXrGPrlNEuvL8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328652; c=relaxed/simple;
	bh=odwrunGrUaB0OlhzyNWFIRUSSKD3Z7u6GtC4cX0FT0s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tWf7V8BH3X6g3eF225e22wiJTYSKULPnZKM6f0ysNW5ggAoJybnpXg44/m4p9AN0gKNrd76Lm47g/ZnZ89jVW4fBmefpFLOGZ2wzZxIY4ALBlOiabjc/MAPTuQdtbgMuy2xKgLMU6QlKQtzL6lscp9yXaAFT229XHYgYJd3EWPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcGbp7+T; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c156c4a9efso10397449eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 01:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776328650; cv=none;
        d=google.com; s=arc-20240605;
        b=YBB7vtOoNGvK0TIsNo0LS/PAqsJhGlhQ2Ud22vrDrJYHKZS+Hya9BLZheAQoBwEWN7
         7rNlJney1FULjAzFmRgbfZxQPVY42fy+WtKd2UKWBqJSDP6vNmerW9Y8VBIhVEjbfsip
         2fGKqHUML0bGK69eOWk/MBwghXEfBExd0i7BpA/1HuwNeNoM3hl/jjClyj0kyPNd4An5
         xOUgtjTI5HWasL28kmJI099KRs8gO3qQEyn1oc7YCm45glgT71tuPQxHRoNaHsW1PtiF
         Z9wmwJ9/VSOjt9ycvccWYDFhZpFjFWniHI8ADjbJTs1khk9MZsvxpI/GAnjlQHQN+vIS
         VfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=niJrpeUEqFaIUms760ilKReu25zGDrsGDl3wAsfo6f8=;
        fh=1sgbTkrT8KiWz4bA/xxxOpbC9bFLQxQI71eMqsFE6oM=;
        b=HNNdnRlXJVzIoNb00Eu03aBsCWfkFmMiOIKm+4PQYCS/j840OuapNtfI4AG2vcOffi
         XtSwu5EIPkmKYjHyuTjw9ApCAgH/Pn0NrXAsI57ak1k5FwRh+8HpRoDXjcyg0IvZW2GP
         gvcsMa+qoe740OcRZj+uJeFA+O3C2BYB5NqimK4eZByMpcEv6YximEiMHjgKnDlcI0lX
         sYFl/iGaYa7UVgFKPqsokGrmB+IMp1SP6V/ddVYy6Uda+aUDxzfti1xr/Ud9QiL1RuTf
         HINPxbG+fll+JRVSpAbV2xc8Wrh/AcR0tC/ZdCqqQbo1iB3vluy3vZFbXx2wvzIH7O67
         zEUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776328650; x=1776933450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=niJrpeUEqFaIUms760ilKReu25zGDrsGDl3wAsfo6f8=;
        b=EcGbp7+TbIGF39ilVpcJE5sYX9HgIEcXT56Ri6/OldLmfR3iBiY1T/d3pbxFK4ioBX
         23Ox8QYS/T02SDToDYfQXyZ+EZys0RgXiKfahA5cYPesQNRtCyEyXpjTUVpUEwM0UBjT
         dfkkF5D4v1/vIHXWbHXSTi7h4m2rd9uehSgzhyDtaOup+PAE1XZDo/sMiTGBMeWjk62x
         FzZ6/IFMgqUNR4iytDvrwZiCt0sNKbto0papl1bfhaShvH0GzQzNv30DPR24Ky/LBUN0
         enN4HTXk+WIBFgsAmN+EfN/tG9pZUL0PxQ38rZO/7J0c8UM8aZyR0iRn3JqudkCpZX5q
         iNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776328650; x=1776933450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niJrpeUEqFaIUms760ilKReu25zGDrsGDl3wAsfo6f8=;
        b=GHCwJ64ZgSreO/oA93kIVSmnChnr/8OqqTP7pKXjarrG7URI4K/7+DpCJlRl/ir5EY
         3UaM8fpxBJJ11nvXgzGy2J63/7Mci362OX6i67TMAmMZds45D3VruIf7z431h9miqJpE
         EEpFYN4qtDAKPIJ5iMFmAB/X4fCq/k6vLM576TqYeQMfr8XJZhW0jmQ+kX/kR8bvhbiS
         Y8xn8H4njGCYQ+d/HJivPO8+WAHjs0OqAiQYTkucgZyiAlGc65SImVDBALXZxQExYBO4
         +qEFUeGx37DJt5VZUzPwtw//OLRcPqKrUNqoTXvCW6XH6KQKjNdu9L5VKbnG4y8mFhEN
         my1g==
X-Forwarded-Encrypted: i=1; AFNElJ+zwQrCaW+VnDJIH4V4JiPBAwH3Jt0zpmZBlSvFF3AYixwdRQnio5TxpbSCctEQEwoEbutmDDePMlgu+YLiqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOTcHkTIDJd9TdV7lmL1TXTma3yajLWF1ZCStRFAOd8ImzKnQ
	6RSji3VyPYfOGLxYkuo9I6PvHW8EYy23FIHre2bbbYeTW2dBvq/cyh/RCtZnQzMODJp3Ff6nUE7
	75Y0rBaOHGskUjlY1jNchlcSyQYc6y8k=
X-Gm-Gg: AeBDieuYnyiqqzg+Sopw7Ex0BrxjpZdVM+VlPQmE5LTP2QYJC/z0n3VL8ZrggDrLsr8
	rssZk5gIAHOVPftujga+41gITfWtPGfFDCkGR/ZPBuOteXXiPwTYBzaMYAZnAMcYJe9A5ahippP
	gHeQnZUJU+o94Ny1PyTAbxmY9kCH1C49W0Z/e4uMv+bdp+simG5PrGFEaM1V+Qi9mDieXpQSFOe
	CsMHfMj37TQvbo4x0cw0N+IMISOgMmGWk99LVN6rrKT9hQfzgFIjEv+3lMLQ92s5f43w6sos1tK
	qAmDvjYvsr8WWk6CT67BBVYJWxjECw==
X-Received: by 2002:a05:7300:ed0f:b0:2ba:a2fb:403f with SMTP id
 5a478bee46e88-2d58955d055mr12288054eec.21.1776328650277; Thu, 16 Apr 2026
 01:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sheroz Juraev <goodmartiandev@gmail.com>
Date: Thu, 16 Apr 2026 13:37:18 +0500
X-Gm-Features: AQROBzDoQb0IILDg6KGa5fE_DWshl8rJPN8rQSR6tc82k-mIlH91jQJ-yk5uLgk
Message-ID: <CADPJysx0mCpzh7b=kJC_OsZGvME9inx7EYo0imYwniCFO02FLg@mail.gmail.com>
Subject: RE: [PATCH wireless v2] wifi: iwlwifi: mld: stop TX during firmware restart
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-34874-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[goodmartiandev@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CFC940BA89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Miri,

Thanks for looking into this. Unfortunately I don't have the raw dmesg
logs from the original crash events =E2=80=94 I didn't save them at the tim=
e
and the journal has since rotated past those boots. I do have the
system configuration details and the memory profiling data that led
to the patch. Here's everything I can provide:

=3D=3D Hardware / Firmware =3D=3D

  Machine:    ASUS Zenbook 14 UX3405CA
  CPU:        Intel Core Ultra 9 285H (Arrow Lake), 16 cores
  WiFi:       Intel(R) Wi-Fi 7 BE201 320MHz
  PCI:        0000:00:14.3 [8086:7740] / subsystem [8086:00e4]
  Interface:  wlo1 (renamed from wlan0)
  Firmware:   101.6e695a70.0 bz-b0-fm-c0-c101.ucode, op_mode iwlmld
  Kernel:     6.19.5 (when crashes were occurring)
  OS:         NixOS (rolling release)
  modprobe:   options iwlwifi power_save=3D0
              options iwlmvm power_scheme=3D1

=3D=3D Observed behavior (kernel 6.19.5) =3D=3D

Under sustained Tailscale (WireGuard) UDP traffic + active SSH
sessions over WiFi, the firmware crashed with NMI_INTERRUPT_UNKNOWN
approximately every 10=E2=80=9315 minutes. Each crash triggered
ieee80211_restart_hw().

Two symptoms were observed after each firmware restart:

1) Massive skb memory leak. Memory profiling (/proc/allocinfo)
   showed the following after a single firmware crash cycle:

     10.8 GiB  16546157  net/core/skbuff.c:586  func:kmalloc_reserve
      3.94 GiB  16546144  net/core/skbuff.c:679  func:__alloc_skb

   ~7 GB of skb buffers leaked per crash. The TX path kept
   dequeuing frames from mac80211 and pushing them to the dead
   firmware (iwl_trans_tx() returning -EIO), allocating and
   immediately freeing skbs in a tight loop.

2) System freeze when TSO was enabled. With TSO/GSO active on
   wlo1, the crash path through iwl_mld_tx_from_txq =E2=86=92
   iwl_mld_tx_skb =E2=86=92 iwl_tx_tso_segment =E2=86=92 skb_segment =E2=86=
=92
   skb_release_head_state caused an RCU stall =E2=86=92 complete system
   freeze. Disabling TSO/GSO via ethtool prevented the deadlock
   but not the skb leak.

=3D=3D Workarounds applied =3D=3D

  - ethtool -K wlo1 tso off gso off  (prevents system freeze)
  - systemd watchdog service monitoring journalctl for
    "iwlwifi.*restart completed", then rmmod/modprobe cycle
    to reclaim leaked skb memory
  - net.core.wmem_max / rmem_max capped at 2MB (limits per-crash
    memory consumption)

=3D=3D Current status (kernel 6.19.11, linux-firmware 20260309) =3D=3D

On the current firmware (linux-firmware-20260309, same ucode
version string 101.6e695a70.0), the NMI_INTERRUPT_UNKNOWN crashes
have stopped entirely. I ran heavy SSH + Tailscale traffic for
10+ minutes with TSO re-enabled and no firmware crash occurred.

I checked the kernel changelogs: there are zero iwlwifi changes
between 6.19.6 and 6.19.11, so the stability improvement is most
likely from the firmware package update (the linux-firmware
snapshot changed between my 6.19.5 system and the current one).

=3D=3D Why the patch is still needed =3D=3D

Even if the specific NMI_INTERRUPT_UNKNOWN trigger has been fixed
in newer firmware, the code path is still unguarded:
iwl_mld_tx_from_txq() does not check mld->fw_status.in_hw_restart
before dequeuing. Any future firmware crash under load would hit
the same skb churn / memory leak. The RX path and TXQ allocation
worker already have this guard =E2=80=94 the TX dequeue path is the only
one missing it.

Let me know if there's anything else I can provide, or if you'd
like me to try reproducing on an older firmware version.

Thanks,
Sheroz

