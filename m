Return-Path: <linux-wireless+bounces-1264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F481D392
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 11:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F1C1F21865
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34729456;
	Sat, 23 Dec 2023 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="GXCeGKwj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4AA4F
	for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id A7DB3115C5;
	Sat, 23 Dec 2023 10:40:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PdH--Sp0PfUt; Sat, 23 Dec 2023 10:40:13 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Sat, 23 Dec 2023 12:40:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1703328013; bh=MNttMzNopoiCMIk0Vl9YO/OTUaftnsHK0b+WCOVdwms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXCeGKwjx2/WzOu1dSO/Ej5TKQH98kf5cOdvSZXxfLUh7Lrv5E0D7O3uj4XH0x67j
	 AYalgpBQay9CBC4wJdyLOPmqjbs8q5Jg5cJSzTSd3fatsmoY8WsiaSYT3xTprL7uSz
	 Kd2jTs7oZJDvg7WT/lXdESUFFFAtPAS37Z+xF1byGjoc2O6EqYak7ZnfStEpUFHa95
	 O2C7N8K1n6Vf+4QILs7UfJHp76E+4s1J3nCkkjtryDO1rjIo/IMT3GzRJvOO9+4WGW
	 /emG5EGTkTg0WQHvtnc6B56NtEXfq5Y+tVMMuEnEgtKoJnWEU+DqlIeIBnJEl6ZKnP
	 XxPzgymvIN2Qg==
Date: Sat, 23 Dec 2023 12:40:10 +0200
From: Jouni Malinen <j@w1.fi>
To: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Cc: hostap@lists.infradead.org, johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>
Subject: Re: [PATCH] tests: Modify the QoS mapping tests
Message-ID: <ZYa5CotWy+00CHII@w1.fi>
References: <20231213113735.289408-1-andrei.otcheretianski@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213113735.289408-1-andrei.otcheretianski@intel.com>

On Wed, Dec 13, 2023 at 01:37:35PM +0200, Andrei Otcheretianski wrote:
> The cfg80211 default QoS mapping was updated to align
> with the recommendations in section 4 in RFC8325. Align the QoS
> mapping test accordingly.

Thanks, applied. Though, I changed this to accept both the current
mac80211 mapping and the one proposed in the patch that has not yet been
applied.
 
-- 
Jouni Malinen                                            PGP id EFC895FA

