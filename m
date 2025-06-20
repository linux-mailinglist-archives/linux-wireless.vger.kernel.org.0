Return-Path: <linux-wireless+bounces-24282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E1AE1859
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 11:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C61D3AC5D8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF223AB9C;
	Fri, 20 Jun 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IS5xR3iz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F86623AB8F
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413433; cv=none; b=AVPnhLdF3w4EteM5wJc1x/OP97azzZAcjL97PhsKVpLXl9uSH9+b6cQQSxW+uVqGvePAnDVRdO9OrgUi+yeMc6GuYI188JfaOIdlhk5s0bfeHxOVdfLcQ8CT1C+rVzCHEnbYRd7cM4fjGZiUzNVZXiyLQjI6vuS6nsPbfFiHz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413433; c=relaxed/simple;
	bh=3qvw8SQg99LAxxwVG/3V01L7cWpIsAjQzpfejafsUnA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hHqplYaGlkpxaE0hRl/LvNwFciCVgImkJkyS8dunb+OKGyQEppcWEGBVRRU346chvT1g6njdDg9BeJ55wvJcLtgxf+t3vFR+fTtIi+k74hdm+Q4dQxy/Ecr6DvmZl5seJS+8rjop5/lcy8Xe363i8B2/bcWO4l2CvX+iCjER+EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IS5xR3iz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qDMO0OATnlXpoW1nwToVqpSCNQA7hl6rGaWgRA5+sbY=;
	t=1750413431; x=1751623031; b=IS5xR3izzgoJGr6n70hpiHs534EBidtGXXtd3ypPl/QtfKm
	hiES3cHJWvrhL5uIDHaYtpkipk5qmqo0r98WCUYW03Jomr/jwD5GTaULc2sxeEzEMAzOZ4o/erBGC
	K8QFVby+eR5vhIiyzqY5oACVgk2rNkTxr/ioZ6HH6rFYRPZQwvXr/G1znloVxUJ5f0M+yngu89c5P
	JR8YRVBgAtaPOvRvUe5ADEBE3Jr41ErJ+JdtEVaI9YzM2i3+QsolUAdkLrnLXpYXskG10b6URrlJR
	59FILxL1TqiZHFEz7ogEIGn1m1e+GJr9uszRsC/ru7wiEIXUq5bah5l71nche5Xw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uSYUd-00000002d5n-3LJR;
	Fri, 20 Jun 2025 11:57:08 +0200
Message-ID: <f56b0433b616b61f2ed697c7f8c66f9771cbb441.camel@sipsolutions.net>
Subject: Re: pull-request: iwlwifi-next-2025-06-18
From: Johannes Berg <johannes@sipsolutions.net>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, Linux
 Wireless <linux-wireless@vger.kernel.org>
Date: Fri, 20 Jun 2025 11:57:07 +0200
In-Reply-To: <DM3PPF63A6024A9936C00D20E5A7E9871C5A372A@DM3PPF63A6024A9.namprd11.prod.outlook.com> (sfid-20250618_103527_891482_B4702530)
References: 
	<DM3PPF63A6024A9936C00D20E5A7E9871C5A372A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
	 (sfid-20250618_103527_891482_B4702530)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Miri,

So for now I haven't pulled this.

> ----------------------------------------------------------------
> iwlwifi features

For one, as we discussed, it'd be good to have more here. But that's not
why I didn't pull it this time.

>       wifi: iwlwifi: bump FW API to 100 for BZ/SC/DR devices
>       wifi: iwlwifi: bump FW API to 101 for BZ/SC/DR devices

I think we should defer these updates until the PNVM mess is sorted out.
Otherwise we will not be able to release these firmware images either,
just like you had to revert the Core96 (API 99) one.

johannes

