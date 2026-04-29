Return-Path: <linux-wireless+bounces-35558-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM5RFg2c8WlfiwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35558-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:50:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AB648F8AD
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F7AF3019384
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 05:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AABD1FBC8E;
	Wed, 29 Apr 2026 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpNN5BCU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF552DC791
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 05:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441793; cv=none; b=eVbiNVCNEjZBG7fzZeXm/fGXf5s7JAjDbCiPxKWqWR/03FHbKqBG0aPYp44yh5cTslJNZdopX2n+QAEo4P6Tpl8sUarhTabdshCgAFpGrV+UinekpmKVlPrcZY4K1ye1UeTrzZoC3ERo0so/p1lA62eDiluedHFl73to8sRjhV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441793; c=relaxed/simple;
	bh=6PwYOWPOOYvG2DrrZTt6asbW3Y5Zvj9XwiRvbY3CzYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhH7af9zAYYwlRONH7wJiWag7KNc0VRUzPD4webllJGujYZjbjHg2nQdgipqajktCblHPUtA7l/dUIH9roJWKS7QIulihGFnQ3bLGf+TBfnjSH13UpXNrmwXLmilbVHJTEwvSRhy2gXnUA9gsv+GE0f2ZG6+39IVa5kFLkVT+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpNN5BCU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f8b60e485so5070722b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 22:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441791; x=1778046591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK9jzP1pmenmFL+uCGEOE0gremklqtqG7a2J0RuJ4fw=;
        b=cpNN5BCU6nyimoiKksmkJxD5v/6S5XhyPqXPZQKSmpaL10FcfPIzJ+gyBlodXbV865
         DmaAiAX8852UZUHDxFKkPPyvqTmAOUWYnZ0I8OjqhivsQlHY3xPmrb97KupBlskz5rum
         iTELQhNc2YV45ogoA7PKwsjX4N0vDW68K+zYu7zQ9cJHG8IUdjW6N0N71z7mrOfRtfye
         NlJUUX/2SVZoCgr+ff+iIqjmbjRmmXYdbhamXQ776DoO9gWcr2SFgnCtFXt81opwLOz+
         fSwUUOD3DF7oniGs3/3lRSrFDTW2Uj7QwFdohP/lO15n5FhHXmaTEhFTBUI1g4f7vPZd
         MYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441791; x=1778046591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hK9jzP1pmenmFL+uCGEOE0gremklqtqG7a2J0RuJ4fw=;
        b=B1KCj8/WYKINMLP0lVJV5goZRUPUXSpBOfALItcC1aqXP+8kC1Ue06yZhBB8lCeA2t
         ng0bSEvll5kVTJV6jQbj/VDLBYET48iGX9xhW4c/j02ez1gPh3Ifbvc+OieCwC2X3D2+
         6THDzzMncHgypXhnsv7pNYC5CDy6PcBRSVaJHK9eB/uVhoV8vSlGFAXH9u73XknTfG3L
         lMLDfSz1cllT64gCv0eklf/5OVc9r28+hECMclmjrzgzRs2gj9vf7kiUnAi7QnuONc44
         KJ8ANGbcdH1Zyb6kRFaOqjJxi2+ABO3+l2qBu3LdQgMS8n7Dyuvg5qzNZS8ud8+H7B/T
         yqzg==
X-Gm-Message-State: AOJu0YwjkigH9/JyOcEP9SXiaAMMK2tbZ2rSEdNlOyRxBP56uq4lkQZv
	scspyx10m274UMxQ6RaL39NR3mnN2XdkjlmwDLFz4Db15xHZXfAvKqQcsBJy8BGnKIb8ThU4
X-Gm-Gg: AeBDievkLb/8AVUg8hE8gjhkSekMufTBGXjIy9B6UQj6f5ZK+gBw7hLm4pZcxF2kBEz
	pLdgNabJNOI2zqzFL9Oe7WqNn3MkFFRV8Mc9Yu03lvLdVl+Gwz6m1dBvsFusF7QbhSWtvURZ1pO
	r6ILuJmuC5qtVNUhLDJBHYWvRaeVSqhztR0dJSxuWYfDK+kqHW8E9snG98JITYc8Yaf2OMIIaw3
	EWHnKvydIZkKUn+oMnxVHUgW3uoHMOyjJavGsrAxGpzWuukIsYsRGdQ3jm40OC/EvfW19rsNj2Q
	8gBu9BG/drn+nUQbNLOYGKsJgXzQlg1zeqBylqfnDbp7JB83K8RlLAf5ZGalGzobt3pm/QNtJlT
	mJbpycDOaTmUiY/e3UXxk3+dXK2cruVCm0PcY3hCYEfZkTlQQdQMSxym7M2sZ7hSplglD3BFuRB
	f8eLFYAl/lMrMP8XEavZk/8xEDSW2MCunO2MCvayn/LA08jKy8AbidDwPAxLoL/WBSuA==
X-Received: by 2002:a05:6a00:2195:b0:82f:8698:101 with SMTP id d2e1a72fcca58-834ddc8e799mr6066874b3a.44.1777441791302;
        Tue, 28 Apr 2026 22:49:51 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5cd3b8sm917616b3a.16.2026.04.28.22.49.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Apr 2026 22:49:50 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: drop stray 'static' from fast-RX rx_result
Date: Wed, 29 Apr 2026 13:49:44 +0800
Message-ID: <20260429054943.98326-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <17d5b91c-026f-4539-a39a-cfd976860273@oss.qualcomm.com>
References: <20260424131435.83212-2-enderaoelyther@gmail.com> <17d5b91c-026f-4539-a39a-cfd976860273@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06AB648F8AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-35558-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 07:23:30AM -0700, Jeff Johnson wrote:
> Is this an identity you commonly use? Note that anonymous
> contributions are not allowed:
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

Apologies for the truncated From line.  My full name is Zhao Li; I
sign other kernel contributions the same way.  For DCO purposes,
please treat this patch as:

Signed-off-by: Zhao Li <enderaoelyther@gmail.com>

I will use the full name on resends and follow-up patches.  Thanks
for the review.

--
Zhao Li

