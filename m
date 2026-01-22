Return-Path: <linux-wireless+bounces-31084-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI7NKK83cmmadwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31084-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 15:43:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9B7680FF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 15:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AA8C8E7885
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09807313E28;
	Thu, 22 Jan 2026 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbNf05Vn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426231355E
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090567; cv=none; b=QEG9p9q+HtIzr4oDF8cL1aBXcHXhXDCPFQiqDIKOSO3xEmeYbE+eZuuKUSCfdr5aRb3J+tLeOjmxRCOwTIh3Z1gUtpW54ajN56A6iIWC6ZYRjPdFVLB7FF/hJTfna9aZKwHmlMimd9f9x5BceuTRYAYn5xHChCU/IHvly528bJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090567; c=relaxed/simple;
	bh=bzjStokDxQhdkHggmyC2zUbAPWDuf5AcT2iZZVjDG14=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=i46OHfYhgDs4Ylqpie0qFV3aTrypNmBw8rSTTU1ilpMpcwOAHrC6I2uGaVV27BQk94p2BiREPgoAbgYNpWECRiHfFxRlavHPTOMzK+ChQzSa/7EUa8VyQHXrrlQDQYYQRtRsuP3dsVwAAJf0JKixSlxlsNtgTK+soNnOD6upv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbNf05Vn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47edffe5540so11267145e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 06:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769090564; x=1769695364; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzjStokDxQhdkHggmyC2zUbAPWDuf5AcT2iZZVjDG14=;
        b=dbNf05Vndm7MZFswvaLPfBUZy8PodRvzyC2baBwVOvlPkzF7JP9ZvIBHZ8vGEfntJa
         Q1P+9s+o4CTdRiWq/HIr8MmZOOBCyLywlFlY6Jk1N3wIs1dvfCZ0M1BFcBlV+qqS29rA
         hIQPelPq+0kCQ3pAo1EcWWWfJ5c9mb4gdalB0H/OZEi4ePsPa0PGFQF2L72O/VH2NQKs
         WVI/LiH9NR2Gp7Dbu1AIYk8m43XqZTohC7a4X52LJSbqjqT2iJ1355X8fyL7hGdv7iA8
         GvzbeePhSJ+O7zyZqmWZXqrIjgO+V+s3pAS+gRNzpL8tu1hdjfp2zjs27Lz31xzCyonm
         5Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769090564; x=1769695364;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzjStokDxQhdkHggmyC2zUbAPWDuf5AcT2iZZVjDG14=;
        b=kLLKewjqmHdQleFDNC5Symxm/5RdegZRJsgK7+5LgJED9OXpUR6bOkyKfPjj1U41gY
         UTTAIe1UsnyBN9tnz23DcH/d6eQsiSJ26/BONIFRAUgUqUGcoYff2eIOvm+r0S17sSTq
         7570I1M9ml4kXoddNAFHYMV96naKqRsTdA2EJ+dErsb8eGmx0mKHXrgdK+72IBADPXG/
         YNGGdHCjLyzdf1zbWe+mE1dsND498stt0PbI/u2NS6Uugg1dZfkMtEtQacpSomHrSbf8
         OuR7WsvdHh6EOPG2oNgCwokjFUaOEO78NEYw0T0DaFQlOkwAKgbZc124rJdjaq6vuRqP
         UCug==
X-Gm-Message-State: AOJu0YyWYHk0SqoJjf4VtFtpI8LKTUwAFAYLjWxQb+TtRQuLWwJIlv99
	eklDd+yYEiIFNmdWCUP8JAmqBZxZGB3UeiYMlnqrcdcOb0w/ZYmL31+f
X-Gm-Gg: AZuq6aJyrsGTsYWjKqOBZtwYwuFKHTfc3khJu9TzlnwN1JAxueQZb7cFMbL4QdtXE+v
	4cjWQxu9gd7O++w1FfVIVHKu4BKCpIqOYImq24EnKncsFhVdLKR//1mRqoEuVrsdv1uvIE2YUJu
	BR9L2Rh1dJudDT47HYiYiag5Kdz+bPSSiHAxzFpaDTZ5kb+zqF27LF67Y7GTKbCFFkKf4AaReqK
	by2n/tP3mRY2VIhjOxOm4xflhzdt7hyUoIp85kzQ+ITBOZ8GJ1Qgn4OIQk/Wm+Ekkup7caLNf9K
	nODjOjQFO9T/mS2w5e+BcRp5cI8JejObezOJ1yqfoR9+YO/Bsp0iYPsUKVLvhJKTBXtxg1tXHtv
	Ms3EDfIp+ui7nSRRCQtDLcmn70OBaBX3hod0Juip7myhJoJWBpzSxfziJsyfhAg53pW7rVhov0i
	1I+HCAS9/X6P9aXLSV1uqe/y4RvB7F0g==
X-Received: by 2002:a05:600c:5246:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4803e7f1b66mr123740895e9.30.1769090564171;
        Thu, 22 Jan 2026 06:02:44 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm44595333f8f.4.2026.01.22.06.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 06:02:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 15:02:43 +0100
Message-Id: <DFV69L2EXL7Z.2ELUVCHR6LP1J@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "Florian Maurer" <f.maurer@outlook.de>
Subject: Re: [RFC PATCH] ath11k: add ath11k_mac_op_flush_sta to properly
 flush pending packets
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 <ath11k@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <GV1P250MB14333A5BF24623C4753A10E1E8E0A@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM> <29a30250-137e-429f-91fb-1f509a55746f@oss.qualcomm.com>
In-Reply-To: <29a30250-137e-429f-91fb-1f509a55746f@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.de];
	TAGGED_FROM(0.00)[bounces-31084-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B9B7680FF
X-Rspamd-Action: no action

On Tue Oct 7, 2025 at 4:29 PM CEST, Jeff Johnson wrote:
[...]
> These are just cosmetic comments. I've asked both the infrastructure and =
the
> mobile teams to validate this proposal for technical correctness.
>
> /jeff

Hello Jeff,

Just to check if you got any of your guys to check this subject. The final =
patch
here [0] seems to not have been accepted yet. And the "issue" is also there=
 in
ath12k, so if we could fix it for both driver that would be a plus.

[0]: https://lore.kernel.org/linux-wireless/GV1P250MB1433E723AF90A69AEBB696=
DAE8CBA@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM/#t

Thanks,

