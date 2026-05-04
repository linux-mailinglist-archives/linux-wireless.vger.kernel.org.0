Return-Path: <linux-wireless+bounces-35881-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M7hNYDw+Gmr3QIAu9opvQ
	(envelope-from <linux-wireless+bounces-35881-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:16:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2CE4C31B8
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A770230071FD
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 19:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E5131E83A;
	Mon,  4 May 2026 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ9zjSps"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1D3F9F28
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922174; cv=none; b=uSA4FxW149KapNhCtehbpMppEy2+ZKzvBGcqQYsqBhtaZeWpc/cUfgtLJ9VZEm6QWHb5gP3mel2RzzH1sVK1tPLt5nsK04cMl5W2imzXckhe8ETf63Urb0rUa6DJPVXPD8K6cDZGi5kayYaZJHBRgiJllAG8ARAK3RkaICvSH44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922174; c=relaxed/simple;
	bh=IaDde+pHXPN3EVogAF7zM70rUxLaoxxU8H4Ac9DBs94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hB2N4L56QDxEGfsTsUcDdMnhtlTIy3jZgLBFhp4pRDOyZxTxOTJ8RHcdpYVU8nmEVICq8aPqy6n7rmv1LPdUFMJTm9GmipCPPYisPhWM/dVkLilqnX4G/mZz+CpurHSoW6jsaHJo6nhe4NQw0BeHM5qYQe8SkWSTR6C+A8/ch20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ9zjSps; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48374014a77so51746935e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777922172; x=1778526972; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaDde+pHXPN3EVogAF7zM70rUxLaoxxU8H4Ac9DBs94=;
        b=EJ9zjSpsbzXpYteF7iXO3PJDzyoFbK9AouhiDUNtTudXICqubGDdvDvCOZxfPTeUun
         W52w4Gz0oiJiF8GCmdcyMiYMvm1BzU/+L4pFLic1/KCE2elrsvI6HtLYLeUUNMD8tsb7
         /oFqw/dsgWUn4LRzTQehulpAx6t3Sq2Dyyku5DUjzRvcS5D8MZRvoUxS/555gTYMCAgT
         TCyWzf9wLc97VF/QKvgyVtu/DYk5hJAByGxUxkVxLocOz/JaT7RaeA1KZ95cmomvluKE
         ZJ7siEjwbWl+VdF/zn5Sba7POETYJrpH0CbN2J2ZO/HfBv2FV3z1RAr01pJTjPS+0VlZ
         FLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777922172; x=1778526972;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IaDde+pHXPN3EVogAF7zM70rUxLaoxxU8H4Ac9DBs94=;
        b=AeFoaieQ/ID+wltKGnwq3BsNTLRZDiTpblTpIKainYuoO/z2QuPMzcDpSnAuHArq1y
         ITxr4hZqhPoFhmNt4hvTuBzxybs/35qWr3gHgcRMFMWIkV0eJ84XhIMIJr2ASXiZ0Uu1
         4Ii96PWhL3m/PXIDR7egytJuNIZEeP4XRJi8UHha0eN3TLEIEeQ9tljQoeq+X0b7mB+2
         g6hzYk5SYVtqt7zL4zPj0Rn8S+uGoq9i1BNlAaRNpM2hevL4zCpTQYkRADk6+kK9NNSH
         3PkbMEeAD9PzdXcJw3bfdBTyk0BfypwFM8TByyND/43QaxUeofH7VcOOdvQFVD0mH5w0
         GzXg==
X-Gm-Message-State: AOJu0YxTvKp0gw5pzbt+SdQi8rr0TJv23xTpe4QYo0+j923kQAe9iB1l
	nA9PZ61asA//w9i+/byWmNJgpLESKMi4P/BMmYp017MmpmZXEnaVQfk=
X-Gm-Gg: AeBDiesEDsC3UE/i4GBuQXiVNLPw2cir6uPgnOIE02TsUMWMKTSPBDqdhIwvvxEhicS
	E8Ym9eJCVlh2bezHJv++socAQ/HXfuBYgNISHiAnfNlPG4y8mQq8iXEwTOfcQfNxAl4hYF8J8Wk
	GgziH2WUtrgZjE0l7YeFiljNxyj7Wx3uK2rWeJCpc7GYAoEF1zjaiXUCqZAKGKiEcaiPIOx/Q7N
	TFQbmN05yhtnp/DkODk6q95yN9/rydkyz6YOL/4wsKZTU+y7U37gVm4MW0UOCJJNwwEAs4MLElh
	pJaksnMIiRYgiBTlLDMY21o9jb602MspCk1WMHzydfTVck83cCJb6a3X5qSLvxKxMhT1ttC4ygV
	eK6BXa7DdFLAgszbqbBOekWkaS30CUj9GmV08j73/oALGtl6v4ucj3ScO9Vw4Mil8RaEbMwVG2P
	LOADe6br57JBEQSQ==
X-Received: by 2002:a05:600c:35c6:b0:48a:93d2:609b with SMTP id 5b1f17b1804b1-48a9867a95bmr208635275e9.28.1777922171892;
        Mon, 04 May 2026 12:16:11 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4500d172c29sm139679f8f.2.2026.05.04.12.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:16:11 -0700 (PDT)
From: "Tristan Madani <Tristan Madani >>" <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <Tristan Madani ><tristan@talencesecurity.com>>
To: Peter Åstrand <astrand@lysator.liu.se>
Cc: linux-wireless@vger.kernel.org
Subject:
 Re: [PATCH v3 0/3] wifi: wlcore/wl18xx: firmware trust boundary hardening
Date: Mon, 04 May 2026 19:16:10 -0000
Message-ID: <177792217085.3474994.10705574258290709303@talencesecurity.com>
In-Reply-To: <74835891-3336-f0a5-5408-07012c382866@lysator.liu.se>
References: <20260421134952.338301-1-tristmd@gmail.com>
 <74835891-3336-f0a5-5408-07012c382866@lysator.liu.se>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: AB2CE4C31B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_NEEDS_ENCODING(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35881-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:mid]

Hi Peter,

Thanks for the pointer. I took a look at the TI forum thread -- the TSF
instability and kernel oops on debugfs read look like a different class
of issue from what this series addresses. These patches specifically
guard against out-of-bounds access from firmware-supplied index/length
fields (BA link_id, logger buffer size, smart config strings), so they
would not directly help with a TSF read race or firmware timing problem.

That said, the oops trace from the forum post might be worth a separate
look if it is still reproducible on a current kernel.

Thanks,
Best,
Tristan

