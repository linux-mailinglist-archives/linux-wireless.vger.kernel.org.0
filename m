Return-Path: <linux-wireless+bounces-34971-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFG1Jmau5GnLYAEAu9opvQ
	(envelope-from <linux-wireless+bounces-34971-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 12:28:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10577423AC8
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2FE6300B55D
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Apr 2026 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE0632939C;
	Sun, 19 Apr 2026 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaDc8OZW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF226B742
	for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776594530; cv=pass; b=RzOdfNFJwblcGZL05BiFZOoj1eFOvlCC9hSHaEQ07S1RhAqWBY225H9Ceb0yswoBQ8OsSGbKNIK439UMpkxNhVmyZjZ6gWNHxVV4Z68P2EgV2rmsU/TZrPss/G6rq0bW/4iQp0NZPCHRKQUjpIyA6mkBADGIhBqTsoEAsL6TOZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776594530; c=relaxed/simple;
	bh=zY9mt3qI59qd05j+vxYkZ9HvCS2wYLsshMe4Z6hnmNA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BYYE1VEusBNcUdK3HGZwVxskmGMCt0aOrO1v2Mq7G3oOYLV5bifwqOnsp5Qr4RYJhrojvy9j6pfoQUIQDp2shFbMMiyQ/tPjZDXZjj/UPq8rVh8o2YvGGZHpBIWCzBh6ecN5qcJQs4NQGU9RzUxD8p6zjW+XcZRBjQLUG1diOsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaDc8OZW; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65318dafbcbso1737944d50.2
        for <linux-wireless@vger.kernel.org>; Sun, 19 Apr 2026 03:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776594528; cv=none;
        d=google.com; s=arc-20240605;
        b=BGcJ/XDSQw5kjiJuwJUM4fIX7NMWWPbALGW16lIJ7/2TtoepCq9wI7/NubNmgMWvKe
         4s5j+simHThwCN2mQFOeYUve01F/YhHnPIZ8o0hw6qDm1CstZFvgQFRCXBTXucExvH/d
         3axNVexRAEw9dDKSh8izbjUYcwGfCzuaRFTwNDAtTHD0gmm7BKtaC/yuvz3ScePWUzpt
         BMxWbq6/9CoMrKXvKB9TL1cn1LWoTFRaPKvx6nJP2Es+hK4jbAzw+m/Q2h+prD9a72mR
         kg8IFnGv7GzSyYN19VVPKbgzpW/PlZAlOBcjMMQuCyxmz91dIbO1Cs6lYhp+ovEyg7fL
         gEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=b/DD4soCOVV1+0nCfBRBj0QLYGUGuUh1dnkGDgO1jDQ=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=NDV/rYiCxMmb6Xg4ILh4E3gN4SXQwC+0d9WF3S+APsnZddImzMOXtifzqVbtU2WDpA
         27muUZuz5wp1MSkHv1kfD+HStXeynXWC3RTOFWIiSRIXh6zzXaUeo3FmWNYcJh1/mjt6
         OlYA4VcPfQ7iLSchkFpVNrEEp13AnVe/6LvedGojkmmg8HaCExNkFxOOQFjQ8DirL/al
         mM3cxDz1NNDBZAv71s+Azuo0R9Ag173Cq5hhWqRoVb1tBG1xXxabzpHIVd82SeyIc0Mp
         pdU/+mS+riroOsFBero1lw2kQnqh1/IA/X3q+nQV5u4Ar09k+8iuGT1rd81JMFjeExDv
         0WEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776594528; x=1777199328; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b/DD4soCOVV1+0nCfBRBj0QLYGUGuUh1dnkGDgO1jDQ=;
        b=PaDc8OZWRwWqR5jVYlOO4B0MyvGdvWVTKsVMp7XdOQZ+RuFbb4TmYx+Zo7eNKNTjHd
         cHrc3HBLI0fgKG8B88ljQwFyJfldZ1BCPB8cBIj+tjbyKIPt8WPQqNPBonBDOC8IBbaI
         Zn1UvthmNE7lo8BWc3VWtm0oBFgYXqlKZtAy7zaMBLJZUXsYCoMM19aQ4ycwU01Eb+Zt
         CJr14qaqXGaDoPeDv7X+O9haecdCsdokaN1J51S2FVh5n3ga7Re+Fk7GdFqXEc/UcaQK
         KXID0xjblTj5jOth+UQKI7pen1F0KgI4Iau4SQMBcY29GiPJhTupu/gMcnxHrhTeuDyy
         XW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776594528; x=1777199328;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/DD4soCOVV1+0nCfBRBj0QLYGUGuUh1dnkGDgO1jDQ=;
        b=R7ipSgIRZomUPM4q52V5RiOJgmzsXwDNyR8eyftVvenwKpbaBKdSV2uxELZwJJi1VN
         ID1Lj8j4CyxsyiIevA2ht7jU6+X613m4Hwhumd22eCOquiBLufFCmABSFGgyujZc0aWI
         Na/11KGe5oxQMfA384IkvgmDOU4eUrKVh0vafXyBJuEN7jEUTijKv6KvlXUE5M3Xn6H4
         ncYDcPrCdY0TgzfPnvd6uijVSqofOXndJeEUG+scrKP03dsGiBE4yngo0W9PhkC8cPmN
         gw7ZHQQZTLHwY9OQrBcKsuzpd6N5d3tT7AzWk/5hYWqcepVznukM5tfhZZQYVKPelkIv
         7XkQ==
X-Gm-Message-State: AOJu0YwU4qCrNR8Xd7y5eR2TaA+tV7Y8sU44rQPEc/zx2hlcWixOAW0X
	+DC/xfcKeTEl4dNy7PfvAMfEyJq2hBKvF4JwmbrqbeHcziyMEA/d1LD8bHM5EZGuObNI0qIDFz+
	lHDft1BR/SJQeYk5zOA+WPCkMWc0QC6glVd+jN1Cbkw==
X-Gm-Gg: AeBDieu5G/e3QZ/tX+WRmntPqdF5eXFCN+M4rT4JkAO5R8gzHR2OmU/QcAXy23i1Jjs
	AxOu87+qzwjsQM+I1MJ+s+GDuSvEfTtWL2EhqtX2tW8DV9gmiphWjbhVEABMZxH/HngxxOG3uXZ
	BIHM7Q7GJTpBPLwUT8E2zvjxZR7+4ope+q86R57GJoxZlqi1ilTk1ec55C/649lqcGpoL9B7J/O
	IOWubbV9AwG5iufyOsIDKySsPRUtPaNimhhd6ju87pbgceJUNluk02xGNuYBrgie9NDu3aVnSQk
	LTXSYBvD/wU+tQBUZ1Dhn/242Eb3JTqA4bPMBquM8oeIWlrYZEs=
X-Received: by 2002:a53:d059:0:20b0:651:8d11:a585 with SMTP id
 956f58d0204a3-6531085e5eamr6944261d50.25.1776594528454; Sun, 19 Apr 2026
 03:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ioannis Barkas <jnyb.de@gmail.com>
Date: Sun, 19 Apr 2026 13:28:37 +0300
X-Gm-Features: AQROBzBsPLMbe6YsClxANtzqX9GbOY-noN0-NfDkfv0cdeD-TocbJgkB6bbMW7s
Message-ID: <CADUzMVb+JNEcpizCBCho+qCMPG1fzNfJ10Nh78=N7-vvao8Ogw@mail.gmail.com>
Subject: Garfield Peak 4 trouble on TigerLake
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-34971-lists,linux-wireless=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[jnybde@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10577423AC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, all!

Replacement of a WLAN module at an i7 based TigerLake device resulted
in AX1690i not working under 6.19 or 7.0 kernel.

I get the following:
[    4.461487] iwlwifi 0000:00:14.3: Detected crf-id 0x11219, cnv-id
0x20000302 wfpm id 0x80000000
[    4.461511] iwlwifi 0000:00:14.3: PCI dev a0f0/1692, rev=0x351,
rfid=0x3010d000
[    4.461515] iwlwifi 0000:00:14.3: Detected Killer(R) Wi-Fi 6E
AX1690i 160MHz Wireless Network Adapter (411NGW)
[    4.461910] iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-QuZ-a0-gf4-a0-77.ucode failed with error -2
[    4.461917] iwlwifi 0000:00:14.3: no suitable firmware found!
[    4.463035] iwlwifi 0000:00:14.3: iwlwifi-QuZ-a0-gf4-a0-77 is required

Not sure if this is a valid file but I could not locate it. Is this
expected? Also Bluetooth goes nuts.

Best regards,
Ioannis

