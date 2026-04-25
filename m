Return-Path: <linux-wireless+bounces-35287-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HI3IRcM7GnkTwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35287-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 02:34:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA980464445
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 02:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 680C6300C923
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 00:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD9E1A6813;
	Sat, 25 Apr 2026 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsK/AXOM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2F1F16B
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777077268; cv=none; b=Ti4Ix6YytTCJZ8a4AzMbFbF4ukrQFZ8CLZ2gPLap9VCgMZEzBJR5di98XioN82TcCJLj8A8kjSG7PhAbahkadf9f8n+IrQnSdj53uYNCUnTSCak73NMibvSQmp4uyr6J/LLdp0eV8rbBRxyNXKipgC+AXKUk5716rHpgxZqRTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777077268; c=relaxed/simple;
	bh=x5qSm5xIP+b0YijJnQ3EAn2k382Bn6thPE3QMobbIhA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=du+aCIwsc7GEZdQY3qCp8vjhad5/qImRDjfaPtld5iUt5/ao7bDDf6C9FRCyRBBKVySAi3gAz6+p/QjdJ3fnY0kWdd7YAhC0jHVjmqmuLDsrcyGWY7jqOzT8wqbYF1C9dh/bFtE70ZdO6GhVHyJv74YsvTnai3li47pOmQ6jYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsK/AXOM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2589c26e3so78977275ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 17:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777077267; x=1777682067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x5qSm5xIP+b0YijJnQ3EAn2k382Bn6thPE3QMobbIhA=;
        b=SsK/AXOMPEVxaAF2b+gnvoEYPmzQXnn/j/Nz8vgpKXRMhpau5aBZx89MYQiJjnkfBP
         GDGkmjs7jMN6UBRx3qhlSS9bPWNQwPEu1fPNBh2xPtvD712vRr+dI+kgw8R4SfzmX/rG
         DZ/8KXlsxONuYy/8ml/Z860lMdiwbSKLxkhVYqL9t5dXtAFPDBp74NiQbaFUytY5HLLb
         xj9sI5IxnUciTBVn5AoZzBUReF/Jc8AdO32b+55Cy2h0OCuVLB5aLNMmne57et1XF4Ot
         mhbfbO1WcZGTrN7Fz+TNbZZ+KwOz6rAjJSQkhZmeMdoNTRzjgQBXctM/0pX3QFRY6gt5
         ie1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777077267; x=1777682067;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5qSm5xIP+b0YijJnQ3EAn2k382Bn6thPE3QMobbIhA=;
        b=TSKTHBLlTE7ll0d2ZTJl55M8APYZouAjbEaFGLQ0noCa7QgsxYBjltHNilTPh6qsCI
         JjC95NzvKXfE5TemnLkKSSkdni2qQyCCMgNinEDAI0P13RCZFnSJBSKSgB9H3Mi0UBqW
         2NICiR9zndH2GKdluBa7FWj0FhQTs5uxM5fScjqc+jm/YRci78t8bPXI7NEZIFvQ3pPj
         wPbIzIYOtA4/yL9UcOT1dCJj6fAzfvsAF2xIOuCHGpT7iRz9I489ZwYgFjcLt2pFSttV
         xIk9sIxk0oRHNuxfmhU953034l/e5TLinpAJpUwlfobV3fQr1iwFsRdydje5FcX1GxGo
         xQ2g==
X-Gm-Message-State: AOJu0Ywbpz/DZHfbTRWzG5hxiWuBTGa6JzN+xPeiZR0P0X8aRb+Zitlz
	tWRirVg7mhaVZGC/kQqYWDiZ78v7EDzj1+F4tbWcrl7+lZ7J753UHxb4WHuMnik0DZs=
X-Gm-Gg: AeBDietotU+EnK0XvTToVdgB/1kXui9s+SlCbHLNFKO0SKUcEUddFQJ0uYJFtsvNC01
	DU+ovl84t465cyQv4glW4DKeRDryV/zdUIDSW++D1r90p9Xvey1HiUY3WtIGnSBa7f/EPwss3n9
	gFzUFnod4aYs+JRmXR1/C8d/ehj+Sjl4fID4wgBPQ0FkA+CwdfDz2oZH56hxfBygohoPq6e2WUg
	VOEQDRFBIiM/QJ3X/VvJIFQHdPnz86RHC8cGJLxqoZidZSuz2UKB32P22M5zTzwS9FpyeLtMJvb
	m51espdlDNYWp8f5tPUJDbKOtadOOppRwgbRl/Cq7Qb43WQR3gT9XsN8qK0rOo8IRD2FGqgxp2+
	xxR1wm8ZwdFIfwvz8uTu7HeM1CnysBW0CIE2CRACF7mC1W0fPNyuDjpZQnwjtkkiDJBdUf4Wo3c
	e62xK9J3v6B9VCAJHQ52d349kJZou3SSOgN9o2Qi8A6kM66UuoTZE=
X-Received: by 2002:a17:902:e746:b0:2b2:42da:25c4 with SMTP id d9443c01a7336-2b5f9ef6877mr405510205ad.14.1777077266996;
        Fri, 24 Apr 2026 17:34:26 -0700 (PDT)
Received: from ehlo.thunderbird.net ([203.184.33.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff8d6sm227843465ad.1.2026.04.24.17.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 17:34:26 -0700 (PDT)
Date: Sat, 25 Apr 2026 12:34:20 +1200
From: Brite <brite.airgeddon@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, fjhhz1997@gmail.com, oscar.alfonso.diaz@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_wifi=3A_mac80211=3A_restore_monitor?=
 =?US-ASCII?Q?_injection_when_coexisting_with_another_VIF?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9f7df38831598001ac6cd79ab4fb95b4b6e042fd.camel@sipsolutions.net>
References: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com> <20260424120807.25005-1-brite.airgeddon@gmail.com> (sfid-20260424_140854_559281_CA03D57D) <9f7df38831598001ac6cd79ab4fb95b4b6e042fd.camel@sipsolutions.net>
Message-ID: <D87EEEEF-E514-4A6A-BF15-83EA706EBD86@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DA980464445
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-35287-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briteairgeddon@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On April 25, 2026 1:55:46 AM GMT+12:00, Johannes Berg <johannes@sipsolutio=
ns=2Enet> wrote:
>I don't believe that all this complexity is necessary, and the code
>changes have are fairly clearly LLM-created w/o such disclosures=2E
>Dropping=2E
>
If it helps in any way - just tested your v2 patch which causes VM freeze =
but adding the 5ghz surrogate patch solves the freeze and also the issue wi=
th 5ghz deauth in ap/monitor mode coexistence=2E Tested working on 2=2E4/5g=
hz standalone and 2=2E4/5ghz ap/coexistence mode using ath9k_htc and mt7921=
u=2E Also tested side by side ap/deauth coexistence mode running evil twin =
attack using airgeddon multi instance mode including channel change monitor=
 and no issues at all=2E

Brite

