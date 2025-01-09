Return-Path: <linux-wireless+bounces-17228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D03A06E26
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 07:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D233A18823B0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 06:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED1A7E0E8;
	Thu,  9 Jan 2025 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8kxESVY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9819BBA
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736403505; cv=none; b=UMySLchyX9mRepcUa96NbBvmVEHm74Kq3iiphMv9lFAqUszvlQ4YflzrsEEgq0H4IAIcnu/wuSYsfdBUM42NQTFxfvH2bFNpHEl/MDaesMK9MEwo7lop3iE3s1Oz2xScUOhUjx9MJrfauK/r89T4GE6sM6lR99oR/kfFxomxVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736403505; c=relaxed/simple;
	bh=N1f6ZkyJIoETWpLvZ0mYd4z4Nl5EGCbr2Fpw7Lm5gtU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Zqri95W2PmFOyZ3MSX5Qv2pWlD5rZbtjm548YRH/e3BlkrZNVu8fhoEbrSDjR3Ic7SMc193uFJxkzw5a947vwXOmh7O/khoF0nJ0PgcFY8AlieQR+GsjSNgG5QvkG5YO8xrrQ5UNMcyPh+D8NUieqpb0+rSF9BIIWYs1/tpztus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8kxESVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55B8C4CED2;
	Thu,  9 Jan 2025 06:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736403504;
	bh=N1f6ZkyJIoETWpLvZ0mYd4z4Nl5EGCbr2Fpw7Lm5gtU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=s8kxESVYYMVC9lBsXXBFJtFX5c3IfrRPMbenKTdQ+IS7uMDXw/Ejqbcuw1c1mmQ7f
	 GkTXhEbuIlcfNuSmL758OJ0BKtWZrsZfYJNs1lqC9+QSTXev1gMYHO1d5SQKirqTPH
	 tWYyaybZkJeGr5jBjPAnUcss19vtTTjUGg2ZRaOHJwt3tmE0kYhHaWPwatzeloLeEH
	 WuNtVCg3AD8XhbPnIwZ9YoF7RJZ53Iadx4TXuysu2Ed6JsV32gZi6PuOCXP9DlrijL
	 C/bvGAOAuDFgpGz7672NPxsSTX5KGuhjSwXhPixdVSYXyB2CzvPy1iUxZoKNKLmgKD
	 lMLn5AOU7rXYQ==
From: Kalle Valo <kvalo@kernel.org>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 14/15] wifi: iwlwifi: mvm: add UHB canada support in
 TAS_CONFIG cmd
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
	<20241226174257.0b1d92ad59b8.Ib80f8514a64fc2800a2a20131e730c2bd9c4c4af@changeid>
	<874j29qrq9.fsf@kernel.org>
	<MW5PR11MB58104B7162673212E5389F2DA3122@MW5PR11MB5810.namprd11.prod.outlook.com>
Date: Thu, 09 Jan 2025 08:18:21 +0200
In-Reply-To: <MW5PR11MB58104B7162673212E5389F2DA3122@MW5PR11MB5810.namprd11.prod.outlook.com>
	(Miriam Rachel Korenblit's message of "Wed, 8 Jan 2025 18:49:46
	+0000")
Message-ID: <87r05cpl1u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(adding back linux-wireless, please don't drop it)

"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Wednesday, 8 January 2025 16:57
>> To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
>> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org; Anjaneyulu,
>> Pagadala Yesu <pagadala.yesu.anjaneyulu@intel.com>; Berg, Johannes
>> <johannes.berg@intel.com>
>> Subject: Re: [PATCH 14/15] wifi: iwlwifi: mvm: add UHB canada support in
>> TAS_CONFIG cmd
>> 
>> Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:
>> 
>> > From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
>> >
>> > extend TAS table support to revision 2 for getting UHB canada
>> > enablement from BIOS and send to firmware via TAS_CONFIG cmd based on
>> > firmware capability. While on it fixed kernel-doc for struct
>> > iwl_tas_config_cmd_v4.
>> >
>> > Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
>> 
>> Is this name correct?
>> 
>
> I am not sure what name you mean?

In From and s-o-b lines full legal name should be used. Does Anjaneyulu
really sign all legal documents with just "Anjaneyulu"? At least the
email address implies otherwise.

For example, I don't use "Kalle <kvalo@kernel.org" in From and s-o-b.
Instead I use my full name "Kalle Valo <kvalo@kernel.org>"

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

