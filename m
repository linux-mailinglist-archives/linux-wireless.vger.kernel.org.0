Return-Path: <linux-wireless+bounces-32339-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m3gdKqwupWkQ5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-32339-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 07:31:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0718B1D3739
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 07:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0FAD300AC08
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 06:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCBE201004;
	Mon,  2 Mar 2026 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="OLh8k+PQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314A430BAC
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772433063; cv=none; b=k3yw5DqmqVD7JAkbUg7guYGa3PX/01Kt+iXmjRIJL+5tv9GHEPuAC1WAAvyDIU8idP9QJZhWzKy832+AwJAlewqgwGDwzbIGddEpYtQjlg3PjCKFoEuznYYkNWOVk6dzMyzvp8lZQcb7N6NYvEqI7llDGGSnFp0i+IsmjggQMLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772433063; c=relaxed/simple;
	bh=FI5e7kUXwTMZGsaX1Bmc/jhSL6wf+Db0liEe3JzJb1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdOb4pa+AQFMGL4OGSVRK22fQnHYQJ+XsuMMcbZenzS+0xYg+HDt3Sw+lNSK5DSjQgJOmm3PgUOuMrkZ2U1TAvZydxWGknuCSLzKVse9DANTUHLfagz5utHf00AmAGmNahRqTFH+02H9NkZ+PPbLJ9n6T2N/v/kt5cZ941wlrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=OLh8k+PQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso2203003b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 01 Mar 2026 22:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772433061; x=1773037861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sjy06VwiT1htqZ4CDq+rZVYcGxQBSEUFxhtQwV91Ao=;
        b=OLh8k+PQrCn4Ezb26WbSBM46dVbO3WbUh72ZwLDpMYQmF5VNUfsiKcsB3Q3Ljx8ayk
         Dv5LXk8TIcdmUkBEl9qIZzbGlxRx60sDTyQAQlae/R2NdOsSwHszNFu8R4RbiuVsJ5+3
         Gw5Ol7hf3v4nBd3l6yZxjPsKAHCmg2y0/UWZLnwFC7ImB7R+XT0Tjy+787tQVI/UjPQD
         Nndt5VJtjc2SG3X1VDAtOR3FIj017XGBChIMhMUuM3a1kAY07128+6CqFwiBYFSi2ASF
         IxX3StX3KoMmUZu6PEBarkI9Fshl5PzYwB3lsEbknhyCPQYa2SgDg1AV4zU7Kb3YS26y
         Fgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772433061; x=1773037861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sjy06VwiT1htqZ4CDq+rZVYcGxQBSEUFxhtQwV91Ao=;
        b=M4WdWplM4ejAuGV9UbV31nbGS23iAPgue90KK8cmVKljAHpXIzhAMXNUenRsGaNL4g
         mlH6FxJBz+k/1dVGwqZ4woGOFrm/WZXaW3kFRMtvey+Xra99CGVtV7AKT42juDjSYOvR
         wXpx3cZYsk5xSYDrs5ygHiocN1YLFIYugvUpR4FypQwV4Xmg1cFK61RzQRKVaWbcHRSq
         mr1FQD/YdSJlPpI0GAniBpR+Pc2rt8FjvyzwkBQ7fuCQLu0i6xVu6F2UiLndSEzC9axL
         XUwQFwo50z7pGKu8AaLLIVSWQcKCFyzf9ycXKR4YUAXYnt44ryKSV2/nXFCFJXESH28M
         vtDw==
X-Forwarded-Encrypted: i=1; AJvYcCUtoATLSofK7h/EKqTHg/aqsaK4O/EqwJoiSQ9VUS3xzQfv9BHerPT2ZVEYOdZOuTNlxTjC0uqQp9T80/YnFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/8ZbWYChvthdlHX0Wv9zvv7LJ0prerP/X1WsoNPT16Bx+zKB
	/S6WVkmaARbW5jo9YUEItM8uNpaaKQ8Oj1qfdhTwor1lwvXFha4uZsNkIb5aKc6blkg=
X-Gm-Gg: ATEYQzz1GYWPKBd78vbBgvaNMvz98BWRJ2oi32mL/OUHN0tijDAaBGyAtdhnCdG+0wJ
	0J+q83KIBWs55z/Jb43Sgwe/yXDWXcPWx5i1Dhy8UO9rsSHmDUrYHAMp1K3ClK+W3WTtWo8LgWF
	CCJMWh5XF+3cDvn1mpgFImz3vVKXhp7U8ixhDFjjlxzEjNzsYVzkRnGgOroFFjCDd5W62I12x8q
	4x4t7Nc/S80kph4gWO7iW6MyxhuEqi23m+ZEA8IcmvycCVmiLuWXXeu5PbXhJ1I16YNZnh/jUmP
	8A1GT6Zvk19f8sCQIyGqOnpPNd7iSs4ayQ95wat+2uKOd0LSSyt6nRqIEgPk3fKUy9YClX5cnak
	P0BPBa7ekMDRX2cH6kcTHo3/mg1fFEDXTr2fN97PCIkcyQmMrK4dA9SWSCG6nPIa/n6stSESDHb
	1FkNCvWwuIoQ1rfNKhyv/8D2KppLm8ah9meZBiI7Vw1ZR0Qga9Mbl+TalbD5zyhY6UHg+IGFTrv
	as=
X-Received: by 2002:a05:6a00:3a25:b0:81e:96c9:131f with SMTP id d2e1a72fcca58-8274da126d0mr11641836b3a.37.1772433061146;
        Sun, 01 Mar 2026 22:31:01 -0800 (PST)
Received: from localhost ([60.227.233.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d5689csm15320757b3a.13.2026.03.01.22.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 22:31:00 -0800 (PST)
Date: Mon, 2 Mar 2026 17:30:57 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: johannes@sipsolutions.net, 
	Dan Callaghan <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>, 
	ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 23/35] wifi: mm81x: add sdio.c
Message-ID: <sze5g6binniqbqzwvn4nx5qbytsxu3f2rne7wqtdsmlgzqcq6c@4rwtkq7nyptu>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
 <20260227041108.66508-24-lachlan.hodges@morsemicro.com>
 <20260227-spotted-rugged-moth-3fdcbe@quoll>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-spotted-rugged-moth-3fdcbe@quoll>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32339-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0718B1D3739
X-Rspamd-Action: no action

> > +{
> > +	int ret;
> > +
> > +	ret = sdio_register_driver(&mm81x_sdio_driver);
> > +	if (ret)
> > +		pr_err("sdio_register_driver() failed: %d\n", ret);
> > +
> > +	return ret;
> 
> And you miss here module description. This patch organized per files,
> not per logical pieces, makes it very difficult to review. I have
> absolutely no clue whether this is module or not, whether this is built
> or not, whether it is complete or not.

This patchset was structured similarly to how ath12k was structured
by Kalle [1], in his first and second series revisions, where each file
is split into a separate patch for review and then it's squashed into
a single commit once accepted. Admittedly, ath12k did not contain
anything pertinent to separate subsystems, where we have DT bindings
and mmc ID that require ACKs from their respective maintainers.

For example, if we include the MMC SDIO ID in our sdio.c patchset
such that it is "used" we would be using the wireless subsystem
commit message format rather then the MMC SDIO format that is
traditionally used when updating the sdio_ids.h file. Noting that
existing commits to sdio_ids.h are individual commits adding the
SDIO ID and then used in later commits.

Ultimately the structure of our commits is up to Johannes since we are
going through the wireless tree, but since we have patches that
touch different subsytems that also needs to be considered. Open to
suggestions :).

[1] https://lore.kernel.org/linux-wireless/20220812161003.27279-1-kvalo@kernel.org/

--

Appreciate the review Krzysztof, will address your other comments
in a separate mail.

lachlan

