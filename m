Return-Path: <linux-wireless+bounces-8700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825FB9009E7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 18:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4951C22FB7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5FB19AA58;
	Fri,  7 Jun 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sfOg/7fM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687119A2B8;
	Fri,  7 Jun 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776335; cv=none; b=gF5HmzPno8oFA5JPIRnNQGkBok/fjxQ2DZ3aPq71KIOp7aoVZE9juGQUHt5mE/L3q6NfgL3VrStDaummmtEgyDYRYEzF+r47UZNtuxFiwD5ccW+Bj9sHQRqqQHGD2iqYXoSVVumQijZUCujaxV5u5cPkH9k2q/iCtqsKQQswJBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776335; c=relaxed/simple;
	bh=JMgcbIarvEtBlwz38S+91bS1tGOV5FhszjE8gX7ffgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLFW03HdLNO3eElRblM8FR38N82981qAEIuNiINWRyf1nUq7JOT9VuCvC7ngAyA7MWutFqRdbsNz/y5MT7yN1sN7Vf2/aC5KCTk76w+Oc1NjzkLQ4OXlSADQuzwh3fwFl1wzTdqN2Aqt5WxXN7KCGglXWUPxH64WlqBewSxRQh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sfOg/7fM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=GsQwOUVHANrfRC7C3PE60cZtrwaaAhQn03Fvn23yQCo=; t=1717776333; x=1718985933; 
	b=sfOg/7fM/m4oE/I5a5n2bhyhYWSnq5ppKk5LJrsBJFzSx++h4XtcLqHo+JdEtsmUpTyuHTx6bvo
	BrYwd3CDgkCci+N6dVPihhCGHeDTGqwAIauXrfytXwyw6S/KJRk0Tb3cUoZvAAAlLEyiD28hhwkv2
	+PQnxnBsuQNIHjRa4rsEaNNNKFQCWKaW8LnnI3YNFZSChjsiet8LPzgGVQxVikdWAIVbGuqGrhfRK
	fuKoGQGSIqOdp87FBdC/KSGFpKHw4JFhFm/AEn4dRhc6tpsAm6d6cLxdzRRsvp3W3yGzbjsv2mzht
	ERzAOCfQjBIthZMYDGqvHKOWKiSJGJ25Rmkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFc5q-00000001Iyu-0Yh7;
	Fri, 07 Jun 2024 18:05:30 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v4 0/4] tracing: improve symbolic printing
Date: Fri,  7 Jun 2024 18:04:22 +0200
Message-ID: <20240607160527.23624-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before I forget again ...

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

v4:
 - fix non-module build and possibly dynamic event handling


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


