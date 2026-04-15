Return-Path: <linux-wireless+bounces-34845-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKpfEIkQ4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34845-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:26:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D15BF4089B5
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02F3B30827AE
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E8439182D;
	Wed, 15 Apr 2026 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzKxdBXR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184E3939B5
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291853; cv=none; b=DVL3ei2kP+slelJ3G+ssoAE2HmbwvDEQObWM/YKkpSJgDRLjARWDIZjkjQrUuW83g/DHgsE7RtEXdrGHUG9BWC9qwKaAuWUsh8dVMNT2UHiSYSG7mi3Cm+orN5NzDoNRCs3Jn6fGJYqZzGkWqxOXJPy2XDtdSpMA21+YOMitXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291853; c=relaxed/simple;
	bh=SEW5zJT180O/zKSTSj3TJA/Ia7qGoLyBMbYHz53jdbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tT+y9UijFjYQPKOKtPjUjx9FXVKjXb4ee7cOe1AlCTO/cXOnXMAfJX+ghcEib8hXb7YYfA4fFq5CdQzvgq0aRSz3SC6lBCtQO/T5R2q2b/HFtsqDRVQREgIzIyGKvKSChm5P18au59whef66qvvkYKbITwqr8q0/ul6PdX3ACwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzKxdBXR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso88710925e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291850; x=1776896650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEW5zJT180O/zKSTSj3TJA/Ia7qGoLyBMbYHz53jdbo=;
        b=HzKxdBXRTQbTpuWQQnZquKAkSIaMaY/zvjUwrg5kuECOOZ2rdot+ElSP0JaR1Ru2ip
         QLTEuGLCi0IYMoG5BAAQvqzYVmMYA2FqRbJC7FBG8MJq5BcC4vMPVGwBgkHHQZ9nmczc
         2CXRIoLl+bvlx0kxqmPJJnDd7JOe/Hn3x+T7oOGwGyIthAAfHA48yI/b3sLXclaehfSl
         KK0Y+ZTUOd7NBlElagtm1cZsTDRxkmh8/1VK0ATTbwOZmFpE+pR/6LfFW0OVL0MnwCXL
         XRcrPiAkkt/lKC/sVFdOowNqjzGB6XGBD+4Ak9zr1L6bPD4WBPzBDtQTY4V3ASl4niQa
         VWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291850; x=1776896650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEW5zJT180O/zKSTSj3TJA/Ia7qGoLyBMbYHz53jdbo=;
        b=GIY/MeACaAxBRZSCrAhVYcSY10VuqJNujgkNIa95KQcJGuL/odb6m+oDg9OxtsUwnX
         Aamp0Trskw2v4dXdUJfvyM1qu0kILeJUADbXlUpvEC1x8i+AGRyP2coRtRzV+fsfkcXC
         XwFA65C0A/YRpjh8q1gpjehTH8Bj5Gt5GPkoDmj/W9hqpfwYjsshmLyhKGyXvbuBwlnh
         Y4Ipj8EfUV+gI9sZJ4JlYPt5JKx5bsQQF75C0p7HF/d9TjeX+s2QOuSjdFLQS4McYIQ+
         Z0AN7GYAgoKu1Gtv3GSCb2/nkR3oXb7lGUrYwyRAbEvl9ki3kLakt8D/6Qm4IFeQFFyg
         KvHQ==
X-Gm-Message-State: AOJu0YxT2Hqntl68OgzSC9j1a7JEVb8ifP4y+sKADe6dEVaVK+ohB9kX
	HrIM0FGNWKNw1BCb9w11vOEM7YJkPSI3TR7Ocq1K65VVo2pxed9y3KM=
X-Gm-Gg: AeBDietbhdszi88SDAoEoBsyXCdb1sGnzNE9R2IaSKoadfrq0uUtXKv+wzJv4kitIJq
	Nj07/A5LEO2L/96uS+w4ip1eSW8OBqCMMC0lWhr3jcI2GvaPStp5t1qzGu/l3HStiIOq29HBonT
	IIP/z5ihRU6O6aI71wc9hV1hXNRxNk4gMUzTW3GZa2Y6T1avinnxJ4XT0KL9+SEuo2S0LJQrekl
	MtWmPds/+nxlttdOT+601vf9//Krd3H7NABc51JJRPZ71b+4zUk3/fDKhL+UMnuiADApMR8ZKEq
	L46NCC9ilUGYXCAyxQ9NwLwPYieFMD1eUG+yZ+onQPwGsxU8pUN/ik/PhdBXX+0BYthhJ3q48qh
	V3QigR/FR9/Q6O68AofEWx2qMW9OaCOTj8hBMNe7OYbXHXvKpbvm2mk7WrTX4ThkGIdVFGm6TPM
	q7DpMp1kcyhqedJQ==
X-Received: by 2002:a05:600c:8709:b0:485:4135:5c92 with SMTP id 5b1f17b1804b1-488d66580e3mr320589245e9.0.1776291850427;
        Wed, 15 Apr 2026 15:24:10 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818da1sm1932785e9.6.2026.04.15.15.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:09 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] wifi: wlcore: fix OOB reads from firmware event fields
Date: Wed, 15 Apr 2026 22:24:06 +0000
Message-ID: <20260415222409.1542989-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34845-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: D15BF4089B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Hi Johannes,

Note: this is a v2 resubmission. The original was sent via Gmail which
caused HTML rendering issues. This version uses git send-email for
proper plain-text formatting.

Three issues in wlcore/wl18xx where firmware-controlled fields are used
as array indices or buffer offsets without validation:

Proposed fixes in the following patches.

Thanks,
Tristan


