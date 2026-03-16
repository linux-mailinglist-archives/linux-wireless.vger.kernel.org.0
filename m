Return-Path: <linux-wireless+bounces-33286-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNlHATy7t2mpUgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33286-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 09:11:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7133F295FC7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 09:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DCA03018D68
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 08:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F72355F50;
	Mon, 16 Mar 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IETys/ZG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860E34CFD0
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648687; cv=pass; b=NZvat4Z7Wkym4U8ZRxjzlQl1CH0UN1oZj9pXNiMGTKNW/JVm27UbrCDpW50/TeAw2U/AQxIvUk0iZxv0HdO/zXo9dT3KAHwtlsLFOKixlhcD5ZSMjMb/lrgcLT/whwHZa+P8nniYpeRxhhgCeGqrR/I+m/ShmWco5Q+VN9LYxig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648687; c=relaxed/simple;
	bh=s19fIheyHKeaZL2EAKo+JjF7jvo4kQbOQZZGSFXaNIs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hxRBGjT2Nl1E2uUcFQd2ECHuTFNCywaC6zt133id5EGT30zl23pheL091RhUQlQX1ueckIbomhyxXH1PIr0axuYPDi8pBA9tKQqm5RwW21wTfrsB310IHAAykCJDIUx638ZGMPc+CmKGmI8DRLHlxLFj6LrUXQEmv4848mZ+YE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IETys/ZG; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1273349c56bso6126227c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 01:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773648685; cv=none;
        d=google.com; s=arc-20240605;
        b=ccz2yM9h6GFguajANIGDfqu7pJm2JiN5oTQ0Msg6heq/aYBVl65NAunbT0afAECJWl
         3JyffnQzGcrCHifdeE1Qe35OBMn9ig8kV3SlIrmpPCYskl+vyoDCO+BHcLA63DKDgrzq
         jhBnwe/Cdyejy1ded3DPPh5IwM7h73g5JhD/IZc6SOt8kO/hSFvXIVJaprS2veZIEv0z
         b6Btjm76TrRdxndoKXNKtMSInvwnXlIzYNviCsWgOB3jTLb/5l7zY5MPqzJeycBCyX33
         tWEsswUbOyEuKoodCkoElOnhRiFXDuSCtLMUyJJByOut9gpfgE30ymBxoDwhK30oPBWc
         oxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=s19fIheyHKeaZL2EAKo+JjF7jvo4kQbOQZZGSFXaNIs=;
        fh=2jA5PPwosZxFhPFPdgCPwBZHEAXdqudcGn+YPUiUbaY=;
        b=cZOKQ5E7tMx2iCUoazeIz4ulebUPRLq1VZRJF0hs0Mz3gafGJ9qKHO3y/s2s7dho1U
         XDdbh/GJh3fNdJHRKjvN8AqaESLdxelgUzVBvkK4FixGBg+ZqBXwsMqIu9BqsSkoLNeR
         AVEQZcLTKpcA2YlmDgM0LrxKJyXEJQeMHhz4G83unJhy14ZW94GnMYqSfNSLbusCJIlM
         u6LLfQU/tE+/NRGGMhcXqGYwhOXKHOeKMKd5t2EHwLt200jxG5DX+zQED2uJ7bP9etAo
         YFxLob7peXCr47KzlgAkGweJARsGr6GVFbZHLdHohL6rQkV+JF6B+Gu1AdSd7loSK6Xf
         PdeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773648685; x=1774253485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s19fIheyHKeaZL2EAKo+JjF7jvo4kQbOQZZGSFXaNIs=;
        b=IETys/ZGLxJCXz/C7ClqnbdQmmxgYAS7Rw+xLpBb6YGEA9jgPXZ20GcuzMJNNIUl/4
         QesDN1RerbiRnCV1lnzpWvd9fBjuKwIklS05gOYXOLHQIKnniZ6S8wZS0sNXcxrNHIK8
         t0pmegyUSGcoFJ9bcgxxtVH78ZpKUI8g/YHKsQoSQ+ZD3H4leRIGrO94g/n1DnZqidIr
         zmTRHvUKo94DktjhXlF5i0EryI7+AN2TQzPTZzhN82ebpvRP6RXJSbXIi+qWSwfJPWug
         02wLGRhhB/EaD0tqRwlDEBTfZjECXR+qDviaaLDDEoQYz5b0qZ1cMPzUKaa1MQsST23L
         lDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773648685; x=1774253485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s19fIheyHKeaZL2EAKo+JjF7jvo4kQbOQZZGSFXaNIs=;
        b=kmonkkvJE0SNfE2jOwCwuALB1FHsuZWaH5xh9rKtMtwSlstlurNSuBBmkBCeA19AkS
         l1vMENPOPKeXZC1Q3w4/qxJDlFp87d4cORyFwW2u6AlUFn8M+QaFSRUuYUICCsUcms8B
         RkHdNwDPFhqn2TOZpeQfo8QETL69mIDGWgdXX7YCuyH5mCRgOEG6KHs0Gw4IBlrtW0AQ
         ssaNwhDr5Bk3cMx98spDZwyb8ep5R3Ilq5xs2YJT2CYHcpw2yLkeYttFseRUEKRcYlC7
         n97vos5FQ0A0P5Up37E7gWjVlQXTk+DGf0P0xnT+bJ7+MwQiJMw/Fqmjv7oWsxoWO5OO
         RpKQ==
X-Gm-Message-State: AOJu0YxwCGGFk4Ak9dqyYX0UafBbquSwRc3bjlr6pj4kF5mCILOfEcwC
	gZwOukKE/RSurDJfyeTGwKEGS/5EQ8W6C95GCtSJXd47zdZA7GJ/UHHYbgmkGjpJEsZNC+tmgmW
	F6rv4d56kcHfzq5iqUz69MVq7a93toA==
X-Gm-Gg: ATEYQzwQhztQm5m4wDFzEtcBDQojkCGJeZejn76evg9Jfe0t4yoZ+K0FDl2TADL4te8
	fPkDvYtOGzQZ6znOwyaVf5SlKuojFfw0FmTc7MsB+G1qI73P6C9iKy/LaQRYRCpacUz+tKUkjBj
	GKhSXRPPB3Z1o0MXV9oSA7IAFRU5xXwiZlgvCnzdHfcNQVOWoVG8hRsIzxfJ2y3iE8c8WFEw0Jg
	T27Yf80som4G0D/4DnLIscDgdmBtWkBB0t6urEksgOwkEKIWvIXPZoYFviG+tJNDhQQL0hOnkbe
	zJ/EGj8m8nJ30ATraAs2op+5R8EYSck139JuGkE=
X-Received: by 2002:a05:7022:698d:b0:128:dcbd:e27c with SMTP id
 a92af1059eb24-128f3d5a938mr5673294c88.20.1773648684987; Mon, 16 Mar 2026
 01:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kaushal Kansara <kskansara79@gmail.com>
Date: Mon, 16 Mar 2026 13:41:13 +0530
X-Gm-Features: AaiRm52GObCrQw376pp3jmf1IY7_1kyJ55cuNMzRjXBnzYEM0WQDQY6jG0qRRKs
Message-ID: <CAHFM2E+d6KiOfAgejK+hEUMvyAwx+uCwZLM3dVSBgjXiDoxoQQ@mail.gmail.com>
Subject: [REGRESSION] mac80211 WARN during CSA finalize on mt7915e after 20240129194108.bad8ec1e76c8
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com, 
	johannes.berg@intel.co, kaushal.kansara@sophos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33286-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kskansara79@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7133F295FC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

I=E2=80=99m reporting a regression seen on mt7915e during AP channel switch
handling and it is related to:

https://lore.kernel.org/all/20240129194108.bad8ec1e76c8.I12287452f42c54baf7=
5821e75491cf6d021af20a@changeid/#t


Environment:


Kernel: 6.6.116

Driver/chipset: mt7915e

Platform: Sophos XGS

Trigger: concurrent AP CSA activity (e.g. WLAN9/WLAN10)

Observed warning:


WARNING at chan.c:92

Function in trace: ieee80211_vif_use_reserved_switch

Worker context: ieee80211_csa_finalize_work

Relevant log excerpt:


WLAN9: IEEE 802.11 driver starting channel switch: ... width=3D3 (80
MHz), cf1=3D5210, cf2=3D0

WLAN10: IEEE 802.11 driver starting channel switch: ... width=3D3 (80
MHz), cf1=3D5210, cf2=3D0

WARNING: CPU: 2 PID: 8713 at linux-kernel/net/mac80211/chan.c#L92
ieee80211_vif_use_reserved_switch+0x546/0x8d0 [mac80211]

Call trace:

ieee80211_link_use_reserved_context

__ieee80211_csa_finalize

ieee80211_csa_finalize_work

process_one_work

worker_thread


I can consistently reproduce this under CSA churn; please let me know
if you want full dmesg, .config, or additional instrumentation around
reserved channel-context transitions.


If I revert this patch, the warning goes away.

#regzbot introduced: 20240129194108.bad8ec1e76c8

#regzbot title: mac80211 WARN in ieee80211_vif_use_reserved_switch on
mt7915e during CSA finalize

#regzbot link: https://lore.kernel.org/all/20240129194108.bad8ec1e76c8.I122=
87452f42c54baf75821e75491cf6d021af20a@changeid/#t


Thanks,

Kaushal Kansara

