Return-Path: <linux-wireless+bounces-16630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 097779F8391
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 19:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05AAC188BD6A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 18:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99C91A76B0;
	Thu, 19 Dec 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfkOWAqW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4956194C96
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634481; cv=none; b=bB4rz5rq9MCiax+O7Gt2JxIrzbI1ZijZuxt21FC9oSbiFTzPK/tFR0yftO5/i6YCdTSqVlC4R4RjNQ0+tH0bQ07FY7Qw/5asTeBGpn78V1fiFsgldaWHVB6zyHl0fvLgfWMMez6D4yQHL2lLV5PQHiL9uIESVP4fv4mA0AqTafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634481; c=relaxed/simple;
	bh=a/HOUFNOSb5LHyaR/JPllJIMj9GNdpkNSE399+J4acQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MHONLTX1MjQtvIIKUnySFVt1zvzYVfFk2iT09K4tjlzaLn8SLleVOBYNZUwMf0fk/W04wF/mq2D9iI2hiFBcv1MsJ7ZTU/y31yac3BVn3m2dsx4oF25puX+L+ExFOCqIS6uXXT6nMZgPhGVKhv2g8W4TtfEfsvWLxS4mbq9dOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfkOWAqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D22C4CECE;
	Thu, 19 Dec 2024 18:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734634481;
	bh=a/HOUFNOSb5LHyaR/JPllJIMj9GNdpkNSE399+J4acQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mfkOWAqWdlfkrdttXu+fDVHZUc0fmZWey9TsYPyGAYLVjK9JQOc6BWGgr2iM/OtIs
	 Ceyw/zPGwEYS92l7+zL4OIfx/nshX2axMPUOlrHwjbeAUGGayfCw+JzeispuAgdMws
	 A8IyS5qDIBmsMs0cd+fcUKGQR/KJrArNURdyd1FrrKBftnBMeVXMc8c8mbVHM1Is4+
	 /r0CGvJgzvZvK3qODy7XHAt5sNbhf5CHZzAo6hGs7lA9QpRbZwK9/kasvZEAMsMV/S
	 A2ln8UWiMxjyIHa+iOp3pe3GWZVMI1sJJOTlOyH6l7q8rQpOyqaUBfWx+cmKja6Xmi
	 uHAoU3zmq0niw==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/3] wifi: ath12k: Refactor Rx status TLV parsing
 procedure argument
References: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
	<20241219001006.1036495-4-quic_periyasa@quicinc.com>
	<87seqjj48p.fsf@kernel.org>
	<44bfd319-caf2-7459-f62e-0f61de452a84@quicinc.com>
Date: Thu, 19 Dec 2024 20:54:38 +0200
In-Reply-To: <44bfd319-caf2-7459-f62e-0f61de452a84@quicinc.com> (Karthikeyan
	Periyasamy's message of "Thu, 19 Dec 2024 17:12:26 +0530")
Message-ID: <87wmfvfqq9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> On 12/19/2024 5:04 PM, Kalle Valo wrote:
>> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>> 
>>> Currently, ath12k_dp_mon_rx_parse_status_tlv() takes the TLV tag, TLV data
>>> and TLV userid as separate arguments from the caller. These argument can
>>> be fetched from the TLV header itself. Therefore, pass the TLV header and
>>> retrieve the necessary fields from the header instead of passing them from
>>> the caller.
>> The commit message doesn't reply to "why?". Is there a clear benefit
>> in
>> the future or are you just doing random code cleanup?
>> 
>
> It benefit in the future for supporting EHT monitor functionality.

How does it help exactly? Having even just one sentence explaining the
motivation in the commit message would help a lot. Otherwise these just
look random changes.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

