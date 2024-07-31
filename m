Return-Path: <linux-wireless+bounces-10732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8075942D2F
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 13:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D96285795
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44A01AD9EC;
	Wed, 31 Jul 2024 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihwMH75S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DDF1AD9EA
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424932; cv=none; b=g4bdFyfsTbsrBWNEvvop7R9ENDr7TMUnvloEqvLiWugyVAnAlse15cXNzzrTcq3ZCLQgeMiys6nGQG9HqfxVdQS/QwhzVgHVKqm7/IH+NdhzfvQdvKZ9zMl6+hG4Aw2jgqoieh+kodlsJhTF74uVpTHJhX41J0Ini+OqPF11PT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424932; c=relaxed/simple;
	bh=RWov2fP2Ldj1Wjq1BbyCVDc90LthzJbmJPb+GphqrOQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bHmaEwXcjJATQsFCeowJ5GjEvHufOeZXjwV1d6kYKIkgz/hNjWEJA00hRZ69yoHyKoHpM4stJ85ivmKgmsv/WYaUWvFb58QGvbIusFvqIBbR5dXNUGvi+duiijGZgR2qdPeTBf1UYztL5V/ZWoYjOEdC5/agFILEr9gbFrDVxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihwMH75S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5175DC116B1;
	Wed, 31 Jul 2024 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722424932;
	bh=RWov2fP2Ldj1Wjq1BbyCVDc90LthzJbmJPb+GphqrOQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ihwMH75SI14u2a7MmgbNO7U8ZBfBN6DTK2sBWMZCo3pMEXMI7vBrmBNAF3SDpflQZ
	 5av66Gcs5Pfbz/1YsBxx8zJ5TI9gUo6+18Rkg3nV0mK4p8SCgi7DVL6//Jv6TbiiF1
	 iban1ygQwqXPUrdCMQi8MIFzk3Te2R0is0sYAOEejudRVLWifxV9ewSw1xd5iRvuEK
	 V57kh73ln/RYYhGXnuPDTRiLzHMwdxUgGSLqeM0tMeLll7eviquiaJSYB2yzQ//jwN
	 UyQirh7WrfqJ/DmoOp1fQbORbR57Z6l+3FaFhWa5K3QOM5j1Opju3pcuQtDNM5L4vF
	 OQzQ4ACADj/MA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: kangyang <quic_kangyang@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 04/11] wifi: ath12k: fix struct hal_rx_ppdu_start
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
	<20240725120035.493-5-quic_kangyang@quicinc.com>
	<aa2b6791-9d18-479b-a80d-722b99592cb8@quicinc.com>
	<87y15hkdyf.fsf@kernel.org>
Date: Wed, 31 Jul 2024 14:22:09 +0300
In-Reply-To: <87y15hkdyf.fsf@kernel.org> (Kalle Valo's message of "Wed, 31 Jul
	2024 14:17:44 +0300")
Message-ID: <87plqtkdr2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>
>> On 7/25/2024 5:00 AM, kangyang wrote:
>>> From: Kang Yang <quic_kangyang@quicinc.com>
>>> 
>>> Current struct hal_rx_ppdu_start in hal_rx.h is not matched with
>>> hardware descriptor definition.
>>> 
>>> So update this structure and related code.
>>> 
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>> 
>>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>>
>>
>
> Jeff, your reply was empty.

Actually I saw several empty replies in this patchset.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

