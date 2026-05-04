Return-Path: <linux-wireless+bounces-35878-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPKMNzPw+Gl93QIAu9opvQ
	(envelope-from <linux-wireless+bounces-35878-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:14:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 814024C314B
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 21:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4171430071D1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51F3E866D;
	Mon,  4 May 2026 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXOb3CjW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02E3E3159
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922096; cv=none; b=PFrO8ojeZUfue2QD0iSubF4J+COa/WlnKtBQLv/yWfqEXYQQ1cssMnTMRwh9eS+4WVU9MIDCjfAg10SSAKN8qOZBqbcArFGF5eE93Nv/qvGld9rN/Srbgy8l+2CfPYR3nEcak8c0fuom8223sXZ+q8gsxn7mll7b1MwQJT0ZDw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922096; c=relaxed/simple;
	bh=+bAI8eLvjV8H7zLkrlmXjgTqU1HStw9NDvywYRU1WxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OB7A117eAlYqzscB38C9dk2o/d51BBWPiklKRVV1an5ASjHiFQNBrbDHqdgYxhgBJP41LHTCpEiWKgwIwF8Pok9x5Fpw7F46mScU4eN2DGkd8FAbWcmuUh3AUMQTw99Kf0JecWe3ir1bhFVG42EhhXj2eTFsdDwOtCmt67HWB9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXOb3CjW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso1717106f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777922094; x=1778526894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07LyOuuCoCXmOP8qKcfNaETTgt91OVt+KU1EFdkCEjA=;
        b=qXOb3CjW55ErcK/xGbDWuDTdU0rWWJbJ6zaw8/AZ4SukvVzFkaVSfG2S/is/ZFED3W
         L+vxsIbfGCFzLw837ECeWbsN7GvTqfzWhHlML0E33D15ZgYqLD06k3v0KZTFcBYXvcdP
         iFE9R42/5XLSAqn74robC82LWfE2AtXhLhtcc3IT/lJLUEh5r9+agwl2jJfsv+9UMPsM
         CYEhGFv+8BYNOFkDFZQvCkv/FP1Le0nPq54t6Dq4DdB3pQYdB5SXL7/ZyRbZNEQ+XSEa
         ckU+tJ13XrtboQxlKjE2IT93N8KmubOGyw0TjNckmQ7Cl5M38kT8AHmuYUdkDuhUY3e+
         iwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777922094; x=1778526894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07LyOuuCoCXmOP8qKcfNaETTgt91OVt+KU1EFdkCEjA=;
        b=JTzYDggAsLMEw5D326TfGJaqzTrxlIKw3KOUSa8NU9p9Frad+fZm946ZcRGxTScbUa
         QIN9No4G9UkvxuKGbzQ91mgGy/yOc6QnOelrEvPGOAwyBlyTlrsbT3qMynV2w53FetLm
         yXYFTGw3vTHSBbi7fu7O2HDSPBU+6XXhiDyHrvxXah8DrwDg+G2EZGElYUnCmkmz6vGZ
         UnyQNBy7tYDrAb3HqoIUlUTLwap/2T9II/Nc21bmCWJ/TxevcVaPzODYiOq/fjKoOCNt
         7y2kJzfIVK7x3UM7UTgGCBCudVEZ7LjVc3tdgUzYGE8pvFgdwQT2VxC4W7F2Voy/XZMp
         IFwA==
X-Gm-Message-State: AOJu0Yyx2CDNUNc/9p+UMTngIy4iF/yZNclvyhkXw38yiHK9ekmlSPiJ
	dCsG8KGM5AZBjdcrj6A98WmdQByEVNDFpAfveJahdp0DvihXncPitSpTVldz
X-Gm-Gg: AeBDievhnu7tlqa3ql7lyhBSgAVO8A/Ib+Gsu75ft3dwR4eHfJEmzuKPD4I26GHYgKR
	BGFH/Pgh98kjY6voWbufmLS7Hil5xIUzvLlosvT46MEhr6OyLl8G1b73u3dJVaGWj8Vdx5r7byH
	A45a0ve5wxdrcoQZ/AvNHhgdLqgexPG0FL33kiZ3RILyVpA0+VtEZ8XrPB9KGFiYDFIDd06tTEb
	eZG4miOITA9wVuauo4YXejHZG7aAz4S5I0ZQfdbwy9VMiiEYT7ZcUZE/uMeDgOZU7PGhGXPYoPy
	fu7T6xCiXbRYGk82wqkBONw83NzLRCaSC/CiBzHWvlvA8qw+IYvAR9lA9d8BK+8FqBxfopWj/ts
	0X7JtOEnNxU6/gLvtIOH5dcQm7YLfDTtisZVWTP6ZJrzaKegl20Adx4v0sGLQvzFjSv0eiY1rTZ
	SQw4fSxxTpWdx4v6AW3iblVXQY0NgOAczX09TqXg==
X-Received: by 2002:a05:6000:2dc8:b0:43f:dfb6:78e1 with SMTP id ffacd0b85a97d-45003afe478mr334936f8f.8.1777922093725;
        Mon, 04 May 2026 12:14:53 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4500d73510csm105445f8f.14.2026.05.04.12.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:14:53 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-wireless@vger.kernel.org
Cc: error27@gmail.com,
	kuba@kernel.org,
	johannes.berg@intel.com,
	dcbw@redhat.com,
	linville@tuxdriver.com,
	lkp@intel.com
Subject: [PATCH v4 0/2] wifi: libertas: fix two OOB reads from firmware fields
Date: Mon,  4 May 2026 19:14:50 +0000
Message-ID: <20260504191452.3408257-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 814024C314B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35878-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,intel.com,redhat.com,tuxdriver.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Two fixes for out-of-bounds reads in libertas caused by unchecked
firmware-supplied fields.

Changes since v3:
  - Use size_add() instead of raw addition/subtraction in bounds checks
    to avoid integer wrapping on 32-bit (Dan Carpenter / kernel test robot)

Tristan Madani (2):
  wifi: libertas: fix OOB read from firmware pkt_ptr offset in RX path
  wifi: libertas: fix OOB read from firmware bssdescriptsize in scan
    response

 drivers/net/wireless/marvell/libertas/cfg.c |  5 +++--
 drivers/net/wireless/marvell/libertas/rx.c  | 10 ++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.47.3

