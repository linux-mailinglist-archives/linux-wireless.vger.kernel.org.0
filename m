Return-Path: <linux-wireless+bounces-33370-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM5ZLCkjumkbSAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33370-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 04:59:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE5F2B59CD
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 04:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D52130614F0
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 03:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1351F226CFE;
	Wed, 18 Mar 2026 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5wnwF23"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CC2765ED
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 03:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773806359; cv=none; b=Stra9wumk/4iNh8+H9sbYAP4IsQlzZ4wHcgH1GqXqAsJblomluoiCtS+cmhIMve2wOfDCDGx+yhbBOptkIYvTHvcxlLSR29juI+JIAU82tg1+D6N0jq4t7YdgzjaCXOAcH72pKI6XTs9zHZ/wkqhEvc1vc5wSz/KL62oljmkuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773806359; c=relaxed/simple;
	bh=dSDrO0qq03ZQallHvVYCa/qVY9RPvxeAq076TjBwxJc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lQ7DVW9F7sYFj39pfC48rYXlZ4QR8QpS6JBa2EQQiuQW5XvC2VUIPag5uleVjSs1C4tgHHxyf2k92U+IkBq7M6uVYjpciJNcmZVWlHkjWufgipfpMbTP5oH1ZAsVb4zPJlqalR1XCFMlX45egdUfiD84JeuGtUFeU+7M7k0FfQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5wnwF23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD1DC19421;
	Wed, 18 Mar 2026 03:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773806358;
	bh=dSDrO0qq03ZQallHvVYCa/qVY9RPvxeAq076TjBwxJc=;
	h=Date:From:To:Subject:From;
	b=m5wnwF23AJO1GAT4hfAvXelpflT4bna0pyF9urcrWwyaCdE7DIFyHxNpmGIt64PHx
	 EsCvIGI7Hrk2FcZrLC9YN0H2yK6c4vHy60JSnYeDM3kUk1WdTUMFTdsxr8oAJZOrFb
	 6begW75AU0pZuKxMUzrP2b+yF2kJtMdl9HVkxjXikAkJwtY7ncXzYw2jvbpV+pQ2dM
	 OwAe8tofwjMUPZgk63UddOV/2H1zSGKLCHkZzMUk6HnVmVAvNjLvzsgfP+QclxU8kv
	 Yza7W+EkHN1Cbb94blPMdxn7q6SPfsQ4joJJu6RJIswIfjBP4144Cdwf+QnE6imrbk
	 NMtYULftfqhWQ==
Received: by wens.tw (Postfix, from userid 1000)
	id BD5195FCAC; Wed, 18 Mar 2026 11:59:15 +0800 (CST)
Date: Wed, 18 Mar 2026 11:59:15 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2026-03-18
Message-ID: <abojEyQYNTJM-v5u@wens.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33370-lists,linux-wireless=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FE5F2B59CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A new release of wireless-regdb (master-2026-03-18) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2026.03.18.tar.xz

The short log of changes since the master-2026-02-04 release is below.

--

Ben Hutchings (2):
      wireless-regdb: Fix regulatory.bin signing with new M2Crypto
      wireless-regdb: Replace M2Crypto with cryptography package

Chen-Yu Tsai (2):
      wireless-regdb: Update regulatory rules for India (IN) on 6GHz
      wireless-regdb: update regulatory database based on preceding changes

