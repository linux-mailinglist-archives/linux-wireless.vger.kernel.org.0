Return-Path: <linux-wireless+bounces-3823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F3B85C433
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 20:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B45F1F22A55
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 19:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914A4763EB;
	Tue, 20 Feb 2024 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0wO/dIP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D9762E4
	for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455734; cv=none; b=pPX6JzSGHwabcR5xIrMXsRd6KPs5x7MotOQy/9C8KO6O91RBOWxNI0Glw6Mc41/FYCOzpUa5StGHTAov1d/cSOpCj2eaIG6YfzR88bcCl1GgFBk4dN85rIdDHOKDGMH2dTGh+/HXN1/5HVcyln5U5Y1RfmdCTFsVqr/hy3ZvD3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455734; c=relaxed/simple;
	bh=Tnx/ILToaBCvVs1oz0BuT98ZXyX2/Y/A0JuZq6UgP2Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mp3c1C++oKYt/gcP2JBbN9NAFWDKtPIC1gkDJwvuJCxUzpuTWyoP0f83QMlcevyuPnOOM6ZH4i+Xl7uhQ38NjPl44tPG7Gdwv322i1jmajx33HgBb4f7Nm3C5BBby1wsbrvmlLaUEWcWyjxG54Y/wAQ4ZkfpdU+m/3w5KMZTv6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0wO/dIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9AAC433F1;
	Tue, 20 Feb 2024 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708455734;
	bh=Tnx/ILToaBCvVs1oz0BuT98ZXyX2/Y/A0JuZq6UgP2Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=u0wO/dIPnRwNLd0eSbdBbcQanPpXke58sbPEVmC+BoLHnSMs6tL+MQKw/Il2VQiGC
	 zkHeD+fMTMjo9yHkrW1DIBlSxRUX8Y4q/FeaELJ66Lrte4EMJ/nNjnq6wRdlWpRUUe
	 SgZpT3SrtydzVTvKZvszFbsv9EthGE0/gFuF/kjr8uSn/NTVgmV9YZjV5t/bzGhjIv
	 gjUudJMzUy17Me5SGQSs7wLu0dJ2/mmf4vIyWTCErpKtLNw7OIQZ4aBtVbWStN69ey
	 f7e284Em4DaQvPLrBZs3dO0U/VFLTYqOCb9YGqdZbiWP5GxGnupvRxG0k/t2rha/Q2
	 kVaKgwJQXOG1Q==
From: Kalle Valo <kvalo@kernel.org>
To: drastic_endurance425@slmail.me
Cc: miriam.rachel.korenblit@intel.com,  linux-wireless@vger.kernel.org
Subject: Re: PROBLEM: iwlwifi null pointer dereference when debugfs=off
References: <170844096394.7.10031732457351764961.271076804@slmail.me>
Date: Tue, 20 Feb 2024 21:02:11 +0200
In-Reply-To: <170844096394.7.10031732457351764961.271076804@slmail.me>
	(drastic endurance's message of "Tue, 20 Feb 2024 08:55:59 -0600")
Message-ID: <87msrvarik.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

drastic_endurance425@slmail.me writes:

> hopefully I'm following the correct procedure at
> https://www.kernel.org/doc/html/v4.19/admin-guide/reporting-bugs.html

BTW v4.19 is from 2018 so that's really old documentation. Latest
version can be found from docs.kernel.org:

https://docs.kernel.org/admin-guide/reporting-issues.html

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

