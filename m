Return-Path: <linux-wireless+bounces-31319-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHZbJdBOe2n9DgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31319-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 13:13:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB00AFF32
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 13:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BD303018402
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C438551E;
	Thu, 29 Jan 2026 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOl/1opY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0437FF72
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769688781; cv=pass; b=EqzzGXz1u2QRV4tiHpPQompwZbPLiLjFWGytk42sNL0ed7OZ7CTh4y3yWlnaC8d7qi5AeeT+9yPAns0C9monUFlx6ZpxrUz93g0RbkAEjrKBI5XKeBkDuxCR2FF38N7FW42wSeZgSFT7bcZdwPhbCiNKwpJGqugldSEVhNVl854=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769688781; c=relaxed/simple;
	bh=0bZSQgErlRkdrm7dweSYF0IR0kmEDiV0FnrXH+ukaqM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uz51Ea8kXzLZ0L0GCJ4s28aDzB4ALHM9UzHqHk3bIjNJCLHZo4eLHLMOFLbrXHPFbTCvOndy/QZJFgrsiBbWjlIJ64MiD5dSwA5n/zotyLKz8M8coZYLtldPaLqZTMYM8KidfMjD0YteEBx19V9rJRifKxHBzSKAz7OyxJ2TM6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOl/1opY; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45c87d82bd2so580675b6e.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 04:13:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769688779; cv=none;
        d=google.com; s=arc-20240605;
        b=M9pxmmndTwKKaHOguZnjGHJ2zUcVtM/H63hzAnRZlkPrgwb5gVKu1UdBNGKUXbMihr
         7OzvDRJGD/UXf/29K8+agObJiKJShFSzldw4RdJKiNJC13JhntJOyQDd61Z4aPV+GlEk
         czUK+GD9TviO74kEXG39EovxvSxJYCfUgAcUhSG27UPA8xs2XBHbgeCEMPYiAf1bj503
         FKSv6fq4AY9iWEYeF9oToAyjheZr8NC0XfgC6wu6EEkrkHn591SbOg01j85Q1UtuEmLm
         xIa3e80NlNKjZdBqS6mzYgC0p/lW5IpGR1ILBfoqywXAP0r9N3mFgT7wCi7CBewkH0Vl
         5KGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0bZSQgErlRkdrm7dweSYF0IR0kmEDiV0FnrXH+ukaqM=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=O9G+fTY6S7ykvBa6ESrU4C7s5Rmz7Sj3vzpDtJrKNpcOyxOcfpiSvSnz+YSl0VkWYz
         2wSAAI0q9YZNGixbhZh3vZ5EAcXW4UVCd3n7KkPSyhkNTglInd4U8QaPJMud5mmBvYYI
         QZ6Z8NPCw2PdrMN3+kwhM2iZRPaPxBtQ8tEAV9HAaxTY0EEf5btlsiq0H08nHbT+A3aX
         Em/OnHF9csJ/mtkNB3xO7mlQ9FXFGwbQU2aGCxEEJXekMZimOGYRmsi8DbG0K0KRTI46
         evb2wfl8roS2KrgihW2HgPfsKD8ZLfw0uL9oUGStOixj/QwfTVgNHiW1fGRTmOlpMTSX
         gZGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769688779; x=1770293579; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0bZSQgErlRkdrm7dweSYF0IR0kmEDiV0FnrXH+ukaqM=;
        b=YOl/1opYf6II+Cl0Al03UhtaAPhroKsHJxy1NRnqS32xkkTfnf/+G7CPDSUox/+JjR
         puV03HzgoLvLnOrBVrd1GtuQYkaGXIL/ue6Bw0mAGOHl3H11OdcJs7IYuYOrx5/pULbh
         y3Nj531E+9qSSFML72/c9ZAhH0UDq/dsg8fkH8b1dPrMsQS1FWSwcAweST/OLls1/hye
         G2iaMgMl8xYg+WZM56oAytRn/CO8Ab2sITVjtqPz0hTAb6WA8OU2JexARIKQDR/qODRA
         09OdBhGBe8Nu4ht1gdFso3SgrpQtF/T18qlvwCJQe1TO+YqlrIc8mbKVKTiJOstow3mH
         pdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769688779; x=1770293579;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bZSQgErlRkdrm7dweSYF0IR0kmEDiV0FnrXH+ukaqM=;
        b=PfHBxcg92/TDaC32/p2S66sd6dBIAjWcTEHl8CpXTeFLF7V4QM/uGNI0HkbKwfF+lg
         LDjhKbbdaeX7Mu5pliGhiC/jBm9gCdhLVOn54ZmQNFV+Xhm7+GclZST6E3lv6mtURzht
         pq0dcqfks843WrxnOcVdJMO39mh4wLLvBYZoXDwIIRozFkAIJpZmhiONDmM8NP50hPAj
         NfV6CoBHHuFVSpIXxOawK2IBsELXbNkb76JxqofiL68q7HEV+rinAxdEaFxmjSKF7G4t
         UnIVqtvD7e5URhMxTfo5Up9ZaxOEBKnLDYYL+i9CskF2J2AhFb2HU++yWK7GPs8TesDf
         CBbA==
X-Gm-Message-State: AOJu0YyEb9ctqV1H4qZdRcVx5XCiSeiPFnBll7OHTJUqwZxVmrzVSY6s
	MVgTDQJdl0bHZlDwNqxng9xOFxcJwmCjr3Wv9CJDaRvGS9a8leuhlGkwhSJgu36oEZA0L8idm8g
	TgyQ9ITI829sqHCzBcm8zRAGII2WAX6ioAhBZX3U=
X-Gm-Gg: AZuq6aJ4pVxRUiK3XsXPObdiME6S0hpmyP+SlpFixqGEAVd3X7Ij/qmhHzxVuffoYCY
	38YeyEloQanVzI3QbXKAohM6PObGp02zXz59IyyX6wn38UQVMIDbNM+BRT7bSOsntolbBa3rIiI
	WFuoykIUq+SVnZv/MpRRYcxijRD83GIKQcqUF9hwnunn0qvShdeA1lQaHeafUP0PQP+TIDHj6AO
	g8ZBFh5WsNgy8CgOl6l2f0PzxZ34nzriYbwZKnB5f6Vvlco2MKcUN7nnYBuOjs8IURszw==
X-Received: by 2002:a4a:e910:0:b0:663:1f2:3e23 with SMTP id
 006d021491bc7-66301f24201mr1910999eaf.24.1769688779025; Thu, 29 Jan 2026
 04:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Iohann Tachy <iohann.tachy@gmail.com>
Date: Thu, 29 Jan 2026 09:12:46 -0300
X-Gm-Features: AZwV_QgaCqwhkO7A0um8WCOQyFvJhen3kJQQrmmRt0FRjlZrTimRCNxE5YgGdd0
Message-ID: <CAPVS0eKn3zEyRekrQP_K3W5n5iVZ44nXkUAAE2=KkNcpq+LeYg@mail.gmail.com>
Subject: Problems building rtw89
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31319-lists,linux-wireless=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[iohanntachy@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0EB00AFF32
X-Rspamd-Action: no action

Good morning,

Currently there's an issue where it's not possible to build the rtw89 driver.
The RTL8852BE card has a compatibility problem with Intel X99 chipset
and a hacked rtw89 driver is needed to make it work.

I kindly request to read the Github issue:
https://github.com/lwfinger/rtw89/issues/396


Regards,
Iohann

