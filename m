Return-Path: <linux-wireless+bounces-33174-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4icHOJlas2nEVQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33174-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 01:30:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C5827B98E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 01:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1214305CE12
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 00:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0C9288C96;
	Fri, 13 Mar 2026 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE9U/TkZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549322798EA
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361814; cv=pass; b=BBPsP5lSmflIliZy9h7xFly4uTaKasY12SF/K+dm5/Nri1cEWbMGypv4ZpMGC6+5fyZ5DhF2RItdU4+agD6/wdVelduKUwd5ZKfmAtJXE9D4VyeDMEZKf0sptTkPkayFP5OqXZF92fU5LC1Tmpf3MyGAYPBlYIzf2Etugzzep94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361814; c=relaxed/simple;
	bh=L5vsn+RZ3i/1NpZu/zzIwpdFnGnSQGPz8S/E5XPbWB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VicAEf/wZJ/war6Y7gUzGzxYs/cCS7tJXRrBqEpj0qz6aseYZM0lPXywR6/YLY/4i29QUEzPScIBLLaHSz3zukUGpgc1+2pDSjW8tef1VGwg/o8RjadmQB/M3CkvytrCHi5IamOV3xPB1YIhCtjbhHH1SvKequO3FlYsLlfsgl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE9U/TkZ; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d74a59262fso1509131a34.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773361812; cv=none;
        d=google.com; s=arc-20240605;
        b=cC0VeaRPSXZ2wNX9IsY1qFx8A7PDbqL4VCDnpTyMeKrQDz97oQ6RqgdgcTBkuBgFLe
         Q+xYcK7ky6vpPh8T5v7NIfMIZy340H1dRg1o+w1HNNg6BOh48hhc8G/Ddlaa0G1qH8HC
         rhEp4ualu/wDibSyJ/HRbaoOfdt1G1AHE0E3wLWAqddxGw1he0qWU70yLelmoOCLWms2
         IyEAtOwbZ7sr0HUel+TpIsGGr1yTQFvCwtyfVQlC3FYyssaf8YX0Dfmz30Xt3V6G3zby
         5x69xY0gX+Gfa3f4FIaXN7T2KlcmY8K0psaOujHUMRS8dQDxi98Ontcrc7aO/ZTIrl2C
         R3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L5vsn+RZ3i/1NpZu/zzIwpdFnGnSQGPz8S/E5XPbWB8=;
        fh=fFUQ3bDSnwWYL/1dqZwPKYywXd5TONRsAevI/mvHYbI=;
        b=GKKVH9HyGC77juei8Sff82YEh6+L5FeP2UoZxLQXOJrfyaiGbrAkzWmHt0bZG8Y0mx
         fuHQ/dwZXETBAomBmB4dSN8flj3hGJY1uKCQG/Sdbjna45DypyDTvFRI83jALuVzLqRs
         u+Jf9ndXGeluOc/EJ2DJXNmFJa9wWA9NiE33uxj09ZL/QA9mOqBlS3Eh40uv0oVoZDAf
         ogUGh6ldlXnmIBFCutxiMGAdG5OhN54RtJIOJ8P01dY1ChbEjmu6YDP6HqzmdkiqJG8W
         umQ5DyiOVU8wVKeL0tD1J+/6PSH/uV9e3gRKcFF572g2AMjBpR3SyTYsTT6fvp+H9mFY
         GLIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773361812; x=1773966612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L5vsn+RZ3i/1NpZu/zzIwpdFnGnSQGPz8S/E5XPbWB8=;
        b=nE9U/TkZe3xm7fc917HNr5jv5uKxGDL3wWafwRVjsiaUy6TUoFQkjclGf5Pwi2p6Nq
         C6YlCpCrxR+4xtzgFuRZ/XPFdGQYjprFyMMz4rA2HLTJ2BFLCgeKYe6szcaighUPmVQV
         3ldfaeZJJhGRylLQ1HhfhkTsTTH/qZXzJIa1DmMHa26HGsyZOKsW0k33Pc4mVCooGI/i
         ll7r9m0Vo1Li1R1pD6ika3xkDC4OGsSGBkEFcq1lXb38Ff7lbCZ27GqnBRx1Jyx/gY3Q
         IpvkJYUrWAXzCsIu34uXRntKYq1FKP0rUQDvC0LdU2iiwnmvTypVxaMwfWhwfxecteGm
         ZIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361812; x=1773966612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5vsn+RZ3i/1NpZu/zzIwpdFnGnSQGPz8S/E5XPbWB8=;
        b=m7i27Baa9007hIpT/Hlc+/fh6jiwCrzK6+tCTjeYOL5KYM8ns0mfcCEQIFfIGfnmRM
         pmyCrv6mGmaXZ5VkwhKW0z3dVPYou5xlOEOvOn0qpJL5wzDBYmU5D3l9ZVDGUW92OaHz
         qXJOUCmywF+K3ngv1T/w0QFozm3U1pzwrAIWtsBIijm6fgCVhSBV/pVFuMOQAlyiKoPr
         DjOJBjFqCectIrntVYUr2/ATd4aSo1uAMxiMZ1CpBeRzgb0DLJj5lb6vph7GwV530jx5
         BiQezdbmcQugb2gSvqwqPUzJlJIhuh5/zOTFRth0SbV5VyAgtQy57PJIc58IoSTwVaGG
         EaMg==
X-Gm-Message-State: AOJu0Yz6xoMcbKilfyJTH9ErYxnLShCmYoRixX7t5Wk0TwSYGLO3Qv4F
	mJLEv72BXA5UtsyXoDhoeGiMb3LfOOXdtbIlETlVBepYXnVSegQ/CJzBEfDHU+s9+KVPgkOlcBZ
	JtUrrTb1/QF44zm2OvL+V/Au93MqLUZo=
X-Gm-Gg: ATEYQzxcbTjeXkEHDHfEudJfXq5R/udfKgwNxurpyUs30C+v2KeOwyg9vh1HGc/v1re
	WyB0D8lLN8EDE1v1t1cBKb4ciCtiWN7yLMrduF7/a1d2UkLV2tgmMaCAJ2eDeTjApu6EXoD8sD2
	bj4P+9Y5yHsw2kHvbpcAG/vckI/a5v4nw3iQ9d8Z4ICW8XQBt9s7yL1PSKsvjBnG6WqA5ZA5NFi
	mh3esdxUzxerCI81rnLi8D9RI7OHzDiRvfZtWkECJLkE8OfmQWVK6X3TjiJVxsQphvQoW6pm+T0
	nqYz0ocqN8iARpcnh3NHdqI2
X-Received: by 2002:a05:6830:6f47:b0:7d7:46f5:981e with SMTP id
 46e09a7af769-7d7824cf97emr966574a34.11.1773361812260; Thu, 12 Mar 2026
 17:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <1e96af437fa24674b353ddb530b2d8e7@realtek.com> <CALdGYqQb=Vt0jjqW7k8RGMV1gczL0cg-26cHgCm3MmzBjezGMQ@mail.gmail.com>
 <792645eed36041f0b3df951f1b28a08a@realtek.com> <e6720993c8c14245981432cfa4ae902b@realtek.com>
 <CALdGYqQn8GGXXjZTsL+a5Mfdmw5HRYB2Jyvqq5M5SUwxK9yd_g@mail.gmail.com>
 <CALdGYqQee1sjgdBAPJSyb1gL6ksK4z8Uw_v3ANTnyXE+LXFAiA@mail.gmail.com>
 <458ed80e39734ea99610050140bb31ce@realtek.com> <CALdGYqQykO9ZzO=-+D17R_8LC=Win5nGN6-9zFqChtNEyUzEfg@mail.gmail.com>
 <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
In-Reply-To: <CALdGYqTHz5Pz3uSGLbrVuNMWAXaqniUCuOSQACXUYHSL22ySvw@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Fri, 13 Mar 2026 02:29:35 +0200
X-Gm-Features: AaiRm51MQDg3mHzfXYt8l7N1KSWInH5j6srRGkzTviArzhSTQm0I0YxzGHpNSZw
Message-ID: <CALdGYqQ5K0iuxjjX4TwNLi9Km5O+YL3Y9r6Bwfk9BaiuV3BHPA@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33174-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41C5827B98E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ping-Ke,

I apologize for the rapid follow-up and for being perhaps a bit over-assertive
in my previous email. As I continued to dig into the code, I realized that
some of my interpretations of hardware registers (like REG_RX_PKT_LIMIT)
and kernel serialization might be simplified compared to the real-world
complexities you deal with.

I'd like to reframe my previous notes as "curious observations" that I
stumbled upon while testing, and I'd value your professional take on whether
they are relevant:

1. RX Host-Side Validation:
While searching for the 12KB limit I mentioned, I noticed that in
rtw_pci_rx_napi(), the driver uses the pkt_len field from the descriptor
directly for skb_put_data() without checking it against the host buffer
size (RTK_PCI_RX_BUF_SIZE). Even if the hardware normally clips DMA,
would it be worth adding a host-side guard there as a "hardening" measure
against potentially malformed hardware reports?

2. TX Write Pointer (wp) Fetch:
I noticed that in rtw_pci_tx_write_data(), get_tx_buffer_desc() fetches
the wp outside the irq_lock. I wasn't sure if mac80211 guarantees that
the direct TX path and the background worker threads can never collide on
the same queue, but I thought it was worth mentioning just in case.

3. Memory Barriers:
The wmb() point was more of an architectural observation regarding
PCI best practices for non-x86 platforms. I understand x86 is quite
forgiving here, but I noticed it was a pattern that stood out.

Please treat these as humble suggestions from someone trying to learn
the driver's internals. I didn't mean to imply these were "critical bugs"
without your expert verification.

Thank you for your patience with my technical excitement!

Best regards,
Oleksandr

