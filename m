Return-Path: <linux-wireless+bounces-28922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6807BC58ABB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 17:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB962363803
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AA32FC013;
	Thu, 13 Nov 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hFEfF5BG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9972F7AD4
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049977; cv=none; b=Pg49YW8l0DkMm/3M/rRg2zIgjPgpnxQr2fGlOtFOOECXGBfzGznK0LfDUeSDUk8pPGxp+3ajEJoW4u5ELbCgqqn2BIkGzcanZcqYGPDTj4SYrkOmsT3TVadztcVxN0bPii0x0nIGMVbD6HLNNQeZnFgN3czIv+iCSR8SEp9PoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049977; c=relaxed/simple;
	bh=K7xt323VJ1uJRwqxUQs4bzCVCzNHYNwFwbiulRpdL5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rX2NIISTBPg5iF71zZtiqf8nveJpqveHKFPitQow/WGaZBXlLEwoOpL3C4WMmV390E8Cku5YNDE44amprHqs89cVrv26RuGC9Fe1bCAjvxtllUf2wAo5IC/3OBHznhH60aCmfDIHo2fCtTAOX1COUpicA3u+WQDT2e4794L7wwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hFEfF5BG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47777000dadso7659615e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 08:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763049974; x=1763654774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jih7gSI3dbyWiOmzQIAyW8PRU2Q1lIgEuIklK2h9qCU=;
        b=hFEfF5BGpfnMohemUnzclnr5rC19eZVo0/h+cbeTXZOQqvDtCCAsEKq4y5CluuQUqw
         gTGry9sngYbCBQF/b+rPRzOh+euMiFjIN118NTjySuhApK/gjvlRLsdWnw9VV52Q5zGa
         mMFWl0+VLXwquA1PWXmC2vDB0lbwoovOxTx7UE0vzo5okRcq+qVcXRbWFDk/9wdOic4P
         LrPx7bgN0tzUKoITf0sxEHi2/8y/bNxtn/glLI/t+FaCu0SX2+X3s/EacVl4E64xE9BG
         XBEFPlDeAsccwaYaVHMYMZ5RyLTjdIRuH1YjURe4cIirGvF+loKNQLs59o75UNs4moxa
         I3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049974; x=1763654774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jih7gSI3dbyWiOmzQIAyW8PRU2Q1lIgEuIklK2h9qCU=;
        b=GVVU6EoX2ky4JAt59fc+Tajs26l1+SfV7SnG2bBxgcneIKJJN6EnKIkMp2Wv4aPULy
         mCWKcFbaUfXeMlQzVe5vWLdEwSwl3LGgU1KbBzZBBc2enci127Emcf0bB93hiNMBHoqj
         KVNKn1JH7cSO7csLmB31gbOgGKFv9yRRi8LQzWSl4lmnPcbO96o6V2UZXY2ZTXTW4qVS
         xmSxIO7EbcHCyv0eZSod5F6jn4oBGY6sV5MBOoiyB1hIIt1zGbOH/tWEvaptKCbFK79D
         JKwk/uQul/ybrZ26sp+lgI+o+9DFi90e3BopnArw74Gw+MXOpmom8/109ZeSV4zl68vW
         gZMw==
X-Forwarded-Encrypted: i=1; AJvYcCXZH3r7v/NO1GcfQOTYJa/v41BsjlvPmQXanBng5NMD/185zx5AsoVrE9+CXzPrpvkFZEzPbmS8HEmo8sDxeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJuqLlgmwp3oFVCNUnXDy9+2PyfzxnrJB8Ds0vntSuEbxG31oZ
	Xbq6MAzxISWJTcSyS1GAehUVbHu6nr/uS50eJ3JJPs2tOgyPosiX9f8nsFMMUU+8l+E=
X-Gm-Gg: ASbGnctc3W0h2r2xWSaOcYOtdVLjFyRnsFe1BEgzCWQwhTYysyGzYNan8LJorw+s+Ij
	9H+McBA7oGIOAjRKD+TSeSPcQgmqbfymTCo3VW0Mx0JIFpJd5b7SGWIHoXK3IUgtyqPF42lZtYG
	hA1dYTyptb8W28STjsz/t2K8H10cDYIL9A/cH70+JMHFus30AQ8/NYZWwYjlqixVYFtfpiGjtf5
	9zVt4161+N/ZW54MMiQ7p4XR7XDcq6pSyJmw7UY53BN3jMhZcN/FNFk9mm+6LER/xxgPSAmhhq+
	vYUaQRT/Gb6flzhSQvFa8ul+nb35kfoYKYjICq0yD4x7Veoetyv3rW9VGs+Y2Hx586CPpY8vBVu
	kQa9+IekgRvV6zDHtChqeDhU2zFco6rlg2JDRicyWfrafQdFEjgSGLoSGVzzONKEH6V9U14lBu8
	v5UScfgRXDtO+3x2dQ1OM8CDnR
X-Google-Smtp-Source: AGHT+IG/TUS56JtJew2HLvlhyV4PRkjY0fBbwkOSF9xrNpWgIoGxEVrZD8+bc1Az1z0UWDTcxn4JZg==
X-Received: by 2002:a05:600c:1f88:b0:477:be4:7a52 with SMTP id 5b1f17b1804b1-477870b62d3mr63554405e9.39.1763049973769;
        Thu, 13 Nov 2025 08:06:13 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c847c3bsm41595415e9.2.2025.11.13.08.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:06:13 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 1/2] wifi: rtlwifi: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:06:04 +0100
Message-ID: <20251113160605.381777-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113160605.381777-1-marco.crivellari@suse.com>
References: <20251113160605.381777-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.
For more details see the Link tag below.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
---
 drivers/net/wireless/realtek/rtlwifi/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index e26feb8de658..2786e4ee67eb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -445,7 +445,7 @@ static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct workqueue_struct *wq;
 
-	wq = alloc_workqueue("%s", 0, 0, rtlpriv->cfg->name);
+	wq = alloc_workqueue("%s", WQ_PERCPU, 0, rtlpriv->cfg->name);
 	if (!wq)
 		return -ENOMEM;
 
-- 
2.51.1


