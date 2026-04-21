Return-Path: <linux-wireless+bounces-35146-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFOXNgGC52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35146-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:56:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A03043B9B8
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F626309DFFD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8652E3D7D79;
	Tue, 21 Apr 2026 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1+x1ZOS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077983D75D3
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779373; cv=none; b=j/ZiDS2Z3x5jSOTKn1gOWRu9Sp254qvYL3JH4VZU1DfYlxGB4FjxrEBxGQFT1GBg9eZ7Ln7BGPsW9ZunnO9jUYG2VD1BcsdN3bxpMuWOndbkTmnwqV+GOrW0ilFQbSL1s+C6BIJCaBdtc0S7Bqx4awJf6RhwrR/LgE4AJukXxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779373; c=relaxed/simple;
	bh=b8b/Yy/jpr3q3eZ8qHzJviWI+ONrm6G4QbNL4jGwiyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4ppfTlBsFCWqM0ltYIZaooUYcGAwS/ukLjGyvVHLa3KRYdVicf12wpxTNj21aJIK15mx/214wQALPFvvg3u0Zawp9M+7oCyLZw7Ym5fac9zHG4u2lBv5zxNY0rl6ilCX74eZP5wO1iaLYpzcRVKeDCAy149CNFY47Y1XPjfFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1+x1ZOS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so54919325e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779370; x=1777384170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0py2CuukM9HdCZf8dOTX/TKF1J0/3gVm+au1+/3vNEs=;
        b=C1+x1ZOS0526EB2lBe2Bfn8gUbXi4Ivb7ltCfYvjxQifObIdo0k+PXGGCqt4cu/QV8
         CKyQj0mXWbFeKlqW9c+inoGIgEOcof1K1ORUPVktI6bFOMA5pXnHjzrV4frxl5St2QcT
         ax2Didd0W6BYzpd/s5aDGn8URGAI5i7tfxOwoUaTphC77YR+44+UgCcQafJgmYY3IQxt
         Y+S5niDITynlk3iHkjJatQD5hmXHP5Ip+aEKB+gjvj4ibCjKqQ23zR1wdgymPocxsKcc
         IAvJCZI4l2lOAW5dQBX6VT0Rptz/VkR/Ee6u78v2vYM5HHHqkgHIW00WVNSr5k6Bhlb6
         vafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779370; x=1777384170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0py2CuukM9HdCZf8dOTX/TKF1J0/3gVm+au1+/3vNEs=;
        b=phhNyHLweDDJSMNPLC+48EIaNAbtsfV7TsmlmopEOrVF9zwDn44ROpBzhVXwg6IJLJ
         OPAoUL9jpSPBTlTNT7t6WRDi4mh2qZtV9yZq3148N3d+fBJuDEzF7kDkkejU+kQ23Qec
         kxqDl+tCI0VGlvHOg/6TYuuMX3lRq7xQqTqbzjptP9b2vgWq0Mdp+g7k9gAneSkQRGYx
         CAQ268iwaB6oVzHTvK3OzrXWbD7195pFxrpkoy0Uu2xynw68bbe9E7BM03K9zOJePdyG
         sfpKRO8pjYfWy20/31Zu1UjuANCwbu7aH8xmFSJLp8YNmEN967Q0c9+m75m6BchYwP6Y
         Qjtg==
X-Forwarded-Encrypted: i=1; AFNElJ9mYGCZ81jalqcwIO6wJIr/VC5NMLgCJSgipgDE2s1c61Ok/w/Pt1IIpu2ppxTLc2aBsO8F+Ux2Q34r+3ST3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQF9VE1JDmHI8qtlY8XNhGVbufXWH7R05P06mFzyBkL3Pb9g3
	tJUg0m2SgVbhSuv0ZmF4JBO28EiEATvxXdInnMgvfy+u3Gh+zI3PbTg=
X-Gm-Gg: AeBDievklGDZLMUjj/LLyVF2IWkRmw9XK4z1AJmMfD8XFlWw5+8x7S6mGXES6wWCsc1
	vPJnf0J20AkUUTcI6Cw9scnJZviBdCFhCx3JfKOu0BCF9VoCvE5ZrjxKXqyEm5awzdxQTfyI0Ki
	M/F+vXeanlZK7+CkSLub8KUTIlS8CvMbdDFeYyH8eD2AFdwO1W2Bhk1kv4eXe74w6F/ZZs10hJY
	eSengcWff+khTU+G+/Vv3D6Q7IL9ASjSnaARjBsmXifKUk6Dk7j5olK2fao4C/8RYawDmIqikwF
	yZCx6IZIoLEBzAQM+kCmso+CECb1f7yqKndYq+kP8XlNUtwr6usmYeMLALRmPT0zdS9Dt6nRDz5
	Als9FLQLhdzHEq0mKg69tjMb69GSLkeiMWAQk3WN90518JFWsWoQvuysk0ShlM2PABV8WPYycA4
	yYnSA=
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488fb7880camr265076365e9.23.1776779370391;
        Tue, 21 Apr 2026 06:49:30 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c318636sm168157785e9.7.2026.04.21.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:49:29 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/3] wifi: carl9170: firmware trust boundary hardening
Date: Tue, 21 Apr 2026 13:49:25 +0000
Message-ID: <20260421134929.325662-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35146-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 4A03043B9B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

This series adds missing bounds checks for firmware-controlled fields
in the carl9170 USB driver.

Patch 1 bounds the cmd callback memcpy to prevent heap overflow from
an oversized firmware response. Patch 2 fixes an off-by-two in the TX
status handler. Patch 3 caps the failover copy to rx_failover_missing
bytes, using min_t per Christian Lamparter.

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch.

Changes in v2:
  - Use min_t() instead of separate if-check in patch 3, per
    Christian Lamparter.

Tristan Madani (3):
  wifi: carl9170: bound memcpy length in cmd callback to prevent OOB
    read
  wifi: carl9170: fix OOB read from off-by-two in TX status handler
  wifi: carl9170: fix buffer overflow in rx_stream failover path

 drivers/net/wireless/ath/carl9170/rx.c | 7 +++++--
 drivers/net/wireless/ath/carl9170/tx.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.47.3


