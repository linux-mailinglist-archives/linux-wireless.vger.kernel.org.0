Return-Path: <linux-wireless+bounces-3213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0540284B1AB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 10:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1931F2341E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D5412D74D;
	Tue,  6 Feb 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvUIesS2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3612D745
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213403; cv=none; b=gDTTMo+DVyrF6GZpwluRwv5UQXBQZKQpMGenzIBWugVOU/67UHdmqtMAi/W4LQEqBGvHSzC/01F5snykF5S7URcsXfZ+nh+EywAWIlLNM1slCKaPN2iueD6VH59tAR9vo+kB3cf40pBSfG1VxUTEjjeyMsbcwT1EyD1EpbnCkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213403; c=relaxed/simple;
	bh=gO+v1StDHs3ZKhy95kzbKoIFkdFUG/xXc895ghfwFXM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UAoixfet1VWhAa5rApf7dnL7gM3s2zRj9E6796kVJlwylrCGeCjbj6HKhjVHnltTiDM67GLBB0tPxxLg5sluUh4oyuuYkTzS3sD466/RyCWVIBpRCKepxvX32cN1zkroXjAFZ8jpOYzs/Dh/xM1ortukeY/je6kkqSK0RyPINwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvUIesS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF79C433C7;
	Tue,  6 Feb 2024 09:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707213403;
	bh=gO+v1StDHs3ZKhy95kzbKoIFkdFUG/xXc895ghfwFXM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=EvUIesS2bpRau95djEH8ck3HzW4qbsmdY52hch655KTXGWyjE5sjqoL2R9bKJMblT
	 17bUEQpev5APEymKp2lBiqdfNcQRMFzs9vV8hJaWpf5t1lOqIRdSLe8C7nnM8yuaxi
	 8LzczCad+L21OiwmJTSHFGTGmQ3QK+x8fu0/rXiyZq14ftnN+v0NxYZ3IeB4oFIGIb
	 rj8+cuDG2F8rx393P6jcmj+iIHvIG9I/qKxTG6Tiks+LCNSRlkiMWu6MYc1OwDKoHA
	 WcDzOydWYVPEfd4ZH84e8LxDnxhtuj0JFBYW8j4BgwoEz7N6Im7AGhBBudHP8TJU/n
	 0E7GrOmVOpuNQ==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 05/11] wifi: ath12k: implement handling of P2P NoA event
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
	<20240130040303.370590-6-quic_kangyang@quicinc.com>
	<871q9vt1km.fsf@kernel.org>
	<bc5baff6-83c9-44ec-9beb-a863045194da@quicinc.com>
Date: Tue, 06 Feb 2024 11:56:40 +0200
In-Reply-To: <bc5baff6-83c9-44ec-9beb-a863045194da@quicinc.com> (Kang Yang's
	message of "Tue, 6 Feb 2024 10:21:13 +0800")
Message-ID: <87y1bxrk4n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> On 2/2/2024 9:53 PM, Kalle Valo wrote:
>> Kang Yang <quic_kangyang@quicinc.com> writes:
>> 
>>> The NoA(Notice of Absence) attribute is used by the P2P Group Owner to
>>> signal its absence due to power save timing, concurrent operation, or
>>> off-channel scanning. It is also used in the P2P Presence Request-Response
>>> mechanism.
>>>
>>> The NoA attribute shall be present in the P2P IE in the beacon frames
>>> transmitted by a P2P Group Owner when a NoA schedule is being advertised,
>>> or when the CTWindow is non-zero.
>>>
>>> So add support to update P2P information after P2P GO is up through
>>> event WMI_P2P_NOA_EVENTID, and always put it in probe resp.
>>>
>>> Create p2p.c and p2p.h for P2P related functions and definitions.
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>> This patch 5 had simple conflicts in wmi.c, please check:
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=cbcb45c458a93d32a48b9280c13294e0853fa5dd
>> 
>
> Sorry for late reply, I am in Spring Festival holiday.

No worries, enjoy the holidays!

> It seems i have conflict in adding WMI event, because you merge TWT
> patch-set before.

Correct, that's pretty normal as we have several patches in patchwork at
the same time.

> Do i need to send a new version ?

In this case no need to send a new version.

In general I usually try to fix the simple conflicts myself (like here).
If the conflicts are too difficult when I might ask for the author to
fix the conflicts and submit a new version.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

