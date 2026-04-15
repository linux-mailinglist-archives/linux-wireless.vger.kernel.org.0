Return-Path: <linux-wireless+bounces-34828-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /naGCwEQ4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34828-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:24:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF16408931
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9A42307312D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF914392C4A;
	Wed, 15 Apr 2026 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3BzdnNr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE03939B2
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291812; cv=none; b=keMYPJq+umxid4WZXLZvkrxudklwyaLMdM8SoXDRgAeunorDxqnQte7zcFo0rucsP569DtCFLWKV3xTddS6dmj9SUQ/j42g4ArvWCP4w0Cw4eUUMYZjpw3DXyn0PLur/QLBV0jT3KaqAaRyKEcLAbQuS0vUonBjpvpPDtAQOUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291812; c=relaxed/simple;
	bh=/ZmCNdjI9A7nX3F+UvhW9CH8DUFcLg9IKlggWd5G17k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCoYyHOcm9lH6ca9nBT89E1EbF9jWlLyFoh0z6i+4/Wk5K2dSOpYgo3gP3OLmBU7Dxn9xQvWuQfmaBmUdrtB4DcdBcD5g5nDzctH5rL+j9ZjtAATUDSLTDyHqZryUkG8j1mZKD5R8goTYV6HFwi9EXd9U3zb/nr0ONYdV1+mpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3BzdnNr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b8efed61so419375e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291800; x=1776896600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2CYOJpBDeN6fLoZvv3pSUAiveiT2GP58DFfPIbyK7A=;
        b=E3BzdnNrju3mnIhJy+uyPPrICnMqPq/vYSj4m4D0ezj/Vthp140ai7D0CAJ6c8ZjDI
         EQrvzqBsI784FmMXs6jXaXb0c8nIqMoEhCKLQ64kMXEAmjSFTguFYlUkgP4VNPGOjLWt
         VzqqGDyXwXZevlA/FK6vDJS2v6JDY31CewDJe+eN1D0IIkNnIT2zIr8ZdIQ8DO3z217T
         M8T8TieZ98SVEehvFwsWnov4Kfr8kIJaxaoD1GM5RxduoqSs/yS8XWhpXEU0yQUXPOvm
         QwP7iRR4YFf0jsf4Spi1VAE7irwl738EODkzMmAubLJIjVP9xn2msnRHmWMPDzvBXkh5
         1tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291800; x=1776896600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2CYOJpBDeN6fLoZvv3pSUAiveiT2GP58DFfPIbyK7A=;
        b=MDaCRe/z5KvumO3+KQtIkxB3PuI2vijlnz2LLqelphzT/bkx2RnNmwcuUpGXJmADmx
         xbbDWagl0cTAOIeT1WYpLiA4ZOubHfalx6QA1xAopseSXwRAU4W1bHsM9anztz//zqpE
         KBj3wID6JNWJwmrJPX8kNiF22cIhchs7Gx5hD0nTEifrYQKRXl/aT0Bkmn4NlVJQudFe
         /j0w1k8rdqDDLjZ5eM+6FPrKmWX6ayek7kQdHUmB7HO62RXZsBPMPUHWF7BXGqv8EAUM
         0oIDepO8mwM0UeGLzbPsPIVTV8kVIe1hbJ2N32EInsRGNLvDuG/hKUAUotTff5sIvupG
         OJwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DPeCa+Q8nntG+R7uHHZU2+UfRFaurHIBqqELjpe/ZwM9sFE+jWtaW3m5HUTr99LGyOc+JRMVm/UhQlLXoDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjmAq20lmD0xt4D67l7Dkagx695Eo9m9tyDj4Wv/vjAoVwO76
	QhPTn6VxjaX1dQ3dKd7DGdNM10GylPeXcRcNM/Mm74mttO6sj+CsVrA=
X-Gm-Gg: AeBDiesF+men/WeTnTNfywflvjbw4dBmVirU5RXUMeGzKiQ6zFffWpIGit3ODP10Pn7
	ibNVMV9NZbM1AlUzjPSKe22STnD6nRhQH3XvgpjV2SuNFF0BvzijIvA4N69uvJclu/PMQu6whef
	9HnugWyJewMX0mBTubfp1p7sOumG0CDStGxKs58vcwIl796V3ePsgwb3BwBi0/nHftVVhYzj6L8
	PSmitSW8hsXNFhMjue+SQDpeW6f7LTqh2yjBdEG7Nwu6kAIgc4uroeJcZlLbR26w/5r2geq3Lkm
	u/jdhb5wjpcBQDc1Fw7OQLQuLaaCo2fUNixVQkWlX/M4g9PQSEIoFTkNZimu9dvRihrfLZrvUVZ
	b4ti0Z9OhYUGtF3c+gScYAhS/0scB8QLkt+bLOsSMSbb0Y329pKGk+TXVR9a4YoCmzuoK7ZW/ha
	bmD14=
X-Received: by 2002:a05:600c:1e28:b0:488:9c3b:ff40 with SMTP id 5b1f17b1804b1-488f4829bc6mr13884395e9.15.1776291800352;
        Wed, 15 Apr 2026 15:23:20 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9a742sm28702585e9.14.2026.04.15.15.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:19 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] wifi: carl9170: fix buffer overflow and OOB reads in firmware response handling
Date: Wed, 15 Apr 2026 22:23:16 +0000
Message-ID: <20260415222319.1538389-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34828-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: AAF16408931
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Hi Christian,

Note: this is a v2 resubmission. The original was sent via Gmail which
caused HTML rendering issues. This version uses git send-email for
proper plain-text formatting.

Three issues in carl9170 firmware response handling.

Changes since v1:
- Patch 1/3 (cmd_callback memcpy): bound with min_t() instead of early
  return after carl9170_restart(), per your feedback.

Proposed fixes in the following patches.

Thanks,
Tristan


