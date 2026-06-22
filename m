Return-Path: <linux-wireless+bounces-37966-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JM/8FGvqOGotkAcAu9opvQ
	(envelope-from <linux-wireless+bounces-37966-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 09:55:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A192A6AD6F9
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 09:55:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SD3D6mmw;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37966-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37966-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AD5E300330C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2026 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4B738333D;
	Mon, 22 Jun 2026 07:53:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7438331F
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 07:53:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114825; cv=none; b=SLFDW/1jOdBkiG69DnDKpWCKCUpMJSSwdEURlEqsLzPEZ0FcgYt30yHJlo/LWmG3W3VhUBxzZHLSvlWJ4CT5gr5kEcKXwJk1dggBPoXvD2PQotbVV/Wl6sZXusKc0y9icMTl0o09R+Ozlc0PssLVSrPNgyAaldkmN9HzbBqyAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114825; c=relaxed/simple;
	bh=kwPAUQHA46UWAzKtvEAsrpO6XV/aeWY/zPZEW9c3HjU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tSjWLrO40sLjg7/1ZjABRYD7MZ/6+C6Pp3lWUUcWYf3Qo/7In2DKOD2P3jBcUOQs90AWOLQIOcan6flAxJyjUCqCVAfBG4JqDa7u0btHhIKCLrHIArYt9ZtPdCktKrywyieDvpaOTBpIJP737ZFmslRkRluRQos72LvHh59TajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD3D6mmw; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c6c101aeafso24875765ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782114822; x=1782719622; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=muhh0ZwVTyB0/KcADVsIhtg8n2TSc3l0G+5X+uSwFu4=;
        b=SD3D6mmwLaW3/dquDGLd+NGimfScOJx31HW2jKD/HRtxxPDZnm+mR3e3VGES1vhcH8
         4G6XmMfp0OXA8YsYn1gZ+Hn3+lA7xal7d0nBM4VuKENrUPqlXN3RBKvL64WMClSG5QOe
         azd/gmtNV9vpQTOUbc/O3kXiHyXIvOP+nu8Z57el0up11+Jh9UtmFCCMhXC9QUefj+Pd
         P3UfrCUdVlRnd3G056UZIAAGyGGPdgVGV9pVOX6yQMYzCVzywUYtqgio08asYaeIw0Km
         TaE04696N5j9kEeqrUJdMPwYVZIDsb6RhNAxkDdItq0Yrmq/pMooEhtfyhTm0e50kA49
         kiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782114822; x=1782719622;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muhh0ZwVTyB0/KcADVsIhtg8n2TSc3l0G+5X+uSwFu4=;
        b=L039tBsPJpEZP3ekAkoBS+XfdY2PNCb6I1zXvXi9PBI8MPk3Mz7UpP0nCTUNJuSwTX
         PCQmmHNl99bEXEp59NefJ434Yh8gFQL7zDOArE4mXXuxqRPJeh+14+cds2Urc8UqnAkU
         lx2MZ2IBnYQRgVwIv+gUWTj7Dj8qQrJ2Tn+NRcr9PzZvEoMh4/sKob9uovxKG5ZKD1Aq
         0xkygy5QR8Zj+ULu1osywzwAdLlkCQ5nhuyjgq2h/Yv+pszgqEKtIfxjCIao/dgiFFfo
         ogL+NvHLaY0tNt/WzUUpmDcObw1Icnkk76B85mQx6qf32jEa2OqohJCizwu58T4JVMrv
         3ffg==
X-Forwarded-Encrypted: i=1; AHgh+RqoQSbSITA/UnpbYRBd/fDdpnLtT8MxnfCBulMzgVLQwFNMKGwqdxxHS0LewAdxgnyIYQSkH69ROJuSWRsvfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBXr4kHROUJkLL8avsJvRPmkqLc4X6u5SrcrU3VDo8QQRQ1Ucn
	1iJ/vF3cpHbM5kxYV4757qsyPq1nehoBMfk70K4VnNuiUwtCfA5fLMK5
X-Gm-Gg: AfdE7ckCVrLnGW+gLs4XFpTeLU4JBYLKKEVp6clHttw4WvAM3jXTIxZjBIUYhAW/FMJ
	sAzuqJwzPdxS1RCTiQdgFSKj+9jcVKjYRmyabg3j9eJUTqxVlCDaLkPJRVH8vqpHoBgeG5zAXB+
	UDQ84wFizbPtY9Tx3wfZ1FfOoLN9Sc5zjYMswJgiv4i7ktAYbOTUnmwaFWFriTSe+oOVygkXm2j
	MqV5YR2a44iqvTdmBi0ASb3nhXe5hYH+kSfIf1FSDvDpw0UeP3VTKOgcNEFAOkbx1dPnenMYYRW
	CJ/9tbgOh4fGreXCLSCuL3PC0dP9ctP1nZTU1O9sBQ7au6dk+4nPDiWUGbk5ZALGfNxeHSQvT50
	h43JzoedOXGGjVxDsVDjvVjMmTMWheQUSlxsRWSkeSYW8dECmo+eJfYWbY+f3DbuCOc7Ihe70xd
	4dgSs0jhOUFPHlZN6JDE6hap8Y0X2N+TPHF0JTOQ==
X-Received: by 2002:a17:903:1d1:b0:2c6:d70a:92af with SMTP id d9443c01a7336-2c7190576c9mr133110835ad.37.1782114821743;
        Mon, 22 Jun 2026 00:53:41 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aa5f1sm79786155ad.78.2026.06.22.00.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:53:41 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org,
 libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] wifi: libertas_tf: fix use-after-free in lbtf_free_adapter()
Date: Mon, 22 Jun 2026 15:53:38 +0800
Message-ID: <178211481807.2212567.8773346114561900100@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37966-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:kuba@kernel.org,m:linux-wireless@vger.kernel.org,m:libertas-dev@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A192A6AD6F9

lbtf_free_adapter() calls timer_delete(&priv->command_timer), which does
not wait for a running command_timer_fn() callback. lbtf_free_adapter()
runs on the teardown path right before ieee80211_free_hw() frees priv,
both in lbtf_remove_card() and in the probe error path. command_timer is
armed by mod_timer() in lbtf_cmd() whenever a firmware command is sent.
command_timer_fn() dereferences priv. If a command times out as the
device is removed, command_timer_fn() runs concurrently with teardown and
dereferences priv after it has been freed.

This is the same use-after-free that commit 03cc8f90d053 ("wifi: libertas:
fix use-after-free in lbs_free_adapter()") fixed in the sibling libertas
driver. The libertas_tf variant has the identical pattern and was left
unchanged. Use timer_delete_sync() so any in-flight callback completes
before priv is freed.

Fixes: 06b16ae53192 ("libertas_tf: main.c, data paths and mac80211 handlers")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I asked about this on linux-wireless on 2026-06-15 and got no reply, so
I am sending the fix. It mirrors the merged libertas fix exactly.

 drivers/net/wireless/marvell/libertas_tf/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index fb20fe31cd36..42be6fa22f9c 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -174,7 +174,7 @@ static void lbtf_free_adapter(struct lbtf_private *priv)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
 	lbtf_free_cmd_buffer(priv);
-	timer_delete(&priv->command_timer);
+	timer_delete_sync(&priv->command_timer);
 	lbtf_deb_leave(LBTF_DEB_MAIN);
 }
 
-- 
2.34.1


