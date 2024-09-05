Return-Path: <linux-wireless+bounces-12538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6308896E02E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7998C1C22C14
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42FD17BCA;
	Thu,  5 Sep 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv5BpnxL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E0C2FD
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554985; cv=none; b=nksADSA+nAX8it0QElboyZarN2htoawSinuDXnIXddp7lAyjRXCnVW/ivW0Cev2ux3fcWqLlBs9Hn5jQ++Fis29IGABRyCDdD5tioKCt23e2eAnKR+WSG6WInxyXzN5p9G8ePx/di2mx3apx7kTVDT6Yd67jib0i4JfOBhAtE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554985; c=relaxed/simple;
	bh=gOUAkgewpVDUJacIk/hhD/4iQglVJoqr44Ovm/akqe0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SQhFvILiZZKkbKmPwNtGkia8hrnGxOrRUDRPJ65adWxtgATjeY2eif9vZF6GdjC/CVPPP5ziIx5BfCvLbD8VgjEBrBjzg8ogjb+l0kf3n0RxSShI2TIXYU2nn8vpSuUTYm+Av9co4CQyr0ld9inepDlQRfiGPGppRv1Mcvq+Cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv5BpnxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B41CC4CEC6;
	Thu,  5 Sep 2024 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725554985;
	bh=gOUAkgewpVDUJacIk/hhD/4iQglVJoqr44Ovm/akqe0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Jv5BpnxLCDx8ojnSea8cJT75bKa+e4knY4sXzaC6RJZQididZGVbb6gS+ohHWuc0b
	 S4CRmSg0Y/OdXp3/sIs2crWFMLjffxjKKfWVU4k2hiLTd8RWEIPDTkueg4T8SX3QXI
	 aETvhetgohLNUwtCUQGdReudoeDK/VjXoD2qrIwMSFrpg9ryOcM/ORnf1jgYfSGDgq
	 a39VBD901/rZlJ8vMEblJjC4R2vQM4hJGJV5bDtddMZ7/fLcOUKMu5Tl05BCt3E9dr
	 9zKRCh9ohAy6JopFjg4eKn+oy+kN8tCzLkw2zhMLpyiz9BQBLCPPSAdkn7YWuG4VRv
	 jnxc30Kk5gCcg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH RFC 2/4] wifi: ath12k: cleanup unneeded labels
References: <20240821153728.2121600-1-kvalo@kernel.org>
	<20240821153728.2121600-3-kvalo@kernel.org>
	<5ae832c0-8395-4d9b-a226-04255682c6d3@quicinc.com>
Date: Thu, 05 Sep 2024 19:49:42 +0300
In-Reply-To: <5ae832c0-8395-4d9b-a226-04255682c6d3@quicinc.com> (Jeff
	Johnson's message of "Wed, 21 Aug 2024 09:55:55 -0700")
Message-ID: <87plpihwpl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/21/2024 8:37 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> After removing the conf_mutex in the previous patch there are no unnecessary
>
> nit: s/ no / now /

Will fix, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

