Return-Path: <linux-wireless+bounces-34852-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB6iHt0R4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34852-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:31:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE666408AD3
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4963231D6007
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCED391E41;
	Wed, 15 Apr 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WALNlVFj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58D364EB0
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291869; cv=none; b=HPoRrw5gzsXmRbYJ+g+nGnqi7Mu+M83xw9hqRSV8GkuVwS+uDW0DJ/Z7HBmQHk3vjwQoaonPNWlk2U8VCwGSsogvKAz79ErN4zp7FqG8t6SRiqprG82kBZ0mHQjKZExLrpynNfm+C6qX9Wn1bGzFAAqhFEJs6q9U0zA2F45gWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291869; c=relaxed/simple;
	bh=I4P/KPSPk79n8En4cUv+2weHLeKZt0NTU8vFr8mQscA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3J5kIw0wEcUJOm2suricsGnqcVw5NyUOn71AwbRLE+/CjP+NFYQ8XzDkC4LzRlVkYuYBMnH+QJVcoPe7etMHqOThiZpzjbqHALpKA6KFoUsVZmDdXQyrs0EncsDP913bYhttFTBclgWqtz+Qtjg0lGC8wCcQcl4fA92w5sW+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WALNlVFj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so97042065e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291867; x=1776896667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4P/KPSPk79n8En4cUv+2weHLeKZt0NTU8vFr8mQscA=;
        b=WALNlVFjWoMQdvMwG29I1QVlwVMPBp7A9amVngNTEPt1FJYsqpae4oMaaRO+zzz4Np
         WPERn8bsqMVqa+aY+aX5PrgQ+oG3aV82RcNbqjCvcoLzeXism59ZqgJvOe75H5FOP8f+
         5xWEZvLftS5N/HlDZxfijG4GkrGsw0stThe9vqU1duseVPCl+deV0pLEKPCs+SIPRUh/
         EoVnJRg3sEf3r645dLHT/v5O8HhcCxRy4xCHHgSMylHP/8i+92wgYkVu+0xt0Nq0Eqws
         l4S/dHBdiya1pjS39ZpShqPDDQ9e94toImSy9YdVHVZTWlV7iGz/b9DHHjhvNoyq90Gn
         neCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291867; x=1776896667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4P/KPSPk79n8En4cUv+2weHLeKZt0NTU8vFr8mQscA=;
        b=eT1Nh3W0WbmDKSYlVwLzuzLjW0akucRsws+tspaPc0XUoVQXoVKhRzkfaOBT7vk1rL
         7lRdYIkf/jv+TNaKlL+ggLmzsXaUKHMgY9VFWS/5vl7xrrvg4lR1rVFfEHsB5pINPqj4
         U0gEM+z9dKLfGuW9lSbRUsGA/WuVXNuJkB081AmBEcv2XZdvvc5NlyV+wpgwt7xgttGW
         h7hZp42ba7++XFtJ8+dTY72bYYKTlROAN5ug9VlpcH9sG2ZXt7ez/LmAC0yhJn7taF3Z
         /nNqws3M/L3S9UrHKEI4lXVvm7sEaWiuj0G6Ee33b54FnrTCluigSp5+CpCOy18cm57i
         AkPA==
X-Gm-Message-State: AOJu0YxCuTCE0GaBulE4xQKYjTZrlj9o5RLGCqCntRgb+jVmANyGxOMT
	lgmk02OAQBjkG6hmL6RGyEHjsvOFQrBnCG6CzVPi9dJEjVtLGmuORnFX9pEbCJHINQ==
X-Gm-Gg: AeBDietVvajY5aIUo1e0Jw2qkr1dHNZfNvi+dzcb3l4DYqF/I7aANsiD6zF7n/eiQsZ
	+An89RihK4iy86c6V0bjDur49lWFo0IWfzWPuJbvUOgcHkVtdA7aB2A2kuDI1geT/ADDfhoqfAa
	VLiiBauuF6DeryulYfLZ1gyN4hDrg+m+Qmdbr155qC2n5YHyrdrpVrVKlkOVEigeHzPsevkJhJ3
	YvqIEdKpm9fxGwsb10amdRt1e38kzARVL0/3OiKKwVSufkTYHEh0BTgtOkXSIkRKzdDxe0kdhD1
	zS3yHG3fJlmnlJyNWTT4GACcGUE3wIpHD4G0VCPRGRRkEVtn84xixlq5Q9cEc5xADVdJNGBojfT
	v/GL720F+1cme+h7EOEW+yCEz4fWWHdrd9NXhRVDBUC0e+FH0cZjRXBo+/cLu4QYgkjPFNaDPYJ
	xPOuA=
X-Received: by 2002:a05:600d:12:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-488d67df3f9mr262213745e9.4.1776291866925;
        Wed, 15 Apr 2026 15:24:26 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5813954sm1896615e9.3.2026.04.15.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:26 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	b43-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] wifi: b43: fix OOB read and infinite loop from hardware-reported values
Date: Wed, 15 Apr 2026 22:24:23 +0000
Message-ID: <20260415222425.1544638-1-tristmd@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-34852-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE666408AD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

Hi Johannes,

Note: this is a v2 resubmission. The original was sent via Gmail which
caused HTML rendering issues. This version uses git send-email for
proper plain-text formatting.

Two issues in b43 where hardware-reported values are used without
bounds checking:

Proposed fixes in the following patches.

Thanks,
Tristan


