Return-Path: <linux-wireless+bounces-13352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5970498B475
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 08:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3301C2325E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B61BC07A;
	Tue,  1 Oct 2024 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aqMZtiIX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E51BBBEE
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764348; cv=none; b=n44WlUcwlcEUlwHPoGA8CuONyyb4lj1rgQ7/e8VbWloLQafZXHjiMO+Sj47BWbFsK1SZONrMz98qpjyha0vHC5t4SoeakKgbvYGWUzXOmAnNpvE8WGVMByglAbJKKhxgsntUUwJn58iTxx7TUQjD7NzA5Ruof1Geri+D9D5RNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764348; c=relaxed/simple;
	bh=fOBAMPE2E0L5e0qcPlmXJIO+UucSSed3hXNvGmWiPqs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lceFsEcRawibB9MMXziMfuQ11qwfM47Y6zhMYllnaGA02akOnsMukxXlHg7duHpLEqkTSpq3Xb1vZyZTY3Q//klWt6erE/D7ulllKd1S4vMjlQDnoQzCxv7dRthaIaz8ERtse0i2O/FTFw6e9YTtIRLJV3BCTiNREmiDUgpSlbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aqMZtiIX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fOBAMPE2E0L5e0qcPlmXJIO+UucSSed3hXNvGmWiPqs=;
	t=1727764347; x=1728973947; b=aqMZtiIX5JY4BzJRClZKD3cXrYp0lwlmkEWlpbKaoMz5sJD
	hUOxDSuJPdnKaSfGyOGQZOfyg8LYpWnVKbdosykF7xYX6QYW+NJjrAHcu/qJUpW8M4Rx40GKc3o7d
	JiObkOGE9Dbrpk4KzQxnPp19cjrf3WOnV61TF4qV7MDJM1Z2LCS+0ERJF4pOABtCf0mR/5a0MMMJ5
	7h68Rj2Ha+MUrsIsb9uXV0g4/kT87qWpqNCTTEFAEjNLz7b32Ah0VK9mTIRir9TXCHS1kZcg+JsAn
	I53idRLlalNmAYOX/a2X6KCY1qC/ER6fYIyLNqUmCaq3HET7eo5mWMa5S9PowkPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1svWQp-0000000EdAy-2EKu;
	Tue, 01 Oct 2024 08:32:23 +0200
Message-ID: <06708838017266efd2351f0bda1bf01b0ee2bef9.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix assigning channel in activate links
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Tue, 01 Oct 2024 08:32:22 +0200
In-Reply-To: <20241001041518.2236297-1-quic_adisi@quicinc.com>
References: <20241001041518.2236297-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-10-01 at 09:45 +0530, Aditya Kumar Singh wrote:
> The current flow in _ieee80211_set_active_links() does not align with the
> operational requirements of drivers that groups multiple hardware
> under a single wiphy.

Btw, given that, I'd argue it's not really "fix ..." right now, since
there's no such driver and no real bug? Dunno. But "fix" makes it sound
like there's a bugfix, and it isn't now, it's just preparing for future
ath12k compatibility.

johannes

