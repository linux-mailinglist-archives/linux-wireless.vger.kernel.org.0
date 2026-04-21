Return-Path: <linux-wireless+bounces-35159-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O6fKFqC52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35159-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:57:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CA243BA25
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C8A830C4B6E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBB83DB65D;
	Tue, 21 Apr 2026 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHJ8+Obg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C7F3D88ED
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779398; cv=none; b=P9UHUVRcnxqYJTC5gDpWvtntH1rT7UsMN1igY/QxZ6gKlC6wYc80/e0V/FMKXWYqyMsvrcvjFFTNHlqXkgnqn9kkuOmIDqMFMfoCoA3r2kXFiXOKght4cHVbkKZiTTKP9Yl8FFdJwFUooxegt/ByfT/NRi+HJQaQiS1m6DbFaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779398; c=relaxed/simple;
	bh=E24Tczye8NmN8rfTgXHEyKNVuFf/qwEd5oSaY55BPaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ICOyuYKgANlIiDHpvYgwsceHTmR8JEUcjcB//PfkuMGnL4vqzGCcZhgIs6rdy0csig3MbGS2ho3i88xS/fAz5VZ5LB8I4Dv/gNM4eURyiGjwayyWLI3BHeqeBlbK7VieJGTXdzJwkcRaoFVpY2JPnyCgTuFlkMIBXedQZAaAq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHJ8+Obg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so58505615e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779395; x=1777384195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5fdB5FfhHWL5VSsJ6GW1j8QvZho6Z0T5QsbXoUs2LNA=;
        b=NHJ8+ObgT5/fbK8/rKUKpvNu6Qj8Qchvr//EDLNZK18DrIJaQp/Kz3tVdtQfY3FZSW
         e6S9q5lJ5YUKkYCNFW9tb9Kv9gIfCbOhUp92VOeHn5RtWj7xCp2mXuryUbe1j+Rik2z8
         O8FIr8DwjddXJnSMc0i8K7e+nmEhH1+OH9cgO3HNaDl0FM3Q6kejL3wri2PHEl3U0/zI
         84SedJIydNyDmCgUSOgQ11oaCUTh+SWIcSbV63h4XdplDDpHpl7ORY+5vIa09PhxzFH8
         44xX+/awfQcwlZ8OLs91EH+4zn4gwn3UBrTF0kUVtTHmvkX3dhxToDx/BNQ7fE6mj8LH
         oUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779395; x=1777384195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fdB5FfhHWL5VSsJ6GW1j8QvZho6Z0T5QsbXoUs2LNA=;
        b=EwzcXuZSz01VA8hZTVoIAQp4f5NmVknSRZAfDeIHFbJt0/IMfge8/TZjaLmxH+KfgJ
         soxe5wmkSBbqP9wqm6vTJHzKffKe79pLoNEcZLlGfMz6XQzKNxkWMYF7tMUd2pza2QC6
         8peDRBgU696l93DmromNt36/euHnuWoznwYlsxDoxYkWd9eDe3VPalOqwiPpl5NMM9dL
         qYMNLQFE1Rpt/GrSDl/DR37U3iKpPhPZkUMP+FGXy2luGoMmPu17CrDXS/MG5DUS41wf
         2Nd2H13+OdImLZxpZtsIBZq1a7BHtDoIGLZp2u4tcvA5fEL4WOKaUkVqpX/7BTAG4t60
         /M8A==
X-Gm-Message-State: AOJu0YzS/niSEl/xDG32zWvvhbLXxn8WwGhfMtwNBavfdnDYlWIhlivE
	8nvItf+LnHo47NbE0z6tl9w8yS6O9nWiTYhfCVjN+2JoBbNVgBU2rPQ=
X-Gm-Gg: AeBDiesTdnweIzlg/Sb8HhAfUm8Mbif33wsn0g5vWXVxpddg7vi07r/B8sQ9w6IImUt
	KJgozUzpzpkiCm/CB3nMWCfRXsF12jIQymXqJUZuDAXkYjZtOrPLIE2irtHoEv5hWUJgOKxv54K
	XzRWDb8ye/WbyMZs23vjAUwP8OyHOmn0Rh2ElMQwwnvBok04F3zcVAwvkOkXNhJlpx8uRZyuEVV
	b837lHpxjXrNhJpBtAJmp8s+o7fMDUtVYrdAYB5iLJpYp2eP/BPChXrcI2BbSd/6VZuQ90knehO
	YbcSrzkU8tzRvbw5a55sMNlQudc+47AgndKHSySSjr3q7DgPzlpalkeW+VEctPGr0VrS1A/w7hl
	0dMXeKOUpaD81/R0PzMqyGeATs/jP7dd/45T/5vsW76naor0MGcsZloYvTh+zUhinxmmu/7qR3J
	723NxEx1ksulAiSg==
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id 5b1f17b1804b1-48a55743d05mr43381995e9.27.1776779393270;
        Tue, 21 Apr 2026 06:49:53 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb13a0sm37671480f8f.8.2026.04.21.06.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:52 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/3] wifi: wlcore/wl18xx: firmware trust boundary hardening
Date: Tue, 21 Apr 2026 13:49:48 +0000
Message-ID: <20260421134952.338301-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35159-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 30CA243BA25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

This series adds missing bounds checks for firmware-controlled fields
in the TI wlcore and wl18xx drivers.

Patches cover: BA event link_id, logger max_buff_size, and smart config
SSID/password lengths.

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch.

Changes in v2:
  - No code changes from v1.

Tristan Madani (3):
  wifi: wl18xx: fix OOB read from firmware rx_ba_link_id in BA event
    handler
  wifi: wlcore: fix OOB read from firmware max_buff_size in logger
    handler
  wifi: wl18xx: fix OOB read from firmware SSID/password lengths in
    smart config event

 drivers/net/wireless/ti/wl18xx/event.c | 9 +++++++++
 drivers/net/wireless/ti/wlcore/event.c | 7 +++++++
 2 files changed, 16 insertions(+)

-- 
2.47.3


