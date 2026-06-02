Return-Path: <linux-wireless+bounces-37286-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ3XGfl5HmqPjQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37286-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:36:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE053629138
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA33C304FA5B
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 06:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E73A6F1A;
	Tue,  2 Jun 2026 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="ONMSDu9U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292B35F5E0
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381938; cv=none; b=JkoaLOCEKe4POjR4TPHPQPev5hGcQA02ul4XpOeYe2prXjYX+MVEi0dOmtTYMPWYsiKGiKKblUCi5zXGgfuWle47F8bU5HMU2aklUHcgkoUexsfWjXs2pFBxbNJ5YURVm2CGUyCgFPHzg6xDt2bf5yQzeJNyG25XwS4nkiPBAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381938; c=relaxed/simple;
	bh=vHwqNbfKPY05XBeWI77MainLcylGDZKzx/nGNYiWTiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/V4SxI9lUdpVqDdiygDat5Po1YPhDf0HtjCsdl82eOOVQ2QKmmX+v2RrJkK5ytv2AoNCVMA3ZN70BX9/JdAu0jdvtHOL5jlyRA4LplquibTJiIj5puVCepFB/mFdIRYF4WUH0F3n+iG+QaA0+CGBK1g/kAO8Nu/oEgcuRkBRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=ONMSDu9U; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36dac5d5da0so851833a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 23:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1780381936; x=1780986736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHwqNbfKPY05XBeWI77MainLcylGDZKzx/nGNYiWTiw=;
        b=ONMSDu9UaVKicppmuyAfHURmKUDEruVNoRrzOdeCcsPAZ6ETI0KhHNSMFdBIOL3RKj
         SgxagKobIiTUGwUsh3eet+DOuht1HChaqYFrmKYNGNSfhD5NDwkduysvwnzeflno9pSP
         OGRvFNIn6MfkloCYxUStsTh/B61VSRPazU2cz6xczHe/cgxZrauk27yk6rjiVq+8qca5
         XL/hj0XyJuq0O+r/ZBBbUMPzDfYLnS7v9PPSViNFqMAIKPqw6m55VxS8G3sthljITR8g
         +AEIFmmqE9De9KlrHLPPJcCWh4ovXpd/tYTQw++2oaH4IxGOLv7TKTYVZjW+fnRewxHy
         Pb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381936; x=1780986736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHwqNbfKPY05XBeWI77MainLcylGDZKzx/nGNYiWTiw=;
        b=n58v1OvkqyVOKLiOM+PpQqrKZ8XahEsSCfK3SNjdDBPnk8dqVqD+CxSpakbYJTNUbR
         UCVHsbwX+gk2V0VCYSKa1t2gQyCpcDTnC4mzf1WlnQtoMPeHjrsD6T5KUmzU1nOa1wdA
         amC44tA5CkQQF4JRmomXxpqKmllfYO1CU6C6vAONn/HBQwHQ5D7hCLZjZfTrbzT83n4m
         oK8UF4qew+NUm/NGat8F+9w9lZxvexk2GL3VRLzCf4QzGkXyVOutlkxrCY5NTbaeP/Mb
         srwZFC/FyBaKSUdlMKqdccsimlldGo8/JkYdfC9zFEwlBa0mRmuE4VaiQ7vH0RaMRTZH
         WIGw==
X-Gm-Message-State: AOJu0Yy4cfn9zZn8vQGqxXe1C2+ncNNw2fA82Z1R+zvqF5LOf6KD7sob
	HsOnJzdPYRBfzMAqsD5iBATRSGHnCF30zZl8LaeaKL14S0YvaQQJ03wGEnMfRgzAgx4=
X-Gm-Gg: Acq92OHeniaNApb57Z0hA8PE+RAGIcKKkYafxaQZuXtJJYXOlpBLBHZwkqmSn71PC4k
	vmebb8xoFOY6NeSGBhuHDrwqqH3aOM6GK5FcD5e9Ynu74XQHKLw6FGpg3TqMmAu7RlVE2dzIaWs
	jzGSi/0CCQLWT2/pJjtPWnA9GWOQAci6PBInEbVMy5hjpm02Nxm04+Rvb167Wzz9PtWaCu744yB
	4PN3Mza9dGiVkNtj/S1GI7tjFiqeEd8qIsa5eFUWpVxX6RzmwgIpXLbJODsH5Is+F5W2xziVhzT
	+7XU4WCNdG0KPJu4JCA3q7yr4N5ITBwC8SYWw8xWn+Lt1+Kzq9ShHWCh0fA5BzpYoga7E73+hoT
	RBsA0qqUTBgFmMFRn2KXYFFlEaWWel1j4FrSI+RqXifzKPZsIv9koxRiCaU+B/ixtYxalQ7PO0c
	2iOZhidUJUXbv87IbOfXaNLX2kqHgsGDgFnixcNV4EiEScj+tIxLo20bZBhG+elDz8n/Mh+RtbJ
	z0=
X-Received: by 2002:a17:90b:590e:b0:36b:9e24:c697 with SMTP id 98e67ed59e1d1-36c4ff673b3mr15897817a91.12.1780381936357;
        Mon, 01 Jun 2026 23:32:16 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd98925b9sm1628066a91.16.2026.06.01.23.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:32:16 -0700 (PDT)
Date: Tue, 2 Jun 2026 16:32:12 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next] wifi: mac80211: basic S1G rx rate
 reporting support
Message-ID: <2enlvwdxco5ezmpfosvvp3frreharqiiuspf67veztsmjwfcbd@rk3ej7yh4wow>
References: <20260602062224.1792985-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602062224.1792985-1-lachlan.hodges@morsemicro.com>
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37286-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE053629138
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jun 02, 2026 at 04:22:24PM +1000, Lachlan Hodges wrote:
> Introduce basic rate encoding/decoding for S1G stas such that the
> usermode rx reporting is relevant as it currently uses VHT calculations
> which are obviously wildy different to S1G. Sample iw output (with the
> associated iw patches applied):

Johannes, there are obviously some driver changes associated with
this - I'm not sure if you prefer these to be included in the v3
since I have to fix some things anyway or scope v3 just to review/bot
fixes and then send a subsequent pull request once it is in tree. I do
not really mind.

lachlan

