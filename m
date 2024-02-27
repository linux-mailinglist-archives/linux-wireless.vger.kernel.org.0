Return-Path: <linux-wireless+bounces-4106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5BE869BC1
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 17:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458FD1F27B1B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A995F148307;
	Tue, 27 Feb 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Fm41Y4qq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC501482E0
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050421; cv=none; b=T1URv2WHBY3e5xyXo+gH1u0L/FcVOd+lDNHO1Qlyda9OpmOgNJs/RAKnF7ckEddoGbkDoudlO0lvlGfC2wMqSRLzYHOQeYalJBdtf/o04cVnysSEYt3UlpkjNxTguuntG8Xc5jrnL7fULTICF1PCzy6r5BzwqG1w0xDSQ7Jb9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050421; c=relaxed/simple;
	bh=aFfWm9ewiVqOz9LPX+SG8HLtHBjipMwFYiopez4VN88=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T09r59Nz7mFeVfCsFlmOK/TEEu1mthZFlUZwta6U3LbKARGjISojsp7/AAtglEj08cBLyEk1+QJydKquHinqICs0ixuNwmDPtqBhx35vs6ltfb4zjt/o3enKhn8jFVuuRAbNvNJPZUiySP+TLbl80ze+lJt4vgFXSP9OLCYfjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Fm41Y4qq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RvGU5kg6IoYg8/6HA9uA8v7DsmTag61YxNg/dMsn3Nk=;
	t=1709050418; x=1710260018; b=Fm41Y4qq9K0tI7NTCrw5/7oFUU3P1p9JU14hqo85mOh5iLD
	3CCpS+v1dcfVN20P1I8NZy5yg0tHyvnraUk5fjJJYypMEzhyWVWeUze+rYbPEHHimASEmCmV3RWVB
	mZyM8QeII+5qUFse51696PLyw2Eky2WPhvoDFvrh6iyP+eidt5sX/w6+GqtSJGauNBXg96mpkLJ43
	FZ+GkJ9931yx6r44ZRlYG/9riTmySCRqsmpUKI6acxE//zy68JiTiUC6Xq9xXaHoRB353VDqPmz7Z
	ebzgW2ql8PH+HsKCMhIfvYDO1IxCb1SDXfFjSJ/F9sn3mC0DbKQH48VgjGa4IaFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rf05I-0000000AnPJ-27wp;
	Tue, 27 Feb 2024 17:13:36 +0100
Message-ID: <f2aec39d67cdb20cf813b575231ab95b409e315d.camel@sipsolutions.net>
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 27 Feb 2024 17:13:35 +0100
In-Reply-To: <366ed520b5f4b3cd603be11124f9b51e32ce8106.camel@sipsolutions.net>
References: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
	 <bdc7c51e3b6afaa7ac79efa15c6d1d41e9e918b5.camel@sipsolutions.net>
	 <95d56b9a-4b91-476f-bab3-7af0f28ff469@candelatech.com>
	 <0f8a0451e547f318febcbe36823e1f9914cc684b.camel@sipsolutions.net>
	 <33cc22b8-5852-42ae-9e80-8c3c58c36b6d@candelatech.com>
	 <4a3edd404b84da53b56bb0a391cb42d00f42f4c5.camel@sipsolutions.net>
	 <492a290b-752f-48c3-be16-59bdf7914487@candelatech.com>
	 <366ed520b5f4b3cd603be11124f9b51e32ce8106.camel@sipsolutions.net>
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

On Tue, 2024-02-27 at 15:58 +0100, Johannes Berg wrote:
>=20
> Which, btw, ignoring comments, braces, whitespace - then really just
> removes the line you're getting stuck on.
>=20
> So actually no ... invert the test?
>=20
>  if (refcount_dec_and_test(...))
>    return;
>=20
> If it hit zero here, there's guaranteed to be no user, so we can return.
>=20
> If it's not zero yet, we might yet go into a new cancellation, so we
> need the rest of the function.
>=20

This is what I wrote now:


Subject: [PATCH] debugfs: fix wait/cancellation handling during remove

Ben Greear further reports deadlocks during concurrent debugfs
remove while files are being accessed, even though the code in
question now uses debugfs cancellations. Turns out that despite
all the review on the locking, we missed completely that the
logic is wrong: if the refcount hits zero we can finish (and
need not wait for the completion), but if it doesn't we have
to trigger all the cancellations. As written, we can _never_
get into the loop triggering the cancellations. Fix this, and
explain it better while at it.

Cc: stable@vger.kernel.org
Fixes: 8c88a474357e ("debugfs: add API to allow debugfs operations cancella=
tion")
Reported-by: Ben Greear <greearb@candelatech.com>
Closes: https://lore.kernel.org/r/1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@cand=
elatech.com
Change-Id: I6c7aeff8c9d6628a8bc1ddcf332205a49d801f17
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/inode.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 034a617cb1a5..a40da0065433 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -751,13 +751,28 @@ static void __debugfs_file_removed(struct dentry *den=
try)
 	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
 		return;
=20
-	/* if we hit zero, just wait for all to finish */
-	if (!refcount_dec_and_test(&fsd->active_users)) {
-		wait_for_completion(&fsd->active_users_drained);
+	/* if this was the last reference, we're done */
+	if (refcount_dec_and_test(&fsd->active_users))
 		return;
-	}
=20
-	/* if we didn't hit zero, try to cancel any we can */
+	/*
+	 * If there's still a reference, the code that obtained it can
+	 * be in different states:
+	 *  - The common case of not using cancellations, or already
+	 *    after debugfs_leave_cancellation(), where we just need
+	 *    to wait for debugfs_file_put() which signals the completion;
+	 *  - inside a cancellation section, i.e. between
+	 *    debugfs_enter_cancellation() and debugfs_leave_cancellation(),
+	 *    in which case we need to trigger the ->cancel() function,
+	 *    and then wait for debugfs_file_put() just like in the
+	 *    previous case;
+	 *  - before debugfs_enter_cancellation() (but obviously after
+	 *    debugfs_file_get()), in which case we may not see the
+	 *    cancellation in the list on the first round of the loop,
+	 *    but debugfs_enter_cancellation() signals the completion
+	 *    after adding it, so this code gets woken up to call the
+	 *    ->cancel() function.
+	 */
 	while (refcount_read(&fsd->active_users)) {
 		struct debugfs_cancellation *c;
=20


Can you test it and let me know if that works?

Same as what we discussed, FWIW, other than the comments.

johannes

