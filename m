Return-Path: <linux-wireless+bounces-37249-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELkvAvdfHWojZwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37249-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:33:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 879DB61D890
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71CDE31AE986
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504CE395AF6;
	Mon,  1 Jun 2026 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="qHuub+Eh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592C39891D
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308140; cv=none; b=qCSo36zE2PIRK4xE+xsAeJllcJX8k1jXUBrwkTTk/hJ/n1si8mhuJLKYh21IRAOdgplFElVy4U+LA2ZYWaqyfz00EL3gC19d6PKTJ6KvKCC526JWMN+xFdeAvMdqiYFGwnJMmfSjRvWnacL2dShnvfSjgIp4I+YX8NznThSEZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308140; c=relaxed/simple;
	bh=xkl11etGD93uXbTw3zPcJBQkvWBKy92INJ64V5tOpAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVmifA9DbMfQCmQV31d364uUeRMu1fLyIWzrns0yN3sc4CzLVcjgt3mPeD/6RUfVEYaC42krRoJcPP71lXFT+D5A7Jbg/JZ4yLf6Sa3jyI9savFORkGhTLwo/Jc9op7FzQhebWsGhIJuw7W0mAghIP9gfDYxnGXHxTrd9LZ2S1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=qHuub+Eh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b900f350fso3418532a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1780308132; x=1780912932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CieEYmkGoeHvlbyVD9E2YerXojSMQhPT4STPYJUveVA=;
        b=qHuub+Eh6wHjUum8qp5gNqOnYiAAqfJozf7OODyT0vDz4WbuFmJquPo6onEZhGEEpP
         x/ltONb+4H6Dglga958yvvm65YhfoxbxJv39wwZsp/f9T7cs3+fvhA87QNT73tSyEk7s
         q7cfd/a5CgbF48TViqTGpOg8KXvF8/pmRRPFMFY+Md/A6VYUEoCOLfpIn9iXzZY98RBj
         Na46xA12GwXYEWuyM2yrYIR2Bi/P/AGFfZQLOs0VZRwA7q8EVGPBkjOcK2DByG4O97VD
         mPSyShnFHbJRpBVocki1qGaM6bv66nEnYf9vzV6qpRBcIwHT9L7QTRd54hJyCSn+yBDY
         5P+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780308132; x=1780912932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CieEYmkGoeHvlbyVD9E2YerXojSMQhPT4STPYJUveVA=;
        b=dFjd74+MDl14llcbEV2J0ZPN7wLEp3SAd6UWJSYJZqdprWp7iZfcFdE7gg2qW+QyT6
         ttfDWChT2fUTPyIG0t+qJLZcDsb/hxSeAx8f1CXgWuhfh+wOc/YjDqOerVlIKqNxhnAS
         bEbxSHFdDOn4iMmhSng8urw6jlqShZEZydlpF3od7i5+bKW4GBeZUbp9hTD7cLoUAug3
         s8tJN7MMowpVliUgCSRKcZZckv11MaUouFu6PSK/YALzeatMMY2NH/zikh4CPEJButhr
         5vulg8EhpVYwbWDn2lxLPmioV9bFBhxUbYvpZ/oV3YLMfNloNriozz/j6YrTxqqpiva4
         7lPQ==
X-Gm-Message-State: AOJu0Yx42JcXXBQ/tVWgmSczIcJNK9pRvDYDqTR5eF+57/CSvMGvNcQk
	qeKYsQQ+44ZldbztmRtRkAALkSDonoZO+GnIoUNVUFY4upl0FHbPRmMN7rmMdJ622yQ=
X-Gm-Gg: Acq92OFxVKCiFd9nV7u5THHXCJC2hJsMhBHYa2y3Wrx5/OdT2AN49Qm4wpiQcnCtUEo
	d9aHzwc0+LqHdpBZHn0uTO0RVX0MH7TY6UODftiVZSiycQf5ewqAxf9xm6mFplqUN+4FjQYwOiX
	JY5yw7visli9yyC5WnTn/TMsIbTQWxt5MnrDSpGn8gSfV9VeniIbgPFaj5bJ72oEKhRO4dZEVgY
	rzpGdZG7vujM1JfVztU/QuuB5bSQKglkAqelzaGadb/iQOcxOK6HQhx3hh7aIzICbTCwFmbmxM5
	B470wckEd/3xs5KUpj3Di7fsPAXmIJs3r9lQ2TmpA5jgS3hINtHJdK2BWk/0Jh38cxGsXEvzgM8
	NR9hF1z+ExzZEnjjcUKd+7V5ldhXcO14kDYX0gnqU+CVsIqN/LSGLnATy9POJT90g9HJLfukYht
	y4zwj1NqtoGxHhU/Ao3UauW3Fk+3UkK9IfMImKGStXt6EQkuvgiy+H77hLMguVCILwydy2D8/54
	aA=
X-Received: by 2002:a17:90b:4ec5:b0:368:b724:6d53 with SMTP id 98e67ed59e1d1-36c4feebcb6mr9724095a91.4.1780308132152;
        Mon, 01 Jun 2026 03:02:12 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbffc1879sm10839152a91.5.2026.06.01.03.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:02:11 -0700 (PDT)
Date: Mon, 1 Jun 2026 20:02:08 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH wireless-next 2/2] wifi: mac80211: remove 5/10 MHz
 channel code
Message-ID: <czbtt62nkp46allnwfonmlt5rd2ky6ydsnubbac6ubqqwhklxm@nrxridybo4px>
References: <20260529064502.37422-4-johannes@sipsolutions.net>
 <20260529084502.4e5a9350206c.I2f6169a067ddd1b5e234668fcb6e07957fafacf2@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529084502.4e5a9350206c.I2f6169a067ddd1b5e234668fcb6e07957fafacf2@changeid>
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37249-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 879DB61D890
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 08:40:28AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Now that cfg80211 refuses all attempts to use 5/10 MHz
> channels, all of this code is unreachable; remove it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>

