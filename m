Return-Path: <linux-wireless+bounces-35741-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK/2F/A99Glj/wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35741-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 07:45:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C6A4AA810
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 07:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 895DE3015CB6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 05:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E285A32A3C9;
	Fri,  1 May 2026 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="qjygoRdV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B62EEEC3
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777614316; cv=none; b=bgvrrwhMsh5lQ8s0AOVBbilW3ttPfxhcFBQHh4Tpwn91qTFXuGaZa5bFWkkcvAow4MzddO6o+LTMCXCj0Nw/iurGw4kmBrYuw8VwC/7oepAvRGN5Tf7+hvTgRf/eSouUjIcKzAMZoErbXWY67HtLPb820m8pQiO7HD6LSvM/oBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777614316; c=relaxed/simple;
	bh=L3h2As8wmmNZZwDrkO964qeICdJZijy99+RjpPvlMqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgY3GOnhgjTOonAdqsc/7DUheMS3a1OB1QNOhINR3m0UhQ2D953eP6qPoxgnJZeHvOpQ9CcOF5Xdd0JtXBs9w+J05RHnhX83Mhm/GEo0CxSKf2nWR0ZdcC82TUW3YTqH9TwDYia9NPmKF7Ibq9nIa5ArX7JhRHWAV34lHE14LeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=qjygoRdV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so630679a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 22:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777614315; x=1778219115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3h2As8wmmNZZwDrkO964qeICdJZijy99+RjpPvlMqs=;
        b=qjygoRdVqLwFXfa2Rd5wjgirjWy4e4AmbyKdHrWTwHY1IxPAv91UK/RpvDv+3savNo
         Z1UXBwvc16VQ8F+eByOEHDl4EWh9QdgeVUtKf9zYmuUBVemz4F3gYoKPFhdVEVcmKr94
         MtvkEIHu9zp+UN4h8VXpi2gbodySAyH/vAs/Ggp7HERYGo4DIi3jB/cy0+W/Bm1THdNZ
         q4GDoJi0Ks6Ykl2cbF0+2GS6jQDaEnXptX6VVPoNGQolvxdHfY7gCsncaDRW/NfOCtoK
         6AJ/1oMAfbpl314ezDxm4QsMbCTB65V5ryIThBcNYP4OYSLWirlWBpnl6/JWNEBUt1GX
         3imQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777614315; x=1778219115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3h2As8wmmNZZwDrkO964qeICdJZijy99+RjpPvlMqs=;
        b=QiiWENpvNVoWSBrCwrgc3BoWCHhUx+qIs3zMErCQ+pcX6JiV+mrk4KqKkHVMEMM4E+
         V2jGVcmauIZkuycw2vAwfFL3SKNt7LodyrHbuQOXAG7Wk+51KujxmnweQe20GhWH+uNu
         +2liCz1v6uIcwo94O1yWRE/TFF0LsSSdnLWBUrduWPUJ7AMVSwfDW6pIjLZzlnlK/4Ru
         QvMxEGgJQAMgQJFQunVelhNuh7U/8Y23Orxv7jc7ijv3xroKAB7Ufz0nP6JCJe7aP6or
         /wMYp9WA0aOP3brh8jxACVYcfmHfuAbWpBQ+CNHopLFhE5SzwvMmIYMLztZKUcyAnPOh
         MzBw==
X-Forwarded-Encrypted: i=1; AFNElJ8/3aTFaUeb46/nTAMNprM+MEU4gcbujETGK3t9p3ZTQVTG6DFtXIEP/4UZjf/0+mS5UFsYmc2950VTpPMqdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWho9j+4QMlLjFbxjcpeq9yOH9gM/a2KmkGbPfYtsnhv9QpGbD
	0tY5xnCS3brLusMsMuWHM5PE21Uf4cs1PuR7qx1trh1hyj0m0bdlWK93lzisch5LUcEh29eybGp
	ASgmg
X-Gm-Gg: AeBDievY5CuzUXZPaM/RpQ8O8mU/DIR7rzfeDT1VEOiTwFbVJoELoipl2ilFXqa/cRi
	7FcDO4+ttIe0m3IGdAsB6mggUvw+90lisrdgrjNpP0t30TkFxLuuic8Ue92Hu0yXf3BPYUbwqPZ
	swjuN9wvT16ky46sqoNumnqcvIb+o+CQDzpqmuSOvOzR7Yoz/hzGtEzuGlrcwZkGLVdhgRVoasd
	EzHd7ZdKLo+B1F0ANEpJHp4W3h7jQoQqDIzDQ3ww1yXQ+CdlzTWLlY/pI2iUwggG7YvhVZtjfEy
	CZ+ZyAK8Vm55GAPS3rfY3mjba6Ti30ksH+r1hxtE/Wm+cFbTbUbvcSz0JE3e6rOR5x8CCKi6vXg
	9JOS4+B3N1/PrFYbnpmY1z7gFooEI+9Yfa4j4GRYwrRFJQQb22snM1AkT7LfiV6aqkYU/bDgtoP
	YRCyvcT4OKT25isPnQq8xnn13PpGriXn7gJDS1PW7cT5MnWQYjRpoy9e868MVMpKXax6ceOiv4c
	4A=
X-Received: by 2002:a05:6a00:6c83:b0:82f:96ab:e011 with SMTP id d2e1a72fcca58-834fdc3aebfmr6546257b3a.37.1777614314780;
        Thu, 30 Apr 2026 22:45:14 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351588f05dsm1370287b3a.16.2026.04.30.22.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 22:45:14 -0700 (PDT)
Date: Fri, 1 May 2026 15:45:10 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net, 
	Dan Callaghan <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next v2 05/31] wifi: mm81x: add core.c
Message-ID: <shvnbiphccjqal5o3pgkevsr67fhveeyn7fzngu65bly6wmbsl@em2lclvrcjk2>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
 <20260430045615.334669-6-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430045615.334669-6-lachlan.hodges@morsemicro.com>
X-Rspamd-Queue-Id: 94C6A4AA810
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35741-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> +char board_config_file[BCF_SIZE_MAX] = "";
> +module_param_string(bcf, board_config_file, BCF_SIZE_MAX, 0644);
> +MODULE_PARM_DESC(bcf, "BCF filename to load");

Just reviewing the bot results, I see it is not happy about the
mod param, especially since it doesn't really work for multiple
radios so it's not actually a valid approach anyway. After some
discussion we will remove it for now and in the future once we
are in tree add a sysfs entry or something similar.

lachlan

