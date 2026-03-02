Return-Path: <linux-wireless+bounces-32363-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGKxDrIepmmeKQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32363-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 00:35:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9356E1E6B6D
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 00:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE67F30C2FB6
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531893382C8;
	Mon,  2 Mar 2026 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="DjxXU9+5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95D337BA0
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494204; cv=none; b=HnXwlVNENsrkSMqOyPGLYMd290xr8xdytz0PqxMbzGOGscNRVMH224uXd011t/kNaATyQBefk7cTNQ7pIwZLd4BH+8gl1+91QCQ6p7dOjRQTLLQ8OkGEc0+7pLMzq5Ej9cGeRVDv3TKgaK3OKbmHVFpihaXX/g/QGAJYwtR9Kik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494204; c=relaxed/simple;
	bh=jmEnkd2JP9QeQ+3jaMuyocQLHYWGeRcWd9aGdfIWoMk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fYEBc77rFbTaR/Ymo7XfhpyoGl0voPAN0ZV/gucTFZzBCpp0dnmj+ActsIoTyDr+4y6MZuwJNMpYBQbDDfSh8pU0L3VsJ5w/7by4hhCjotFqZaJ4ptFt7tl8NkO0wLggIVzOvPEM6mpKuQDtHKKIx0Ssdiv1+QhEcGpfc1gLj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=DjxXU9+5; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 13AA48C007E
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 23:29:54 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 7BDCE13C2B0
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 15:29:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7BDCE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772494192;
	bh=jmEnkd2JP9QeQ+3jaMuyocQLHYWGeRcWd9aGdfIWoMk=;
	h=Date:To:From:Subject:From;
	b=DjxXU9+5CWzbRnz/5Hk7siTUubg5IzayIlYfeypGLXqenikBiXgZwp7VaTDQrp9Ks
	 gMDWO9lIYXDcfJIMsnCU2wVHVjdIs4U7DFZd9r/43x9+E0El8U9xgUuyRPClL+Oi8b
	 2940ZcDqa5K4Z/LyI9CKfineY9uBpNJq6SkAiiVo=
Message-ID: <51a8ef48-d1a7-098e-57c3-868d3183a650@candelatech.com>
Date: Mon, 2 Mar 2026 15:29:52 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: RFC: Potential fix for inode use-after-free
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772494195-ofwLUlvkFPsI
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1772494195;ofwLUlvkFPsI;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: 9356E1E6B6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	TAGGED_FROM(0.00)[bounces-32363-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

I was hitting a tricky case where debugfs inodes were being used
after they were freed (more of a double free attempt, really).

I tried multiple things, but this is the last thing that I tried
and it seems to have fixed things.  I believe the other stuff I
tried (adding a spin lock, other sanity checking) didn't actually
make a difference, but I've left logs in place if I do run into
more troubles...

For reasons not entirely clear, I was seeing a logging message indicating
that a station was being deleted while links were still active.

I believe that the problem then becomes when the netdev calls the
debugfs_remove_recursive, the inodes for the link's debugfs are
deleted, but links still have a pointer to it, and would later try
to clear their own debugfs.

So, explicitly NULL out any link inodes when removing the netdev debugfs.
I'm not that confident that I didn't somehow break this with other
local changes..but if someone else hits a similar problem, maybe
it is worth cleaning this up and making a real patch.

In net/mac80211/debugfs_netdev.c

  void ieee80211_debugfs_remove_netdev(struct ieee80211_sub_if_data *sdata)
  {
-	if (!sdata->vif.debugfs_dir)
+	struct dentry* dir = sdata->vif.debugfs_dir;
+	struct ieee80211_link_data *link;
+	int i;
+
+	if (!dir)
  		return;

-	debugfs_remove_recursive(sdata->vif.debugfs_dir);
  	sdata->vif.debugfs_dir = NULL;
+
+	/* In case where there were errors on station creation and maybe
+	 * teardown, we may get here with some links still active.  We are
+	 * about to recursively delete debugfs, so remove any pointers the
+	 * links may have.
+	 */
+	rcu_read_lock();
+
+	for (i = 0; i<IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+		link = rcu_access_pointer(sdata->link[i]);
+		if (!link)
+			continue;
+
+		if (dir == link->lnk_debugfs_dir) {
+			/* Deflink sharing our pointer, probably..clear but do not warn. */
+			link->lnk_debugfs_dir = NULL;
+		} else if (link->lnk_debugfs_dir) {
+			sdata_info(sdata, "Nulling link %i debugfs dir in remove-netdev",
+				   i);
+			link->lnk_debugfs_dir = NULL;
+		}
+	}
+	rcu_read_unlock();
+
+	debugfs_remove_recursive(dir);
  	sdata->debugfs.subdir_stations = NULL;
  }


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


