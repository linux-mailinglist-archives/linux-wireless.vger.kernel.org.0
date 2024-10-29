Return-Path: <linux-wireless+bounces-14628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C69D9B43A6
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 09:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FAC28366F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 08:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6E5200BA5;
	Tue, 29 Oct 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KmVTk8oB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE37202F9C
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188912; cv=none; b=TbpdkpqKKloszcdPAROiR6/PPmP2l2aAVJRUkHJ9RBqmwMyKjvnRjr0yIbWhdnUd4fyQeU1mZ69cX3ftMV/XM3At2H/lZbtxYb49pOhWDRMyYQYxBV7+9wTLk65njDANV4mnGSjBjGzSV+3Mpryelx7TUM4nwmqWcC9cNYCNyHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188912; c=relaxed/simple;
	bh=Lb7+JRot0Ow/hXFvvjjqUJ2t6DwR3AB4KdHFXq1esh0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NC+j9sAy6G9IQqntG02rCBwK0jLPwZRHh4AYwYNMjtYVxHJe+2Wl+mRN+ShkpZDhiNJp+n6MnVHi2CCnFWEJrYalUsZjUNUMKLTf+7em3TCs7zbOMa6TNWL/pa5pQUwYXd+CrFpTBnlcdUABsfsnocH0+zHWNpDGwkiaubTHY7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KmVTk8oB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JTtqIS6uZm1lVd1JigYggHFNA/02TY3W2/sJni/wQjg=;
	t=1730188910; x=1731398510; b=KmVTk8oBF2LNHJ6tpNMnqPvZzl7W23u6u5ITQINZtRHqXae
	y8psbjqWkIh0neWQWx/hEzL2Apa2JF2lELKShGrN6K9cUh3Y4f4j7oTBoNgwCdx1UgjqgxA8l834B
	EenthmRB4b9X67lKQVaPDgW9dshyd/uh+Zwte/4FpUGix331xrv5u1ft3OymrhQRW96L2m24fR7Nr
	dVM/B3S3npuMHRyiuwDIlsHZvG0GmiVxQrX5gTWoOg1clbVTZ/O7UNxm97orGq/c5ZgH5t4CvlPIZ
	xznij9qNNEVI4UMWhRGehIdwyKMOHxnv/376KpKVUctK1e1fD6ubi9dNiYYdq+WQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t5hAc-000000087a4-2f2V;
	Tue, 29 Oct 2024 09:01:42 +0100
Message-ID: <1f6d998c16510426e57b774c42358dcef7a5cd31.camel@sipsolutions.net>
Subject: Re: Question on iwlwifi iwl_mvm_mac_itxq_xmit, possible busy-spin.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 29 Oct 2024 09:01:41 +0100
In-Reply-To: <8dce89a1-350c-4885-afcc-0eda162fd76c@candelatech.com>
References: <8dce89a1-350c-4885-afcc-0eda162fd76c@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-10-28 at 10:48 -0700, Ben Greear wrote:
>=20
> We see indication that the iwlwifi txpath can busy-spin,
> causing soft-lockup (and, only indication at this point, possibly
> issue is elsewhere somehow).

TX path I'm not aware of any issues, but we did have this recently:

https://bugzilla.kernel.org/show_bug.cgi?id=3D219375

> But, I also wanted to check on expected behaviour.  At the bottom is a do=
uble
> loop.  The inner will break out if the queues are full and for some other=
 reasons,
> but the outside loop is spinning on a different atomic counter. The quest=
ion is:
> If the inner loop breaks out, at least for queue full reasons, should it =
then
> immediately break out of the outer while loop as well?

It shouldn't matter, but off the top of my head I'd say it's valid to
break out entirely since the "queue no longer full" indication will
restart it. In fact, it seems that'd really make more sense than the
"sofar" thing you added. Not much value in retrying if the queue is full
anyway?

> And, from what I can tell, it would be possible for other transmitters to=
 hit this
> path,

Not really? It should only get here from two places: userspace
(serialized, so you're not going to get to this point with two threads
from there), and the "queue no longer full" logic I mentioned above. Oh,
maybe technically a third at the beginning after allocating a new queue.

> Based on the description of the 3 tx_request states, I am also not sure t=
hat
> this would not hang the tx path in case where inner loop bails out due to
> tx queue full, leaving packets queued.  If no other packets are ever tran=
smitted,
> is there anything that would re-kick the xmit path?

If the queue becomes "not full", then yes, that kicks it again.


I guess I could sort of see a scenario where

 - queues got full
 - queues got not full
 - we kick this logic via "queue not full"
 - while this is running, userspace TX permanently bumps
   tx_request from 1 to 2, this decrements it again, etc.

What thread is the soft lockup in that you see?

johannes

