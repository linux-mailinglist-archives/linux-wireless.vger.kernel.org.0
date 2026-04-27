Return-Path: <linux-wireless+bounces-35364-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBUsF2s372nV+QAAu9opvQ
	(envelope-from <linux-wireless+bounces-35364-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 12:16:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B444470BFC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 12:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9D1303A5F7
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 10:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76263B0ADB;
	Mon, 27 Apr 2026 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY3/3tou"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559DB3B47EF
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284568; cv=pass; b=KbXTH6gtkAwbn/z15jGBDQ05IjryUwv1OGitLEIU1k5lrXs1eQUAjO3q1lO/BxDadsJOW2Ws3da3Hr3dAmYSvrKXzCqZCafe8C17T2OJxy3z7pBKYnJ6y5hEhkBUuQbVQ2WjR+RsVcwr0XpwJL+9vZZ+9y1bBB69EMLEFNvn7Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284568; c=relaxed/simple;
	bh=BpwJ31YoRKb682GNDyymER48bVYgnLpSpxFFPiMShVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qS2eeQFmZ2RqUMfbuCYjFjmvofKn28KouJ7OwBpxqlEmzqinouD4LDVSAzl1uwE1okOoKMi6reuc+MJ/cZIzQ5w18rWpFFvOrcmT1dIyiTxTNXmbj6BkPn1nwLDsRaUgpsncBW8B5UL7tje2xTMNF941ijv98gV2bpfgVC3xeeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY3/3tou; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7de4a9cb8eeso3942610a34.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 03:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777284566; cv=none;
        d=google.com; s=arc-20240605;
        b=PVo5NcjM9LpwHjeVvTGHY0qZDLhp4w5HsGDFrFiNNNNzonlP/pQa9c4bHdapaGwmnG
         6Rz7wFEj+G+FE8Rl016Lrwu4GpZ2tRf1E4zgM9QC9+D0YxSqSypsBt6u9hN/9rO41clh
         Vh0aeMpj6KW0E8nvgo3yr/wUqdw7KczkqpkyKalbnNJjSycLToGwlT2Dp3Y7B47QT2vJ
         XeHkz3Z7Kqr6KrEfCWxNsaMXMkl1AQruN1TiR9MN3fQRlbzXNZqjxpDHbk+cC8tgIGTM
         n8vrFNBB0gtJWpeZnWDpp4U/i1NoJYzgMfYOviLt/mrtOzALmf1jUeAprOCAFeuSeuoC
         AU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BpwJ31YoRKb682GNDyymER48bVYgnLpSpxFFPiMShVI=;
        fh=lH5IVTYY7VEEzLTiMMfzzSoXLLtu9PKhSYt2+YUCw6A=;
        b=ALkA6LrFXFEgx8Vvr02Nxaazck5up83dD3bho712YZTUrtyKLeB8FmYq8344WH1OSf
         vyZzvtbPQZxNi5v5tkH1XUaaWz0Mn+ZCbDloE3gwOrx76b8PaDY7ZyPyWmtv+GJ2hQzG
         tiDH1CybGzZswbOZITt6mXAOZK0mPWs5GR9wTBFUWC1Q2SVdn44H/X5GNGJvRiWw/vkK
         d2oPUfl1I7yI5U8pNmkDNGOAPPP9xdQ34oR+X1Gh/UyY7uhDSXQq97R7gurgDE8LvjE0
         N7FDRGVD08ft09iehZIUR8yCIPTFrz4GvbkjXggyA1KILOzTIjdcVjpuhDHLnUHJIpbR
         HL0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777284566; x=1777889366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BpwJ31YoRKb682GNDyymER48bVYgnLpSpxFFPiMShVI=;
        b=DY3/3touZ2x9cUYCaRa7c3Ow1XjuppvuJggfp2waIMgCPLtR6Z848dVc7OjW2Vmb31
         dysMAXIv+/pF0tfoikoZFzAEldOMfAxqZAOkQt1VcaDJiQ0+2nJRXw+hMt0YJ/7mebbI
         Ur5igkmxJ8b5WuZ0+sdm4wGcz3kTi4C+B773VvYOU9g3j95zSKi0v3dLqKLv7+B9Owsp
         Qfe50F975afpg5vURlVwLsw9kM51Pjttk0mwsWIUbzEXHFvr4fTvUo3oaeWQPJ2LdXVr
         sOAgyxmafq+9Il5UJizOf6TQ1FIusQYc+vL5hXMDdO7+xR4/cEAAbLsbXYAHdHksQhWh
         iaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284566; x=1777889366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpwJ31YoRKb682GNDyymER48bVYgnLpSpxFFPiMShVI=;
        b=tWOqPY7Ui65OVeqhhJMbwwXwpfd7W/11M2sicwxPq/PwGRrmGr5fIiUGTev7vf1VF5
         ZNN1fOsoKCzpUDat5A6h6IjxGDx5ZwAQXNtefZrbh6mH7Z51AhCfK7nVDh55dz3PjYCo
         2Q3R5N1DQ0kxdrt8ydlSIRA9XmdtoyyzkZkxRiZE2Zg9nVGqpLqdmjPY71qWlLExT2/Z
         XZLA78LaQ8nB5Ai6kwfRGj1Y7Haxx3XRkBFrRKfCnkCNBcl0JvLa8XVNCVqfc9KCB5uk
         cVJys1ZEt99FyHxkePFbLaArT3fJJ3RAqM7UruGvL3nhOzPYH7XtXVG4QO3tYtNBzqeN
         I/TQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JY7fHEIia+D0hs1tSb3oyR5xn4n9xT25JIi984yfy/WuDnR+uNMvh22xgvFVvTCxKnofKPdUgnM3yWTXerg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtoosI1A2BHvplw/ypVTjEWbPrX5Ymviom4lDX6sBj8nnyYWb
	Xu0nuvkjffpdIE1RuvxWYhbHwc3yCYtxX3hR/EYFNllv82XFl/jdpC0kImD+5H2fB1ohxYwYWPV
	yfNQ6hKtx37WVjRh0pAiQKopzOpXEhZM=
X-Gm-Gg: AeBDietTeihopH+f4D7J0eQ2MWut67a8xDOc+YnJsoXBAPJWrf4jk+CfZYRv7DE55lV
	1kOfWsfbGw3RmgpRsnUqAHR6KgcZnXcBwGxwkKc3TdTN6oSgp5L5VQlVz5MVbR5m7O3jRiiPzGz
	qcQwFcLkxXOpwdRwy+bhviYZNQUq9Fjl68QjDRzbL/lCUlEd+2cZf1Sxenn4RPL0DkGt0OJ4n7s
	AgRxe4xuoMe5AZKN9QCbRTlxp6cgLB908dP1PRJ8ukvYCJqyD88ONed4lAsrH+tibrMBGLI/Vw+
	Bv42P8PDxLEsPN6jb4w=
X-Received: by 2002:a05:6830:411a:b0:7d7:eab6:fb23 with SMTP id
 46e09a7af769-7dc951fc6admr25734644a34.22.1777284566329; Mon, 27 Apr 2026
 03:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com> <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com> <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
 <5fb2f699626b483b8a0a537960b274f0@realtek.com> <5f9003ca-3bfc-45aa-bf0e-35e9c991629d@gmail.com>
 <faa215f1-ac2c-4072-9603-4baca1d5e07b@gmail.com> <CALdGYqQ+Syz+6weTChA=aXe=DBZSi1c0-7OYhJgkj7ahpR4EUA@mail.gmail.com>
 <CALdGYqSS1WXdqHi1rp+PznVOW9wCF3vDC6qkScUXNV5YHQ=Bjg@mail.gmail.com>
In-Reply-To: <CALdGYqSS1WXdqHi1rp+PznVOW9wCF3vDC6qkScUXNV5YHQ=Bjg@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Mon, 27 Apr 2026 13:08:49 +0300
X-Gm-Features: AVHnY4KPa4dwGAINbK09KKxkGhO5h9cTo-NmBwrNMcg49XZd7LT3ryNtV6jRGXI
Message-ID: <CALdGYqSS_4yrKn73UHR3zfgJN98wjR71V=pn+1C4pvg2UXGHyA@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1B444470BFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35364-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi all,

A quick erratum to my previous email:

I mistakenly wrote that the corrupted descriptor happened to have a
`drv_info_sz` of 24. It actually matched 4 (`PHY_STATUS_SIZE`). Since
`drv_info_sz` is in 8-byte units, this translates to 32 bytes.

The core conclusion remains exactly the same: the hardware randomly
generated a `drv_info_sz` of 4 (or 0) by pure coincidence. This
perfectly bypassed the `pkt_stat->drv_info_sz != PHY_STATUS_SIZE`
check, proving once again that length validation alone isn't
completely bulletproof and Panagiotis's NULL check is still required
as a safety net.

Sorry for the typo!

Best regards,
Oleksandr Havrylov

