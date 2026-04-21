Return-Path: <linux-wireless+bounces-35161-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK4fG0mC52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35161-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:57:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AD143B9ED
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7EB230B35E2
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3663115A2;
	Tue, 21 Apr 2026 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI2b3s+k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C23D88F5
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779405; cv=none; b=swI4aAfTKLBsSmP2dbqu/UdJ0oUXzYpclsmYwa6AyZg+F0mStw+lua4AT64gquEqbS4kAljANsU7OeXsNXCW4BF8YdFI+foabn2dHcsIr/+o5lrAwR4K/MI8Zs+23zj36d5Rt5ONXeQvFV0IWHyxzaYCSS8MLMi5InVweGZvUEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779405; c=relaxed/simple;
	bh=jUhssCGdcneS3074KscAEk6x1Cccr3YW+fGAYxC5WNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRGTNtwxTQPFHbC4G4ZcmGABWdNIwSxzRtKOuuB10bOG0lRy0WKc4R3i5mkgvK2zIu5rGMqdQf6tRPhSPcCf11WdETvpKr7u4G8KcGko6U5HtKdky7XGK9VL8VrUUjSB6Pde/ofaOSu8nrvN7jUj1nEIvBetiXHVl6zMtKc47/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JI2b3s+k; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso28017725e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779403; x=1777384203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMmWKkDEvKdIOANHSc78b9meO/9FHMlv4sCKWjewmxo=;
        b=JI2b3s+kzHnyeIqT6I0+KsYSa0Tkvhp7Xw+zriU9tZi8S5eiRRgXDRj14tQzG4i3RZ
         TC6N0SgyS4yOXEdKmrroeqmhuzOcANKovkcCBiB1W1fCpsIHrQzg9T9loKwmSXyTny+y
         PNj6gDkV7iOo3bM8s/79JdugGjMfrp8FNJxKMla7PoIZCniBl+ihveJ0V0bFzMr5Nkwf
         H8ZgZUJEVfrrE7LTxzdwgx1y+ikB4P+Rl4LVw4UjrVxIoNyNvBKegE/6ZztBcEhUHGbC
         FVAs89RK2/1z7mRpHIEX12IfB++Phq7ojKSmXk6kYFk2FVF3MNJ0wdmwrSw+wbscv/cP
         +N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779403; x=1777384203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMmWKkDEvKdIOANHSc78b9meO/9FHMlv4sCKWjewmxo=;
        b=YdgHnht8bwqqZkMU58wmpoV6ABnzBlzjn+y37qKkxPIIi6xD/FEQwXS/0wjTPl0Tkp
         H0y/ej8BX1oCltrNxbtARib4k1hYuv5IiqbTeIqUvcsQJWdn7gAN89ruEbcVH5gRm4e6
         B9H609w1l/dhkVKlQERMgoq28UvfNbM55zib8wkv9Jv30zcENh5bHaSRl2wRcJddr6F4
         vGDlRo4wJQ0YCux61eoklPlatKoKoTDUGDggJ8MOOL7qRW3YrNGJtJ9TnqE25DPDqOmL
         TGwWkahO5BC8exl1+bVVBzbRfFyFEDtyLima00mxJkI7pYhixihLSxCuVTVV+hJ/yirq
         VI/g==
X-Forwarded-Encrypted: i=1; AFNElJ/QtaHMp4hdmvy7FTPFHtUEari8ccmm6xalJ46Yq3eVJtY/rz3R0QsQIb2HfSBcQnHdu+OZne0IkDmCeEdgww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCXL+Gr5Bkl0lUT6fgkXNleoRTfpw1xtraJCi9MsKdokXZ7hvs
	0oIUjJ5/Wqvc5P6k3Dt1LpDP8jvTBZBkBynWpsSMCCgSCh6Xaak8Zno=
X-Gm-Gg: AeBDiesaOTQa7EfTnVxuZ/TEFzp9fR1D9etmlZpvMzQoukamDlbvtnjtk7/PANu45p/
	rt7XhR1MgjukAGcCEGqKhwVHv9Ixvk+cKrr04lmbaWIh6KO2O/ostFiW7YzTrWK/gF6/av3DwSP
	9h3P5JITtRxZx+NJ9E+nlgo52K240UTgSnVrGHHs/zN//MRQu1zaYr5IsRczqgr26a9WEZOBHoc
	yeGQtVsmsWAfjYRusPdyP9bEA/sdfdjMrVAz41xvleqLDW0uZQQFLJl0Lqxd0GQmzsZ9gEYHA96
	1SzZecHujcOQ4ZyqS+YjkBu78rCipoBKnhzksHQGFbiUeNibzUsuudyVCLOjml6KicIb0RVWt6n
	BTVNybJ0V5F3Ihkn+Vdh54AJFMy33Ep+DlXVU8D+N2PeSOPmBI5/DZoBfWLj1KNV9b33T80VQ0M
	BIRXg=
X-Received: by 2002:a05:600c:4e8f:b0:48a:56cd:5266 with SMTP id 5b1f17b1804b1-48a56cd549bmr31005305e9.4.1776779402555;
        Tue, 21 Apr 2026 06:50:02 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffad20f2sm157213795e9.0.2026.04.21.06.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:02 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/2] wifi: wilc1000: firmware trust boundary hardening
Date: Tue, 21 Apr 2026 13:49:59 +0000
Message-ID: <20260421135001.343596-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35161-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: E1AD143B9ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

This series adds missing bounds checks for firmware-controlled fields
in the Microchip wilc1000 driver.

Patch 1 fixes an integer underflow in network info frame length
processing. Patch 2 adds bounds checks for RX packet header fields.

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch.

Changes in v2:
  - No code changes from v1.

Tristan Madani (2):
  wifi: wilc1000: fix integer underflow in wilc_network_info_received()
  wifi: wilc1000: fix OOB read from firmware RX packet header fields

 drivers/net/wireless/microchip/wilc1000/hif.c  | 11 ++++++++++-
 drivers/net/wireless/microchip/wilc1000/wlan.c |  5 +++++
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.47.3


