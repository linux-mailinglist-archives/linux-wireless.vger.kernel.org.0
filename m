Return-Path: <linux-wireless+bounces-8643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC858FF5DD
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 22:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C284283376
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 20:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70624194C86;
	Thu,  6 Jun 2024 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TlZaNFpR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192B139D1B;
	Thu,  6 Jun 2024 20:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705992; cv=none; b=ToKHnWpbKSvobeNV8OJnzSfdDSLbaBUFIhCSUsGYe+yLlyOONKt4hIT+k9ydlELqOROl4SQpbzy5C8ZccF7upAdykKIc17FMS62tr/vzHZWtd8OzDBBUjr5Jh1qBAoG1nqvu1XbnLMH4HOPjODkOdHDZjTh4wFrjYyW+5qr6hC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705992; c=relaxed/simple;
	bh=O/fIdSuE87jvT+rTXQIXkzqnruiLQx3ImxqfaRKWYqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmYzul+2zDAZXcAY9EnzhhmolRCPgIkBxFx/nXfXdRu06hwcS2+RxJGc39PAHExZ9/FgFvA54IkCu4S0Fm4Yei1sDQlDmVaewiscZrRyuzh78PzKoPm+KOylujqtTqSI4WOCQHqAZJqROQLKyWKOVVadZNf3hpj+yvs2pteIjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TlZaNFpR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ncgrJTEhoRR3zBhbPk7eARi4Oy+hPL2CM+fE1z0zHPc=; t=1717705989; x=1718915589; 
	b=TlZaNFpRMd/vNXG8faBshzjdXCDA/mHoycrg00Girak2kcS1P2t8SGUiNS2krxh7+FVjxyi9bvG
	8r24vcYr8UfxaXcPfC7NSjBUHMy7W/yq3PrVoeujAo6JEZqx1cYNOjNZFadBYGKhe/Srr5wHPL+bs
	77sputfYj7ZXks3PpTbF75JjwB50NzOXN/0S3kOjTAvefvbEplUMeyKMA8TrVijt1uSW1fWn4UGwH
	e/tiRsP/poUpEHIg3s1Q6qA3rexHdLq3bJk5U77z4r08dWq1T6dIL0AiLEFLmlHhcD+u3DixaNfCr
	lp49G3RbPO0QYmVAEidELqBRMAMlFQ/VRE6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFJn8-0000000HDhM-2x41;
	Thu, 06 Jun 2024 22:32:59 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v3 0/4] tracing: improve symbolic printing
Date: Thu,  6 Jun 2024 22:32:00 +0200
Message-ID: <20240606203255.49433-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Completely forgot about this again ... here's another respin.

v2 was:
 - rebased on 6.9-rc1
 - always search for __print_sym() and get rid of the DYNPRINT flag
   and associated code; I think ideally we'll just remove the older
   __print_symbolic() entirely
 - use ':' as the separator instead of "//" since that makes searching
   for it much easier and it's still not a valid char in an identifier
 - fix RCU

v3:
 - fix #undef issues
 - fix drop_monitor default
 - rebase on linux-trace/for-next (there were no conflicts)
 - move net patches to 3/4
 - clarify symbol name matching logic (and remove ")" from it)

To recap, it's annoying to have

 irq/65-iwlwifi:-401   [000]    22.790000: kfree_skb:  ...  reason: 0x20000

and much nicer to see

 irq/65-iwlwifi:-401   [000]    22.790000: kfree_skb:  ...  reason: RX_DROP_MONITOR

but this doesn't work now because __print_symbolic() can only
deal with a hard-coded list (which is actually really big.)

So here's __print_sym() which doesn't build the list into the
kernel image, but creates it at runtime. For userspace, it
will look the same as __print_symbolic() (it literally shows
__print_symbolic() to userspace) so no changes are needed,
but the actual list of values exposed to userspace in there
is built dynamically. For SKB drop reasons, this then has all
the reasons known when userspace queries the trace format.

I guess patch 3/4 should go through net-next, so not sure
how to handle this patch series. Or perhaps, as this will not
cause conflicts, in fact I've been rebasing it for a long time,
go through tracing anyway with an Ack from netdev? But I can
also just wait for the trace patch(es) to land and resubmit the
net patches after. Assuming this looks good at all :-)

Thanks,
johannes

%

