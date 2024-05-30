Return-Path: <linux-wireless+bounces-8326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152E68D51E5
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 20:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE261281367
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 18:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030ED4CE05;
	Thu, 30 May 2024 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksB2Zi/c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAF4C3C3
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094451; cv=none; b=jqCMEd7zZxZKj/nZUg5cAa4sMOG5gkM6/TOeQ7cBXEDHdD/COz2E2HxUlhJtKUEQIElGx2FlOygjXWFftLiVdmgLXwlEgLC2RwQQzgXfJj8mYZgbvu39Em9OuetKzGQ+/VIcBmNrgu4/XROZPVcfgja1Tlhxw3LSobCoDprQwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094451; c=relaxed/simple;
	bh=BLOo9CVjIS/IBAShUTwUmdOv6KGCT3ETni5bWuaIk0U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WW513cTPbqpTN5+btMjoKmTeH2r9y6kBAYr2gCXmBaZcgGUV3vYQQK31FAF6hBAWSGiUopjL4DE/jhmXG28flgOqyvDnjMWdwVQzQugxpx937/6tcQiuwuuwsREr47eHEjIXaLbCxZkZgkRP1U1SHoWOye61ymoC5NpRxOAvlTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksB2Zi/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AADC32782;
	Thu, 30 May 2024 18:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717094451;
	bh=BLOo9CVjIS/IBAShUTwUmdOv6KGCT3ETni5bWuaIk0U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ksB2Zi/cH7IR99oiUvkZ+Cq3/2fyk9ej66hSJQZFvyRmVZ90NGtQnCUPI6QGlll9i
	 eFN16fMPWlmT9y6HMLsgAcCez+Xx+jh8IpfF4Ou7VwlJ0F9iLz0L2XxGPhV1IvfM0F
	 t/zG3W55v4aqkZG0Hm9VHsb7s6l4XD/qIf0tmiNvdvkU6Nw/bi/9geydTYzmdDD19/
	 DyfWUNZrcJtE97kUETiAj5+porr1Oot55hvvG9BfGKxNiQ8EtbR5xXiVmRV3CzlB5A
	 4XyKhbx46WmjbC5qlfZIKWPtJald3bE8VulPnvj5uRDQtnBJL6P7kkKvbVE+8jinOq
	 eUIOMWkTmZ8Pg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] wifi: ath12k: add ATH12K_DBG_WOW log level
References: <20240530072714.25671-1-quic_bqiang@quicinc.com>
	<20240530072714.25671-2-quic_bqiang@quicinc.com>
	<b3ff72fc-c4bd-4cb5-a6d6-ad6772657d6a@quicinc.com>
Date: Thu, 30 May 2024 21:40:48 +0300
In-Reply-To: <b3ff72fc-c4bd-4cb5-a6d6-ad6772657d6a@quicinc.com> (Jeff
	Johnson's message of "Thu, 30 May 2024 10:55:39 -0700")
Message-ID: <87jzjbm9cf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 5/30/2024 12:27 AM, Baochen Qiang wrote:
>> Currently there is no dedicated log level for WoW, so create it for future use.
>> 
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>> 
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>
> As noted in cover letter reply this needs 2024 copyright. With that added,
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

I can add that, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

