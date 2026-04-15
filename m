Return-Path: <linux-wireless+bounces-34860-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAPBEakT4GmPcQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34860-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:39:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D1408BCB
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BBFD3151ED0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284D8339844;
	Wed, 15 Apr 2026 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck8VaR2t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C9335064
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292635; cv=none; b=h1iiYtYu3FCCWHuaSOGL3IsV6Pl/k1VBVYXZqZyQqclfwYz6U7gALmbQLQEJa0aN3cfN8q84DUU9ySGKnyFqMiFJ9ST7x+IHjmgUGe+lif6WcB/VWR+/noP9nzMaOfKSY5FK+Q0ZFijOewTb4CIdd7NQtEndE+jA7RMBNJOnLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292635; c=relaxed/simple;
	bh=FWZh+bpoeNl243+DGXsMV0oOeY5uxeAu3hfQ6f7yr+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U80gAX0oXyrvVfMe5t1FnAhSjD4pK0MKOnSwPb0aPsHkjYoZqeI9A0969UCvaty7t2isqKAfeTnoLHOEuer0BlEam8XCxhaFxWmC6c+otMtUB1tyi7525NdBf/W//QVpxb1Xc1hHuJuqDC/wozBzMHe6QM9+z333MlCNQPH7WcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck8VaR2t; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488971db0fdso72602235e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776292632; x=1776897432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FWZh+bpoeNl243+DGXsMV0oOeY5uxeAu3hfQ6f7yr+o=;
        b=Ck8VaR2tFDa1OFeiL5VBdKeaWq5LS56LJGh+TjFLuRNEHzTeWLTW0Ls3oyKC7D3aIP
         PSnnspNk1uq/VqEHx/WveuNYBJcMotbpwYTkNpxBdvA06kzLPj+OkKk39l0WGRqROodV
         K0/W9ehFk7cqAw7MYuinvMysz5PHxRvP8HT1oZRuWOezTbaspx9F5AapQ6dqc+3sNwgt
         cLT3JtfVY7YMAV+P3DXxNLmEinHgmBMu3ufdP97/HLTJ5Fc37wbeL99h/nL7hBEihMAd
         PWqwdOEr0xlfajSBHAqZoLvhsD+Ae+x/aOkN015XQDUqF2+KWNMAsUfN9gKF/35/gyvX
         AdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776292632; x=1776897432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWZh+bpoeNl243+DGXsMV0oOeY5uxeAu3hfQ6f7yr+o=;
        b=ps7W51qR6vV9XfpT0ixhGXHSlOYWo1GCxtPwadQpTpVV4M7g3UuX23C1QbJzBAvp3q
         fWPy4t6gEPTjixue+HfZTzk0qUreqSF/xnd1vByII/g+dqFd2biIaacS6SbY7pyTGZXy
         vWur4LDPucSIBxTFkLPMm02ZeVnunsBSfCQugszIozpK97qDUm6jYNCmPEzTCenYYFRk
         Z7MKY9tGtEm8opN9AfknzwTcgHfPvmk25IL1RqVk+MJLFSy+48KEad/K7MQLhckfZBXR
         IaWToRNXZ/gaVOlIJk4QAiaK4VAmblMb4o60GOjE+d6LYCqGdDl73M3IYW5GP5Lvyx4K
         z5cw==
X-Forwarded-Encrypted: i=1; AFNElJ8HoNQheghUWBB0TcJP0eBcBbV14lFzbGe9bCJqw7HNHnCMuwOZM4SEUnz8an4eqIxjr+BVbxAtYDwDDYDaVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJXjLrCeUyFtRBzubpVI6qcQ5vTGdzzhTMcgnlX5wkgt66q4RH
	udMbLHT96LU6CqICSrhIknTyZY8sdSg1WlV/g+jiC2mxwxXEBKSaaec=
X-Gm-Gg: AeBDietMRyKJxwTiq8NX2hklqiZk8KmyWWrtLEmOWMYGe1v66f2i4RmPWyXZVJPC5TX
	+58QCkhZIJT7th+KHrpiYzvVQjSJ2AKIs1GcyVdnni29tVqn/5hEBY+KTvCDN45PWT7KrLiglPm
	lAygntg30kyCrwDkcNnYLSzSuEQoXm1yBOM5tCLU2M+2l0AeYi2ZtqI2X35d2kCE6yMjIa0MdE5
	+hFA1xtcigEIBkvg8Mw1DhJuc/tdA/tKvocZy+JpIqr6CR864SgEvAP0xU+pKMtnJ10+fxn03B3
	+6/Zo6KVMp+8NvcL/3mQEea9j54wUmDTdi76V1uWUpqoYdqzgmLf8jelG4PJ04jOKib3zaPCYg+
	pIiu+gteRkjEQ6mzCnrjtXXOUnZcggx5HB6/XkoyzczFPp9pw/9e7KukCkzyQe0EtUKctaWM2Ab
	bpzi4=
X-Received: by 2002:a05:600c:871a:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-488d67f0b8fmr339005725e9.9.1776292632000;
        Wed, 15 Apr 2026 15:37:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818da1sm2550345e9.6.2026.04.15.15.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:37:11 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/3] wifi: wcn36xx: fix OOB reads and heap overflow from firmware responses
Date: Wed, 15 Apr 2026 22:37:07 +0000
Message-ID: <20260415223710.1616925-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34860-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD8D1408BCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Hi Loic,

Note: this is a v2 resubmission. The original was sent via Gmail which
caused HTML rendering issues. This version uses git send-email for
proper plain-text formatting.

Three issues in wcn36xx HAL firmware response handling, including a heap
overflow in the main response dispatcher:

Proposed fixes in the following patches.

Thanks,
Tristan


