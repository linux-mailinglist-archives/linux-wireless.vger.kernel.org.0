Return-Path: <linux-wireless+bounces-35225-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM+gNMYQ6WmiTwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35225-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:17:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E69449A6D
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DFF7305E1F6
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEB73C8728;
	Wed, 22 Apr 2026 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVsVQLBF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65359392C39
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881581; cv=none; b=YgQ7VqClED4e7b8DdSqyXbLg1hZ2HdIZPkApMLaFaI6ZDCpXBjNsjbU2M/HIHNNZV5xcmwiWckD/jSQEEdgMqFxnQ1E7jIKo1S4W2sVRINhpqwTnbD0gfTMnegIP1p2DVp7ybQvPi+XnD9eR5gQD0ZmDZmK0bRY5u/PcKkumN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881581; c=relaxed/simple;
	bh=zqzp6N+tteerZ43Wplk3qf9bDZUdzAlltR13R+ntqsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vgqn34RyYX1Zwqg/2S5gc9PGZwmct8pZOrxQcUFXIlGAG86KCmuHift74RiBhXcaYq+2/scU0b5eH2xjZeDOJiMND/6/33pIZw7Bu8O7SM8+gsn/ePW4ZOyXgNpEd1zVSnFbDfUmaAlImkLZsZ5JsutPfr2acdc0QIWVAlfPp5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sVsVQLBF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab46931cf1so47811505ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 11:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776881580; x=1777486380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvJb0BsWSnyMQEp11ZDn/hO/2BNVrzmyvEY81XwYvWc=;
        b=sVsVQLBFD5xL095uzvxAgaCx4wkdM7U9VTEex9nizrYS6kDkeLmUSdEV6UyRqT1fOb
         A3laFCSq3wq9fImVzhoXz7mwF+/G4f+Sy1cHZaxzrtk2TzUTZEraYJj8RvSShcm1hJzT
         cEzLuNdR7Kf9YkMk++6k8qWzAcP+dc88zMYnbfQDvZoVunRp7hp72w1JyvZchcmI0Qdo
         BgMXAOtjxmJFhmF3i0tN+hJjh6I/NUVoGIUKKXjnsoi66COYd3d1vZxrVnBHpQFNLQKK
         YLjApGmBsKylqvnNgfVCCVzkiCk2TjDySkIx87o6Ao6iw8pHClDeILl69Ne98Ba/Iz+v
         nyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881580; x=1777486380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvJb0BsWSnyMQEp11ZDn/hO/2BNVrzmyvEY81XwYvWc=;
        b=JEV3UpJJsct75PM+rZI4E6imzkxCQW40H2Qk1w02meF0Ke/NneFgL6/OxaUcrl2XKe
         wkVnf443bJpFABuqQM5aUa0Q5/JTbCC8pFbGDQoZw7hKx2fRF0vnUstjRZlCDxMqPOGv
         QNDZIhRXfh7JKwFuUyLAZKx0ewBw4wQjZFAMZ8DwLDS/NyyI/YpIN6czvnpP6Iifa27b
         XU25tkjjrnpHULzj8qqIMirw4P3GNHzWUemm0k7ieWTfu9k6qH8PLGvMuX9tS3jaDti5
         Uxa8DAtD7jvTeaKFYIf1IwzJ6XkDMWbYmonNoEZ9D5WQOS68AJ1mAVRnbr6UBCbkxIzd
         DtGA==
X-Forwarded-Encrypted: i=1; AFNElJ9xxz0XZBkZnWmv3tSahkd5Huq2/w1NFt3bRYX6NiE01YSwLTT44nXzHzhLXelgWRVWl0F+qFzZeZ8lWRtAwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz523q3XBLWXKct8M6oEQHpL/cWxuvrVA4FCcFy8QnnR1GSbYV/
	M6P2tR7+jtaCgU+LlgzhAy2u3QC+vUqnQ37Ltu8QVQpSV8hy0aRFfDnV
X-Gm-Gg: AeBDietgzOhwbrTM2i1KkiUd1pFZ11///f/4u2JaBv6Xjo5eTOVZyYJo7UlCwGPNZCq
	aW3lvEI+wFcMJWWhdwNqcZ72F7Bhj8/hymlZOG5QB6QTOWF2MwNFWwRIZJxh63bgE0lgJQ4zEbI
	C38AAflhJulj0UKyV83HIIEWUdVG8DI/dWjYenxeVP4kE/EyOkjUsjZg0S4t+gdH/WqwwFZI1eR
	ldFLrkhlpqe49+aNBsxIbCNpfQtAtDQIa/4bWcRcAiatHvjC1h0GS/Cy7CO3UaA425HZvKuCBS9
	KtCge4PxjsxyIqFGw7PzzyiYHDtjo0iHKy63X/j6XsldVJo3OpitigwJxIl5LV0tbuVE/40Vmt3
	FVt4LkjjV2vVeB45aRZEyvTLGbTaQV4qKItZYYouiSxk4PLJIDwunOlxfC60K/xN4nUrVQqybgn
	mqgfpCfkj9NoGZiWxsjXIWEjw9mYqESaMPiLJEqkcbFwS5H+n7A+GcyCT0lFGYgOcoBdA3QMdgE
	Y7VIQ==
X-Received: by 2002:a17:902:e748:b0:2b4:5d0c:7a85 with SMTP id d9443c01a7336-2b5f9dbcd42mr221249815ad.3.1776881579714;
        Wed, 22 Apr 2026 11:12:59 -0700 (PDT)
Received: from lenovo.localdomain (211-23-53-87.hinet-ip.hinet.net. [211.23.53.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff713sm173734745ad.5.2026.04.22.11.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:12:59 -0700 (PDT)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] wifi: ath12k: fix false positive RCU warnings on PREEMPT_RT
Date: Thu, 23 Apr 2026 02:12:46 +0800
Message-ID: <20260422181246.1944073-1-asas1asas200@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422142325.Glnd_2Zc@linutronix.de>
References: <20260422142325.Glnd_2Zc@linutronix.de>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35225-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asas1asas200@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28E69449A6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 04:23:25PM +0200, Sebastian Andrzej Siewior wrote:
> As elaborated above, this is not PREEMPT_RT specific but preemptible
> TREE RCU.

You're right. Sent v3 that clarifies the scope (preemptible RCU in
general, not only PREEMPT_RT).

> If both this then use this then I guess something like
>     lockdep_assert_in_rcu_read_lock()
> is what you look for.

Adopted in v3 - thanks for the pointer, it reads much cleaner than
RCU_LOCKDEP_WARN().

v3: https://lore.kernel.org/ath12k/20260422180814.1938317-1-asas1asas200@gmail.com/

Thanks,
Yu-Hsiang

