Return-Path: <linux-wireless+bounces-34857-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N5FCQAR4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34857-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:28:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCDB408A10
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF73530833C1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949E738C429;
	Wed, 15 Apr 2026 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwzPzl4L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3227639151D
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291890; cv=none; b=VIbEll+LsjG2HoT5pRGpFxUcAo+agNuNPQOvEORtKD8SeNrafvpSLyALhGkTUFE8OA8cgV4AGKR8vwkl0ozCwF9F5wHjIiMT442ZPN8IscPSEb/Sh5YxxkrpkBVAF3kd95ahraHVUZlK+FioRz+KOR+F4ePUVudVAVyuAs74vcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291890; c=relaxed/simple;
	bh=Vi3C6nN3Figf2bsxirx2vXKUrcBK4DyeCtOKcXOamTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QldocmSJuPkuqGInNA74vP8TiviuHHAGvMqAlao1fPzz4AkpPjDfzxZXSDhuHKa9FD7rb7MfMsj1TAcZH1k2cWQfLptwUjHzXhnJf4EVsHJHizvNH77mkNGg2DXk1ArJt6CEA9ooNo/4eu6Uxp73+lEpe65HnLKu1tHGa1F69lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwzPzl4L; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so52451255e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291887; x=1776896687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi3C6nN3Figf2bsxirx2vXKUrcBK4DyeCtOKcXOamTg=;
        b=SwzPzl4LzVITEi1UQmih62oMuW+WuD3PtoYoaflx15xIxKgrCnlRclOgxEHDffPSqB
         0XSOTv17FcVucQ5GFBHyefHkpPfWDyDxqq01bQeUtGgLlCTNVd+t0TBAy1D1pIR/Jh5/
         r+2a2N1UXRMYoJVOT494mgN7S3BMwPMuE2VEOpdGJc89Ta5TKGmVIYK4o7m1cZYk0CPg
         9qJzqFFKXmAJSSUrMB40lAFAeECipAkFIOqhMp18MKBBoxESuDbN3ZIWc0RseI/RKAcH
         8pynitcRbErFnIqwhjtFkp5LdzKYf+xgK/rBFuu/BK31x5Jo/6X+4c5Eaa+Wc/LH342R
         SE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291887; x=1776896687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi3C6nN3Figf2bsxirx2vXKUrcBK4DyeCtOKcXOamTg=;
        b=MfnlxQ+g+Te3W3fySxbe1+F4nIZBkF/6oF16zYsQPKM4AhXNunG2eGryBb/F+6/IUi
         Qv4zjM7A3VNX7fIK3MhSVStFOGKVFAsmn6eN9xyTxNaLZ2r70HLUVkuq3UJ9NX1Ey/FY
         bj3ktDAF4Y/VNDu68Thkh26mgyDe73OKIEVCrW9VnjXvW3WPAZz7cHRBdFU48KqYDrpZ
         Gii9HeysWhMjxQIPt2O5I4eIRWshywF0W7+dwNc4r3c3eGM4Jui8v0Hew6x0XeHDfr7B
         9E3W2N14KfeUxwKX5mx9pwnkoI9a1krOpKKV1CELsrz6iiyPQWFRavXWOI+i0vtkaj7p
         5faA==
X-Forwarded-Encrypted: i=1; AFNElJ/OIcprxFFFOzB0tbnzu/CUf4G8w6aT17ZKWttmx5s3q1DaBv4IutCKKxQoLohqOW0BbMr0PjZyexyKLms5VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzILnmXEvltQ1TGDk8X9LTFo6z1THwEmiHf5rDtNePIXsJ1HSj
	3U9WONictOO6app3HZ+1h3Bl4lXiUiwJ6DEw4pP2hfWwqrmjGfvPRh4=
X-Gm-Gg: AeBDietptK+cVdEogymz8vH8P4VNY5pm6siDOeKSKYdP6kOBWGG+UnatJsP4fyMa/Vo
	Y9nm1mv/gZkNwpc2tpLoSdpAaEDMhG2ORBbDRN+29i/R+KuTiwFMeBHKK0J9eJSeZCghw4hTL06
	G2N031O4vgWtrKwsxI+HtkKL/dbcE00tt6amI/VCq4EW5KZxm4THDdirunwjwcDLenKnVppGeMt
	J2Sl55onkkquxAVkHJhK7QMqwHSaKTy/Sqw5ZtK0t1+HAuknTYE88HUtl4QUuxQPNOjkI/pniWE
	FG0HPc01k2wMByutHx6gPW84Q90wnTj6OYks5ABj1XcTquFanD6UIqF7u59Xe/zZCrz7Om/aNIc
	Fgt4Kqlg9b899+c0vabT/5WYjW4kBtbYMUKSAQBTs25C6zPjcMvxbQ6SlDBVS9RP1jeb712wD1J
	qklHQ=
X-Received: by 2002:a05:600c:45c6:b0:488:a797:f0ac with SMTP id 5b1f17b1804b1-488d6ac2226mr283876365e9.28.1776291887556;
        Wed, 15 Apr 2026 15:24:47 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818e51sm3144295e9.5.2026.04.15.15.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:47 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: libertas-dev@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/2] wifi: libertas: fix OOB reads from firmware response fields
Date: Wed, 15 Apr 2026 22:24:44 +0000
Message-ID: <20260415222446.1546616-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34857-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: BBCDB408A10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Hi Johannes,

Note: this is a v2 resubmission. The original was sent via Gmail which
caused HTML rendering issues. This version uses git send-email for
proper plain-text formatting.

Two issues in libertas where firmware-controlled fields are used as
buffer offsets without validation:

Proposed fixes in the following patches.

Thanks,
Tristan


