Return-Path: <linux-wireless+bounces-34876-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD/yBQqj4GkEkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34876-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 10:51:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD12C40BD88
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 10:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75F1B300A129
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623D9392C49;
	Thu, 16 Apr 2026 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfnYWIj+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26AD246BD5
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329295; cv=pass; b=lnXlNjmKwIfCXLSewAICvOerzb3kJg3CQ4eqB/dQDyBb0WL69FD30qPUsAf0wAOS2UEsCfIa4Z9BTZZ6km9ovZqiC4/V1UwNHiYUucWCu3zW6mHZ3DCECVAN2Ymf2HTHdVFfa8HxqwdS/UCSnHKaPJsubkLzACNSgsps6az6pG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329295; c=relaxed/simple;
	bh=+mD6jEvmuyOFXixUU/3LesPcGaCtkozm0ckL4G+AoSY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=n2jdfW/CNoi8i5R00edO6DBuZQ8mWtEJ4REj/WeTgU2yVkQrpHRPu6or27QpH6ho3a2dYsB23xMw7lhVjFmu+K562OhYYBL34zdxiT35ykaGdhpmS7gc7wOMBNEkiGbFEzwuuEm+t/X15/rYGAz59oacwKWFQfx/xgk2phhNWfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfnYWIj+; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so3097729a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 01:48:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776329292; cv=none;
        d=google.com; s=arc-20240605;
        b=Qiigdge/yjEGmqeNxgsJsdVCkqzLHeTlR4CwtX31t3l/K8IKUh1IT20DVOj8b+xRMI
         vWlzha/GQjyi1zYw8ofYcNkl03GxoMrLCRLxEkRm8y4AmYapWSAT1CXqjB+BihQNT7Cj
         Ln21BF4fIh4lcD6YZYqbQs2/lbkkKMVYFodPQxMDOVkuROAqJxssSQpIY01D9tsAPgvv
         sBJH7r09tYWdOQxAQLcC8RCnRcxeZRIt8zj3jE2rNJsyaxmTT1KfQK3/4mTW7E7hSdfi
         0UAo5H179/gXGfC8IBVhNxdRvpsgXhvdGAs2kGvnCYLP8GDM6sXdjLol95fJYQZ6a6CP
         QuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+mD6jEvmuyOFXixUU/3LesPcGaCtkozm0ckL4G+AoSY=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=Ncm2vESgrs8Fk2wVFvRBc0Uu/7VOMxfecogH+r0EHBMhWikLqWVjHg1MaXr1Cbj2zs
         e9RPUG90KgMGkqx1k/UPYDmbGuu3hv+oPRLRfQghQtZcFMtQgOAVoLPIlxqV++d6CpfN
         P9xh+nQfKS+hjFuW1eFijQ/m5FpDp0RGFCZ/ALM5aj8bwBYBec68Pbz6Crq/7tJxgXZA
         xom2BnaAq7x/A9b5tBYYwW6zpdDqOrlA7CQ/NSwYgnUnZqNgtBH2+j5ZsCEJK1mddrgU
         RflJKL23bOa0wMDMJmi/7qvoonjW4sSGiMQBSowFo7Z9DoBuRS/0ET2YCrtRdGLaMtVu
         Zrow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776329292; x=1776934092; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+mD6jEvmuyOFXixUU/3LesPcGaCtkozm0ckL4G+AoSY=;
        b=cfnYWIj+G2qpqdfBe4a/6945Pyy6AM+eqIlL8+/fW96WkSRSbQ1kaEMQZhwWj/xt07
         R7KQIN54Sb9W6qxHPFidzgOgYgW7sdxlrhPps1dzhneGC5lxRAsN+hzcKLIEPGAt/B8+
         3m1Y6RZVHo8nqNmwr/lrlg6j+QBWEXW1is43w+2N/VyjmIwnwKyA52LExL5W+8cuPDZh
         g3DAruHONK4DjwX0E9rcHn+iOuFJ6hhbdYvr/VUWj6nLsgRrlbJWcR6WBJLQcOpc0aXM
         M8LPNdFtQBi2B2c+wWxWRgtF2kk7DTzXDe8V11ZCGvcmRJARQbS7r+kn8aYlvCfqpIiP
         8FvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776329292; x=1776934092;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mD6jEvmuyOFXixUU/3LesPcGaCtkozm0ckL4G+AoSY=;
        b=oANPKHL2h7kgZXzw262z7p18Q9uNU9PpZW7YNWnghoP/7yti3yViY240GkuwzsD75E
         QXRz1Nd03gb2Cz4Xbcr1zJfPRSy8KYMe3MeqbLE4CB/vV4/j4X4moIz5HY3jEZBoWYiE
         AH/UtzwdEF4jgXgCcou/ZDgXjL2FkXwj9EqxAG8WhqIy/0tFNsyGOau3lTSJwuTkoetu
         ne41HewP7i0JQVIs5v5P3URzyKnhdV3uVA9yyy+r31tSYZ31+Bom1CEXpA271krN6b4N
         rji//2CEIU+qJqwbaQR0DNvd8ZZxbZ7jkwZKZO871Tt5+1p5AIeWWH8ihbjbwBx5+zJs
         UyGQ==
X-Gm-Message-State: AOJu0Yya1NPbrEzBxaKahISiMAQjP+PKkbXsDzXE5lftpB66HauLBKJy
	0fJZlnoyN0bg9Fy4MFsZOiyVxYzc5cb+nkbABT4abC5Hmylg/SN1Y172dS8xXNUZ0LYmFzsTVSZ
	HoebajX0cKSo/RNha5Jgtsxasp2SeykoHxgptDRE=
X-Gm-Gg: AeBDieskN3jxgoJayfClIjEk0jfZ6wSwGnFIeUIT+sGL5So7F5uUB+CNcjb7f9Mq+X4
	oGZiGEP0NZJAOL1+j2eVOOPjy3CgfPLRnL+iBGllUPZf9SjXsjAi0Ffywr+pIn53ExHtttQ3tbp
	f7vOQsV1V2bPE7/OlVuk9juCwUHL2mpm9idLPOsaRea1v4L//SSQugPG5GcHNJePS1BexPgEwSJ
	ehn6M2+lc4GFAV4u/4IvmVkmkSfiiwYcKP2QS/z3IWZsERYd5iC7ZGCO9urZVg/cdTlZZ55/Fz9
	C9Abqw6nDbKN7oX/l4s1ig==
X-Received: by 2002:a05:6a20:2455:b0:39b:8dcb:f36d with SMTP id
 adf61e73a8af0-39fe3f1d72fmr26770467637.35.1776329291684; Thu, 16 Apr 2026
 01:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Benson Bear <benson.bear@gmail.com>
Date: Thu, 16 Apr 2026 04:47:59 -0400
X-Gm-Features: AQROBzCzh-AHzKKvF-NtzlHZH2tuQ3QpJGt56_V6LMwx7f1AWgEZz1v8SNmzmBg
Message-ID: <CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
Subject: Wi-Fi speeds degrade from 600Mps to 30Mps while using WPA2 security,
 but not on open network, shortly after ISP firmware upgrade.
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34876-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bensonbear@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD12C40BD88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi folks, I've never posted here before, don't know much about wireless, but
am having a big problem I have been trying to solve for a week. I've been
googling and ai chatting non-stop but finally after reading the info
page about the
list figured it would probably be acceptable to send this message.

BRIEFEST SUMMARY: There was a firmware update in Rogers's (Canada) XB7 Gateway,
and subsequently my Wi-Fi transfer speeds degraded badly on all three
Linux notebooks I have. Fully up to date notebooks, running Fedora 43 and
42 with most recent kernel 6.19.11. Two different NICs: RTL8852BE and Intel
7265 (rev 59). Wired machines and phones are unaffected.

The machines all connect with high transfer rates of around
800-1000Mbs on the 5G band,
with an 80Mhz wide channnel, and MCS level ranging from 7 to 11 (HE and VHT).

Transfer speeds using WPA2 security have dropped in the one case (RTL)
from 600Mbps to
about 30Mbps. (Using internet speed test but iperf3 gives similar). The other
cases are similar.

BUT the transfer using no network security is still what it used to
be! It is simply
the enabling of WPA2 that brings them to their knees.

So it seems to be a problem related to WPA2, and at a lower level in the
stack of modules, since it happens on two different NICs?

I suspected for a long time that it was a firmware bug in the gateway, but
now I am starting to wonder. I have no solid evidence of that except that
Windows works fine on the same gateway and the same machine.

All three machines work well on another network I have occasional access
to, and have worked fine on this network until about a week ago.

I have ordered another router that I hope I can use to solve the
immediate practical problem, but I would really like to figure out
what is going on and contribute what I can to fixing it, even if only
by being sent out to gather potentially useful data.

Thank you.

