Return-Path: <linux-wireless+bounces-15964-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E27F9E6C1F
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 11:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2F62881EE
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 10:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8274214A92;
	Fri,  6 Dec 2024 10:18:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C84213245;
	Fri,  6 Dec 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480316; cv=none; b=ihGC0weTZrXgNMiWOTyV28Bfg5AaxuNbi13lQT+CCydXR/scikw+VWGQuyWAKOrh3I8yG2y2Y4ipBbt9tB6gnucmPkWsoTcpJx3Hr5ZCpSojnRLIG3CaVGw2+zuZ2Xax+u6wJrhavbb0VgFYriEIKEd9im8pDpv5ZtjIoQdm6uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480316; c=relaxed/simple;
	bh=8SB6tdX0DI5Trz5Fkh+yzJxdlWFNvnxCalYu/COompM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUc6O3z7sdwe61JBZNh9zBIGSsBYJg4ysPKrMdZpTlZakWmVAqpT1/5n4+MB+G1YWt8Fd08GgKTmIIHLjyAKiOWNwP/8cWIhhJlHSrLI5jcfOX0velXSr2xZqvkqvDOGpSMvDb+N8Uz18fKQaUagDSIrQGDQxrd6sD5bTxPDyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.39.247] (port=51794 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1tJVPf-005uPb-No; Fri, 06 Dec 2024 11:18:21 +0100
Date: Fri, 6 Dec 2024 11:18:18 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Johannes Berg <johannes@sipsolutions.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexandra Winter <wintera@linux.ibm.com>, loic.poulain@linaro.org,
	dsahern@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
	jhs@mojatatu.com, jiri@resnulli.us, przemyslaw.kitszel@intel.com,
	netfilter-devel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: reformat kdoc return statements
Message-ID: <Z1LPaoazEajgMhp_@calendula>
References: <20241205165914.1071102-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205165914.1071102-1-kuba@kernel.org>
X-Spam-Score: -1.9 (-)

On Thu, Dec 05, 2024 at 08:59:14AM -0800, Jakub Kicinski wrote:
> kernel-doc -Wall warns about missing Return: statement for non-void
> functions. We have a number of kdocs in our headers which are missing
> the colon, IOW they use
>  * Return some value
> or
>  * Returns some value
> 
> Having the colon makes some sense, it should help kdoc parser avoid
> false positives. So add them. This is mostly done with a sed script,
> and removing the unnecessary cases (mostly the comments which aren't
> kdoc).
> 
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Acked-by: Richard Cochran <richardcochran@gmail.com>
> Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
> Acked-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

For the netfilter chunks:

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

