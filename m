Return-Path: <linux-wireless+bounces-38053-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BqVjMje1O2qObggAu9opvQ
	(envelope-from <linux-wireless+bounces-38053-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 12:45:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B286BD783
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 12:45:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mbpWnfOk;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38053-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38053-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAAB7302334B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630221DFDA1;
	Wed, 24 Jun 2026 10:43:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DEA1A6834
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 10:43:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297815; cv=none; b=Le4JIdwRHAJqU/322cbug/PpN1QoaXtdWvf/Bo4E1N3THRxeNF/XGIo7oGW3ChVLQF0/PdFXG3PEtcDfpjEX0Np7bfiwIcQ5Wd/LVoux9op86ftXdBDu9c/6/8GV9oygjj4mlXT08W8I0ojDZtPRwAYkjMwXieSbkHQ5/PdfUIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297815; c=relaxed/simple;
	bh=r2jVVRx0ElsXfhIe/LKOcm7CYkea/HJxyOCuMSorv28=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=Sxafi46zgnDZU3KCrtTX1imjCNNris1F5bpG63S1bxGgE3PQOIpPxnZDGm16v4lUFGKjf8gLmT4ITPEoOElKu4jC+dtVqLrx5WnMCkqYcKtlmGon0GU0wY5t3tgKpUo/vWLza35MQ7r3gfyIJMGA8g+73s8KOE61lmHyx+7VKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbpWnfOk; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4924e6fda5dso4541825e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782297812; x=1782902612; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r2jVVRx0ElsXfhIe/LKOcm7CYkea/HJxyOCuMSorv28=;
        b=mbpWnfOkZJyJpomfbbGlwTVta36OcPv9H0hqyrVc5pKoEnqq46VEWptIEQb6B/ui8q
         292fJzSZo4zn+83bSo7MSM5JHn+6DCl3U2vxdaHEobKzIGMHHrB3MiLIoPVkR/8Sw8JN
         gHP0KV3x1BckO6mffqMr3LG/HlQX0QLiVUj5ysnVFcrFTSopaedtmFzDHS8rN7TQifZq
         JQh/WwqU/fa1gFVZZW0ief0MhBZKnUMwG6MKqHdbVDM12lXeheXLVapd5BG7B+9c8l+Z
         lyIhRJuhnj0d94tSP9DpfHHMXcanzRwljfT2Up9Q14cOk3M3qoBxO6gpsXqca5YfnAm8
         fZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297812; x=1782902612;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2jVVRx0ElsXfhIe/LKOcm7CYkea/HJxyOCuMSorv28=;
        b=mcmJNAMcL9g4vbjIloC+gxwLXtd/84JgYql+m0Vtmbix/J+dYSTQHK9U/O0XqulSNb
         QKNW29zD1wZXxfdb4a0eHoNoDlPyh/OsA0+Y8M/eRerXhYiLukn7ESybVFSub6wVzMVx
         8zCHRToAJogt7TY3yr59s3I60HRfdg4NMRXyPSj6J7UnX5OIjfABpjv8CKlsfgTg4Jbv
         m+0iY4W35z1KCpviZiU85PM3oJswf5Rpqe1Slflfh7Iz6J36W029CFoEqUhd8UAcEVdE
         lvxcgst/2x310cyic7WeL35sl9FSBOuSIuabnKKputicBqsuxLAAz2zf+HdBr88fQQ1a
         nj9Q==
X-Gm-Message-State: AOJu0YzKPsd4EQwDHiBFNgefd8p9DwavLzFE29eHTgIHZy20xCTXM/RK
	YFRJwDWruHKLGbTEuVLVCcmytCWEn2whvkGqG1MGZbUoKzDGnh1fQ2zsawZucEqvR/Wh0g==
X-Gm-Gg: AfdE7ckBxKz8NfzSf4uLSvpcWfBJElmWZQo8unttKUhxBTG/YfxhFogM/W0VvaTj9hj
	aylKQLs32UWD8T/pxIjJ9kB5RfdjuBQKUu2aOsVlgVHAXMCG744PAu39Ymq7XCE5ysKn2PQc2JS
	MuJO9S8OFCbc+HlxRGaJs4rr60lSLc0ethKp8Pgna+g3Lz41VoHHo035k6VBUvHZFls7XZZdAKN
	BF6L2ogdVbKH9degrO2g5ddtsOsSRqd7rE63MIBB3MSTaoCu41Mdxu6Qo4zoFXj1dCzM8UIU+7r
	d92kfRUAC2s0ep7d7ovAcu9JYmfhBTFtFPTY+o1QpE/QkmuZbzxOXWhzx7NnbLpOeyurG4421OW
	tydMo5JpV10FuB6IDgl4ZmGmwB6T4CJQE1VejKi1n4H5y1T1q4LSHf9XtT2HU1YvlHgcoY/GpQc
	BXAj1PskJErCXe2ZdS87aB9DVO0vvXFK03ij7dsRFrPzjkg7xW
X-Received: by 2002:a05:600c:3113:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-492490a790cmr262096195e9.22.1782297812238;
        Wed, 24 Jun 2026 03:43:32 -0700 (PDT)
Received: from DESKTOP-01OGNHT ([105.116.13.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9371sm5877045f8f.21.2026.06.24.03.43.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 24 Jun 2026 03:43:31 -0700 (PDT)
Message-ID: <6a3bb4d3.829f5021.35cfb2.a95e@mx.google.com>
Date: Wed, 24 Jun 2026 03:43:31 -0700 (PDT)
X-Google-Original-Date: 24 Jun 2026 03:43:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bh1.bapcoenergies@gmail.com
To: linux-wireless@vger.kernel.org
Subject: Invitation to Register as an Approved Vendor with Bapco Energies
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38053-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[bh1bapcoenergies@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bh1bapcoenergies@gmail.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mx.google.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,bhbapco-energies.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37B286BD783

Bapco Energies is pleased to invite your organization to particip=
ate in our Vendor Registration and Prequalification Program for t=
he 2026/2027 business cycle.=0D=0A=0D=0AAs part of our commitment=
 to building strong and sustainable partnerships, this program is=
 designed to identify qualified, experienced, and reputable suppl=
iers capable of supporting our operational, maintenance, and proj=
ect requirements. Suppliers who successfully complete the prequal=
ification process will be considered for future procurement oppor=
tunities and potential long-term business engagements with Bapco =
Energies.=0D=0A=0D=0AShould your organization be interested in pa=
rticipating, please respond to this email or contact our Procurem=
ent Team at tender@bhbapco-energies.com to request the Vendor Que=
stionnaire and receive additional information regarding the regis=
tration, evaluation, and prequalification procedures.=0D=0A=0D=0A=
We appreciate your interest in partnering with Bapco Energies and=
 look forward to the possibility of establishing a successful and=
 mutually beneficial business relationship.=0D=0A=0D=0AYours fait=
hfully,=0D=0A=0D=0AMr. Firdaus Panthaki=0D=0AProcurement & Supply=
 Officer=0D=0ABapco Energies=0D=0A


