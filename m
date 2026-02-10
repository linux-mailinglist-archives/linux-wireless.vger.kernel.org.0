Return-Path: <linux-wireless+bounces-31676-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIY6BwSUimlvMAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31676-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:12:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0051162F4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED5C2300B59D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 02:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02352C3261;
	Tue, 10 Feb 2026 02:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMAXEWa9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8E2C1589
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689535; cv=none; b=I/ENF9sm0HhW7oSKj2g3jp5VJQ05hLWH6vkAgPkuMy1mAtilkG4Mdxl8be/dz3m2u8I4dLdp5AxzuAB37lHCF8zVl3lYuUZ/Av8c70+JNlsiZFuuvWtBzd/2ZbI8oQ2mx3Oh/AikiAMTg8ViyCU6cxfUbnMMNY8s6pcyrKD9vqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689535; c=relaxed/simple;
	bh=g73yWlQbXm8MvqWYeDVKPBAZE+NoaQGme72IjoD6wg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pw22NJC2zYTK43cT5beXiOiFOPq66NJtdzgmrVhPKgMeZxWWgSKq66whWz+OARd+UUrpf42zwnSB2X/SzMmQXKFZi9RQnnBb71mVN20RcW2f7D7wRFXXupGihEbkcTKhy1m/ee0XFMpBNfcO9gHXs9r4qjfrpn3MffLwFI8ORdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMAXEWa9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8954a050c19so32842216d6.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 18:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770689534; x=1771294334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgV1JaYKP5qoidYVClUbj04Uc6QjnqpFw08clZ3TjPs=;
        b=NMAXEWa9ikxvaZ2eIV8dTO3zFKYR7ZQ4r2g6zPX2lixG9ylvjLlTH1BxktZmuZq6Ca
         E0uk2loYIuRpFjLX33/VtNg0GTThd8tb7lQy0aV88z7t9IuEGwDWKsccqaNB+emFsy9b
         ggjToeZ4P8XSvvM+MnprMrPNLh9wT6pA59iuP0vS1/UEZeV9o8w+r/bq8ISVqcKvTblH
         fFmYGmEXZEXfMfmczp+hKlzkX78AvoEkl0KvWJxKROsf2BRP9Rn3jyjeJQZuqE/ymrOP
         ogotKKp8Bf3WqH/zcTE9yLkIzrHnwjJpOysN0MhLgO0grW9KAU6xcAzU7T1DJygxgg7p
         necA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770689534; x=1771294334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgV1JaYKP5qoidYVClUbj04Uc6QjnqpFw08clZ3TjPs=;
        b=aGfi7Eh0/Ldo1LvA7HIq97y6/YIdeUBNHeszx+0m454umqZlbq3yooXhdY2/gxi0hr
         10/D7eY0AzilHUIooCMfzqwyGWi9ZvjCqdy6uAfxo7PJzURZy30ksNcpxzdCpn9I34Cc
         g7yQV+lWKXytUWyAcayrFxe5Q6HFMG6F3wLznZfQZ2CNAeJ8W6+Czudg0yXhPtceHWRk
         wCxD5M8FFXMIUoLmrjnlvZpmKLMg+Ro+pgAOPD8ddaCmWxr8oysAr7AM53sjhN1SRSRj
         5jfktPWTI6UGRkXbQ4B8omQy1NmWJToRWSlXwpHYjkqgJfqaj9+JJuxltF4t+a3W8JLZ
         sz9w==
X-Forwarded-Encrypted: i=1; AJvYcCWXKsX3Sj3/xiCq//oCOTkxGP8IoQknuHZvnUbijX4KnOTU8YhvCve1Ie9Nn6hejMO5MPZbkrAGLTO++njruQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzINg3ao1bqetEyiwt9iuY1UTWoXU7UoBikirL5dzCITzzffYf+
	gl+/dysp0/EixcyEbMehv+6Nau0x2BP8S775JA7YhHR1HGNqqgu3e12i
X-Gm-Gg: AZuq6aLRuMPHoBPrgAwp+HtMXtKsSMxMPps98r0ZakNO+28yZeOQ1c2zct74lp4rjql
	KhvAz8Ht5za6Q+6gXakmfTowlXcdkGfB2XgOlrlhiD0xNObGIRxQUFc+75VtdrH7EcEqMVdljjh
	1Cr8zB4zhDAjP/vpd1sfAr8sPOZ1nnyshtv3hii4RsEqa2GkfZLuQ/2d3KxCQKSMMgDzJEHOf7S
	OEjB40xDcrnVT7c63txt58ekpHFNq/NdLfERYcSPI0zeyo8+n8b25JthO0A8b50K+500eL+dqvL
	pgUpxumbzOF2ZXO4TpY7QZvQtOC0pw+or8yQtp2l6NT6SUT9mDO3Rcsn/ug17ITWylMzf/Lh4fG
	s4e5F7JtZ1apnxpVovBVsuMPDqcDRidJCc741o9WigIRwbKxa+7l/R4O0MX1XMBvDL6wKTIT/OQ
	Im6MM8PRylKo09j8O6wKyAQY6W7jjU4QFs9Wr2FcAm3/S99m1Boou2rmMN6Vt+E8eXZ4FBDhT+q
	gHUGxMWsX1CYXU=
X-Received: by 2002:ac8:7fd4:0:b0:4ef:d04e:565 with SMTP id d75a77b69052e-50673d6f048mr5993101cf.56.1770689533566;
        Mon, 09 Feb 2026 18:12:13 -0800 (PST)
Received: from localhost (bras-base-toroon21-grc-75-184-144-58-243.dsl.bell.ca. [184.144.58.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee8593sm928410085a.36.2026.02.09.18.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:12:13 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Michal Kazior <michal.kazior@tieto.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [RFC PATCH 0/2] ath10k wifi fixes
Date: Mon,  9 Feb 2026 21:12:47 -0500
Message-ID: <20260210021249.12132-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31676-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailingradian@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF0051162F4
X-Rspamd-Action: no action

These are WiFi fixes that seem to be helpful on SDM670. There is no
ath10k support for SDM670, but some similar SoCs also need these fixes.
This is RFC because there could be better solutions.

On SDM670 with patches, the MPDU has 32 MSDUs when the last one isn't
the last in the A-MSDU.

Richard Acayan (2):
  wifi: ath10k: make in-order rx amsdu buffers persistent
  wifi: ath10k: only wait for response to SET_KEY

 drivers/net/wireless/ath/ath10k/htt.h    |  4 +++
 drivers/net/wireless/ath/ath10k/htt_rx.c | 41 ++++++++++++++++++------
 drivers/net/wireless/ath/ath10k/mac.c    |  8 +++--
 3 files changed, 41 insertions(+), 12 deletions(-)

-- 
2.53.0


