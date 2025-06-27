Return-Path: <linux-wireless+bounces-24629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E45BAEBE9D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 19:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1A64A7D31
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930E2EB5C9;
	Fri, 27 Jun 2025 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RM5+bK7p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE062EA742;
	Fri, 27 Jun 2025 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046729; cv=none; b=JlUu2xs3kS8oMDR9ZOg1/KydX3WEs/Bn7Cg/kQAnYgFpAE7UVo6wEA2FW5JHnraav9HARyFSnrC8vxDV3x+EOTsq2HF2Nzarq5wKNpl+SKcgakimqbLOW96DZgNXvYelofVysgBlTV/lSoKEtiBzpVAGm9rIHTwGUCTC/wh1OjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046729; c=relaxed/simple;
	bh=sdgfvVloB/QFl6iqoeelnvm1/3gLL3sDSj0P0PWGIs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/mU7Oxm40M91sm/7PvyqmXGSCxRab1N1yO+sGJf4NoR+IlG4DjIKHS4nlFlFZnJDc/I5p/lzDU7cTGWrjPiylQn6nnoS3+x6DUkzMLL4C4fxCRU27P9LY5m5rwFKf/mNlN6TW/ImqSOwwwNC8zMqgdjGAg/bkt2OuInozzuT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RM5+bK7p; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=fhAy7nKKx0JGyjq1aCihLVL+QejNvq1pgv4yXYKDpSk=; b=RM5+bK7puaJGTLuD
	+LLEez2w9hyxm2dUopDohR8Ar2mLonEoUUssfm+4jukIGcS/ikHsWLSLhlCTNa2wO1KUl6KpPHjMy
	4IZwjT8xRJ8wfY7s1WwBljBUee816Pg2flEHXwmM0X5/rjKMEXmKV3EYibgJm7oKBWM37cN9p7ujp
	SPTBjEM6g0e8KAmqqJvxndDdLw+fAVV6yajeBQPPHAzg0y8yhfbnNbPhzSLjjGRD+jfXKbxwun6KJ
	sx2mpFAg55Lh0ZeT23rUfR8kO6KUU5gt/bc6jdU1C9BEkfNVYostTOfl5COVOV58LacV9z/WfuxEo
	gavEhtKc9WtZ3aMMRw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uVDEz-00CZ1u-1p;
	Fri, 27 Jun 2025 17:51:57 +0000
Date: Fri, 27 Jun 2025 17:51:57 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: arend.vanspriel@broadcom.com, kvalo@kernel.org,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] wifi: brcm80211: Deadcoding around phy_cmn
Message-ID: <aF7aPZc3xXfcc-UR@gallifrey>
References: <20250626140812.56700-1-linux@treblig.org>
 <7625f178e7c2be9fd11f1b4cdeb4da47a4635c93.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7625f178e7c2be9fd11f1b4cdeb4da47a4635c93.camel@sipsolutions.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 17:49:06 up 61 days,  2:02,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Johannes Berg (johannes@sipsolutions.net) wrote:
> Hi,

Hi Johannes,

> Just a couple of general comments for the future:
> 
> 1) you can drop Kalle, he hasn't been involved for a while now

Oh yeh, I forgot about that.

> 2) it'd help for the automatic bot runs etc. to have, in the subject,
>    '[PATCH wireless-next]' (or perhaps rtw-next etc.)

Oh right; that wasn't too obvious to me because get_maintainer has
linux-wireless@ in the list but also had the brcm80211 - so I
didn't know if this went through brcm or wireless picked it up.
And what's rtw ?

(Perhaps a Documenation/process/maintainer-wireless.rst would be good? )

Thanks again,

Dave

> Thanks,
> johannes
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

