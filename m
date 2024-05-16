Return-Path: <linux-wireless+bounces-7746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0444B8C79EA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 17:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87979B21299
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 15:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECFD14D433;
	Thu, 16 May 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjj9vNuV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96414D44D
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875102; cv=none; b=cfT3wDyK0CAFyl8ttHrygd5tVuVhvfz0b0YxCp/nTKgzqdlQXO7qmLbK2/r6HQRwpHH5RZKl88a8WbpmwbtPdEcSgHNHDuKsb6LwyH+R5E397nqBlt7sqG1GcB/j/xVV+7qvbieAebOZT8PVwCzx0nVeySksOY1LIeWCZ9xwUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875102; c=relaxed/simple;
	bh=GUMoHHGD/pkVQb1m1BnMKO5q1xGRoSbjWCggGFScV3Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=c9P1EuynmxxVLM0zv4x702VWe3tnBUu9tE0q+kjz8Z0pWrfGDfjTXxnGn4HMWHdNK/DIvWk6WN9AQB0eQUS0cTuPG2lrOurAdE65NSODiBPdSyTBFLKarUXPjX8hfvGzXr+jny9Xp84f7ay7O/yHw95fGsp5FLd6szAtsO/1qqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjj9vNuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3112C113CC;
	Thu, 16 May 2024 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715875101;
	bh=GUMoHHGD/pkVQb1m1BnMKO5q1xGRoSbjWCggGFScV3Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mjj9vNuVe1DHj55zBEKyPFmt8OOjJLarq+TF/4S+9fVggt20W1PXv3sA5Lgvz73lS
	 lwyvWJDs3mjs60t0guUSakrHT09jgsQlQceMgN7nuAhhWsLWveortlcH/e3taGsj6W
	 Aj0PdVazSJ2/7SsTqZRTXCPaFldxgQTS1Z+52PCsgg++9HydMiD4+qMJ5sBh3MeZsH
	 V5/id2u/dDswLViFlF3vLAGFz8HXJCTuanPKM8txUbCxMge3JTuk2Bplyy/NXKC0j1
	 KZ7PnY039+1KR7Szyd8oZGOlCrldEzdzL7+K1zoFVDuaEzxVO+uJQVH+ybsCMEQIEH
	 dnvHghB6jNYbQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Lingbo Kong <quic_lingbok@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fix the issue that calculation of ack
 signal strength
References: <20240511030917.65811-1-quic_lingbok@quicinc.com>
	<41dd47b4-a1cc-48f5-a91a-1d64150d8c98@quicinc.com>
Date: Thu, 16 May 2024 18:58:18 +0300
In-Reply-To: <41dd47b4-a1cc-48f5-a91a-1d64150d8c98@quicinc.com> (Jeff
	Johnson's message of "Mon, 13 May 2024 17:01:48 -0700")
Message-ID: <87jzjthhph.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 5/10/2024 8:09 PM, Lingbo Kong wrote:
>
> Your subject doesn't quite make sense.
>
> Perhaps something like: fix ack signal strength calculation
>
>> Currently, the calculation of ack signal strength is incorrect.
>> 
>> This is because before calculating the ack signal strength, ath12k need
>> to determine whether the hardware and firmware support db2dbm, if the
>
> please split this run-on sentence, s/, if/. If/
>
>> hardware and firmware support db2dbm, do not need to add noise floor,
>> otherwise, need to add noise floor.
>> 
>> Besides, the value of ack_rssi passed by firmware to ath12k should be a
>> signed number, so change its type to s8.
>> 
>> This patch affects QCN9274 and WCN7850 because they have the same issue.
>> 
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>
> Code LGTM & Kalle can fix my comments in pending so don't respin unless there
> are additional comments.

Fixed Jeff's comments. I also removed both db2dbm variables, I felt that
they were not necessary. Please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=c7b6d4df1ac8427ac758f35b7c1aa641fa8df75f

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

