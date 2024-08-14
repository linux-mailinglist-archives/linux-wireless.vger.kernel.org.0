Return-Path: <linux-wireless+bounces-11391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41351951362
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 06:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFE41F23ABE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 04:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B758383B2;
	Wed, 14 Aug 2024 04:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="annuNz0p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB466219EA
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 04:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608727; cv=none; b=PZRZHiItPZPUcgVO8wYXljDzwFR8wYC9iWdj4NTnfOubHknfNdo2mw+riryYrWvyZvKbdJWswInQClpg31Nruv+UDSK90BMzcGYGuW1PskvIt2ETelKe1Kmfdf0EZ4hQc+RQW5gLal9gw6+Ml7mqDLUnb/NcH3Xvt/lms7ZmykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608727; c=relaxed/simple;
	bh=HkKwIoHlO5q5N5v9NshMb5gWmUGTcPxTXNFH0izbM88=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Eo3NatV5a7Biaqpht6tOrt7o5O5Iyl2Z8ygSRUFd0YobxBNYPulFKqjoYePZcviRIHRu5jJPpF5u4tDmrmebfF1bYeOVx+q3o95eAJbXRXm66ByiprA/YysppfFOwA+qzHky5l6lPDhALisqm7dN+aygofUaBDHPkItePh9CCyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=annuNz0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4491BC32786;
	Wed, 14 Aug 2024 04:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723608726;
	bh=HkKwIoHlO5q5N5v9NshMb5gWmUGTcPxTXNFH0izbM88=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=annuNz0pL5GiQX2eyFsbp/fCXyzBcARPtZQrsoFayVO1jY0gyGEuKCWd71l7qXUPO
	 5toZqQNbN9TWEBSE6FO9IMIWNvkjH8JN45A9Ga/1QFp06CDiOkOOBQxTANKhqKlaX1
	 4ziiQT1NHsTWRMeFXQhp8FO1mObK7LSkRFOROu8E4CuOJAeVPBDlWGTbjAXFv7myuE
	 z4D8IwNNcuptCNneiQ32s7KUpe7U+oFG0Cg56rdKVVxEzJHOdb4k80xk5dELfZB9hc
	 8CjQs1Xt1UL7ffw4sW8Otw0nCJLXjtzJAtiGc7/TudjRPKWwSDlLSO7inxx54VkLwc
	 nK+TedOVPRlKg==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 66AB15FCA8;
	Wed, 14 Aug 2024 12:12:02 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: wireless-regdb@lists.infradead.org, leslie_sen <leslie_sen@163.com>
In-Reply-To: <20240813-correct_cn-v1-1-91275dc00d9d@flygoat.com>
References: <20240813-correct_cn-v1-1-91275dc00d9d@flygoat.com>
Subject: Re: [PATCH RESEND] wireless-regdb: Correct regulatory rules for
 China (CN)
Message-Id: <172360872239.1746842.1519520270672145622.b4-ty@kernel.org>
Date: Wed, 14 Aug 2024 12:12:02 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 13 Aug 2024 20:43:59 +0100, Jiaxun Yang wrote:
> As per "工业和信息化部关于加强和规范2400MHz、5100MHz和5800MHz频段无线电
> 管理有关事宜的通知" ("工信部无〔2021〕129号"), only 5250 MHz - 5350 MHz
> band is required to have DFS / TPC.
> 
> This is slightly conflicting with is attachment "2400MHz、5100MHz 和
> 5800MHz 频段无线电发射设备射频技术要求", which stated that all devices
> working at 5100 MHz band should implement DFS/TPC.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Correct regulatory rules for China (CN)
      https://git.kernel.org/wens/wireless-regdb/c/3b347617c12a

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


