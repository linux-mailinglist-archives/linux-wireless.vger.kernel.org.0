Return-Path: <linux-wireless+bounces-6738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7D18AF7B4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 22:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE841282455
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8F51422C2;
	Tue, 23 Apr 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QDpykWgV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9D13DDB4
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902428; cv=none; b=PAzDmghYYyTdi8E6k2PLT5U9M7jVXy48NPOajwlML2RpmD/IceWmzyc7ZXeNNMljajKdx6U1sJXh1RGHmk8MyTA800meS8bQFnaUlOYxDbcLto5QuJyfWadKesmMr5OHG5gjAOvrsng/4VLHVn0Mmu6jfFd6dOaJMATw/ESfskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902428; c=relaxed/simple;
	bh=ZsvF/J7y9X+oIYfdNPDXysoAskg2Gp45G3zbGNKxdek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fizg4ZZm9BxMb8f3WMNr8JgZ5vXCbzi19KmWezrku5UWB2s9uSGS9hvN4Uqg1NRQWdiSm+kzySufaqs8atbvU99KXex7UNQzxg/GmaMxer1h//SwqYC18hbr6urUpQGSTdeOQr3ziZbl03Y/BkAYHIdFZm/Q7M/qDQa7fOXOgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QDpykWgV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ZsvF/J7y9X+oIYfdNPDXysoAskg2Gp45G3zbGNKxdek=; t=1713902426; x=1715112026; 
	b=QDpykWgVMW8qPObuwvn6+GsBpIpB9vACyIpJOKZUd6N1akEZp5aYjGzFDeBy7bsUq+2amKxupDv
	rbCEp8octVpF3oaAfWKtdsir5I/1PpPGHpK15F6AgE0086CapcpF7tDeKlJ9o6JCVXvYpgl4AG4Pg
	0DJnFjAIg3iwKInA0hF6opwAgZpWWpdy4eHIoqykcpTHt/MXcRMDOPpfbqRwHw7GHqfBqRUUBnL91
	2oMDvfpJL1NrCPgJA0JwyLtAxmyBqljz+mTpHdzMzVIZg7TgS1ZqV/VvoNU1fLvquNN7mZvvoJBc4
	tdVFbA34dY8b9Ca2P9I+T+ZdIZkzWv+XN7Cg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzMJS-00000002OTL-3oMO
	for linux-wireless@vger.kernel.org;
	Tue, 23 Apr 2024 22:00:23 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [RFC PATCH 0/4] mac80211: handle transmit power envelope better
Date: Tue, 23 Apr 2024 21:56:11 +0200
Message-ID: <20240423200019.192941-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TPE handling is a bit messy, we just collect 8 of them but don't
give the driver any help with interpreting, and really in ath11k
(the only user) it's already wrong for PSD, because we might use a
channel narrower than the AP, and then we use the wrong values.

Also, ath11k uses the chandef width, which might be wider than the
vif width, but that's an incidental finding.

We also want to have EHT support here, which is basically impossible
for drivers to do themselves since they don't necessarily know the
full AP chandef, and then cannot properly select the subset of the
PSD values to use.

So I've decided to move (really reimplement) all the parsing to (in)
mac80211 and give the driver information matching the vif's chanreq.

johannes


