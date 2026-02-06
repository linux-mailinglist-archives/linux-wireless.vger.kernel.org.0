Return-Path: <linux-wireless+bounces-31612-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFzJNkyGhWl8DAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31612-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 07:12:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 362CAFA931
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 07:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26E23302D09D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 06:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65B22F6184;
	Fri,  6 Feb 2026 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="a1LebGjC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7433EBF05
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358304; cv=none; b=TgrLI+Aek+qtoDwK1L9Qz4TN/cd3wefnXnkBN+NmsV2dO2fTk80wa1Ne4UtloXCHwYaJ72UGenVKRzCeIRmzce5kDnXYNABV8a2fZYndmRXcCr4X7zuEuP6n0tzLnOmu2PacCPyubht8VzRSiEb17k+Hmt0LdlEJBw/65Ka4T84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358304; c=relaxed/simple;
	bh=m234SRTA4UOrW/i7fMYkUhZwz1gVunthhYU6Engfog4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pG0yi7Fd4Q/CvZWOdoRm72+8Wfb5aiYwfXO0u+Z15wY5s+1Ym5Mbo2tcKdbuVZXkVvwzRpZF/8f7HrRDR2zVuSaKF9ofljYnxtgBWCnps9WjZPdvWMeh4TIoAeAyNFCu+cPu6rGF03kr1hd5wdc5GWYF2Wz78P2P3CpydVaZnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=a1LebGjC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a79998d35aso13801215ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 22:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1770358304; x=1770963104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SZphE9Yxa0PH9fiw9qf3ILYXM2QLsDre54Bjsf86RMg=;
        b=a1LebGjC9/+kg6Sztmz7BXsVgyipYRA/GZdAX1MvFo9FlBLDFJfve/G00zZFwLAXH5
         CQImDRoUP66sMIPGA3EY+eHyQ96JQY5Yfs2/KXiKWtFmjlmv0N8FPREJSo3M4liKImhe
         MC+N4qXEB9TMDXSA83hIQyhQ0qMAOtEfT319rlL7I3+Gb1gA/Sz2TLkfaOwppfJNsZrR
         3CGGPaRLuJxKeU9p6yiuTXigdgEA4swDRpBeHx3xA2+jgyyePlDuXYFzsZbtcLGye/1i
         2qX/Q6/BdXU4o/RswayOUQi6E5hY4TxlA4vpCMpdgiq8hFhZaitcuBhd7Rvn5I6vqbe3
         WCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770358304; x=1770963104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZphE9Yxa0PH9fiw9qf3ILYXM2QLsDre54Bjsf86RMg=;
        b=iNmDhIHrVMMAcpJAGeFoTWLdmnWNC6pOgWmLSk7ApL51jlrbx+EqgYTFHnZ23zyE/D
         HvFbvqRl3LFNrgDA2GphYUWXxwsEYmAoEsLPmGQVwtrL4cZOLU5epMykmmC+yhWXWyyP
         HBJb0lpLsCLbxz7acRA/S14Ypcj4340eXRGhxvrdv8WUxNp/rbTXGwwmnqqMslcTLLXZ
         u7CKw+Y+LqmckBV6TxrL57oVqlIDS+4xfBIM2QNGJSeL3O0Jrp2j5L0o6oFR6wtFZ2vK
         9uUuMb+TqcUqFb3PwWO8XFapeoHdkEgDMrTYE/QDTUCoPlB6CeIaBIdFk3vyguE27IUF
         Esdg==
X-Gm-Message-State: AOJu0YySs17j33XwTyWTuFJ+Ci2TCbCK4aWG8uJddUatm/zknCFCjDmW
	Cvc3WTyOHAcVPShmiuP9b/FtdAJ/d/1+DClQMxJcAVN0qm4Agp6iFW2Afn/hUdpPLQ==
X-Gm-Gg: AZuq6aLL9DDqijitDxNYzbq86oCIYsyc1fqnTRZDoVkCCLJ5SN3SKBtK9X4kf5md41I
	u3uyGFOXYz/cC5e7QSeWpqgfsZWYaMYn9HykKMlCgfiZVJ+OcSewsGWiyNDrxSDkwVaIGtc5xqt
	YnFfQmYCBAMcjuPhBtwpX17v+ueSe6cuhuYY5DYttgyHZJ2R160xeCqLOGaaN/kkScbeXszwXBr
	0b66x3OYVIYbnJNllg3qXKd5I8ZKmdKu1mKO1CtBAs/e/VcxB9CWtMZAvsg1LwU7AIHe9GYcoWv
	oV8c5I0ij6QfsGtGjAQhuX0u7SQ0RJQhGXAp3ScGJ5sKJY9anAYSuse8kXYRqbYDfFyty+2wCsh
	CioVNY5pd8DBI7edMDAjkaZy6xRnX4YWA14WbZ1i/Nc2QZSTTe+E8Hj7pUzcb6VKnE0iSCzwZOz
	5B6MJHKO02MjSkpB0A/KWIx/mU
X-Received: by 2002:a17:903:247:b0:29e:9387:f2b0 with SMTP id d9443c01a7336-2a952209791mr17909245ad.39.1770358303538;
        Thu, 05 Feb 2026 22:11:43 -0800 (PST)
Received: from localhost ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c9d415sm13267185ad.42.2026.02.05.22.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 22:11:43 -0800 (PST)
Date: Fri, 6 Feb 2026 11:41:39 +0530
From: Ria Thomas <ria.thomas@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com,
	arien.judge@morsemicro.com, pradeep.reddy@morsemicro.com,
	simon@morsemicro.com
Subject: Re: [PATCH wireless-next v2 1/3] wifi: cfg80211: Add support for S1G
 Response Indication Configuration
Message-ID: <20260206061139.6fdwaazvk4swpreo@1207>
References: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
 <20251209062424.3926297-2-ria.thomas@morsemicro.com>
 <9eb13765529bac88337ab2fd1a13769fa4519f52.camel@sipsolutions.net>
 <20260109040041.tnk7e6uewo24u3tr@1207>
 <048c2715d08822d7f79b082cbe332f982d8ced61.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048c2715d08822d7f79b082cbe332f982d8ced61.camel@sipsolutions.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31612-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ria.thomas@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 362CAFA931
X-Rspamd-Action: no action

 
> Actually, reading the spec, are you sure it's even on an *interface*
> scope? A lot of this seems to me like it should be per intended
> receiver, and you need to know its capabilities for generating the
> intended response?
> 
> If it were per-STA then I think that'd have a much more natural lifetime
> (since it cannot exceed that of the STA) which seems far better to me.
> 

Just wanted to follow up on the earlier reply and check if you've
had a chance to review it.
To explain the implementation a bit more clearly: The issue is that
response indication from a MAC perspective doesn't really make sense
elsewhere. It's simply embedded into the PPDU for the VIF that has
response indication configured, and the receiver uses it to determine
which type (if any) of ACK to respond with. So it's entirely handled
by the lower MAC besides of course setting the value from the upper MAC.

While it may seem more ideal to sit in a per station or something similar
where the lifetimes are more natural, there isn't a capability exchange
that occurs - configuration is more for local transmitter config. On the
receiver side, it isn't communicated to the upper MAC at all - so considering
it as a STA entry dosen't really make much sense.

Please let me know if you see any issues with this approach.
Looking forward to hear your thoughts on this whenever you have a chance

Ria

