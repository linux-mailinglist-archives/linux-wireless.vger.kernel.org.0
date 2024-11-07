Return-Path: <linux-wireless+bounces-15094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C65419C08AB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3A11F24226
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F9B20C48C;
	Thu,  7 Nov 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MN30PC4g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402F1F8EFF
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988946; cv=none; b=b52ZOiJoTczppaFJoRd27QUuISC6ver8GYimTFrhn1XfmNcZQVkRAgEYZksG70wwEd13sNiImdx+Pq+OsJtjiRnv+MVaT8xPg9hfERDXqTnrWjFkyAJUVvGZ8RTAEehfhzFMFnoxqMp83pyQoi6q8Rb/mhmfA4HDR3q+RrcHFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988946; c=relaxed/simple;
	bh=vIvEAuo7CXsKsZVFoyHDp3t6/FR9gqCJHRpMaq/nXbQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOV5887IOZ+3bSXfPLiy2bPyda64MRYm/uHiPWms3QidGDkbhxBRt6m2OMd/Lwxsf0Jl1ub76iLtI1mjq1zM1K3Fu4F5qIeA1W3ALMPmkD4B25MUNxfXi5IPLMJ1YkKnC7KYq2LmRTNhlj1Hg6M3OQnZFSh8v+TkaHN7uyiVjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MN30PC4g; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vIvEAuo7CXsKsZVFoyHDp3t6/FR9gqCJHRpMaq/nXbQ=;
	t=1730988945; x=1732198545; b=MN30PC4gJ0aoptVadDTDbh+qLNecPpn/PkysuoBY6ZsXybV
	SWW00ZZfXqZTk5jXMJfOLXxexzPW2IMFNjfpwIzqFlWeY+OqVLUyxeiO/NDCqhW9aMduU0+GX2fTN
	+xry0wpckTjP7elRMvKwHrR1VINOYpgGZzdqqX3WST3WhS427bN04YNeBDj7spAvQwKAyQlgMFphu
	1cQbrboC3z6rtTf1mIrODkDf7HfopeFHvgNJIDdnA1nGU7e3DAxv5hFkXDB6cKvN6+LV5T72CgXeb
	eZzzh2s3sV2F6rTXJL3XghehKPhf2GxJ9KtbQJC7/HHkyCYE4+Y4rE2tzH5vsrfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t93IU-0000000GRoe-2kyy;
	Thu, 07 Nov 2024 15:15:42 +0100
Message-ID: <971cd1e3376a839047711b15961d4a118c40feaa.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] iw: scan: add enum for ie ids
From: Johannes Berg <johannes@sipsolutions.net>
To: Dylan Eskew <dylan.eskew@candelatech.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 07 Nov 2024 15:15:41 +0100
In-Reply-To: <20240930181145.1043048-2-dylan.eskew@candelatech.com>
References: <20240930181145.1043048-1-dylan.eskew@candelatech.com>
	 <20240930181145.1043048-2-dylan.eskew@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-09-30 at 11:11 -0700, Dylan Eskew wrote:
> Formerly, ie ids were hardcoded. This change will improve
> readability of logic which may explicitly reference an ie id.

I've applied this, with some changes.

johannes

