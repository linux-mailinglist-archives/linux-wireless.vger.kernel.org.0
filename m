Return-Path: <linux-wireless+bounces-37050-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KdRGkDlF2otUggAu9opvQ
	(envelope-from <linux-wireless+bounces-37050-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 08:48:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 504395ED627
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 08:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 114E63007A7D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 06:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B7233F5B1;
	Thu, 28 May 2026 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="LmInqKmE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33453403F7
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950906; cv=none; b=Vl8FYZXY9wO2XPGDJlw/lYDeC9AUWjwUYseZfaTfe/J3MjtvXll2oi4zc5SKyPInwE5laGXXitiqIqXY6RqN8ZG8YIWqaYvrb49Xi4I6LpKEnAPIfJG1yxtjGJhdx9Z7w5zsiHtPmIv+gp0gvHG9AmOYBctdRnt3KIWqI/oszSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950906; c=relaxed/simple;
	bh=vvxPDhUoZcX5RnUejKO23WOfA3Ok6vo7lgEurg1grG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJwqnQzen667X/V9RhAmrCD8CUkjzTeXa8dwOxgSUCbImFkG5RjVxGLVrCpNgdBZXAHG7HT7inFNusDF1DiqUaHZTqx5G5prXFjmFe4wJJHZ6wiLc7cnLdvXe9WxcX5CuYTxd1AFC0AutNrFT0IlZLzaHtsIAqgAjhS4fk3fyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=LmInqKmE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36931e4f5e8so11586077a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 23:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1779950905; x=1780555705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvxPDhUoZcX5RnUejKO23WOfA3Ok6vo7lgEurg1grG0=;
        b=LmInqKmESN7fpocbC3oBV77Y211JWS/+7Dw1FY9brkzUrAJ/QgltSSGtumIuv2DS9E
         GvEKedIPIGx+4R8ioznkRSOC9SQmTK9rPAPoXfBqRtV7fBjn6I00Z7SEJ0WK243QjHIe
         CHs5jrhtLl8mvx2W212l5y58zLNRTBCOFoxCoFjGM63vU4NbR6UYySiH+DSwVL21Ng7j
         E7ipRT15xeLxhxKVFJR7OSReHIa46OjUSuPH+cJ9dbpcOvoBoGR3kWONhJSvf6e45Xn5
         NsaH3Dk9JDnJPda/2Hlac4lpxZn7NSq7joMaK6/V8SDcUAZaHkhGkN6wzlHCPJhx1RwX
         HLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779950905; x=1780555705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvxPDhUoZcX5RnUejKO23WOfA3Ok6vo7lgEurg1grG0=;
        b=HgBod1G1s9xiyMuQZTsx0E8Z77YL5azCu62b8H+8rVNc4jZJ6odUy1yYdikaxEcsze
         0NqFMUkWn3WmiNdfDtbVRKcnXDDkyso9R+24PfIKpWYhf6s9MKZncWOyKKV2IRopQdoQ
         075tLgw2juugb0TWFE6NM02s1CGZrn7oIDFfQ0QLABbXAbvG1InKo3dujaGVKyLpQPZK
         FpjFwg17MYht+5Z/693mQSExhO53ZwwU67d7lBPbkmrOPf4ha675JihcS0vE3kVJVIqQ
         f9HZvm1dVuyamecy2Hld+L6htJVw+7JHIsFvqVww18Q6bHg2mrQrRfTb2zPvo6yhiCwn
         mEsg==
X-Forwarded-Encrypted: i=1; AFNElJ/p1vYjVu3mlhnqEyhUMRD9hXfPDwDoG0JnK3WVkq3tVo2JCIHrUEbYZ11spBD5oPLQFCa6ZgEsMDoQjEzilg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4ipR4PFBasxx0zcZrs3ZtV0YnpfsGFSbaxj9j8SD439DgZvZ
	H/ykobKLCvxhquj0bVbnUVvm0d17n7ne/SRTRVb0J9DRdZBVUPabnpTI3jrkCO2llZs=
X-Gm-Gg: Acq92OHGjlIWYqV9/xmh6XAlajogJA7TNcB7iRAbk+tVO71oczJlNxP6uTBpC+fmzvG
	D8+DUY0tmcgN6wnFHnRRibo0Ce0qVpo1jr0rvN8btn2oKxYWz/TCAeqAt/h4g6B1uDmYZvSuwEY
	R/M/0R2g+N3GN7hQm4XIYox3h3Wh+85Gij+3iMPSMf7rOEU3D2KXUvUlRd+Hp0p6k9VBkKB54qQ
	8Z76yCalutpdU4dSm7rLdklDU5Q4gpqhpwW9FbJLo+1OF32FUsOT2OMCL2slB0Xd/XjeQfO6lnn
	Bnj1Y1uP87m3JpjbKpJq3H79J9Vg3UTpA4k0N9SG07J3vwi/tM2NGsMvOw1Os6i6yVAmhE+tzyW
	KPnS0+fDcOCkHgfc4j9VQuSxuogjC8Nsv5RJqFlx7f1YLjKNdVL4j8DaV9ul7crABIBvdqWXy69
	doO9+fLkJIu8owNX0Cf3lFYB0wfAu98ewWpEvXylwfG7XjvbAjckZ+DAeGQVsGVq0CIj7uUD8Ye
	sq8SpMyLNUIctuqRA4x2X0ZXzoLsrqjLg==
X-Received: by 2002:a17:90b:54cc:b0:36a:f612:e6a3 with SMTP id 98e67ed59e1d1-36af612e910mr12270485a91.17.1779950904820;
        Wed, 27 May 2026 23:48:24 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b89acdba3sm346356a91.10.2026.05.27.23.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 23:48:24 -0700 (PDT)
Date: Thu, 28 May 2026 16:48:20 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: arien.judge@morsemicro.com, dan.callaghan@morsemicro.com, 
	ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next v2 00/31] wifi: mm81x: add mm81x driver
Message-ID: <d3yxsapxm24iis3t4jrfvywmb3asgqhy4fjochpx3nzz3tw6m5@vkvjzuxj56j5>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37050-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,morsemicro-com.20251104.gappssmtp.com:dkim,ozlabs.org:url]
X-Rspamd-Queue-Id: 504395ED627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I have just posted the first RFC for the S1G work in hostapd that can
be used with this driver if anyone is wanting to test this out.

https://patchwork.ozlabs.org/project/hostap/cover/20260528063857.950556-1-lachlan.hodges@morsemicro.com/

lachlan

