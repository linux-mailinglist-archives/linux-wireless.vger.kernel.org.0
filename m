Return-Path: <linux-wireless+bounces-22420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE7EAA8AA3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 03:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711381893485
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F6187FE4;
	Mon,  5 May 2025 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="W2151x2v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206014B950;
	Mon,  5 May 2025 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746409173; cv=none; b=EK/3iyzVMs03v/DSOTozCRXr5GYy/+8YEJMThbxZLST5MVS7flKvxXdVDQfSjIlcvr4NkqkLyt7tj6rejVFPTXNJ3Me9oW0Atlqnb7xLuYnEyO/IPoOBZ61ohpHLa7VF4OtbRB6ypbAh5dhLoQs3TTr8TSayKiKyzvCxEYFFC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746409173; c=relaxed/simple;
	bh=q77f7B5wiZvw9Dz+CYUdQx/N+1/Qk9NORtkzzhluIuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dReKUJ/FkqNrI+8VgAtC1TefKhlgmcU+h9rrlhSwggEUvYWNxpkiL5URQzgpVAuJCWTmsmAUIhDNEJMkHmOu/P1Yp35TrtJc+r1eyylmkgsMawKuWJP0S1o2CnPNM2YffmxTL+rRKI0mxDEQ3umbZ16l1Pf7EdF5olfk57bxZgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=W2151x2v; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=YNp13OGSu5oPbjO5Hd769k73sfu68cuaSBLtC2WdS5k=; b=W2151x2vaMZHC+7L
	DJ/Sg1D2FO6/OIU3lEoXdp5XNdgdKyOTkgvIKwLqU8cW7xEshh8EQuw4XIHmXsuicAl3S1DvabM/W
	hPHbg7RNyTPxphtfZ16rw2Cpw6fdDTuNKpDVw5uyhb3zDKl475GlgcYS8FxDu/P/7vu9sZwaleEgr
	h5rnm0ETOFhAb9a9I+2/xKrP0lSK6oU/W2NVzt/PrvEAzAt7HaklQZvQaNdCFAxhcRW3HQMqRsk1d
	JfePgiEKdLGHgW7XxMAV/YWks81nha56sawjnV4ljLqoU3CKX4KIG847cLE4ejAJdTeaURy8zbS/w
	X3g6OGXxWwIvSUiWkw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uBknp-001MAh-0N;
	Mon, 05 May 2025 01:39:29 +0000
Date: Mon, 5 May 2025 01:39:29 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Remove unused rtl_usb_{resume|suspend}
Message-ID: <aBgW0UXKC7ZUo49S@gallifrey>
References: <20250425235340.288340-1-linux@treblig.org>
 <20250425235340.288340-2-linux@treblig.org>
 <c92a8101-e8fe-4727-9f85-e1e96ef5392c@RTEXMBS04.realtek.com.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c92a8101-e8fe-4727-9f85-e1e96ef5392c@RTEXMBS04.realtek.com.tw>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 01:38:51 up 7 days,  9:52,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Ping-Ke Shih (pkshih@realtek.com) wrote:
> linux@treblig.org wrote:
> 
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > rtl_usb_resume() and rtl_usb_suspend() are trivial stubs that were
> > added in 2011's
> > commit 2ca20f79e0d8 ("rtlwifi: Add usb driver")
> > but aren't wired up anywhere (though commit 442888c706e9 ("rtlwifi:
> > rtl8192cu: Add routines dm, fw, led and sw")  added commented
> > out assignments).
> > 
> > Remove them.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> 3 patch(es) applied to rtw-next branch of rtw.git, thanks.
> 
> d559636e382a wifi: rtlwifi: Remove unused rtl_usb_{resume|suspend}
> 2d867b18eb93 wifi: rtlwifi: Remove uncalled stub rtl*_phy_ap_calibrate
> 406dac790c25 wifi: rtlwifi: Remove unused rtl_bb_delay()

Thanks!
Did you see the question in the 0/3 cover letter asking why
rtl8188ee_bt_hw_init() isn't called?

Dave

> ---
> https://github.com/pkshih/rtw.git
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

