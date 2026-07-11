Return-Path: <linux-wireless+bounces-38884-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zyuNLqmvUmprSQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38884-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 23:03:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABA9742E66
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 23:03:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=TmugTzPb;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38884-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38884-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9E16300E27C
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 21:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246F5309F1B;
	Sat, 11 Jul 2026 21:03:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CB305679
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 21:03:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803789; cv=none; b=pdKb36QDpO5mEQyKPr1Bo3nvHr2QYKrG6rEC/q7XvwI+PHeOvL9At9xM1LQdqNTYXB+CsrtFBnwPDIHPopiRCCo9gRzmYSG7YrIgeEMcAksP0GbgV0MZYPO/OQ/HEQMuTxgs7tIqkRSZx399Y3TPIpldaf65wuGZVD7X9vfbqkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803789; c=relaxed/simple;
	bh=TtM5obUM1rq7yjPXODdVw8cx3/1jpnLe3AZP6T0zsyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gj07tFFohx0+mpl6JxwlHVB23MRg9M+8/eOWvaI1LsJjKCD2TQjEUYidUOHa8pma6ws+2QlKSme5kwOXUGyG02rbbA5QXKejd9aZYfdrZeuGFIevvyPyqWLIz60ktmo/Qbq6LSV/9iDpcaf0c6BWWUIE9hmL7VF9LvnGQQ4YF+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=TmugTzPb; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-842338c18e0so1533995b3a.1
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783803787; x=1784408587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4peY4OdMSUAxRNTuJFTDFx6Yk17ghd0LBWVFX38rS74=;
        b=TmugTzPbUjZ4AJubOiwYZtLm8jUIQWU0e+uxJlg7zxmEmVwgCPLMgpQo6MZJpKP6ol
         vi1SjihBaFpY/0TcbtPEFa5Bx6iDcmp1RKzZbNoXl704+j5OH6483dmFfgVEWLAT4shf
         NovwK1OMiDKPIN9SNrY27UmbMkbkrzDTh6BA0+Rk8rtHYeKU0W2k/ZTl3bazfljlNwmG
         3dgS15U96kIooTMVGsvCcEEBbgBcyaFrpXEG4729mq6WsEi4FG2QjjEnPuD7YjH/CgFn
         UCxZBw6Q+FlvemFWh3YUlqvwVFJ6uR3MDyxiRb1r0/O2S+amptkcZXAxCodxF1JmgxxF
         NQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783803787; x=1784408587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4peY4OdMSUAxRNTuJFTDFx6Yk17ghd0LBWVFX38rS74=;
        b=ez1wftYdu5UXbBMldj0CmRcwt7xvhfZLsHKNMhedSEblmZlYc6GxweJEf7RJQwMfF7
         oQSJbFieht1+Kfq6/YGBNtfWIdsvd79iUt/teYIV1E6rfWppmz90hROi/rrdl/F25F6a
         JcOwHz6kg5pJ0/TyWyT1sWmXWsgs4CA8OeuO3++qwwPCbrZj7H2DES+jxd84dZM8r1xF
         UqIEzOoVr+XNnWk4hA9hAz2EYPLrKbR7hxMHZtulPIQuGteBL0JSOaZrOvIfa9ILylOa
         ZRuj3K+PAsuyYaC3fTDiKTG7tDQsT1CdILuvaDrTgRLLZCa2yXxp2zf25KsbGQUSlooT
         rmUg==
X-Forwarded-Encrypted: i=1; AHgh+Rpr8SQn2BYnIPVYFkk1i08pPueKXKwmsD4MR/Lo5Tti1zSXjR6I06xl4i/edbzbL1mk+eak+K2HBLIc7cdCnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsAR1yzElLyVfEMJ6i/uLnuCHeYkIocVv/lJjpZtaMCRIyL4gN
	ww2r/t37RCwq2nRBHn9rq26w75EYtAo69bR97n8vnW9NgjA72IY+kuZLUS+cD5CI4CLJPZpsAU9
	dy1mOog==
X-Gm-Gg: AfdE7cl2SdhLiWTUyy3Zo+IC9xRV1gNzAnMSmzP7WkbC6++gzrcCSXWiLk0YPSdxJ6J
	EUZ/MMDpQn3sd8S2JNuWh+aS4sGPLmMgmyIMDT70m1isgGo+xo0QUqcAyw5W+QXY7w7h2Gijokx
	NIoWT6VcYU+2KvltrNnthBRlhdmSEAtZ4Ass5KXWqF9TRIY8jKvFCyMARxhGfnZuuZww4BW6XCs
	0U4jPX96J3qPDG3wHx8Uz+tkcoEBHq8q7Uw8ZRaRLhi2uoFw+n0gahy6ii7SyBzhT/52a+bnQmT
	Qj2f9RbnndRCnQdd6F54P4gkQtCDhdsjCxLYqPkcdf7gxSK/BSjQNSoIyTRlQNrDcZae2iC67ZW
	g44tICrcdC9bvFl0zX6nGnq5o+Z2AwcpNLmneieqJDw8yNhVmAERU8UeUDri5qAR3v0r5+WhmsQ
	==
X-Received: by 2002:a05:6a00:8d5:b0:848:59fd:2f4d with SMTP id d2e1a72fcca58-84889799eb3mr3677687b3a.73.1783803786604;
        Sat, 11 Jul 2026 14:03:06 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec9d:8e39:1e2f:f164:750a:ec94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6ddc974sm12074248b3a.60.2026.07.11.14.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 14:03:06 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH wireless] wifi: mac80211: tear down new links on vif update error path
Date: Sat, 11 Jul 2026 14:03:02 -0700
Message-ID: <20260711210302.2098404-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38884-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,asu.edu];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:benjamin.berg@intel.com,m:gregory.greenman@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ABA9742E66

When ieee80211_vif_update_links() adds new links it allocates a link
container for each and calls ieee80211_link_init() (which registers the
per-link debugfs files with file->private_data pointing into the container)
and ieee80211_link_setup(). If the subsequent drv_change_vif_links() fails,
the error path restores the old pointers and jumps to 'free', which frees
the new containers but never removes their debugfs entries or stops the
links. The debugfs files survive with file->private_data dangling at the
freed container, so a later open()+read() (e.g. link-1/txpower)
dereferences freed memory in ieee80211_if_read_link(), a use-after-free.

The removal path already dismantles links correctly via
ieee80211_tear_down_links(), which removes each link's keys and debugfs
entries and calls ieee80211_link_stop(); the add path on the error branch
does not. Commit be1ba9ed221f ("wifi: mac80211: avoid weird state in error
path") hardened this same error path for the link-removal case
(new_links == 0) but left the newly-added links' teardown unaddressed.

drv_change_vif_links() can fail at runtime on MLO drivers (internal
allocation / queue / firmware command failures).

Remove the new links' debugfs entries and stop them before freeing.

  BUG: KASAN: slab-use-after-free in ieee80211_if_read_link (net/mac80211/debugfs_netdev.c:127)
  Read of size 8 at addr ffff888011290000 by task exploit/145
  Call Trace:
   ...
   ieee80211_if_read_link (net/mac80211/debugfs_netdev.c:127)
   short_proxy_read (fs/debugfs/file.c:373)
   vfs_read (fs/read_write.c:572)
   ksys_read (fs/read_write.c:716)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  ...
  Oops: general protection fault, probably for non-canonical address 0xdffffc000000000a
  RIP: 0010:ieee80211_if_read_link (net/mac80211/debugfs_netdev.c:127)
  Kernel panic - not syncing: Fatal exception

Fixes: 170cd6a66d9a ("wifi: mac80211: add netdev per-link debugfs data and driver hook")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/mac80211/link.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index d0535268962c..dc68144dc363 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -399,6 +399,10 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		memcpy(sdata->link, old_data, sizeof(old_data));
 		memcpy(sdata->vif.link_conf, old, sizeof(old));
 		ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
+		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+			ieee80211_link_debugfs_remove(&links[link_id]->data);
+			ieee80211_link_stop(&links[link_id]->data);
+		}
 		/* and free (only) the newly allocated links */
 		memset(to_free, 0, sizeof(links));
 		goto free;
-- 
2.43.0


