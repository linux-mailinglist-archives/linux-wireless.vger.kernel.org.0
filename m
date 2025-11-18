Return-Path: <linux-wireless+bounces-29091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A8C68D29
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 634A04F37FF
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C3534F24B;
	Tue, 18 Nov 2025 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NgI4vLIi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49234E760
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461253; cv=none; b=E173X9UukXW6RfWrUPDVTyODZ0cxwRToMJMo44fqZMUnTNIlodPnntGz/oRHGB1XyWa3fX0z8DN1VTAxLkYjpCGUq3wWc8pYmOGvIfAcE+Oo8tAefVVFhJdOAXr/cfzaLFI3DbhTesdMnQUa1HrBO1JWI3cNNXFjAkiKQctfWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461253; c=relaxed/simple;
	bh=P9h23L8Gjyirwz1WWqMRg8hLEL6LvVGncng7nYkAaHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPxCJZThwVrQIC+hjXFBiqwyoJpKu9oiVlBsnDfakQx4O3C2Sbrk7CR9+/tmrdkrGU4Iq6ysMaV5TbdH/kOzH9CZMNo/0ZSvDpc1hByY/9eGt2AXaBr2GjpTzQROHpxqxEcbeEpG0ur3pgqeRBtCWjQPtZvCPc/Ai0V40T/SSvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NgI4vLIi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b3c965df5so3127344f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763461246; x=1764066046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+89Qj7fu+1KrH8ZagotGare7OLOGg2NieZMi7MPs/Y=;
        b=NgI4vLIikUzr+DaZz5pAzpAVrwULCfoTgaEshosyO9JKZlQ2OxoLqvql/bKTfvLK3Q
         Xu9Et9DhEu0lCfLhO7SSWn2XtDPbctO3jvoF7d2d2iDrzR5pHzV/7Eokx1hzehqKHOlg
         SqEbcnfWzAkYmoyCfUWx0F+Gn27hlNOeDxEd5xfRrC8ZfjBrqrPjIL9crFcaXBCqq/Jv
         +t8mavchEr//jq4PiUv0HIbrPMqCwSc9lohFfwvg8WrsqTrr5DgGZ3AG2mW8pR+i0hds
         kdr1hjX06d/o/lBN0PFs67GRxAZivwZ4j/nLPekmL0znfL85MDdoky3xCqB9IJ7Be1vY
         WbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461246; x=1764066046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+89Qj7fu+1KrH8ZagotGare7OLOGg2NieZMi7MPs/Y=;
        b=aaR9V6OjhDYvgz8RBGta/XXkik69EtLWOPlkdpa8AEwPCdya12ahbFuS+uK0RvoSuT
         UUyULU8c4SAl9oqz8e2mosr1u5pgfIq0XrRELia8mBYj9JQJOXAtjpmdPxDHz+4kMB2U
         Uy7IkXzJoYz6IX8q3aKiQQc8OKoDW/4MO+oUo1CdwaWEyktxroCZZE67Y7p8SbcsQJqE
         +C/gCC5gFWJNMIsytvrRdmJwTjo16VLZeaJT7Y3A5fbOu09aqxOZ93U5i9nm29MHuUnH
         U4a4C84qhMJ3CBmjA5HxpBTJ/wLVnfNLEUbw7uJaIMgkXFdnXKBmvzFwVHMfzsZzy4Df
         ae7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0ZhyZWGfV9NnLTaD/34UFtn2JrG5pOGL9VkzaMMqt+xRUxrQ/bfggeTByv8RJ4IXvvCfcMbp3YQUhFmMHUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsBo8nVXkzChKEkd+tvLpFUsJJxvIuG/vMe0xkdPjNFRtE9XPY
	E6xCKeYr5vIpil8hptMUAoOuCTgAT24SOGn7lUOLCKHzvHSQ6zPMME/uB8ALcADKZFA=
X-Gm-Gg: ASbGncuSdMr160P8LrnS4X0c78NG8eZba/AftMIkZVJfFvRZZ1VqyNJJX22ETRUpsZy
	UwJXwM++qtuc7M4ayYDRREIIp9tJMIW8L4GLrL6G1Su1g0LPhSf8+2b5SU7PguOLG1D8l92pJgr
	vMhIG21hv/sEJiJLJSb9y2XHydjSJ58f5fyRYZvgf9i0yUJ71TdBDmBUlSXLGKwggRywFN3BLbp
	8/vRaiN74DsF38LvpqeuMvyHV9DKyPWS0Rd5KuJG9iDbskRb1QtCSWW1UPzTcqgw0lF1XeRnfZl
	SO8wrpocLbyV1jcJY97fIVfXwM7yu621ACO2jl1BN5I/cJXMLjBXvGmqKZd1wwaOJ3yPkUp8ioQ
	R68UXAvebwvqj5hRo69wI+lZJ9BrvjQ7kLjQrigwGK5wN+8btMtqA05YKRCDBJkTyYqdB155qHS
	cF0Rmgj8XS9ZS8e/lsRwK4Vhcy/6esMT/ldOE=
X-Google-Smtp-Source: AGHT+IEoPjLdkXGBqQEWOVFXvzQzPT6ouTiGI6i6WvQ/jckcXno7Jc9xHz+oLweh79HpRRR9isjD0Q==
X-Received: by 2002:a05:6000:4312:b0:429:66bf:1463 with SMTP id ffacd0b85a97d-42b59398ad7mr14607167f8f.44.1763461245786;
        Tue, 18 Nov 2025 02:20:45 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm32147587f8f.26.2025.11.18.02.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:20:45 -0800 (PST)
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
Subject: [PATCH v2 1/2] wifi: rtlwifi: add WQ_UNBOUND to alloc_workqueue users
Date: Tue, 18 Nov 2025 11:20:31 +0100
Message-ID: <20251118102032.54375-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118102032.54375-1-marco.crivellari@suse.com>
References: <20251118102032.54375-1-marco.crivellari@suse.com>
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

This change adds the WQ_UNBOUND flag to explicitly request
alloc_workqueue() to be unbound, because this specific workload has no
benefit being per-cpu.

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
index e26feb8de658..09e5a16d7252 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -445,7 +445,7 @@ static int _rtl_init_deferred_work(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct workqueue_struct *wq;
 
-	wq = alloc_workqueue("%s", 0, 0, rtlpriv->cfg->name);
+	wq = alloc_workqueue("%s", WQ_UNBOUND, 0, rtlpriv->cfg->name);
 	if (!wq)
 		return -ENOMEM;
 
-- 
2.51.1


