Return-Path: <linux-wireless+bounces-34829-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAKhDkEQ4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34829-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:25:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D34408973
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB54A31389BB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE994393DF5;
	Wed, 15 Apr 2026 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQhJGRob"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03C3921F8
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291814; cv=none; b=PYqi5luae/cdf/JgG00GVKXbK9CDRQ7FwPDgarAQ0wB704QyokUCycqn79vDx1d1jFVYDAHT0OMgeJ01Vshegk7qXfMSOCVLM83cKnDF2WpTGnLWH5vRx39RhASnhed3GUcKx3kKN6AaDOYdHs/cWCcBsgLCVnWQMoJhoB9pgWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291814; c=relaxed/simple;
	bh=6OBXDh9T2f553Ts7GE9r0Pp4NnhSWn397uoKN9ujZfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufdpSPjtf/RCtgWRvW8aCX/Udus7uJ5naUjYHpERLPvuSSw52No+sy739gIi4Mg+IOxj65P3fPbGkPOIY5AYD/adTHqzw4xeLDRlgL+KfZxHuJZM3IJ7NvEZWa7vvO64UDjH1pTNvXVmQxVvPwjOUEmPfabzmNrKLShoSzH/HQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQhJGRob; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso88271455e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291809; x=1776896609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6OBXDh9T2f553Ts7GE9r0Pp4NnhSWn397uoKN9ujZfs=;
        b=iQhJGRob554QZnpCfMNkBR3ZdUG7ryzIeWbkmMpqbmToRDC4n1Zv/6rALcOuN68F9L
         xGF885CcKAcpd0j/itAXO4JUK1Gx2DxPihtGtQpa0u+9LlKMGVL7rJkHonQxP4a/skw3
         Cq61Gee0WZazV/EZYnIiZM6WwW9lF900X3zpyH9eTqF7PVMA0DamX5vtQ4SCQbQbG1GG
         2SpQ7I2uOcUHpZ36MU5kA0lXqX5OPBHIcDJsXjEfMovgvfryLY4omHprlZxlbSHcJhxW
         8ad9bKWw5nI3xMaLCaxgzHa6wW9jyytf3BIbE4BHdY4tq7l97cKz1vnhxAo1NzaieH/b
         lrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291809; x=1776896609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OBXDh9T2f553Ts7GE9r0Pp4NnhSWn397uoKN9ujZfs=;
        b=p9BWSBwsv0OPIwdPfJFT9GxawIKJdFfcbPlKt4CGcgMSYWyge3m8NFfczekCarlpob
         GXA0qi7ZUm9cHB8SjAFjCd0qAK5DKvo2u/jWZ2vpDbu1xyHrLK0bo2miGq2V3Y8JyPP9
         6nJKKBrOaGr16i2M4V80B/InCsYeXeO1T9iE8GKicvF6zLyaJImsOlSiIa9R5qJtN1hE
         eJFkEezT7EJ1h4s90xPZgDR0C8dEdwYmqmz2froZkJlema9jLXFy9hJ5svNK/yd/1rNl
         U0pfu1nnPfUSinsYWggo+USu08v+m616PWnxoQ/M/eXfITPHH8pI+da61ld4XIW5lwOP
         6o4A==
X-Forwarded-Encrypted: i=1; AFNElJ+sQ83APwiJ+3iJlFmeNkUN1f6O/45FY2cIEa7bQc81jnKQCuk4g3TDcb+NWnRRWRczI8RIjFhjdoukT3JxPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZRDl/JVNbcdwIS4JkVGWveu0RjVfG5qLmVT4XAqpxvMWZrpx
	ugt5M5BeOqX4hMBbDU5saSSo8QXh/gnZNPvMWTUFLCJhz/Q6rlyk+l4=
X-Gm-Gg: AeBDiesl+DOLkZntwaTW/cKtplyFAlsMiVFwqIh6352HqmIImxVkKDeefhYipT//Dr1
	7WF2v5X7bm2neup1IsTkjQgwzvh8qrQNq9rYJWk85CDrZsPICc+HQlKebOmXhxk9apTZ3bIumTJ
	bTKLqrXldN8BttbsQeQFXS2EtnXeAiEhQ0ezxP+iG5LNhJxOlv6UJ2vMJs7410IKlvbOPCvFl23
	K9gXSNnfTFEGWbCmKcSSE4v0iVCCv6ixZzFo2Z12K2jo5o9OcFpLDF1+13C2UJ8uwUpsHUZbLZD
	1c6z5Gp810gYo31IGfb7YtxJN6pfVG7hODHWUoDq4+ZUT1YLbS7wk22dtjm4JeqqvQz4jEb7ClC
	iA8TkVHRrdBpoYeksKbfLcffBTH8U3IkXcs8BUGLxQbrVYDnXe9Chd0JF3XNqy7K3aYP7lcP3h/
	YwTMk=
X-Received: by 2002:a05:600c:4504:b0:488:9db9:5235 with SMTP id 5b1f17b1804b1-488d6867c23mr319760395e9.22.1776291809120;
        Wed, 15 Apr 2026 15:23:29 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0eb3842sm30160995e9.24.2026.04.15.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:28 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] wifi: mwifiex: fix OOB reads and writes from firmware response fields
Date: Wed, 15 Apr 2026 22:23:21 +0000
Message-ID: <20260415222327.1539269-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34829-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6D34408973
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Hi Brian,

Note: this is a v2 resubmission. The original was sent via Gmail which
caused HTML rendering issues. This version uses git send-email for
proper plain-text formatting.

Six issues in mwifiex where firmware-controlled fields are used as array
indices or loop bounds without validation. Two are OOB writes, four are
OOB reads:

Proposed fixes in the following patches.

Thanks,
Tristan


