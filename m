Return-Path: <linux-wireless+bounces-4089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B518693F1
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 14:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E819E293327
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAADE13AA2F;
	Tue, 27 Feb 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PEt9duzJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD9D13F006
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041686; cv=none; b=MkZlpfQZcQZ/91aFL14fa4CHI4AR04lgPYPEvxsl0mzi1NAH7gL5hAI6KpXzdYjpXsKxrjw7l0uuxpKI3A9kWz6Csyt2biLd4pZPgPJL0uRsi5lfjV/yvIPV2Qn6YYwMHydeEKkmJE5G5Kbusv/yuMq3QYnacRPCNCqokquxhCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041686; c=relaxed/simple;
	bh=Fz00mnO8wt75jhaPVRAdWIaW5p/1QdSAgiEzjtfNvdc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPMSvbYtnL5aXHnPWjN9gRY1EjPr13QGFGWv050ecokq0g0Q0KMytSOqiHoxz6Eq0fRq2W9LfgleCq28d655jkWWq7HFRyr0H4wrh4hY0OlVVAAWP10cQktfuDfUdNROByqCncmKqae54FnGH0D0DbbhPVLe92rDVjiz7m4mibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PEt9duzJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aQCQEJyDlL03QbDHCFktm6JFzoi5Nc2x2S7OyRZuXAA=;
	t=1709041684; x=1710251284; b=PEt9duzJEhHjbj04q2ZvG871+dyJB80293HstHVrOSITOOm
	YJ4qLgLhQhT5OqiGHAA8ijlV7Im9iPzeD1Yo8NQBxmfO6Yb8R05qp2cUSndBAXJlPW5OAHhmr1eAW
	fqYbhgOKGy0NElAQTcaQ+SHdgaPAgkzEA2FvFtrJIjZjgwVsUx6pLIpkbUN4w1biJfbLNJRqVw3Na
	BATzhWoQ+/uC8hENBcXNKbDzRPGRgsRIEcpBbj/mVGzbI9OGvi1ODk3CRvSO+FRhjz0fwFxl088yl
	cQP1a4oE92QJAXpmSqOLXW9BT0cKJYum1hF40K49U7Yt5A59iG5Pqt/abkldb9vQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rexoM-0000000AhbM-1seK;
	Tue, 27 Feb 2024 14:47:58 +0100
Message-ID: <0f8a0451e547f318febcbe36823e1f9914cc684b.camel@sipsolutions.net>
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 27 Feb 2024 14:47:57 +0100
In-Reply-To: <95d56b9a-4b91-476f-bab3-7af0f28ff469@candelatech.com>
References: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
	 <bdc7c51e3b6afaa7ac79efa15c6d1d41e9e918b5.camel@sipsolutions.net>
	 <95d56b9a-4b91-476f-bab3-7af0f28ff469@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned


> Feb 26 06:01:45 ct523c-0b0b kernel: task:ip              state:D stack:0 =
    pid:28125 tgid:28125 ppid:3604   flags:0x00004002
> Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
> Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
> Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_timeout+0x19c/0x1b0
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? mark_held_locks+0x49/0x70
> Feb 26 06:01:45 ct523c-0b0b kernel:  __wait_for_common+0xba/0x1d0
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? usleep_range_state+0xb0/0xb0
> Feb 26 06:01:45 ct523c-0b0b kernel:  remove_one+0x6b/0x100

Can you say where this remove_one+0x6b is?

I feel it's probably this:

       if (!refcount_dec_and_test(&fsd->active_users)) {
               wait_for_completion(&fsd->active_users_drained);

which ... looking at it, seems wrong?

_Completely_ untested:

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 034a617cb1a5..fb636478c54d 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -751,13 +751,19 @@ static void __debugfs_file_removed(struct dentry *den=
try)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
=20
-	/* if we hit zero, just wait for all to finish */
-	if (!refcount_dec_and_test(&fsd->active_users)) {
-		wait_for_completion(&fsd->active_users_drained);
-		return;
-	}
+	/*
+	 * Now that debugfs_file_get() no longer sees a valid entry,
+	 * decrement the refcount to remove the initial reference.
+	 */
+	refcount_dec(&fsd->active_users);
=20
-	/* if we didn't hit zero, try to cancel any we can */
+	/*
+	 * As long as it's not zero, try to cancel any cancellations,
+	 * new incoming ones will wake up the completion as we might
+	 * have raced: debugfs_file_get() had already been done, but
+	 * debugfs_enter_cancellation() hadn't, by the time we got
+	 * to this point here.
+	 */
 	while (refcount_read(&fsd->active_users)) {
 		struct debugfs_cancellation *c;
=20



johannes

