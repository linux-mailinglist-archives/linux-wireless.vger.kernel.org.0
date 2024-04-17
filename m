Return-Path: <linux-wireless+bounces-6458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2518A85FD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1EDB244EA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A905A106;
	Wed, 17 Apr 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHMmR2bZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2B53801
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364461; cv=none; b=QbNQHPSwfXIephizoLFF7dcchXwuLE69LtyLcNVOE3jhPOtY/UUBLAc12DpZObQtBe1uOJWrEAEcC/HXajUgAa8l49dEaBgcP79v5xRj9d+ORy+IJ0OesjH/Ehp+KOnTGlhSq1/hsd7vmectiXLJI+2JMQPAb822nc/Ug0z4xz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364461; c=relaxed/simple;
	bh=4dl27/OkqOSeMVE3IRLMM5/zvr+ndRE4x0HOsxzXsuE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qlhhlfvRz9fh2nOCOv/vkSdyTOktc+K5FxdO4cxmiB8kdapiMD4Jt84SnqjP0CCEd5IoIbEM0NBkhITrYDl3uUovlolhajze4d4J7USNehahQ2+RIO/QtMOLT8onw727xOmMC18nGttGvRr7krup8skPjvnebqnXSMjUEjke7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHMmR2bZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0466C2BD11;
	Wed, 17 Apr 2024 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713364459;
	bh=4dl27/OkqOSeMVE3IRLMM5/zvr+ndRE4x0HOsxzXsuE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=sHMmR2bZuHDsTUjTW+bOlor67PamgHcCpdcr3ARhfrvIKRkk2iGycyvg+YjzynO8F
	 koCpRAojjJ/MvUEVJ7OwdqdfuClIMO0ActW4Riya3G70dmISwfASufgMjcFN1/BwT6
	 WZvy76qEJ7T4S9g8j1vPopT9s02p0D0FC3wjYh16jSvnTgVht/GcGcb7XmYVE3gRmr
	 rD2dTyV2dXAIG1Txbj9r4UVwzmvBCAuOOTPyFv3FSmL1SE6Lz9A3/seHBaIb6rU6WI
	 XID+s280s7qsp02JQqu7Q3K8qL2NfSqLFTGByp1FwoDtysu0hIsdwrQiusfL2T4DWR
	 4XsrzcDhnlC2Q==
From: Kalle Valo <kvalo@kernel.org>
To: "Nicolas Escande" <nico.escande@gmail.com>
Cc: "kangyang" <quic_kangyang@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3] wifi: ath12k: add support to handle beacon miss for
 WCN7850
References: <20240412094447.2063-1-quic_kangyang@quicinc.com>
	<D0I2E1O0GLM5.12RQY3BJEOKVY@gmail.com>
Date: Wed, 17 Apr 2024 17:34:16 +0300
In-Reply-To: <D0I2E1O0GLM5.12RQY3BJEOKVY@gmail.com> (Nicolas Escande's message
	of "Fri, 12 Apr 2024 12:16:12 +0200")
Message-ID: <87jzkwvz13.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nicolas Escande" <nico.escande@gmail.com> writes:

> On Fri Apr 12, 2024 at 11:44 AM CEST, kangyang wrote:
>
>> From: Kang Yang <quic_kangyang@quicinc.com>
>>
>> When AP goes down or too far away without indication to STA, beacon miss
>> will be detected. Then for WCN7850's firmware, it will use roam event
>> to send beacon miss to host.
>>
>> If STA doesn't handle the beacon miss, will keep the fake connection
>> and unable to roam.
>>
>> So add support for WCN7850 to trigger disconnection from AP when
>> receiving this event from firmware.
>>
>> It has to be noted that beacon miss event notification for QCN9274
>> to be handled in a separate patch as it uses STA kickout WMI event
>> to notify beacon miss and the current STA kickout event is processed
>> as low_ack.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

[...]

> LGTM, you can have my reviewed by if needed.

BTW patchwork adds Reviewed-by tags automatically to the patch, so all
good there, but _please_ edit your quotes. Including the full patch on
your reply makes use of patchwork really annoying, see here:

https://patchwork.kernel.org/project/linux-wireless/patch/20240412094447.2063-1-quic_kangyang@quicinc.com/

There was a trivial conflict in mac.h, I fixed it in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6dae20769f3f600a5ad5ee98b0fec0b14cf07a2f

I haven't seen any warnings yet, so that's good.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

