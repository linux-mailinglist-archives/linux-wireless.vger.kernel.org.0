Return-Path: <linux-wireless+bounces-391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F74803EB0
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 20:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2C61C20A01
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 19:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E45333074;
	Mon,  4 Dec 2023 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q17UQgS9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB133218E;
	Mon,  4 Dec 2023 19:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB87EC433C8;
	Mon,  4 Dec 2023 19:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701719246;
	bh=mVecGgq1sbChaepPD/HEGlf3wWNPbPnWtMet4hJ5F78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q17UQgS9S5Kai9cMo9y8tTTe+eFTJ28EuhHVuRoZy3vjoRYcM5WtZ/zOlK6I/nCDZ
	 r99MEqJWZ+SFl1cvxSiA/5o95KgESIWhGv/HEOWdE2Cb1tQkgMfoaMtK6O417svEa/
	 xtkosR4Cj5RqKhODaFzh+aujL6HBSszH9rjYzqjndINGnyGBkSmLdWpTS8M+5GmQ6n
	 FMgcdoeqUYg4UgLp4pzMqy/aMdRSYpS1i/vnboc07LFkDIx9eOVhPLqyeD8A2otaL7
	 oXHkycsurdmDiYj2elEphyOj5F4DegUh/0gmy2UoGO0Gf8gXKSmFDqt2f7Akdxt0lp
	 Oh4pNRZN2gIgA==
Date: Mon, 4 Dec 2023 11:47:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH wireless-next 0/3] netlink carrier race workaround
Message-ID: <20231204114725.76a986f6@kernel.org>
In-Reply-To: <d918321ab519800018a9fed71eb8e43d64cd934a.camel@sipsolutions.net>
References: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
	<20231201104329.25898-5-johannes@sipsolutions.net>
	<20231201162844.14d1bbb0@kernel.org>
	<339c73a6318bf94803a821d5e8ea7d4c736dc78e.camel@sipsolutions.net>
	<20231202104655.68138ab4@kernel.org>
	<efd89dee78a4c42b7825fa55bbceafad9bb9df36.camel@sipsolutions.net>
	<20231204082354.78122161@kernel.org>
	<d918321ab519800018a9fed71eb8e43d64cd934a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Dec 2023 20:14:10 +0100 Johannes Berg wrote:
> Heh. But do I want to get blamed for the (perhaps inevitable?)
> performance regression? I guess I'll try ...

I'd happily bet that nobody will notice. Feel free to add:

Suggested-by: Jakub Kicinski <kuba@kernel.org>

If that makes it better?

> Actually I could even still combine this with the netif carrier up count
> in the wireless events, so we only have to do the rtnl_getlink if we
> haven't seen an event yet, and - in the likely common case - save the
> extra roundtrip? Though I guess it's not a huge problem, it's once per
> connection basically.

No objections to merging your carrier count patches to wireless, if you
prefer to keep them. But it'd be nice to also have a generic mechanism.

