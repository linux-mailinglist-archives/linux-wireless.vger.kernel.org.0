Return-Path: <linux-wireless+bounces-36190-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELQBMCJcAWpRWQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36190-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:33:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E37C507D92
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0550C300A8F9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 04:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567AE35F172;
	Mon, 11 May 2026 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBGLo12Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333C1CD2C
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473994; cv=none; b=YBtAwM8JkopgE9JNt1I2BDY/yHkTfNowLkQFgobIRgweQfdChPkqsys+YX0kMvT0Er1Vb+UGpiriptYLlXw4uHFNDSpQrZlYMMz4tlTqWMRebPWXcfQA6xmPK51vFPQoto79SJS/4EVOBwrZXF6508eo9OqyD8ub5id5OCT0jLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473994; c=relaxed/simple;
	bh=TG/vQLaXbRfd6lJCu7ood/bYwWzjkW1iUumYzPNE/qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fD+vQKzjdfSA+FBuLNeNPUNIh7nl4zrIdEtRu1gLAOvoLU0mrmsKApIfy6HroQOPG8KbXXbedLHxQom8MdYXpNQyLIdtW66lat+mF/duyp5a2ilG8kldujDPxx2b3Ea/n4NsYa+1PLgbUSrRkRMBAa9rJGXE5+13U0EPi6jNpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBGLo12Z; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2baca78cfaaso26172165ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778473992; x=1779078792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG/vQLaXbRfd6lJCu7ood/bYwWzjkW1iUumYzPNE/qE=;
        b=dBGLo12ZloAc+VJzSH2CCD3+cx07+7oiUkM174fM1hYWagO+vtdO4qxCgqOtW9Bbdi
         Y2WYZ85b/rbWYQ1DL4hz5/IJk/xoU5bxnX3zFF1X1hnOad+jYi8y7shas5fGyAQBsuSY
         hkbJ08A8KNH0GJ6rq9bE8t6Z81rNNXuT+++L+nFqjs3rixCDrE7PVC2UgmnIjPyEqzbJ
         FmMOOhzjQhbxHPrdFJhJYAcLv9Vm1yCSJooagYEaev40Gp0QxdaLLP8uD1fUpaKx7e7r
         koZpHx6h0HgkOesnqb+PN4ekJ7rj9/gNQrI1ajnOAJhF+MRIHxd6NVs+MXjP0d//8081
         C/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778473992; x=1779078792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TG/vQLaXbRfd6lJCu7ood/bYwWzjkW1iUumYzPNE/qE=;
        b=mY9K8FHWZQN0g7Q7Hbk9MWuO069kjE60QVtll8OyoIndd+L5FEoD/a5Qvn5MwNYD2+
         3k6YBVXHSZB5m82Wkk/DVmGeXkTmfSM7TvAhYw9n768udmxFIEobto4OOv+EPte7+fCY
         b7vPIddB+6v09dKGRIF2t+rgBtW3l35FsXDBIrjFV2Crhml2dU/BOf1HrkQ0bpuoSTge
         gdqM/059ZmonjTwxCImLuc2gl5sSKUgWAZJbPFf/ROL2swN3mGvMmhY3IHlBlPbKiQCj
         0AoYQ9xgpw2//Xg7BrDLoBQf+/9s3Si4MoByscoihL0QD80LuVXVeMx2+LEmVVykUut1
         npBw==
X-Forwarded-Encrypted: i=1; AFNElJ8Zq35KDvPg2+l4mDlLRTyhU2AJcS/5Cfzgp0+zI6FZhDzbGB/Ano2kliTArh+4hMFgUyXwQucdMW82kgjS9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4t4LWooLKVwUvbLsipUzeiTRq+tFhdrLmXkw4KMEmAPpkrgIq
	GxpVo0HmBCA9at2cUQkY8FOIXvaRbTDVytHP3C52IJSnZvjWhKJGpVx50gVG7A==
X-Gm-Gg: Acq92OH7ub4y42LS2BPYEjE1nbF7WItZ51Xkmv/J/ykeUfokP6M0tLt0sJE4wYY21Gv
	rQoRe6nvwULCHoNCs/wcOnD4S0ypJtsLm1hkU93PIiT2Z1BwwWsrQb9P/lGTryX52VwF53tM5xQ
	v2MkPOQ1OxNZzLIfpIak/V2JfhiehFqPozDWbO0bgXAqDxwD0Rc8phALw+Fabg4BYq/vLyeOFAy
	PcjRWClHrXHGH7cctVX98c51ciS2dKhwlAoQju6WrOVU1Hv9O0+IYHGcHZo+tXKtn1CPc9Zh95X
	AGs5vCOMTahbQmOGQR/OyxMw4sSKWxCq58ffmXuI55346QXncmUQXI1pVv1zrfc4DXaAQdu7b0r
	JV2bogX0JHY7SoPgQOFYIy4yy+QpY+n5b8UGas+RiWG2Esz9PWEtdc5HWooJeQhsC2mc7nTqPs6
	ZZTuGNzAbUK3vSsnKrGgccaKy/raBwP+99nHEfcZRylqB5JwreZ17YyoW+JVka+w==
X-Received: by 2002:a17:903:903:b0:2b2:50bd:83b3 with SMTP id d9443c01a7336-2ba7908b656mr230847755ad.10.1778473992394;
        Sun, 10 May 2026 21:33:12 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d271d1sm89109725ad.11.2026.05.10.21.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:33:12 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: ajay.kathat@microchip.com
Cc: claudiu.beznea@tuxon.dev,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] wifi: wilc1000: fix dma_buffer leak on bus acquire failure
Date: Mon, 11 May 2026 10:02:25 +0530
Message-Id: <20260511043225.1000323-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260510112520.977360-1-shitalkumar.gandhi@cambiumnetworks.com>
References: <20260510112520.977360-1-shitalkumar.gandhi@cambiumnetworks.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E37C507D92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36190-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cambiumnetworks.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Please disregard v1. The author attribution and Signed-off-by were
incorrect due to a local git config mistake. v2 with the corrected
identity has been sent and is threaded as a reply to this message.

Sorry for the noise.

Thanks,
Shital

