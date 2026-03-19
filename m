Return-Path: <linux-wireless+bounces-33515-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLcPINNovGlQyQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33515-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:21:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFCD2D29C0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 22:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84784300BD87
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 21:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3B83B7753;
	Thu, 19 Mar 2026 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs3mjMQ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F43B47DB
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955279; cv=none; b=KWkZc8xglGf7Dq8piAAVwwKgWwh8NuPNyrH1xsneDdc6s7jo64oiHxb8+UpjQOSZY3Jn8NzAcmZoS4G/uRKvmUd6dC8k+B+FSe5eoSsM5rw88+Txhed9Ycc+nqhrQZ5JUja5fh6hnyOD5M1Pb0iyTO0eeRWrvI4ig8iJtJoDwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955279; c=relaxed/simple;
	bh=D/zusD1Xejj/hltftP3JIGz+iWb5xyo4W9F7zQCyN5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WuD2Q7xn3v8+tFhRlRxEz6zdjZUtkkbSHXYSAKNkBMOHPtTamqe0hzQpggZmr3umeTokWEkb9of5YKzU7W3nOIA0agsUfwOZs53ah7ygVmTpYC3njUwy3qjv0PBb0sKRc4ql1qZ+jOk7QYF/dEKyWX4dFQxsVqwc8sA859uf/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs3mjMQ9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486507134e4so16722785e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773955276; x=1774560076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/zusD1Xejj/hltftP3JIGz+iWb5xyo4W9F7zQCyN5A=;
        b=cs3mjMQ9P+P5dNmBzEKowXX15mPZVXDkVim+qZ8tBZrQ5YrbPBbVxkSsgL3T+AcT44
         F9SZIhJxwfgZSN0ONtJrMULnI1Ok6ODf6pyD9x/e6ghmVW27cJj3DfNPfZm2oP4gzzcD
         KvzHZtyYRM7e/C1s00i0N+PcR69lKKTUh7NrWmLrHtWXP1nqg1lqRfgFUk5phgm74tp9
         XE3joeUycAlG314l/jIJVWqQM3QyS5mjwx0hzNGCb0s2EFih1DPOMKxQZ/6/yCUgjGpO
         X0OigO+zNelsAfQVqPuEKzewn+zGre6+L0hRREaJoyus6V2Mc9/TPSPYFhSRKGQ9N4c1
         wMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955276; x=1774560076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/zusD1Xejj/hltftP3JIGz+iWb5xyo4W9F7zQCyN5A=;
        b=OQMDdQ4VXZB598/25Tzk7z4vZG5YeRmsrKh1vTUTdCRbJZYo/iNwTO5dVFCb2Hgp5v
         DJSS5ii7eoDSKr39B8zb7SuRUnst+JI2Q+I1O0HhSp8uiGOWwDFkqmdecB8EMfh6Y4aa
         MPB1VfxH17yGGv+PfDNGiODnqbzxkWMwEynulgiwItOlT05MGc+dPy4/N/jIwKbV/gW+
         +aByh0GFnRIeohZZ6vrZlkxJNwnDp3cwnjUFC3D84OjDspOupRhrlPm7m0++3O5ZTJT9
         K5SLlf5qLuEuKiHEgjoKx8dJ9Kw+RArjqK8rB5Hug7II2a9wZcHepXxlmEl+DQ4zJai9
         3XaA==
X-Gm-Message-State: AOJu0Yx4MBnHOph+XSZeyeh/xZ2TbLnqfIsP0WLcTr7WhAaen/BIx0UT
	deeY+QkFt9OtQ0BDx3G4ufwzpLS246ndiv0r/tVSYBm7UVflwaxsaojB
X-Gm-Gg: ATEYQzwQ2rbQXjwp32EZud0RrADtAelhqec7fB/lVSmpep3EfOhP4+6ezQWKWqYP1fl
	1mEBIXdL2bN/z5niMW6ohPVUvo+a4+xQEOMkTSxcB+oqG/rg8nvSM1OCkAPo6q8+SNcfLWqREmO
	hNqsNxzIrkcMB9JI7ldOU+JY+ktqje8kL2gOsR2shA/4lnSD0yJ0Z19DjventqmrAyVpc2NsxIp
	B7cXDiJvx/Fb2q0EZmFNgsJyFysAnU6n5MEA9ZmRyegGdBelG9GJndnlbXC50qn8joDhEu7CUJw
	KVlAiMT9S206IcJeMLOuHkiEg4nX9gnOStaPmymRz+9umGvM+tnWWjS3OXqFd8yhM/GQYLMaTSW
	GPtYYdPjG7ndgFw7O7zzE9svwcMwfv53t8oP9eivHC5/CYlmgneAfFzqdBvBdvfd+dvlmiq6piA
	FaAOWlY0Rbb19CUhlzjnZmo0mSTNAY/jQ2Yfj3x8sxnRXR
X-Received: by 2002:a05:600c:45c7:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-486feddb6d8mr9228175e9.15.1773955275729;
        Thu, 19 Mar 2026 14:21:15 -0700 (PDT)
Received: from debian.lan ([171.22.85.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d923fsm27900275e9.1.2026.03.19.14.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 14:21:15 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: Re: [PATCH v9 1/2] wifi: iwlwifi: pcie: migrate to modern pci_alloc_irq_vectors API
Date: Thu, 19 Mar 2026 22:21:05 +0100
Message-ID: <20260319212110.29819-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.43 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33515-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBFCD2D29C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Miguel,

Thank you for the feedback. You are absolutely right; I've been overly enthusiastic in sending successive versions without allowing enough time for feedback to be processed. I'll slow down and wait for technical responses before the next iteration.

I also apologize for the incorrect CC in the WiFi thread; I've double-checked with get_maintainer.pl and will use the correct lists going forward.

To clarify, I am an independent contributor learning the kernel development process on my own time (not as part of a school or lab project). I really appreciate you taking the time to point out these etiquette details.

Best regards,
Adrián

