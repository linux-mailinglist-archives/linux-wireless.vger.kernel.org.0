Return-Path: <linux-wireless+bounces-38046-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2HWpKfCYO2qtaAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38046-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 10:44:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BCF6BCA59
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 10:44:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=kzQ+1fdn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38046-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38046-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F84E3002536
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C2385D73;
	Wed, 24 Jun 2026 08:44:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5E2ED870;
	Wed, 24 Jun 2026 08:44:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290664; cv=none; b=G+yL96o00aUUrTwhVMmceP6cN7ACIb3slqsd2evEWdQjkZGD8R2dIjYvF8CwdR7k2NceKs+4swdSHxVv3CT14HmkdrJd7GyxkIZiEYcwLtgcFABxW9tJCUszXLqWbDZFsN4zGArafovM/W4sQKtnnMKSuUgJRYrL1+rDNE9pMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290664; c=relaxed/simple;
	bh=GiLBcw8TCw+pVIQKZkGejqL1bTdwhOul8NVSKDP3Lx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rq83CeKe+ilo0DC9U4DIuFWZxrBFEe9/EsN6PdNkPFmInUEBgK/HEv0HZeFCEKycUxeiEPXCEJDvkWsHv8s8np3jo6dPY2tuy+6Q6ap9uTwJrqmm8k5KfvvJSzHmP5nO1+zr93V3E53qrcK+Hn6AD/CdOdBF3G5s8LschQatqgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=kzQ+1fdn; arc=none smtp.client-ip=101.71.155.101
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43926e916;
	Wed, 24 Jun 2026 16:44:07 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: miriam.rachel.korenblit@intel.com
Cc: tglx@kernel.org,
	mingo@kernel.org,
	jiasheng@iscas.ac.cn,
	kees@kernel.org,
	johannes.berg@intel.com,
	error27@gmail.com,
	emmanuel.grumbach@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	zilin@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: iwlwifi: dvm: fix memory leak in iwl_op_mode_dvm_start()
Date: Wed, 24 Jun 2026 16:44:04 +0800
Message-Id: <20260624084404.570703-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ef8cd079903a2kunm5ff92ad636308
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSE8YVhhJQ0sfSkxLTE5CGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=kzQ+1fdnsm3AFFJ6Gl8toa4l6PtX+AkmQQI6hqWRy24LXBPElgAMf81sZW1/B8kKd0eLAS99z/Xwh6bj6a2YM5/yRUfyZU4KCavFNaEyh0I1yx8/6t0ypKnC+VrM43lOtgH0kGdCHCVrf7tWVcodWnxmuIih4exPFKq0B5EyFjI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=YjFfP6DtapMx5m8xVLPsWef0pIE5jMQeuP0d1YNaFjE=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38046-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miriam.rachel.korenblit@intel.com,m:tglx@kernel.org,m:mingo@kernel.org,m:jiasheng@iscas.ac.cn,m:kees@kernel.org,m:johannes.berg@intel.com,m:error27@gmail.com,m:emmanuel.grumbach@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:dawei.feng@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iscas.ac.cn,intel.com,gmail.com,vger.kernel.org,seu.edu.cn];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25BCF6BCA59

In iwl_op_mode_dvm_start(), jumping to out_free_eeprom currently bypasses
the out_free_eeprom_blob label. Consequently, error paths triggered after
successfully parsing the EEPROM free priv->nvm_data but leak
priv->eeprom_blob.

Fix this memory leak by reordering the error handling labels so
that out_free_eeprom falls through to out_free_eeprom_blob.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc6.

An x86_64 allyesconfig build showed no new warnings. As we do not have
supported Intel DVM wireless hardware and firmware to test with, no
runtime testing was able to be performed.

Fixes: 26a7ca9a71a3 ("iwlwifi: refactor EEPROM reading/parsing")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index ca5a8140908a..6bd5b6d84b2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1511,10 +1511,10 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	priv->workqueue = NULL;
 out_uninit_drv:
 	iwl_uninit_drv(priv);
-out_free_eeprom_blob:
-	kfree(priv->eeprom_blob);
 out_free_eeprom:
 	kfree(priv->nvm_data);
+out_free_eeprom_blob:
+	kfree(priv->eeprom_blob);
 out_leave_trans:
 	iwl_trans_op_mode_leave(priv->trans);
 out_free_hw:
-- 
2.34.1


