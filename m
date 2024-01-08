Return-Path: <linux-wireless+bounces-1588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686AA826FFD
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 14:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B013DB21CBA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 13:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A7F44C87;
	Mon,  8 Jan 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfKfPgCG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69944C86
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 13:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A15C433C7;
	Mon,  8 Jan 2024 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704720971;
	bh=BIoOh9pKqZ1iQpg0WB3blrxYcNGyGD50uNuwGK4Kz/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LfKfPgCGvSqjHjQ7b7e8DLz2l61qbIFiUa8c9QPsF9g7JULVff/+bDCSHhin3rMFi
	 gnG1Jqh9poID5TdAZs1Yvv7GdDmTSMiwCb0YPKNGOwfEReGt0FprJDUXwmyHxJMhcr
	 XhLJlCnWKR2N1fCJM2aMWahsuzE3a0yjQuV4+kOk/T1hUDtQ+UdU5kjWcoRAgK629Y
	 YoAsJR43LVRuIM+tOubmYOkENv7XmbASted4U9EfjuKmeutXqlY20VIV738wciOdjx
	 kaTc7HtHxmdK8fWl7QxOuOPxqQAmDQ2kgUkRtAY0MLOjqfTZtzdNPvYvDbd3p91hZ+
	 eVQ8ckQ28Ccdg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,  "Sisodiya, Mukesh"
 <mukesh.sisodiya@intel.com>,  "Korenblit, Miriam Rachel"
 <miriam.rachel.korenblit@intel.com>,  "johannes@sipsolutions.net"
 <johannes@sipsolutions.net>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "Greenman, Gregory"
 <gregory.greenman@intel.com>
Subject: Re: [PATCH v2 05/13] wifi: cfg80211: handle UHB AP and STA power type
In-Reply-To: <3a4ab7b8-4af0-447e-b189-be1e3e7cfe9e@quicinc.com> (Jeff
	Johnson's message of "Tue, 2 Jan 2024 13:13:23 -0800")
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
	<20231220133549.cbfbef9170a9.I432f78438de18aa9f5c9006be12e41dc34cc47c5@changeid>
	<87jzp61ox0.fsf@kernel.org>
	<MW5PR11MB581024768AEC355DEE8F15D5A39BA@MW5PR11MB5810.namprd11.prod.outlook.com>
	<SN6PR11MB3421B9AC91E1FBDAD531C662FF9DA@SN6PR11MB3421.namprd11.prod.outlook.com>
	<5b18c070-71ce-44a5-a7ae-0303e23b6aac@broadcom.com>
	<3a4ab7b8-4af0-447e-b189-be1e3e7cfe9e@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 08 Jan 2024 15:36:08 +0200
Message-ID: <87sf38dk1j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>>>> What's an UHB AP? Never heard of that before.
>>>
>>> Ultra High Band (6 GHz) Aps
>> 
>> Not sure where the term is coming from. It is not in the 802.11 
>> standards nor WFA specifications afaict.
>
> I have the same concern. We should not introduce "marketing"
> terminology; please stick to terminology used in the specifications.

Agreed. The commit logs should be understandable by any Linux engineer,
not just by wireless engineers.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

