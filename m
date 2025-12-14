Return-Path: <linux-wireless+bounces-29734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC32CBB937
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 11:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF263007942
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367AD295DA6;
	Sun, 14 Dec 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P1Kx3/iD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C6287505;
	Sun, 14 Dec 2025 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765707249; cv=none; b=lLs6pdRYZZvZ+7sXWXHMdOAAwsJDq/Qob9/M6bUq7okJku5o2zL0OGm3YpPhb/F3kC0eA3vSo+tgXGylo/GVFvYWhfjU0MEiZsk9qp+mIQ2e9CckPQ6vPQ0gB2Bc0cQY1Gqo1HMQm1s3UKCZFEX/TxBr6B7SYcXaOx65rpdZJag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765707249; c=relaxed/simple;
	bh=XlSU56szVhQgrcQeRl+5gH1+exER6ztV8KCHTdNmhOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsRS5v51xpeFsLFkpXAEylcSZOFhtPBWLnW73pQbQ73QKSkmY3LtZRDsw2EpbAbkFzqc9YqufAcWUBOxlgTJHT1vQSyIP/qM/eVHgCS6DM8yjEdRo/8TElnpQmjiaKkfcKuur0EgKrSci35z6lfTnhXAgw60QPpqrc3inXiYxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P1Kx3/iD; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kb
	i/ttDQOId+XDKOmaeNna6XQhSMKUgACh/eiMz2aTA=; b=P1Kx3/iDO+ByQIDRyz
	i2+d6lXZO6uhWVSKVV+BwZBPv+naPOjJ38Pmv5870gMdQeUUvXIUi4XZiDYtoiTR
	vP5G6F2yPsKS6eRFQxb8N+koUj5odZciXPFGoPQaEPMXvywGojB7Beh6267Updks
	bb0tIiwc3+YT3cIgXCVJoGmg8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXpgapjT5p7CRRAQ--.14065S4;
	Sun, 14 Dec 2025 18:13:13 +0800 (CST)
From: David Wang <00107082@163.com>
To: ziyao@disroot.org,
	thostet@google.com
Cc: daniel.gabay@intel.com,
	jeffbai@aosc.io,
	johannes.berg@intel.com,
	kexybiscuit@aosc.io,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com,
	nathan@kernel.org,
	netdev@vger.kernel.org,
	pagadala.yesu.anjaneyulu@intel.com,
	richardcochran@gmail.com
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub for MVM/MLD PTP
Date: Sun, 14 Dec 2025 18:12:57 +0800
Message-ID: <20251214101257.4190-1-00107082@163.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204123204.9316-1-ziyao@disroot.org>
References: <20251204123204.9316-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXpgapjT5p7CRRAQ--.14065S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy7uw18CrW3Zr1xAr18Zrb_yoW8XFyxpa
	yfGwn8Ar40qFWruFsrta17uas5Gwn3GF42vr1xJwn8Z3WUuFZFga10yrWakasrGws5Aw13
	XrnF9a1jva1qyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoKZZUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbC7ht7Jmk+jbtW9QAA3q

On Thu, Dec 04, 2025 at 12:32:04PM +0000, Yao Zi wrote:
> Since commit dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if
> required ops are NULL"), PTP clock registered through ptp_clock_register
> is required to have ptp_clock_info.settime64 set, however, neither MVM
> nor MLD's PTP clock implementation sets it, resulting in warnings when
> the interface starts up, like
> 
> WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x2c8/0x6b8, CPU#1: wpa_supplicant/469
> CPU: 1 UID: 0 PID: 469 Comm: wpa_supplicant Not tainted 6.18.0+ #101 PREEMPT(full)
> ra: ffff800002732cd4 iwl_mvm_ptp_init+0x114/0x188 [iwlmvm]
> ERA: 9000000002fdc468 ptp_clock_register+0x2c8/0x6b8
> iwlwifi 0000:01:00.0: Failed to register PHC clock (-22)
> 
> I don't find an appropriate firmware interface to implement settime64()
> for iwlwifi MLD/MVM, thus instead create a stub that returns
> -EOPTNOTSUPP only, suppressing the warning and allowing the PTP clock to
> be registered.

This seems disturbing....If a null settime64 deserve a kernel WARN dump, so should
a settime64 which returns error.

Before fixing the warning, the expected behavior of settime64 should be specified clearly,
hence why the dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if required ops are NULL")?



David

> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20251108044822.GA3262936@ax162/
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---


