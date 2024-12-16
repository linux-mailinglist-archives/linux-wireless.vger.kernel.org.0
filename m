Return-Path: <linux-wireless+bounces-16405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE509F2C15
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 09:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269B716722B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629CA1FF7DB;
	Mon, 16 Dec 2024 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyi9goEb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350111F709A;
	Mon, 16 Dec 2024 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338438; cv=none; b=agh/QKIjz2YepIgG8HDdDGuk4YcQhkmn/9ivYkozWKR1piQkuzxyXu7ZaXcGiSmZiogJ5sJx/wpNOetMG0Re1Tea1U/eH276kvS2ombM1cPInYp/z5pK5coNmJs8+P/IfKaL0ONvXhUnYsonoMNsG/BkIJg8/WkZeOyWRfW5WYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338438; c=relaxed/simple;
	bh=gKi2XZT5ZsZzsxN9N8Lvsqc4r13PDdM41as1fO1HNX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pg7o3ALiXXFtcT0YHMsty5Jpb5uD2CTIG3edl9SRxEKDPAnHeddBGoqa3f12ZCvSkA/GF6TaZV5z0ZFwItKES3AT+7yyN3+lnMCs+4+vNpcHhn8U9TO/4POMNR0ZkF13f6+iaRw7bq6oxvq9sfpiXPp4SgE9Cn+g4nNMIX9wqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyi9goEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E7AC4CED4;
	Mon, 16 Dec 2024 08:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734338437;
	bh=gKi2XZT5ZsZzsxN9N8Lvsqc4r13PDdM41as1fO1HNX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyi9goEbVQ9F+IHV92AggOREWiHFMvUW8gWLo7m+1f4woSJAuXImauw99S11Xikhp
	 Et6EZP9+0ZVZ77xOB5xcNTviPxvVUJ4lD+fR5WiOT4WVDkCkgCioUEXAMIDJEPqHlV
	 Xj86vyBTN7+JM9dWG9GxYQCVLPpJRvxVDA5Oh4OdhGpikjjpX8yU92bSQ+U+WPvE/u
	 s+nZY4WtwPNRsAfvkQ/wvJyPzw7ojrQA4Fz94Xa+aipWMG/EK5TQddqRRjxb2ZoNpO
	 GArMkxdOjOMs4j0br8huMm3tjoSAYQ8MflX91vfT4U1135XJvnUwOoMRRHBJzT+pVj
	 nMuJqGX2AqzuQ==
Date: Mon, 16 Dec 2024 00:40:34 -0800
From: Kees Cook <kees@kernel.org>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"Triebitz, Shaul" <shaul.triebitz@intel.com>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"Ben Shimol, Yedidya" <yedidya.ben.shimol@intel.com>,
	"Berg, Benjamin" <benjamin.berg@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH RESEND] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
Message-ID: <202412160040.FBBD5C2AB3@keescook>
References: <20241216042843.work.498-kees@kernel.org>
 <MW5PR11MB58100FB6B101568871F8A4ECA33B2@MW5PR11MB5810.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB58100FB6B101568871F8A4ECA33B2@MW5PR11MB5810.namprd11.prod.outlook.com>

On Mon, Dec 16, 2024 at 07:21:11AM +0000, Korenblit, Miriam Rachel wrote:
> The patch was already applied and marked in Patchwork as such. 

Hi! Oh, I guess it hasn't made its way to -next yet? Thanks for
checking!

-Kees

-- 
Kees Cook

