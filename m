Return-Path: <linux-wireless+bounces-35796-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2u4HC9sY92nfbwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35796-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 11:43:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E884B511E
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 11:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 380513006F24
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2026 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DED3101CD;
	Sun,  3 May 2026 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMNHnv71"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D1012D1F1
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777801430; cv=pass; b=PizpRobVYdQup7eH8LZTD/vHQQpWKYMsgp3nK9EwHGswTff0MCjcOpx2RRRO/LIie24lQCVk9b3D96vzoClP4VdRXf6Fimm5wj2Hp2rT3uU0e/xLn3yJNvV4vX6WLr0RVKJg4b3KFjungDkbz/+fifsvU0GSf+dIS+PVIDY9sMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777801430; c=relaxed/simple;
	bh=S58LiDZYeD8av5YE0RLUeISTTdxg4Ej4Pc67gLRe674=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SSX2oliLC+RW+eEC3sEMRVhUAKHeqRbqRNwrM4aHHZEd71aUWiG/3t97K1UWZ1eO3hcjg4/6DNXU7a6BBVkxnMplpUoN6caCsB1ocRqaNR56UBSgTw8eJIcm7lzeld3BE9/ZhktQtTvng+2NSaeDpiEufJ8LkJz59HmKuiCZN3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMNHnv71; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c88e5f4aeso1892856c88.0
        for <linux-wireless@vger.kernel.org>; Sun, 03 May 2026 02:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777801428; cv=none;
        d=google.com; s=arc-20240605;
        b=dkrQpqtrKhtiygu3USQ1zP0WUvgp54YkMxBv+twfdeOeY7DkMtQiW5S5JWkH5bicrE
         12eanKYFhm9/NPJ8a52ppecKj03XNuQ4hQuOnSRcnN6345Lg2oJdukzaJTYjO00tTeUX
         BfMo47fx2VTzP2FrVU0QUY6XYKxaXg81tn9VMsQm6CtqyfAOkHgALAouyS+4qIAVimwj
         YmnBvUqCgTch6RhGVzk6LFsHlZ9Ts7DTbfmCYvNUkPmW6JKqPm9/YfQV6VOQxFEDjeTZ
         dLzR1eQLpb2FwQzYMEmwcZvcqVp3GpUgfv8U+24cinNfPQ0g9k9avUfEATceoMd8MPae
         UOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=S58LiDZYeD8av5YE0RLUeISTTdxg4Ej4Pc67gLRe674=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=iqBMe4Z+u1gX23vIAwuWeYX3IsRn0Lj6p11kCZv2xjAsnxM3AV83CfshvpBOQl1hy4
         vHbxW4zDSdOvUaZA4lGevJnQTLTsZQ/9UKMCpksw8qzr1cDPqrV3kZ+7tK3+kUQ6VBEe
         LVIGOlUqGFoUF8J8JSKx6+VruRTDUx/t61v3YQJFeL3y1OXkKiZV4QWKgnqZMRbghc7z
         C3NekOilJY8mOeD/bblCtWTbPdAdilXw/msPnSBYGvoCwJFbDm1QQATLV9QIl2ZMmigX
         mtDcspv+PYJfgL2hwR0b7Rzt1WndYsWM3jSegSHfGJUXCJn9Xu29C/efd0mk2GGuYEO0
         6cIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777801428; x=1778406228; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S58LiDZYeD8av5YE0RLUeISTTdxg4Ej4Pc67gLRe674=;
        b=bMNHnv713W9iNb4RdlmGDhtMNC1RqPqKsxN8eyKoGTIzmEheGUjKXr1IeB7A0qaZY9
         /yhLkiBLX6dGorWFdoUSCFkHCjzPZo5kZw/t1lPHAvp+uZ5iEvhVNTTYVLC7QtsijMMj
         MesfUnb1mueT+ocUME3GJcseEsUnCMvFpiaURBPO+bNs5wGW2DMs9xBzwVgq8p9KCi8q
         vJFjjIJ5xTZY8PqNdxgjAcC88M4PZKYv8qchXxOPGSFlCAh/2wV0CJA9YQpeIqGkXr6/
         m0ah4A41zBdW8CtRvoVG0vy+gbJz8T9wjElDVFDVwg1lz1VrlVFME9suspMZixqpGUHm
         v5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777801428; x=1778406228;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S58LiDZYeD8av5YE0RLUeISTTdxg4Ej4Pc67gLRe674=;
        b=VWeN6u7Tcxpou8OIYTxyEs256bBvrQYht3Jz2jDarYLDIPooLAci3Ugj6RIWknC0Vr
         An40WBLMtche0wLBTCb/E4xDgnrofLb8bsdzvkpkfLFlLQO9KTPQCVTyZOz7dyjIBYh+
         RhNWdRMawGPfYJgu86ED8T6O/IiFKk64ZDxPDRsXlscY4FgVUNsvqxXAQHMjg7jbzHEC
         dgHkMhxJaixl71WqmaSFf9cWKcULb4xTE0aehHin1uqcj1yYR/vJYMV57KVUHMxQk63o
         9bVQF4E/tcDEIkKrr4Chd+TMedbKq+3+EeFdETwPmmXH4PrGuVKVocmBpfSftFU/YLSq
         zt+w==
X-Gm-Message-State: AOJu0YyhjPHls5FAXvmCBWvyJUuDj2GOnNvKiLeo9DdvYuLwPoqGm324
	76x7aqnPiZV7KJosX6TYnD9lnK1hdRvqDswwWbJm0VSK7VcTwPoHLWtuxmKjPOtHkJQcqk4h7Lr
	rYd6qEraBZQM26nKhqK5/9T9U49IZqkRhjvYtRdY=
X-Gm-Gg: AeBDieslny99xa92ccKwWmOSO/trq3FdrzfoHC+4I5HPB7A3oU1Pk1SG6sYMWqELRCb
	Kz2DruHEPw9ASbyL9I4QhU1VTXjMgspG/uVlXyMhJsVqmJlGTgQfsm0dxOJiloqgq9VbxFjJNFy
	JciHwFaHAVoGbrKQEqGLRY3ioJxgjRxhNMBc2kmvIz8WPHmaqqdHq0T+wBKpLiBEsnhgSVhCBUM
	IyI+p1R0LDqCdG3WlYBmSH+G+Lo3AhDyzo3TnDeSA3WFcyAym/RBHcvvdGHfjs/cwRe2CVOxUQP
	Kdz19X2l9yqOBoJ+fVBAuCpeDYbhjnnKFva5dtgY+XDB1n8XcA==
X-Received: by 2002:a05:7022:1e11:b0:12c:839:7462 with SMTP id
 a92af1059eb24-12dfd598ea5mr2436559c88.12.1777801428174; Sun, 03 May 2026
 02:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Malik Belhajji <belhajjimalik1@gmail.com>
Date: Sun, 3 May 2026 11:43:36 +0200
X-Gm-Features: AVHnY4IrEfu0QCGgbm6c3d4gdl8lk_VUfpmRrq8z00T8acMGshIuZZ_58J1ypJ8
Message-ID: <CAB+Ar-G7JXAJTCG4SeJP83hTx8n0ObzVRoW7jcbERj8y1soAAA@mail.gmail.com>
Subject: Bug report on the mt7921e for Linux
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 80E884B511E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-35796-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[belhajjimalik1@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,amdgpu.sg:url]

Hello I am reporting a bug in Linux Kernel 7.1 rc-1 when rebooting at
"Stop job for Wireless service" and Network Service a kernel panics
occurs with "Fatal Exception in Interrupt". And resuming from sleep
this occurs :
$ sudo dmesg | grep -i mt7921 [ 0.000000] Command line:
root=UUID=6a9e638f-42a5-4439-b42f-706d2e3cbf68 rw pcie_aspm=off
mt7921e.disable_aspm=1 [amdgpu.sg](http://amdgpu.sg)_display=0 quiet
splash drm.panic_screen=qr_code
initrd=\09d8cc21236248aa9d49bfef3d6bb139\7.1.0-rc1-1-mainline\initrd [
0.038745] Kernel command line:
root=UUID=6a9e638f-42a5-4439-b42f-706d2e3cbf68 rw pcie_aspm=off
mt7921e.disable_aspm=1 [amdgpu.sg](http://amdgpu.sg)_display=0 quiet
splash drm.panic_screen=qr_code
initrd=\09d8cc21236248aa9d49bfef3d6bb139\7.1.0-rc1-1-mainline\initrd [
12.372208] mt7921_common: unknown parameter 'disable_aspm' ignored [
12.401344] mt7921e 0000:03:00.0: enabling device (0000 -> 0002) [
12.410993] mt7921e 0000:03:00.0: disabling ASPM L1 [ 12.418543]
mt7921e 0000:03:00.0: ASIC revision: 79610010 [ 12.513540] mt7921e
0000:03:00.0: HW/SW Version: 0x8a108a10, Build Time: 20260224110909a [
12.775301] mt7921e 0000:03:00.0: WM Firmware Version: ____010000,
Build Time: 20260224110949 [ 50.403949] mt7921e 0000:03:00.0: Unable
to change power state from D3cold to D0, device inaccessible [
50.409580] mt7921e 0000:03:00.0: disabling ASPM L0s L1 [ 51.444481]
mt7921e 0000:03:00.0: driver own failed [ 51.444528] mt7921e
0000:03:00.0: probe with driver mt7921e failed with error -5 ~ $ sudo
modprobe -r mt7921e ~ $ sudo modprobe mt7921e ~ $ sudo dmesg | grep -i
mt7921 [ 0.000000] Command line:
root=UUID=6a9e638f-42a5-4439-b42f-706d2e3cbf68 rw pcie_aspm=off
mt7921e.disable_aspm=1 [amdgpu.sg](http://amdgpu.sg)_display=0 quiet
splash drm.panic_screen=qr_code
initrd=\09d8cc21236248aa9d49bfef3d6bb139\7.1.0-rc1-1-mainline\initrd [
0.038745] Kernel command line:
root=UUID=6a9e638f-42a5-4439-b42f-706d2e3cbf68 rw pcie_aspm=off
mt7921e.disable_aspm=1 [amdgpu.sg](http://amdgpu.sg)_display=0 quiet
splash drm.panic_screen=qr_code
initrd=\09d8cc21236248aa9d49bfef3d6bb139\7.1.0-rc1-1-mainline\initrd [
12.372208] mt7921_common: unknown parameter 'disable_aspm' ignored [
12.401344] mt7921e 0000:03:00.0: enabling device (0000 -> 0002) [
12.410993] mt7921e 0000:03:00.0: disabling ASPM L1 [ 12.418543]
mt7921e 0000:03:00.0: ASIC revision: 79610010 [ 12.513540] mt7921e
0000:03:00.0: HW/SW Version: 0x8a108a10, Build Time: 20260224110909a [
12.775301] mt7921e 0000:03:00.0: WM Firmware Version: ____010000,
Build Time: 20260224110949 [ 50.403949] mt7921e 0000:03:00.0: Unable
to change power state from D3cold to D0, device inaccessible [
50.409580] mt7921e 0000:03:00.0: disabling ASPM L0s L1 [ 51.444481]
mt7921e 0000:03:00.0: driver own failed [ 51.444528] mt7921e
0000:03:00.0: probe with driver mt7921e failed with error -5 [
94.446687] mt7921_common: unknown parameter 'disable_aspm' ignored [
94.460319] mt7921e 0000:03:00.0: Unable to change power state from
D3cold to D0, device inaccessible [ 94.460516] mt7921e 0000:03:00.0:
disabling ASPM L0s L1 [ 95.486486] mt7921e 0000:03:00.0: driver own
failed [ 95.486533] mt7921e 0000:03:00.0: probe with driver mt7921e
failed with error -5

This happens on older kernels (6.18 and 7.0) and it's annoying that
kernel panics occurs randomly with this card. Specs are ASUS TUF A17
2021 (FA706IC) EndeavourOS (Arch Linux) and dual booting with Windows
(fast startup disabled).
Best regards

