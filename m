Return-Path: <linux-wireless+bounces-9059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB1890AC61
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 12:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FAB1C22A3B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 10:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF7A1946C5;
	Mon, 17 Jun 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQaK0z65"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06C1946BC;
	Mon, 17 Jun 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621811; cv=none; b=LkKhx5GuVntlz+DtdGqso63Uo72VSjvi3NZ3wlx1xQv65XkC3iCojXQ9PV7dKMDkYAPI1vcn3Hp8CpdygyS9PoPNRdcTPmSzFDWnMqjqQgaZJeJwSqL2U+FiZo0Hkf6xS+17fXusqT7GksyqJs9TWMIwVwYtuzuq7q9ghH5EWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621811; c=relaxed/simple;
	bh=gnkuN2V0yCmQJcyY7kG5C//mMgwPDwk36C1SGnZV8aM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kDLyNjn6eJErj1xCrN1nVnrBCvTyOqn8lInLwwxK9X7Qk17JRcTJB9LUiFRCWftH6lZOzSahebfuhq6/Y6QncGUoyS5OgbZ6RlKJVAxRcflglxM4f81wct9M1GBMvZPFhphOCmbbb9sey/R//NpbsFKh7GUYR7KbENeLAcd2wjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQaK0z65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737A4C2BD10;
	Mon, 17 Jun 2024 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718621811;
	bh=gnkuN2V0yCmQJcyY7kG5C//mMgwPDwk36C1SGnZV8aM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VQaK0z65nQyx8dSLveR4KQ2jS5QzZ4SZL7DQzJ+vvZvjMRN1Pum7rMX9MH7x0/oXn
	 Rsxp8eYkG1eN8oRJ4tYc9y7tZixD0csgkrvcM9VEhtYgfxWHIrGZitr1utLUA9zi4S
	 WontDbYTtfO7Eqwi+KU/CCD+mLTBaKeRo9jAETX8J7NP2UqMHW1a8XdJ/2Kyy0Sex4
	 ZgaZIfRftLjdrAcIiRb3gYS7K+1KJFFn/5WMEDDZ+ZDXapPm9dntLk9oGhCBrfaxsT
	 E7A1sdRVTN0KZ6zPMtkUICu4oev8biZArNCQ+BSi53ZNKHQ+iTW8dkHhw3Js7KrfDa
	 /9AgXmi+zZGiQ==
From: Kalle Valo <kvalo@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Johannes Berg <johannes.berg@intel.com>,  Michael Nemanov
 <michael.nemanov@ti.com>,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless v2] wifi: wlcore: fix wlcore AP mode
References: <E1sClp4-00Evu7-8v@rmk-PC.armlinux.org.uk>
	<Zm1CKAKCnuc94oIi@shell.armlinux.org.uk>
Date: Mon, 17 Jun 2024 13:56:48 +0300
In-Reply-To: <Zm1CKAKCnuc94oIi@shell.armlinux.org.uk> (Russell King's message
	of "Sat, 15 Jun 2024 08:26:32 +0100")
Message-ID: <87tthrn8gf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

> I see all my TI Wilink patches have been marked as "deferred" in the
> wireless patchwork. Please could you explain what the plan is with
> these patches, especially this one which fixes a serious frustrating
> failing that makes AP mode on this hardware very unreliable and thus
> useless.

I'm just swamped with patches, I'll try to look at these soon.

I wish that TI would take a more active role in upstream, for example
reviewing and testing patches would help a lot.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

