Return-Path: <linux-wireless+bounces-35182-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMLmIAC352mu/wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35182-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 19:42:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF68443E182
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 19:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 230E8300FC7B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8331A07B;
	Tue, 21 Apr 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZzXfhZt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F22EA749
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793073; cv=none; b=DY/63jIc6ICZNd0Y+2wfRdy4tpJn7WxFsHtJ5IQLxHbWtA35G8T0rlg/ZXIR+E8QnudxsS2KKxUVS2UIoONE7uQN25mXxYYXSPuHwzm7uk24cVV1BI0gQNBiwXqbM5R/8qcnQR64caSyrFwtFLHlsu6z6AnZtPUu5z0VaNza5M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793073; c=relaxed/simple;
	bh=/2ixQXFHVUXDsGjirX+hQTMgz+71hp7/OJ5nFlg1aaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbjxZR4Y73Vapu/tPNcJK6I7BH5hZxkgz23tqY8/Y9+NVkRCFw5rUCJwJarV4AHH9sQY7A+sLcw7H3bq4vjXN8ysUkeRNMoUdPSGrxs6S1tcyM6l0SlDOyqExpDw2yK/wj8eJ1CNbO0m3YkhfFgF1HEnx11sGwGAd6PoSlKJLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZzXfhZt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so2857846a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776793071; x=1777397871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2ixQXFHVUXDsGjirX+hQTMgz+71hp7/OJ5nFlg1aaY=;
        b=JZzXfhZtbq3K71JdKkiIoaUV8BMzsiNUdQcs0+nYDty/EyaAY4gtOyjxP1v8Sk15/w
         isaqk+lS79PCYgb57BJbMhdTBF8jA2p7Jd/YeG89wHky5IvsHCuDnssX3LnaaVZMCP7F
         IC3BIqB0Zb/8FmO1/VZqmH1XxovRA25SYwi9DljMkSug1McbKssW292Z4qINljUrEm2h
         +k43qAKU9p1KWhIOnlvzL/AhG5FFisdq/lJWASYZ3XFYgnx2edRxCRtSyt+JEgvW3neQ
         LHqRRUrt3vAQTTOYnoWkZGb24Mbk3insYH4VXUZhe5JeMV56Dv2G9yAHeZohOIpmg5y0
         epQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793071; x=1777397871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2ixQXFHVUXDsGjirX+hQTMgz+71hp7/OJ5nFlg1aaY=;
        b=fdwkr7T6qRsKFMxvZB+tGdgYYnSsI7iksLh6n42Q2BqKuPoMh6jJ95A9Oj/eNochXc
         IHA4ivZJO71/aOnP8JryaTJcT7iLbT3kt7J+l61XZfC4GaKgcd0nox2NxNlst9MIl6mt
         qUXJvXSyz9+hC36cqKMJMMPf52R0q2eJFsNRnbQacpOgQ2V4W+quJzcbVxQY/3s8AqI3
         rOPD3sG3UQp75+WZvcYLJNIS6v0sTNkQ/Y9D9b0jnC+/o6UqTc5GiR/MXCh8OH7PyF9+
         VKqLZdvgyCIHmTFYaHk5Ipf+kJN+L4nL9Bc15q8kO8lCkwDJ2q6iMCQ5IRZRPz6HXuMk
         Nw9g==
X-Forwarded-Encrypted: i=1; AFNElJ98CndAjdu0oidRvaTes4Co1dswX5cI2ULnRgYwSqgpfMBhzgh4giH4nJ+O4P5/lO4XfhJqzX/WpQfFJzGS7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFyFFMkqXqLnMjj5vRID3VlZOxYLu0YRczGP0EMi4njH9gx0wL
	A6aRYrURuFy/hgW66kRe7g2mPWDbZkT6gAVxeHMIffT1tKuQWrlffdK5
X-Gm-Gg: AeBDievJUlEUyAvbABHXGeaLYbugjNO+xz3m+TY3uIh0ydW9cPI1E4zba1v97St/ySE
	b2eJtM97FQ1YDRcvrygQea29ko2V+hJN7+iKriBOtANxdr27WxPAe35Owql+YIc0n9VEpkjLBNv
	VIwdw1NNskjE1j70ADJubJQ8JPgRRcYWsYSTlob4kRrIU8zyqLidnNTKmGpnX4nhwOpHl8Pvr/E
	2dwRliO5PvhmviPlTYLyIUha8H9e82seePplhWrFT8rhBiV1SHaqRrSWO6EpntYrDVFlYEYDiew
	3bTzhbISrTqYiVsO/RSwcixWrKs5e10l4Nw74MjNayGOo4yWEthteki0zBJ+eIezWyswUBvCkyq
	wh7gi9vGSMRFVoXzOO8SbDCz7xAxi5C8j5AcmDARPn5Ldzj0IPYKdt+dcQ90ymPScvYvCI32vjN
	D7HtBnsoIoCzNk5TJnw5AKiQBRA10bU3loF52heMMXCTYjU3E=
X-Received: by 2002:a17:90b:2e4e:b0:35e:579a:7e9a with SMTP id 98e67ed59e1d1-36140204c56mr14523734a91.7.1776793071332;
        Tue, 21 Apr 2026 10:37:51 -0700 (PDT)
Received: from lenovo.localdomain ([123.110.133.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141990bb6sm14772234a91.17.2026.04.21.10.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:37:51 -0700 (PDT)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: fix false positive RCU warning on PREEMPT_RT
Date: Wed, 22 Apr 2026 01:37:42 +0800
Message-ID: <20260421173742.1066170-1-asas1asas200@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
References: <20260420161049.695518-1-asas1asas200@gmail.com> <4cdf2e61-fe69-4168-9df7-55bb71585dfe@oss.qualcomm.com>
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
	TAGGED_FROM(0.00)[bounces-35182-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asas1asas200@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF68443E182
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 10:24:36AM +0800, Baochen Qiang wrote:
> should the instance in ath12k_p2p_noa_update_vdev_iter() also need to
> be replaced?

Good catch, thanks. Sent v2 that also converts the WARN_ON() in
ath12k_p2p_noa_update_vdev_iter() to RCU_LOCKDEP_WARN().

v2: https://lore.kernel.org/ath12k/20260421172500.1050754-1-asas1asas200@gmail.com/

Thanks,
Yu-Hsiang

