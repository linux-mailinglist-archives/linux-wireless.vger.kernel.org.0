Return-Path: <linux-wireless+bounces-35884-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP+eCQUY+WkD5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-35884-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 00:04:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 914C84C4474
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 00:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FF0F3011C7F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 22:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FE37B02B;
	Mon,  4 May 2026 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZMH4F4J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF8372EEF
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932289; cv=pass; b=hbCttMrr8NmA0ESbyTrFagO/fFlsh42jlfsoPsUpmQ/ZEv/vbgIxF2xNoH1xPKCz5a/P+16Silk9Nc5OLvugP/6biWgjVuaFNbAqGhpNGthvOSo1DybAyxibaIv2E/QWmivX2nJdlvTbU+7tmUcCDSlvfQNQmhkybI09Jif20eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932289; c=relaxed/simple;
	bh=E6xt4UQYw7Du/wQ4pFbTxzR+g+1JqUll8WGLYVjjQEg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TPL/0XiiVR802idxkQ+59NtYskarZmmMwTsnBkd59sPqFDYsVSG0YUL5HFXr2cMNDQhKM225Q7UGsLrXCe6oGwqm6zIqdJRTCJFsdacCLxlP7lcpXWO+sSa5WaDwX8SCreiCYPXqf75zeGS/WlP1QaGoomJ5JmUKoq7J8uXfs1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZMH4F4J; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8eb22d4de2fso49409485a.2
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 15:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777932287; cv=none;
        d=google.com; s=arc-20240605;
        b=GosyueFseyVC+o8vTQYEv5b1t8Jn/M7JCKGWbsR43KMb6vc9pXH2qzmg3Ugsm0CC+6
         RUWhJ1k4+HDJmjBeVBBnsuIde63RcYYVRyYvbkD2suT5LKiEMN3yZXqHd7aoSEa8b13B
         LCrm+FM3aTnDJ9qk5FgVWzaXYDei2rgq1WZ4brnFHQ865h+0uLAx63RuuqCQMhSPnTrj
         U9BvKByWiVzd1FvaKfju9LxMcMnk5BUBtmEo/jjLKBzWazz8DfFZuWyrsj4McRDO6Y3k
         unbbpsAqZvhp6gdoiqRRmMxjlK/MgGRvSza7f3Zk0EL4SJY2VcGvTffTNwIiTcLTVnp8
         chQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=D1pMlVjAuoh0c1ODpmfu6E3BfxK+RlrlEBsC5zwkOfU=;
        fh=FD7zqGD3CnYOgM9QznXWVMsxbLALUmUDRpvDzGqYQCU=;
        b=QsrawJCW5oif2mbi3x0ttAQIznIIjTvaJsqECHJiL/BrCdlwI/106O7BUDi/7sOJw9
         fIobPmFFa3wTjzfX6ZXyVyOQRJUFcMDIhwIVwk97CmBOIt44cNAOuPYCai9OoESHsBRd
         Fq5wj5GQQRAM6xAKO5LdIBIU/6Vafn7rFQYUyRgO7jQzmz0ovX25W2pMf6qengy+0ljL
         VK7jpJtEzCQWVRxB8iOe93gt3DCJNZDdx7kM6TFwqbl4WmlQOAvMu867BjtbUGCwwl9A
         QkeMrXw/qEFZkBj/LK/rHv+ZbTr84ayi49FNAqyKiqHKLfAIuCS/hfcjczHEbBWnuq/i
         Kt8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777932287; x=1778537087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D1pMlVjAuoh0c1ODpmfu6E3BfxK+RlrlEBsC5zwkOfU=;
        b=fZMH4F4JLsjHXYr8h9NxfVfz+IYM5rpcIicTh5FA1efLAi/kfPLAdKmr1YWEG3VcTs
         l76J0bdp8xR7RRk0b4fh8GPRSGgbFoQgvqDFzhH29jwezO+rCg9440mnH7z1QgLze+ab
         WnW5nQLQB8CBJjSQIQSVs0HIL20+RTph+3tE8AubnfsHWIR1uoCaAdlCBqiXO5sXCgq+
         vmmLIgiM6QcCgEZegfy4UW/1rzF7UYrIy6l+dzJXFKwGRqulTa8co/PDCmqfnqrHzf7Z
         iTyX8KvmkpNVAXjgTdmb70IwPm84zjIoDZ0qyVayopiQoU6A//kvXwgn5WkIAag7dGgI
         mWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777932287; x=1778537087;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1pMlVjAuoh0c1ODpmfu6E3BfxK+RlrlEBsC5zwkOfU=;
        b=q/V/Og4cP/9NrGtujgOY/X4hquTurLcCguSkBgTMC0EURJ0BfxoIAgMQNAKvxAAtYm
         kxZVknMw6loqnuI0uTXbKoUh1wwScBE2IRi5h+YAhgVHi4dmem33I/VuLsRJljK9mo5Z
         nVFgdRWrRq4/b4gvgsXe6AJ7yPjtqBl4pW2pDAYQetP2ApB0U9a8ona+NUiz3/NMfVOb
         3+YlfJW9dLzxNvZCiMoGsJaiUvcG5x3sUiGQfsDGcXG1JiIwXM3cGYmRI9tf150r9MsF
         lwNEpQNwCPbu8X7t1rbEC/eS+PblKQjoW0WDQ1jx6Eg/qTfjmp2Qmo86uMaEjCuVm297
         XpfA==
X-Gm-Message-State: AOJu0YxXvCaKEG53h+1TYI7wAmG3ljo6bmmQv2zuWfHZHiyRSruq64TW
	0Iu7fFxSY/heoM/h1mkCga67n52QE6vpxQ8R3KTIncFVreyftEdIg2p6XznF6pwE9Si53eau7u3
	vzv0LC9Mo88y7X57CnHPXZ69b/D7VimavQHFzuJA=
X-Gm-Gg: AeBDievYjuCkXrygeu0Z1JNqjFxw3tW2Npu82EFvHjVmAmqa3fgVfVQjhkpvj3CV4Oe
	v2dPrt3/uNEKB+rGbwuGOcnGwgm6G4gTibvXI1WfnBvxQ071mHvoGffLKeA7Wkhe0j0bKk7R7zo
	w9weYx7OYFf3O3vxauuhLWhH6Q/Dr28j3bVTCeUgDoSPMsB8vnL9faknJQwrm284LiZZEVFhgWw
	P/Azflq/NCdKDXVUf5cT8epqY8fY9JJjqGcxE/h8kLiv58mO8J5uwBd6BJIY9wYdzH3Dnm6+Q2Y
	vXbI/zveKD6aJH56XzRT93vFPEYho4NAwA7oFxAVLtgAOi/FnNo=
X-Received: by 2002:a05:620a:44ca:b0:8f3:5b1d:ed86 with SMTP id
 af79cd13be357-8fd18648bc3mr1214849985a.8.1777932286489; Mon, 04 May 2026
 15:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bradley Pizzimenti <brad.pizzimenti@gmail.com>
Date: Mon, 4 May 2026 15:04:35 -0700
X-Gm-Features: AVHnY4KSXlbAshDkF3dl0FZeiXrtvD6YDuqgaRahHXF-UFmtDr0k0S8jcWLVKZU
Message-ID: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=rq5ww@mail.gmail.com>
Subject: [bug report] wifi: mt76: mt7925: iw set txpower fixed accepted but ignored
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 914C84C4474
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35884-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bradpizzimenti@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi there maintainers,

`iw dev <iface> set txpower fixed N` returns success on mt7925 for any
N tested, but the reported txpower never changes from a stuck value of
3.00 dBm. The kernel accepts and ignores the call silently in both
directions (above and below the displayed value), and well below the
regulatory ceiling.

I'm aware there's prior art on the cosmetic 3.00 dBm display issue
(Razvan Grigore's v2 series, Feb 2025; Ming Yen Hsieh's txpower init
refactor, Sept 2025). What seems potentially distinct here is that the
user-issued `iw set txpower fixed N` itself is silently no-op'd,
separate from the reported-value question. Reporting as breadcrumbs
in case the second observation is a separate bug rather than the same
one.

Hardware
--------
MEDIATEK MT7925 [Filogic 360], 802.11be 2x2, PCI 14c3:7925
ASIC revision 0x79250000
Driver in use: mt7925e (in-tree)

Firmware (from dmesg at probe)
------------------------------
mt7925e 0000:01:00.0: HW/SW Version: 0x8a108a10,
                     Build Time: 20260106153007a
mt7925e 0000:01:00.0: WM Firmware Version: ____000000,
                     Build Time: 20260106153120
Files: mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
       mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin

Kernel
------
6.18.18-1-MANJARO (close to vanilla 6.18 stable; not yet tested on
wireless-next or nbd168/wireless HEAD -- happy to retest if needed,
but flagging the data point in case it helps as-is).

Tools: iw version 6.17

Regulatory
----------
$ iw reg get
country US: DFS-FCC
   ...
   (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
   ...

Connection context: 5GHz channel 161 (5805 MHz), 80 MHz, VHT-MCS,
NSS 1. So we are on a band with a 30 dBm regulatory cap.

Observed
--------
$ iw dev wlp1s0 info | grep txpower
        txpower 3.00 dBm

$ sudo iw dev wlp1s0 set txpower fixed 100   # 1 dBm
$ iw dev wlp1s0 info | grep txpower
        txpower 3.00 dBm

$ sudo iw dev wlp1s0 set txpower fixed 1500  # 15 dBm
$ iw dev wlp1s0 info | grep txpower
        txpower 3.00 dBm

$ sudo iw dev wlp1s0 set txpower auto
$ iw dev wlp1s0 info | grep txpower
        txpower 3.00 dBm

All four `set` invocations return exit code 0. The reported value
never moves.

Expected
--------
Either:
  - The reported txpower follows the requested value (or, where
    capped, the actual applied value with extack indicating the
    cap reason), or
  - The set call returns an error rather than silently ignoring the
    request.

Caveats
-------
- Not yet tested on wireless-next or nbd168/wireless HEAD. If a
  reproduction on a current dev tree would be useful, I can do that.
- I have not verified whether the actual radiated TX power changes
  in response to `set txpower fixed`; I am reporting only the
  user-visible behavior.

Thanks,
Bradley

