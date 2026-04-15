Return-Path: <linux-wireless+bounces-34797-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF8JCHqT32n5WAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34797-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:32:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B7C404D20
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D0FE300D4E5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7903B19A6;
	Wed, 15 Apr 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpGDpAYS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B943AE1A0
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259953; cv=none; b=ljck+i8B04i0Cgk39oChvMniI76femlhdiinJKdmNF7WEYVhSHjpHR9xF2iZdpURTCowfHPHVGWFoev2nJoY0p8ZSoY3NZGRqXzGSbXLYD9++yT+mpYa6umzCor9MWIIOGCmEzadZZAMh77kGJh7w5UHK00PozdwGXM6ld1jego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259953; c=relaxed/simple;
	bh=JzY6TbHnMQKD6tpTV95W9zIwOTtJklkFzJD7dGXj/j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm07rLG5aOPH08P1BMoLwdquLyFKKnAVekEEWd+NQkJY8pozCInLnNRaOq74dwDrfargV3cqo1Ad2cnjlfz0Sh4XxFy/hqk/TWFbMWCNZit5J3JktCr7fwf4HVflzUs8YGlZIBLLoN2f0LMLAPx/iSjIRDi0Z8vTrQ2dScMKUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpGDpAYS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4888375f735so67606775e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259950; x=1776864750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJGfQlThfdF78g4FKQa7uEltXkfB9hJKUX9n2sHsgFc=;
        b=KpGDpAYSY5PLJNDdik77heXQ60znZYUyFBV5EM/Ac1c0NxhZRFiwAP3LCRnzCtC944
         /4w+O5yTUECTzk77pnj7HChuqfyZkVmHLUROxF2CPzFktpy0rET4Q/srfwrhkU9WRYec
         rzwRL0A548sXEHggfL3HTWUi3daOFLHaUiFlopihGvtEU3pwvFKdMY7Sz3lDJRxkFW88
         aF3up2dvw8a0/xm/crkJ7ICXOceLzXralRt0UBo4+/matklt7z2xJiDLqKfwzEQkcSWe
         Ungi8pdMhvMhtcsVe3l4efGuOAzLTgoFhAndUfWTpRU2klbHWucCpI4nw17YSNqGTVy/
         +O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259950; x=1776864750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJGfQlThfdF78g4FKQa7uEltXkfB9hJKUX9n2sHsgFc=;
        b=SBVvGzxeLepTBz2KkGY02SUv+lPiRmOWTd73GSEs/kRDlg1pHgudHiRT0J1N4gVNqz
         T1iC239HoWMTtqX/fGHVHTCXuQVLMjggbJCmzajpz4sY6v5NC6PeCMxET2eUZynG79wE
         CrmgnLUyaA+BECTHFduIjVUvBLwBydjSul7zQIXmDE2E6oKUQAlZhoDvpO55+LCcJNsK
         a5chh5o83xfY2+ENeCwgLoXF7PnRIIJWmMbY0zAqDWwszwOAQDApe+tn2ItSkSS8euAF
         qoZOhwVvvM0nMfA5luVtADox9pKncWL20Yv0NshpLjJ9FDGa1EI/He4jkVhdn8fdop87
         16zw==
X-Forwarded-Encrypted: i=1; AFNElJ8B3yPMnvV1ZnQ7BfPJ57cyq0N2AiJvCtA7wu6iRMXbbAXbHbP25ZvnRrae0bicU7t8SjLGiSVHguY9wDn/aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVLD7en31yb4x9BAC2T8z4n1SJuX5uzaOAdkIrEmFnQrOBwts
	SrV5pYjH2idIhfilFQhf94vbaFAug15ixcyYf/3HrKOn+jIkSrUHmoM=
X-Gm-Gg: AeBDiev5pKypgdVwBQnZ+cIe2fs8mrV5e4DDp40Pya0ZGYnzVAFxFUazvIvYHgY7yFt
	lprTMmUCvCVHA4IhES5iU2L7Kmed8VSjMSyDYoAvG7szQZQ454hVCFaxrvUAyUga5qkLEqT4lms
	uzu7zWsN/5Dct/mxlxenIget+AiSakVdzDX+la+CK5BkpFqsqKkJDJtbqj6oU49rjUuIcQT5Guc
	R5+P4PTM9zNEzCU1wcviMLDJs0WRY0R/TSjlDUTVT5e3ypw/tNYdR6Fps4+ek0z7VqjBU7gaVtE
	gx7pAq8FosOgBFQAAV4MzZU28gcMgko/FRFmSsJaNBAR+zpkfN6FHG0cWeCHo4EuRawGPaYFyV5
	sPpQIHA4JTMMrZ9IgFH7jT6Ezi1MJW092sJF7xUJyh5V7Krx7nX4GYczVY/78mM71FE/Ao3+olE
	Buog782uWX9XMnuS4qWpsQODoXfzPBXTzpMCJ3Qx+RufO59TY60ZRKHBPoAbZEg+GfqTrrQirQN
	QBItQUBFdPpHDwVAiT2PdEWjXtj0T4nQm9h3cSZO2cphBZhDZIFNS5tqfyj+pfV
X-Received: by 2002:a05:600c:64c4:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-488d686892emr269700955e9.25.1776259950011;
        Wed, 15 Apr 2026 06:32:30 -0700 (PDT)
Received: from archtop.localdomain (92-242-248-33.broadband.mtnet.hr. [92.242.248.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0eb43f6sm20604755e9.25.2026.04.15.06.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:32:29 -0700 (PDT)
From: Jakov Novak <jakovnovak30@gmail.com>
To: johannes@sipsolutions.net
Cc: dcbw@redhat.com,
	jakovnovak30@gmail.com,
	kees@kernel.org,
	libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linville@tuxdriver.com,
	mingo@kernel.org,
	skhan@linuxfoundation.org,
	swilczek.lx@gmail.com,
	syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com,
	tglx@kernel.org
Subject: [PATCH v2 0/1] wifi: libertas: fix bug in Marvell Libertas driver
Date: Wed, 15 Apr 2026 15:31:34 +0200
Message-ID: <20260415133134.167783-2-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <57275e905a67e789ea438bf637be0aeb442fc880.camel@sipsolutions.net>
References: <57275e905a67e789ea438bf637be0aeb442fc880.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,kernel.org,lists.infradead.org,vger.kernel.org,tuxdriver.com,linuxfoundation.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34797-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakovnovak30@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,c99d17aa44dbdba16ad2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16B7C404D20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for the reply. It should be fixed now.

Jakov Novak (1):
  wifi: libertas: add wake_up() call to properly notify fw_wq during
    disconnect

 drivers/net/wireless/marvell/libertas/if_usb.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.53.0


