Return-Path: <linux-wireless+bounces-5228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F2F88B04F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 20:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B7FB371D0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1901076026;
	Mon, 25 Mar 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="p4wEScDM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D863DABE0
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388617; cv=none; b=X1y8u1HwxSzYs9zZLZlDmUjVRC5bh9B9N9D55atptdnAhRKD7jMDWVNiR123yU4LjZXMy0aG3khPoc2Q0/TCwk9HSq11GrMc6++WwqcUye/uHoLoGr/KVMCgAPB8ociaA6/4BbUyPalmT77KQxkYL1dByTx8n88Dzi9iAQNlsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388617; c=relaxed/simple;
	bh=yTfuv/5U1USvPNDRyI74lL7kKbAtB7x7BfOXHyKYBNA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwiqP10DCgjW/8dnFyHqwL8f2TS8D6AN7b6ZMd1jSDKBOgclK2uUzTrbeNlvfPSABIeKpf1pe0qVtnN/9AjI7v2ZWaLkLzkiyMW3QtEBhLQFPcRUyG3tjbqapjFNSXW6aFyaGAtfg+pFmPkSQLilmHvZHYCauqayqPh7aUBgquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=p4wEScDM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ub312HHl21r8z1oc98BYt4Fn8HPqytH8EZdIXqZVs9o=;
	t=1711388615; x=1712598215; b=p4wEScDMq1RbeJyovzw5v8eEh0vQVryCa9Tvqfi7vjQj9RB
	8XUtW7anXXxOD1E4n1Y3XGv9WTp0xzGfe/DNVCGSf5qVVr3LT7oXKZauoxQvbirhcrNrWNx8Khkws
	CJQa4k2gVY3enD5TfXYNEUKdeB/lMnGuuTtdsuqUz3A53iGz2hHYRcmzjy7ekmVve0Lxir3TEIi4M
	RnlahazPnttlzTiIiF8VZ9SRURI45pEtxzcz73kbxAaRkHyDq9kbswJNSYoLp3MX08FH3xhrWyz8D
	+e+8/xNtqrdLcA5cZhQRHUYs8itfZ05RebwEZYEc356c5QVzR8/HD7m9EksaC2RQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rooM9-0000000Dzki-11ZH;
	Mon, 25 Mar 2024 18:43:33 +0100
Message-ID: <973efc2cb87812f512fd33f354a91da17e3d8564.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Ensure links are cleaned up when driver
 fails.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Mon, 25 Mar 2024 18:43:32 +0100
In-Reply-To: <6bed94b3-4674-7fe9-ee82-bac7f9c7ffd6@candelatech.com>
References: <20231111001023.1335122-1-greearb@candelatech.com>
	 <5fe480c4-fa39-1d29-a5e9-ba2447b08dd2@candelatech.com>
	 <449f6afbc20c57f704dbeabc3a8eac8fec676405.camel@sipsolutions.net>
	 <6bed94b3-4674-7fe9-ee82-bac7f9c7ffd6@candelatech.com>
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

On Mon, 2024-03-25 at 10:40 -0700, Ben Greear wrote:
> It is needed because if FW crashes while you are trying to remove links, =
then link
> removal would fail, which causes mac80211 to not clean up its links.

OK. It should get back to some legal state after recovery though?

> In case where you
> are trying to delete the station, this causes un-cleaned links which caus=
ed crashes
> back when I was creating this patch.  My patch allows always cleaning up =
the links
> regardless of driver errors in the teardown paths.

Seems potentially more like driver errors. Or perhaps we should just
ignore driver errors entirely?

> Always possible some intervening changes made this less of a problem, esp=
ecially since
> MLO is disabled for be200 in upstream code anyway now.

Well that's just temporary, but we've also done a lot of work on FW
error recovery, though likely unrelated to this particular issue.

> I can remove the extra logging if you are otherwise OK with the approach
> but don't want the logs.

Well it'd be nice to actually see what crashed, and maybe it should
really be driver fixes? I don't really understand why mac80211 would
crash on failure of link removal.

johannes

