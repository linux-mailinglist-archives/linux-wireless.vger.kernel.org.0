Return-Path: <linux-wireless+bounces-2670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 109798405E1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 14:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E001F21FD9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271461685;
	Mon, 29 Jan 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDSOy5bg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA3612F6
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533338; cv=none; b=WaNsH+RTNHYvseZSnCA7G2yIbR7gEj/11Cglp0h66fvs+O4zlBhBddIIV++uM25BoqneCtReoN0ne3U7uA0ovpfbPVRTalyQZIP+arnF2GRaTFv79qjV6MUr0UWcHO1Bnr5f2Ll/ko6AmleOE/Amu6xTgF8MqBhVYoOLqEKER4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533338; c=relaxed/simple;
	bh=d+4Z5MstCVFXKpwlXs3/v/FQWYagJl4WAWEOBXcyiTM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fzxEUvUGxyzdo7nv002v70bT1yU9i9QL3XqjCve+4iI022OfSSm9wwA5S5GoUp3cHnxLfXlJWpJmc9oEJrLnw2lb+6qGXsNYVP1qZBttyb7SegrmrX4KZ5A1Hr6e7N88JA72sa6HUmfxUhPESo7Fp7ZQDjtntI8LN98mwBSkLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDSOy5bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4CBC433C7;
	Mon, 29 Jan 2024 13:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706533337;
	bh=d+4Z5MstCVFXKpwlXs3/v/FQWYagJl4WAWEOBXcyiTM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=SDSOy5bgoTLElsi7UY2gJkKFH3ZR60/D1HLQiJXZnpISlFQszj59gyPt44dGoFkIx
	 oL/cEEQ74T96ayvjDP6Z2ab2Iyl56U2a1EZNgeKNpudVouaQtl5Ln09IwL9OponEtM
	 d68rJJtxlxPWcVMQuIxbSM+dnR49+4M8Kg5i7J6jRqOUkv70r80gF1r8RjyRvN68G9
	 zWQsE7eKI4DjUoV5XwnLdX8dyk0Z9KVu494qp7PEczVtROVLXJNtsRQQVKsnsWfyy4
	 KdL7NsMCO+FaPWml0BYVeLeBkggKgrXmwj7TcXlB77K6WmS9ulDeWWKWBHgRuPNRhK
	 NWd/Xq1QayyDw==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] wifi: ath12k: P2P support for WCN7850
References: <20240122113904.8938-1-quic_kangyang@quicinc.com>
	<87cytp1nhd.fsf@kernel.org>
	<9a90fab6-18f1-4664-96f4-6795174d636f@quicinc.com>
Date: Mon, 29 Jan 2024 15:02:14 +0200
In-Reply-To: <9a90fab6-18f1-4664-96f4-6795174d636f@quicinc.com> (Kang Yang's
	message of "Fri, 26 Jan 2024 17:34:44 +0800")
Message-ID: <87sf2gwaw9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> On 1/25/2024 10:44 PM, Kalle Valo wrote:
>> Kang Yang <quic_kangyang@quicinc.com> writes:
>> 
>>> Add P2P support for WCN7850.
>>>
>>> Kang Yang (10):
>>>    wifi: ath12k: change interface combination for P2P mode
>>>    wifi: ath12k: add P2P IE in beacon template
>>>    wifi: ath12k: implement handling of P2P NoA event
>>>    wifi: ath12k: implement remain on channel for P2P mode
>>>    wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
>>>    wifi: ath12k: allow specific mgmt frame tx while vdev is not up
>>>    wifi: ath12k: fix broken structure wmi_vdev_create_cmd
>>>    wifi: ath12k: move peer delete after vdev stop of station for WCN7850
>>>    wifi: ath12k: designating channel frequency for ROC scan
>>>    wifi: ath12k: advertise P2P dev support for WCN7850
>>>
>>> v3: rebase on new ath-tag, use ath12k_ah_to_ar() get ar(Karthikeyan).
>>> v2:
>>>      1. add Tested-on tag of QCN9274.
>>>      2. update copyright in patch #1, #2, #4 and #10.
>> I have not been able to run any p2p tests yet but during rmmod with
>> WCN7850 I now see:
>> [  136.260660] ------------[ cut here ]------------
>> [ 136.260909] UBSAN: shift-out-of-bounds in
>> drivers/net/wireless/ath/ath12k/mac.c:6005:38
>> [  136.261008] shift exponent 255 is too large for 64-bit type 'long long int'
>
>
> It seems you enable CONFIG_UBSAN, CONFIG_UBSAN_SANITIZE_ALL and other
> CONFIG_UBSAN_XXX.

Yes, I try to enable debug facilities as much as possible. They are
really good at finding issues in the code.

> I will add them to my config file and debug this warning.

Thanks.

> It's been a long time since the last update of kernel config. Can you
> share the new one if convenient?

Yeah, it is. I updated it now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

