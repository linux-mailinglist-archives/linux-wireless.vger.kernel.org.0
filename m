Return-Path: <linux-wireless+bounces-35168-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IRYMp+C52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35168-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25143BA86
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DB9030E33E0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243543D904B;
	Tue, 21 Apr 2026 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4mskpWg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55F3D88E0
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779423; cv=none; b=b0j6Kfy3HNpKepS9R6qQxUB2IgI+s47nl0wbmDXGDdXZXzHvfk3A4Dvz7Ee6qc/Z5G8xONsMZ9FTMzS0WD+EFDQwiAduaggD4FvZDQp8/42w5xMZyID3HJGI2QcZaDmUKIlE1/EgGBwervxd6KdL/GeTTSzgpnURTkTBPj7XvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779423; c=relaxed/simple;
	bh=uzWsHcTuBOGRnpsZGDOyG74a7rGserH/46bhB1x8ezM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9fpB9VQOi71iLmCveYroPaf9rNj+vx35HCKLfx57rOmYeWAJesbPjmxLzzeXiiGlTKzBRryNBJ/IzS4XRX7f5KqEmIpfx8prhn81S18T8PfvDoVieH5Q9viQ++TXoeK6IpgqcbipCpbs05X5CFiK7UgIcnvQrAcUs06Tzdyxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4mskpWg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cf7683a28so2920749f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779420; x=1777384220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dxYMhn2LvyaOQVbvGyBd1qcNaBj8zGBQQWRUIM0EKII=;
        b=S4mskpWgQZLMaxRaDg7CnPjISpOUv97hAzHyOIAJa18u+iq8p6bTSM10SbXUMAYBhg
         1YQdje1vdSsNEsMUh0RwGLeIBVfDZPDfqjbYI9GyW5luXm7FSmQ0dO/SLy4tpo+xIsCp
         0VIVUdHorOIHlTULKVM5R0SF/GYWAbCNKczQusdE0PRUT3ggUkopBzZihw3ZG5ic+Qbp
         8dUIadSViTLnFSZmFakx1fJI2FrxNq3+4jCeCZ+ETnvkVEDmGB12ZppdCd3elwUe+QlZ
         MNrA9B0vQbDodmTfU2YIJs2XsIjbgTODrlDSZhmxwueGt5BbaBj+Q0jgczeoQWDGOwp/
         087w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779420; x=1777384220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxYMhn2LvyaOQVbvGyBd1qcNaBj8zGBQQWRUIM0EKII=;
        b=IlwudQpH+KzSZzCSpLC0JKwN5pYnwg9K/WGB7ryoSXmf05ccREkoDjdZwyhUFNjd+l
         ZJoGdkaEFVRgQNl/bzRmWC1b5Kc9jKYPvPAjLS6KaTVpgUxhQrd5NZYH0ksFFhocPnka
         uAqnYvVNUhW/IbndX/hC7H6OthrGiP7/6n+GFg+0SmRDJ7jPtS5PnBQzSpdSfX3yTlHF
         KJtDVC7cKB3pOlZz+yNZNSTJk9KPaLjIta9l1bmR3y2rAoIPvZCZNGJvn6PACQHWzaMS
         aj4G2ZQhPP0It/hFjWtJTXRyFK2ChAu7o2pg0HI1Ji7a8IRYNTI0zPaxt0nVO4J994Ka
         YOoA==
X-Forwarded-Encrypted: i=1; AFNElJ8J8ZH+tsjod9UvZi0dn3sB2MAq8W911Q/8CB0imP1br/OfrIgPstb5yQlH5U2uL2REa+MhFctMXJBmrnmreQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZnzmoBNAAiw9xbCjo1iSELNdrhT6za636owe03RfN6C8ge9Z
	Dp9GI2UMgLl6Pj1II9SHU1wm8dWBkaPKgUPFEMqLzalkCIbcne2iyaA=
X-Gm-Gg: AeBDievCQnEQivr+TIaON+Q/CKKhWeyBYbxK3Zqn8HNY+ctdhrtaZ1Zg52jpm+Wqaob
	YiuC/u+TTLreh6cdjzlwtUnjZllLWJALpdy5n+QOrwG9eiMkhdO4sB/RI7VoxHGwfrgSVa+7N1/
	aU++zuSHo9jpIUW85l/8ziN1o1DDfGX5iHnR3eZBCcNFjAYuqvwZ/T98my7/2AJ4b1vzTAP+TKO
	C6OAWElRs4rUOP4lK3riE3TU4jk9DVdpjNhgtfF/AD8vN79xsys9E8+Czd1crikoqiEAGliek91
	akA8+5wZwvVTpFgtfrBGhcYG3qS1FsLVtfba5VwARFIXfkN8rClPgYovPUQH+m0LO1MWoR74nh9
	jgle8als/rBBJiNjtBsp/+74CmcqDPuyaqc22O+HxWUVZXexlHHKqY93TNm2tzXWKQgNYbQn1kI
	XxEj4=
X-Received: by 2002:a05:6000:24c9:b0:43d:7e34:889c with SMTP id ffacd0b85a97d-43fe3e0ffaamr28550029f8f.39.1776779419970;
        Tue, 21 Apr 2026 06:50:19 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a092sm2761850f8f.23.2026.04.21.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:19 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/3] wifi: wcn36xx: firmware trust boundary hardening
Date: Tue, 21 Apr 2026 13:50:15 +0000
Message-ID: <20260421135018.352774-1-tristmd@gmail.com>
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
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35168-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 6C25143BA86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

This series adds missing bounds checks for firmware-controlled fields
in the Qualcomm wcn36xx driver.

Patch 1 prevents heap overflow from oversized HAL responses. Patch 2
validates PRINT_REG_INFO count. Patch 3 checks trigger BA response
length.

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch.

Changes in v2:
  - No code changes from v1.

Tristan Madani (3):
  wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
  wifi: wcn36xx: fix OOB read from firmware count in PRINT_REG_INFO
    indication
  wifi: wcn36xx: fix OOB read from short trigger BA firmware response

 drivers/net/wireless/ath/wcn36xx/smd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.47.3


