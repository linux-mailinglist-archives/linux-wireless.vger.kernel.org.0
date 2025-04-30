Return-Path: <linux-wireless+bounces-22238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE50FAA4746
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87D918845FE
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ECE2206B1;
	Wed, 30 Apr 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xLV+PhFY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA9215764;
	Wed, 30 Apr 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005569; cv=none; b=ByuaTcFQDAsGvtPx7aEWrHLDiwiQZFPt2B85up86FDOhiAo1UAI3YAygT7a0msVFVa0RVNqF5OM4puXf/XsJbVIFqjVy1xoQi7rTauuc917GxzOjG+2UDW7E+U20nIgMm12NI3x9MSsh+tSjn6dWNp1ZfFE7s74PmX2lICdnLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005569; c=relaxed/simple;
	bh=8WnOM9om3a8aY/8sdAN1c1P0u7wut4DH5PitZitNZ44=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdIlgjD7cxZIbEYf2BWapl/wIKHCnDrbJtDvn3ZCvXIegvXT3xfncUvKYAh9iDejW8lTU03lDfpj6DTTk7pwGEwWZO68ZTFOwGIVsvdUXPGh+PSOwxVgB9mfJqWtM8PL1oPRmMEf/bMXdspaMVSczgIg3jYvx3PP+NyVs1QeUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xLV+PhFY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=10qVHHzbOA/Jbb/XIt7F7bPhOtPSgrjpSygZbUOdj7Q=;
	t=1746005567; x=1747215167; b=xLV+PhFYGfYIjrQz+adaJm98qAKX3a/gTl/UJyIiES82bsG
	C+twHC44QANjqy/43vztA+jZX2r8kt/Hi/CEL5zCwl1kmvjL1CBozr+uLq5ireRktFp7QSwiJTPbt
	qf6tWNvqgOfJnJoM76Ip2OKIrLckmQoXLGqm/29JuQT1C0jrSTATvuynN4gLMnnOSNZXQHOBDnXi6
	9OHPPH06iwcJz1SMGieTVYaYgcCJDnifnIa7N4IFfwRmp6Hdt+ZBjT+5ViX1FwTke9IB77mqeAApR
	Mhut6gH4wM/3rTE4DCAMwPCnuV5J+j4eEVgYnAfzIQQXYv/8f1CGwc091V2KdMlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uA3nx-0000000DZ16-2krj;
	Wed, 30 Apr 2025 11:32:37 +0200
Message-ID: <2d3c5c2946e4356ba99edb4cca4fa205149c0356.camel@sipsolutions.net>
Subject: Re: Introducing iwlwifi-next Tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, Wireless
	 <linux-wireless@vger.kernel.org>, linux-next@vger.kernel.org
Date: Wed, 30 Apr 2025 11:32:37 +0200
In-Reply-To: <MW5PR11MB5810F9A009F45F1A58AC0E63A3832@MW5PR11MB5810.namprd11.prod.outlook.com>
References: 
	<MW5PR11MB5810F9A009F45F1A58AC0E63A3832@MW5PR11MB5810.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Stephen,

On Wed, 2025-04-30 at 08:52 +0000, Korenblit, Miriam Rachel wrote:
> Hi,
>=20
> This is to inform you that a dedicated tree, iwlwifi-next, will be used g=
oing forward for development.
> (instead of wireless/wireless-next)
>=20
> The tree will have 2 branches:
> 1. fixes =E2=80=93 only urgent fix that needs to go to wireless.
>      Patches for this branch should be sent with [PATCH iwlwifi-fixes] in=
 the subject
> 2. next =E2=80=93 all the other patches.
>     Patches for this branch should be sent with [PATCH iwlwifi-next] in t=
he subject

Could you please add this tree to linux-next?

https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/

with "next" and "fixes" branches.

Thanks,
johannes

