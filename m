Return-Path: <linux-wireless+bounces-34819-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMYpH9MP4GkycQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34819-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C67164088D5
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D693081328
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B297388E41;
	Wed, 15 Apr 2026 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbc3naD1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9579373BEE
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291792; cv=none; b=HqYs6Lu1H4eogKI6O2P48w6O+z4L+HjBDSRifxpoqNv4/gIO3LUaOuuo4TUrt5eH85Kl1zN6hjKXXP2s2J0tejUJ54k2eTDybCyM2nVbXAf8Uc19whNDUcfkem39AAvBd3/bYiTjn4QOa0ly2BseJxdhmFtL1EmuEcUwoQkNTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291792; c=relaxed/simple;
	bh=5wQ7qYWU0EnI/B1ohl4W2R/lhHMML9MQfxhlw5S9jl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ED6PvffowQ0JtGCGam5CB/WsP1j15WPyGeXUt/u7+KtfMSKsRJI7xBYndigv4a0qe1k5gw+JeUmPmlNFZcesmc34izoTFy/efCZko9frBOCsb7eD0fL6npn/V/3lSD6riFurGHFOYou7EMAwi3KOLq6HRlnGheiAdFCDE0b0g6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbc3naD1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488971db0fdso72520665e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291789; x=1776896589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5wQ7qYWU0EnI/B1ohl4W2R/lhHMML9MQfxhlw5S9jl4=;
        b=Sbc3naD1LEasjQQLd9tBUbws/14n2FgE5gZYUXN+csPKoGDtlLSUcESp+J/HyfCN8J
         e7fmPWK2tFJRMUdfXeqoVpJDeFbHWtdwr6uvjTOYgzZ5D3b2tELh6jo8UOBbq6vMUxQA
         OWhEMYfCbNbfk5srXtqETkCfkctarK+yxQ9Z/tuYSSBZQ0hrsPwhJ2UIDgbbEj7T94NI
         FZ4aCqWUiOCWqtOFCBOY08zrxnHejfnf1QvEVszbOfTL4CBfrw1+0MBR7jq0Xev+0Ybg
         XCjxxushMiwadoplX3xx6GA1njH085IwIJf/+qmuqHEzzjBVKG61SU3iTXIZT/6qGjUE
         hq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291789; x=1776896589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wQ7qYWU0EnI/B1ohl4W2R/lhHMML9MQfxhlw5S9jl4=;
        b=jOaSrSNwWja9xb+5zW4CH7PQz6NxY1zdkW7Xmnry1m70tigXBC169f3g8YvxDIqbnK
         cKnMyYCEduYmB43sCjeqF7D8Ns1AGJZFk1CsVWrbORkMVr8iFaQ8vtLcV+zTtt9ugoU/
         F1cIcx+RXDd43vhcz+KQBaDNGsUdjX67Y/ShOLhAYwaFaH6YYJ76KHllqeVdf5CHVkNb
         jo7fCan2W1UfPyZ/WgZoEo+owiSKgaW547vl+kGAQS+khw+c7BtkIyiXFtz7n7P3l708
         wcw0IfycOJN23chMY1QbKESd9wMrMOI/h59cuJ+wnUpNliC71BN4WeqJwU4uFRok4Uw3
         uYWA==
X-Gm-Message-State: AOJu0Yy3fNnYnn+FF3Me6ADyiz5rYT2a5cFtg8EzPuwR301n9pDG0hFq
	bzuYkmEFTL2p/ndkkB0UWSzFSjp4poQ6KrYchTX/kScBklVad6B/xAHeKnW08ztSQg==
X-Gm-Gg: AeBDietIalne+OKFwou1OXWFo/ryDIKX8LA/uokjNRCkTK5aQochP3NnesXy5tMo3zU
	lM6zdlhMk/mDHlpoE9a4g854sCxgRtf3rEY0mDGZsJLDkOeE5Dm6HLFU8Ks8MoiBxTsIYeSpmpK
	MRb2uNxQXhDZbPToznsNn7W+yudgVmOMPTNx+8r3pXJR6jt4eipo6vQR8VWJTmIn2lpY5fT0hv0
	wQiS3wTPQnIcft8T+JOIzkM/b1upW0PDdd7mZyYpnILl/NkgSPZ0ImdtLgrbd+71A11t913joeN
	r+TrdaJxOv+Ku9XJ060BiC1dCF/VXngA4XoJhkD+HUX49dS2RenCvjwwB8Y+idEIC0uQ7ihIWrd
	D7L1WE9wX057R1gA/Ns8x0kz6qVg93dlsDEKujXqH/O3OY53WkNi0NwtjcL1kS71dJ5K8fLUtpn
	h9pZeONyBTgyy6cA==
X-Received: by 2002:a05:6000:240b:b0:43d:7633:2649 with SMTP id ffacd0b85a97d-43d76332872mr22710182f8f.45.1776291789069;
        Wed, 15 Apr 2026 15:23:09 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5eb4sm8662959f8f.20.2026.04.15.15.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:08 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] wifi: rsi: fix multiple firmware descriptor validation issues
Date: Wed, 15 Apr 2026 22:23:02 +0000
Message-ID: <20260415222307.1537309-1-tristmd@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-34819-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: C67164088D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Hi Johannes,

Note: this is a v2 resubmission. The original was sent via Gmail which
caused HTML rendering issues. This version uses git send-email for
proper plain-text formatting.

The rsi91x driver trusts several firmware-controlled fields without
validation across SDIO and USB transport paths. Five issues found:

Proposed fixes in the following patches.

Thanks,
Tristan


