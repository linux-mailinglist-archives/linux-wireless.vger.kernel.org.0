Return-Path: <linux-wireless+bounces-2528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB32683D8E9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 12:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB00B285A2
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29AE50A9B;
	Fri, 26 Jan 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXacPY4r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECBA58238
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259738; cv=none; b=lFJj8mWyvosQgZbO42TQEvyzCxtSzZ/xRsoPcEX+JR4PrEWZx/zpbj3e5uHidSli4an5w7Mc8GX4eRyxNZzFGGJep2oPns8kGd+dSkSB5nvL2ls6hKMWrzQsBT9/8G9hH1u7Op6Fh7kZmiqajyRLfqCI+uuidKcPd3w4oCLlnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259738; c=relaxed/simple;
	bh=U70vpWSi0SEj0W43XQRrQB4eAFAm6CvqzqKqPBTXSWo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=a7EEPEkwDlRHY3dvcaIcyY0EwPW1lCOHM4GcPeji7GD7pDq9PavBWfO2hPT2f60wKWYIJnGBEEPO9h3TEab2LptqBwe+tZDzKJSsdZVr1gaYbxRXqpLQz3a/KAVfYYtWyTs5rFD5ZXzK536xWKWXakwRGREM0LqMFC8QAtSIFKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXacPY4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA8CC43390;
	Fri, 26 Jan 2024 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706259738;
	bh=U70vpWSi0SEj0W43XQRrQB4eAFAm6CvqzqKqPBTXSWo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DXacPY4rJaAMeNlAPiYf9F39H4Nsuhl9HuAQWM7rV6Km6ArqXDLPZ6Cxn3lcJfhhU
	 Kp9V8tybQ89/VDQTeJG+GEwpjbuEHKD+ju3kLBlO2eTZw4fphQpAYKNe2mIUpiwIzV
	 D/LMoAl2kxO0FclocTZdyw84S8gTPXKFVD8tjP2I3UMZ4MsgHMplNUogQiZRCQfXbm
	 H8AZ+prkV926YbtIl0mtJKfpCOJMYIIYhKvfFGGICWRMiNcgQsNtSGf3t57Fbk/Q0W
	 LQczP2gA4LgBgXSDf2UGX4R6DoEWVyTIiYDIulZNsKV7yx/PsYD/hK7YvQ7CDjkMTK
	 DuHe9XaVlpqfQ==
From: Kalle Valo <kvalo@kernel.org>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>,  "Goodstein, Mordechay"
 <mordechay.goodstein@intel.com>
Subject: Re: [PATCH v3] wifi: iwlwifi: disable 160 MHz based on SSID
References: <20240125163103.578d2d3a617f.I558e8d0cf19dc862b1c4124df78a4cb690095bb2@changeid>
	<87o7d9cp2i.fsf@kernel.org>
	<MW5PR11MB581057008E1D85805226585AA3792@MW5PR11MB5810.namprd11.prod.outlook.com>
Date: Fri, 26 Jan 2024 11:02:15 +0200
In-Reply-To: <MW5PR11MB581057008E1D85805226585AA3792@MW5PR11MB5810.namprd11.prod.outlook.com>
	(Miriam Rachel Korenblit's message of "Fri, 26 Jan 2024 06:53:48
	+0000")
Message-ID: <87ede4zcvc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Thursday, January 25, 2024 19:15
>> To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
>> Cc: johannes@sipsolutions.net; linux-wireless@vger.kernel.org; Sisodiya,
>> Mukesh <mukesh.sisodiya@intel.com>; Goodstein, Mordechay
>> <mordechay.goodstein@intel.com>
>> Subject: Re: [PATCH v3] wifi: iwlwifi: disable 160 MHz based on SSID
>> 
>> Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:
>> 
>> > From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
>> >
>> > The driver should not send 160 MHz BW support for 5 GHz band in HE if
>> > PCI Subsystem read indicates no 160 MHz support.
>> >
>> > Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
>> > Reviewed-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
>> > Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>> 
>> Stupid question: how this is based on SSID (Service Set Identifier)? I just can't
>> figure it out, I guess I'm missing something.
>
> So SSID here actually stands for Sub-System ID.

Haha, we have so many acronyms now that we even have conflicts :)

> I agree that this is misleading, let me fix it.

Thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

