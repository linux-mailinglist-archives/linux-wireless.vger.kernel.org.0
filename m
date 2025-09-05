Return-Path: <linux-wireless+bounces-27034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0486B44F31
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 09:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D4C1C8791A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Sep 2025 07:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5512D46B7;
	Fri,  5 Sep 2025 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZEUQbb3Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3032D59EF;
	Fri,  5 Sep 2025 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056584; cv=none; b=KTBXAdnorC03ppTUN6+0zA58mCGOcObF3743S6t4pIP5aOfo1V52xg2vvMFAIFCIYFXXQpt4syQAO5L81b4+7V+c8+JhLqPZ/n4AZYHiy9rxwQffIp4P6F84Q+w/VKb5NQHDaj6wap+rDyletfjVhpvkE0UjrxKNRMAfpKNcTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056584; c=relaxed/simple;
	bh=+EJwsud1rgTat+Y4GCZMiC6IThHQFwuKXd3PJh5RPIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k5V90I4ZDruZthaPNMW1xd7X1dd4fjlkKkej14V5cqocsOVk9xIZMJPm/RKzYYE9c6Vw2yfO/KkFspTsJu0b8rpTP+8/FRV0ujMRoPscQSKcfJdGFk2Qm5nLGj8eT5IpSWkkf4W2Wunl1lPDJBzjBVcy4EBq/ppFSNga/mJACYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZEUQbb3Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+EJwsud1rgTat+Y4GCZMiC6IThHQFwuKXd3PJh5RPIY=;
	t=1757056579; x=1758266179; b=ZEUQbb3YhzN9Wc717LRLQlL/0Fmw4GPV3hPQoZeWlYzMF4J
	8nA5ZtAHaAkqVI1JZK3daL+4ex7cGI4goXmra3942MhSXCbkVmiXLQUCjcFLOOpRvnfmbZPQNH+qx
	3lN9F54w9vqiZuUK8GJ4FQs9fEqt2SHA+WPB3ESVtii4KvS/xaefS0XgNgKn9aEQZUAYeFxJ3c3aX
	ZzMdD8gcB/XUim44xGHbNbfyWBB28S35YeGca0Tql5d4bIJjJijA5jzbGRyWJ0ElBLOYEtUJgarTj
	4EB7NANazeA8YC6y0opIaLipE2sm9mwbfSUuDtQm2pb+S3oiRRPDxSQDdQ7yxe/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uuQgB-0000000GBoz-2vRR;
	Fri, 05 Sep 2025 09:16:15 +0200
Message-ID: <e02385300c075395346ccf70b46a648698a66a3d.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: cfg80211: Remove the redundant wiphy_dev
From: Johannes Berg <johannes@sipsolutions.net>
To: tanzheng <tanzheng@kylinos.cn>
Cc: arend.vanspriel@broadcom.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Date: Fri, 05 Sep 2025 09:16:14 +0200
In-Reply-To: <20250905063923.1170764-1-tanzheng@kylinos.cn>
References: <20250905063923.1170764-1-tanzheng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-09-05 at 14:39 +0800, tanzheng wrote:
> There is no need to call wiphy_dev again.Simplifying the
> code makes it more readable.
>=20
> Signed-off-by: Zheng tan <tanzheng@kylinos.cn>
>=20

The bot complains this doesn't match your From: line, is that
intentional?

johannes

