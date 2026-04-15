Return-Path: <linux-wireless+bounces-34831-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE5LA/UQ4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34831-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:28:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 613BF4089F2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B7131955AC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE372396B79;
	Wed, 15 Apr 2026 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8v/wca3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1939524A
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291816; cv=none; b=tfZ2GzJI13QL86rVTfc4oMfI+FJAa87CatfXrrT5im+Ui7HuZdtoqSmlW3KYQ9VmkdKyfiKxizXFAN4/WMZtnByt44SIDFiNs5q52PYw5L4cwpM/3D226ZC956Nntb1Kt5GNweCOBSbDBF+W72NwlCMGGhSTxIsn1O4kFuGmHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291816; c=relaxed/simple;
	bh=v46IZ1SzmsGJww3UxMiqnbb/req4jkKIhm+Hwkx9w1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vsdzdgi9Lgva6RbTkuwB66A2aIHcGriCWaeZ8H1ZVDaMsHapL70j23UnWYRqOtGGuYVIqo3CCf9/2PtI3Gc6g9l7VPPir6l9WVnsYAA7Firek7laUr8jEkO65YX7xO7fQCsATEMfWfwxwxZaysOUJUrKq5MG2puHPRifolU5Ncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8v/wca3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488971db0fdso72522675e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291814; x=1776896614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qu4+ZL2QMhA6P6OJkoB9A5NpknefCcp85WdeQdgdhoA=;
        b=l8v/wca3tD/feKvgMzdC2Ln2/wDWmYRXKKFzLlGAwq02cBWHvhSHGKAETPKYQNPycn
         2HLUgceZbdrXockzQ3iAo9P/xHUumqUplSB48fpZHmmC2cJJ5QYa1ZAHnxSYeiuV8cOK
         15ZBmhRxVvHsfROJQHem21yRVjm6cTmRLrXBCbzCDrf5cw7JtAoV9tBCWrMJnShWVB4e
         x6jZw+NL5rNBglSj/FFITLzTh4y9esPgAkSoRavQgE3pJQGCt76lGv9rg4nN7hhPrXt/
         TJgLQsLg661YjCXj0GQSx6sDNKm+yGPUrC4OJTGkzO10kmvVuy3LU5FZ/7Bkrz9H5biW
         ebPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291814; x=1776896614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qu4+ZL2QMhA6P6OJkoB9A5NpknefCcp85WdeQdgdhoA=;
        b=Y1YE0GaTW3iTmtWDPms1If9QBE0M9Mk9ihbjPiIhnlWHEkLlrj4EFK7pMBsZiotWn6
         JtKzGZoQqW9AAyLI0SxRbtCzqDgl4KFiohpb3s4SNVXnaLmg3VrZwidmFNtWQriqcieo
         raT4hLJ3OgQCVcp1BmG7APv7E8PlCFBERRrIaVTNsNWj36FDtT3WS/cLRv2cb5JpnUrp
         e4SFWHO9VDgOrLg2euAJQ2LNx546PDiwnjQnbkM5hIDNw7eAPxjkCPidofaU2JkuPOrs
         ymE8ZPdEQa8+egZZDNCx44BvC2P6+d/XtxATQVf6tJ5wxF656p5OB+xgScTv/iVzhzso
         2ZTg==
X-Forwarded-Encrypted: i=1; AFNElJ+AiicAn8QcQvoaP9gFEGwq9tP91FM63wBCC25+ZgSx1dWTSMNXwRJf8vTm6tZKWdTElrPw0c6NZ/QnbgSCkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UeBZ09EqOB4f7PbjQdFz8CRS8/kOON/OsVE4I9E2NPeQz0wA
	nwYQ1xbcrhkDiyV1soqWpylYzAdSC0UEV8vjh2RoA0a/5+LJnlRoaGE=
X-Gm-Gg: AeBDiesy/IR6HxSjLEIyEvxZOimnzRYQ4GWVMTnZwSsOUUvVqGN/AozOP76eA2JjP65
	pifGJarkGN69Qita/crocFWhjYCApgFkMBYVfYuMSlySklz2EJxq1YhMQbjE8DOwZ2gEK3LhPzx
	8wpmfyMJaZRci9WHh4Wq6wCNepjHTvsnyDnQfsmLDNKHvI7QNZBw8S/tZ8TFMXD743b/xnKNdqx
	xfJ6uMzMQ4XNL1uWLLXUjVB3Zu3z8Sy/aPUtlY0JIt3P/IxCbzEY1XWTs4PbQjUXEAwKkGOyboP
	vOC1wqwM+bw61v9eoL3aAVJbBMP/ccOyvnFH0wTNlkJY76ypLjeztpURP+l92pMVtAyvZ5vKTlN
	9yVpcZu/I5eICoBKYreBMxRW9Pnas/uYqu8x3s8Chej68iDMqPumt/58XbTlTx/uGjGVL9Y8ijN
	CNX2VZmvReO6Yr9w==
X-Received: by 2002:a05:600c:5299:b0:487:1fb4:7e1 with SMTP id 5b1f17b1804b1-488d6875f3emr313138965e9.22.1776291813644;
        Wed, 15 Apr 2026 15:23:33 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0eb3842sm30160995e9.24.2026.04.15.15.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:32 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] wifi: mwifiex: fix OOB read from firmware sta_count in station list response
Date: Wed, 15 Apr 2026 22:23:24 +0000
Message-ID: <20260415222327.1539269-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222327.1539269-1-tristmd@gmail.com>
References: <20260415222327.1539269-1-tristmd@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34831-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 613BF4089F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled sta_count (u16) is used as an unbounded loop
counter for iterating station info entries. An inflated count drives
reads past the response buffer into kernel heap memory.

Add a check that sta_count fits within the response size.

Fixes: b21783e94e20 ("mwifiex: add sta_list firmware command")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -976,7 +976,15 @@ static int mwifiex_ret_uap_sta_list(struct mwifiex_private *priv,
 	struct mwifiex_ie_types_sta_info *sta_info = (void *)&sta_list->tlv;
 	int i;
 	struct mwifiex_sta_node *sta_node;
+	u16 resp_size = le16_to_cpu(resp->size);
+	u16 count = le16_to_cpu(sta_list->sta_count);
+	u16 max_count;

+	if (resp_size < sizeof(*resp) - sizeof(resp->params) + sizeof(*sta_list))
+		return -EINVAL;
+	max_count = (resp_size - sizeof(*resp) + sizeof(resp->params) -
+		     sizeof(*sta_list)) / sizeof(*sta_info);
+	count = min(count, max_count);
-	for (i = 0; i < (le16_to_cpu(sta_list->sta_count)); i++) {
+	for (i = 0; i < count; i++) {
 		sta_node = mwifiex_get_sta_entry(priv, sta_info->mac);
 		if (unlikely(!sta_node))
 			continue;


