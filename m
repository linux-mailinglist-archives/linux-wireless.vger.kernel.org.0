Return-Path: <linux-wireless+bounces-9125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5A90B869
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 19:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C6E288412
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B40918A93F;
	Mon, 17 Jun 2024 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vandijck-laurijssen.be header.i=@vandijck-laurijssen.be header.b="Pmv3ycVQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay-b01.edpnet.be (relay-b01.edpnet.be [212.71.1.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702018A939
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646280; cv=none; b=hmG4SrhpMrAzcpQw3bDHQrUBeNnfL0yIXWkBuWLUCKEsgo13pITva5sfhXOg2Tjbem5yfU8sntqVXayOFrXznZDIs4zTKbDeH+W0e2KSMYvqmqsBuACVEppaJdiFScT+drDA6ttxc3/e/j456QKbQW2eG9BuEphF8qX+C5FxaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646280; c=relaxed/simple;
	bh=fHI9suxn2yhoenFRb/GpaUBgD6FKtYobVow+7IALfwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlLKdGdsQx5p98BRcO/a7Fyd9Q+Wq1ClmbPCZIIqtmiYlCHn0k71TIZJgXP4pGnKUc0vEvsx2QHeF2UzoJt93Xx+dCz+rG1FBHMjNWFVGzkWytNH9YpSeLNPt7C8j8S1MNR1PLoXVDvlCOyO8bRKc/+WTO0KmH/7Nx/Cz5W9814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vandijck-laurijssen.be; spf=pass smtp.mailfrom=vandijck-laurijssen.be; dkim=pass (2048-bit key) header.d=vandijck-laurijssen.be header.i=@vandijck-laurijssen.be header.b=Pmv3ycVQ; arc=none smtp.client-ip=212.71.1.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vandijck-laurijssen.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vandijck-laurijssen.be
X-ASG-Debug-ID: 1718645260-2392345cc4a74c10001-9xRsGE
Received: from srv21.vandijck-laurijssen.be (77.109.96.193.adsl.dyn.edpnet.net [77.109.96.193]) by relay-b01.edpnet.be with ESMTP id YyM4m9klsVyZiJlo; Mon, 17 Jun 2024 19:27:40 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.96.193.adsl.dyn.edpnet.net[77.109.96.193]
X-Barracuda-Apparent-Source-IP: 77.109.96.193
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
	by srv21.vandijck-laurijssen.be (Postfix) with ESMTPSA id AD97C5AA3F7;
	Mon, 17 Jun 2024 19:27:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=vandijck-laurijssen.be; s=default; t=1718645259;
	bh=fHI9suxn2yhoenFRb/GpaUBgD6FKtYobVow+7IALfwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pmv3ycVQuKVUCtQlCVz6uu7UY2vfjz9nCzjNT7KMsuzGx4QQpDS1cFpOsJJvvxrmo
	 i+GlyzWgEKX1NroByqzI9AtNOikWW9efFWD+8nEA+gtEn7aufXTQ+6/QmOJJDSYu8T
	 6ttKSyYNr1Gpv/Hm/R+r//pzg8m1AmpuoK2DRMkuZU4QzIcMQV33xijKl4y175PXiv
	 lRIyad7NRkj0nVsGZjXM8IniPouwiKg6DW6Oxz937TC62mSdF3+hxf3dxPLSdrPsJ1
	 HyFz7ryJdnrabPxUsE1wI4sCIvrfVcu0TaJVRfPvZ31eouDhXjg7AdxDxQxrAAlUfA
	 s25t4XLgFbF+g==
Date: Mon, 17 Jun 2024 19:27:38 +0200
From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To: Kalle Valo <kvalo@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
Subject: Re: brcmfmac: implement basic AP-follow-STA
Message-ID: <ZnByCrJlNQPnLYHe@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: brcmfmac: implement basic AP-follow-STA
Mail-Followup-To: Kalle Valo <kvalo@kernel.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org
References: <Zmqf7jCqwlQNGM_j@x1.vandijck-laurijssen.be>
 <87v827k8p2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v827k8p2.fsf@kernel.org>
X-Barracuda-Connect: 77.109.96.193.adsl.dyn.edpnet.net[77.109.96.193]
X-Barracuda-Start-Time: 1718645260
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 544
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.126378
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

On ma, 17 jun 2024 16:19:53 +0300, Kalle Valo wrote:
> Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be> writes:
> 
> > To be less invasive, this new behaviour is put behind
> > a module parameter 'ap_follow_sta'.
> 
> FWIW module parameters should be avoided, especially for 802.11 protocol
> level functionality.

The module parameter does not add functionality in this case either.
If it's a problem for merging this patch, I'll be more than happy to send a v2
without the parameter, with the functionality always active.

Kurt

