Return-Path: <linux-wireless+bounces-34941-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIMqEkZq4mnk5gAAu9opvQ
	(envelope-from <linux-wireless+bounces-34941-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:13:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFF641D70D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 19:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80EA3304A859
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01978362153;
	Fri, 17 Apr 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfHrE6If"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC0314D2D
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776446017; cv=none; b=daYUZdNp73FmKdnIGRJ6f9ReWVucXAaEKM3hkzewyruqKTCxjnGhMOJ+n3NMvxitAtVec9UYvYwefiach3YdYW+BFi8t9ptNq3nQK4CB13fcZNcD5+BO6awuiW+GBGeSoClLZw1Wh32iUryxMHAAP+FHUpyQrF9u44v9viv6GI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776446017; c=relaxed/simple;
	bh=vOvv9PfdqrOQuktgiL2NNsrDaO6BtKVa3gPY5DNRhaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPNy9Ht+/lOKYao/3Y4UiFlnqUBBVN4A8wkb+C4wcO8PE9FQ5cE2pPIkzCM0QB394nYs1ZXPxahZcFhjJXfJ9HgLZq1rBP/6yxRsHF9BqNXEIrEy7foRNVBXENxNTQrx5LXnA/NgatGTlWCFFXd+Q+yv5otY3Z8LO+0G3nLhqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfHrE6If; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c648bc907ebso606201a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776446015; x=1777050815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CcKPgwgP5uli3YETM/bYR++ZHOWnDPNKI/Lr/gqeGHY=;
        b=DfHrE6IfJQv8qP6yoNPqZMuMGpYqh7bgaomrJYcG8BY4oLwy4Sa5H2p6duvLZ4mq3I
         X0SgSnfsyg3pEgeYs3GU/HPpbwshdzD9M5tUxiFI1STJonmBj70wxUspnw4ODyFds2zG
         gFzSf0aQVKPpOX8zfGsUz86AsronoXNXI+139XdtcFNd0KqwTekBP2HNJvHx/DCdnBKU
         LUZA6pPWYaESChhYLRz4EVep1BUBeyt7vTy5cRNjH6/moDu6RMk11RB0hgdm/1KdMoET
         5XIu2vz4TFU+kVsKQSMnWLWAJVOm3OyCpTIq7XHMPE1sJeDg4UXHLxKSGav3Qlyxm7HQ
         hkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776446015; x=1777050815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcKPgwgP5uli3YETM/bYR++ZHOWnDPNKI/Lr/gqeGHY=;
        b=CPlYM+42YHKN050xjFw2Q8Wn+a/igNDsHT++0BY5FrfgAp1thgWvQ1VbAkB41bYyMh
         y5xdMiQEoQnph9mr5UIKcaBZcmWowP6VRvhfkbBPV3L6So4+14iy/5S0Y+clmQythriT
         iwDnCQZOa/0SREonfrXHvOJa/40pTBT7rWToazyKgbok3OGMzEDGln3Ix/dQ70Jw3VuK
         5nMJJqgShj6ZuWDgnbS+lFDfLypUWASflkjqZMTe35gdo1Cs3wqIfmtXPl2CXft/fmPL
         5xYPICiD38wNDSr/jR3gosyYzfSn4xm3AEzc5XLhxXVrmQ6O9J9leslCBRoqLQb7CsVI
         xJww==
X-Forwarded-Encrypted: i=1; AFNElJ+8vE74Xu2Y7nwYZZ1P21fYW4UhFmaohqCOb0mujVGDlgXrpWRZ6wdVLvsa6lLdt9REob64wqeZpUetjajBTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe6/nkM66MKlA6swOlHFVUCqIEfZescFA0OYAsXk8JKdcYX0NT
	FsB4RWwCjPHmsLWdB/2eisE8BRa9HKojHx7z2j6sNq8G4VwgAPDOyw8w
X-Gm-Gg: AeBDievlQGZa2BOyWFJSeAfWFDj9QhmkJfFxNdpmguxo0tqwfQ/SZjGmbPYe9owCsjM
	9FhtvbevsHMVPC+syWeoz4d9cR/66cJC+2RlYRH7Wk7TIm5vt+d/9V0y5JrcDzxU6X+itHr+z+A
	Sk97iILVIM22B+/jAMTFlWZ1iZq7SAvJz+F77yJ9CCbkPmP7tAa6GQYvx2Z3b68092o/P2K5iKs
	uiU25cy/CkbBSzBlUzKrp02yG8KYa3o+AOu8ClZI1ct4zl85gI8h8aGFgvzCrI9I8ZTLE/acbgF
	SL66sgRuuB1srD4XlFWOvx+qTR7m3Bt28Ol5+NN2Kdwhy+j0cnVyzXjj4Gnd9KtFeSz1y9i1IUR
	NuiTCOaYmCVfBMBgDEthHmbVXaWfG+WX0fY7ZaxIHoCplY4mBONRifsGaIw2g/k8/DY+ZVEMLO/
	faCDHQRZUE/7LUxkCZeXVoF3ZdxkHtTHwVV9p7BQdzfoqMxnp9OAsKqNlkZZE=
X-Received: by 2002:a05:6a20:94cb:b0:39f:8aaa:face with SMTP id adf61e73a8af0-3a08d67bd3bmr4468629637.1.1776446014891;
        Fri, 17 Apr 2026 10:13:34 -0700 (PDT)
Received: from localhost.localdomain ([240c:c001:1:2e07:6c0d:c29d:b7e1:3688])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981829sm3199862b3a.12.2026.04.17.10.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 10:13:34 -0700 (PDT)
From: Wxm-233 <lty2wxm@gmail.com>
X-Google-Original-From: Wxm-233 <2200013188@stu.pku.edu.cn>
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] mac80211: lockdep warning from key debugfs creation
Date: Sat, 18 Apr 2026 01:12:53 +0800
Message-ID: <20260417171253.662-1-2200013188@stu.pku.edu.cn>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34941-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lty2wxm@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stu.pku.edu.cn:mid]
X-Rspamd-Queue-Id: 9EFF641D70D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

We hit a lockdep warning in the mac80211 key-add path under
syzkaller-style workloads.

We reproduced this on 6.19.0-rc5-00042-g944aacb68baf. In the same bug
bucket, later runs still show the same warning on
7.0.0-rc2-g0031c06807cf.

The warning is:

  WARNING: possible circular locking dependency detected

The observed path is:

  nl80211_new_key()
    -> rdev_add_key()
    -> ieee80211_add_key()
    -> ieee80211_key_link()
    -> ieee80211_debugfs_key_add()
    -> debugfs_create_dir()
    -> start_dirop()

nl80211_pre_doit() keeps wiphy.mtx held across nl80211_new_key().
After ieee80211_key_replace() succeeds, ieee80211_key_link()
immediately creates per-key debugfs entries.

That debugfs_create_dir() call goes through debugfs_start_creating(),
simple_start_creating(), and start_dirop(). start_dirop() takes the
parent inode rwsem and lookup_one_qstr_excl() then allocates a dentry
with GFP_KERNEL, which introduces fs_reclaim into the lock chain.

The warning becomes possible because there is already an existing
dependency from relay_open_buf()/relay_create_buf_file(): that path
holds relay_channels_mutex and then enters the same debugfs/VFS
creation flow, which reaches the directory inode lock.

With both chains present, lockdep reports the cycle:

  fs_reclaim -> relay_channels_mutex -> inode rwsem -> fs_reclaim

This looks more like a real locking problem than a pure fuzzing
artifact. The trigger is a syzkaller-style key creation workload, but
the questionable part is that mac80211 performs non-essential debugfs
creation inside the locked key installation path.

A possible fix direction would be to avoid creating per-key debugfs
entries while still in the locked add-key path, for example by
deferring the debugfs population until after the critical section or by
moving it to a safer asynchronous context.

Relevant source locations in current trees are:

  net/wireless/nl80211.c: nl80211_pre_doit(), nl80211_new_key()
  net/mac80211/key.c: ieee80211_key_link()
  net/mac80211/debugfs_key.c: ieee80211_debugfs_key_add()
  fs/namei.c: start_dirop()

If useful, I can also send the full report/log pair.

Thanks,

