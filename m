Return-Path: <linux-wireless+bounces-5894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356BC899C2A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 13:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667FA1C21069
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B44016C69F;
	Fri,  5 Apr 2024 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSGnHcLJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B8C16190F;
	Fri,  5 Apr 2024 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318226; cv=none; b=O37Pd8AVOhu3Iga6G9s9cd2tYY4nK6BBz2SbnP4YZmOX2XRPNzL4EkBqq2rvssaNux7P8rSumOS9PnMtbFwIkrlhcjyJBXmAvJEUR/j0aB+EMb4P6TkRF+1pCNi8SMVLuD1BiW+KOEs8QDsEnC8gRL/AKrg8S0M71Obd+I2xII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318226; c=relaxed/simple;
	bh=EyPgOz5gZ3ITDc/ApJcrZJOJ71Fn77fOpA59i92QI5g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TSc1pGDcmeNbYs4qCOic9nYYXS7p6FBYvcQTSI07BiulbhoxNRM4Vusm92kt2BQJIoWId1n0yfsKKDBnsBjM7UR20/5Zh7uqzRWHzWuumUPx9NOHJw5+NyCzz2Xqpei9APkJpLZ91RawK08OgkZmyb5xYpjDViS2mWC3HCfV3uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSGnHcLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E76C433C7;
	Fri,  5 Apr 2024 11:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712318226;
	bh=EyPgOz5gZ3ITDc/ApJcrZJOJ71Fn77fOpA59i92QI5g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GSGnHcLJbJVUx3kuCJ5JfvLlDybMhC76UtK6/GlxaFOm8YEPPW5Mi8tsnp8Z2xq3x
	 4O1e2Vd3VIJyELnSlvY+A2Qzz63DBl5Lm1EKA5Ww1W2s+tVh4RQyNWPkjZvV+Ehiog
	 KGLa0EY7EBlWlfzKMcwMqbYuecjXhStW60s5Kmwp2Az9XuhjnBuxnLQVgBO1Tk+uzO
	 MxIprh9ePYROGXkidAbQQmG6GJ3mbaUYOlQ8nCwjNXht+2+BsjnKsua08zSaQVndAi
	 +6hvF9TM5DGYBomCRX3NvD4IDqZOx1cfy5C3aMJmR6m3xLhBO3kW+VU3v+1mpP5WhH
	 EYlY7EgfmQySg==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  ath10k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-arm-msm@vger.kernel.org,  Yongqin
 Liu <yongqin.liu@linaro.org>
Subject: Re: [PATCH 0/3] wifi: ath10k: fix board file loading for wcn3990
 devices
References: <20240130-wcn3990-board-fw-v1-0-738f7c19a8c8@linaro.org>
	<CAA8EJprsjs8SWZmpTisyQcAZ9VC8g3_GEEc1hhp8bMZrm-hyaw@mail.gmail.com>
Date: Fri, 05 Apr 2024 14:56:59 +0300
In-Reply-To: <CAA8EJprsjs8SWZmpTisyQcAZ9VC8g3_GEEc1hhp8bMZrm-hyaw@mail.gmail.com>
	(Dmitry Baryshkov's message of "Sat, 30 Mar 2024 06:48:35 +0200")
Message-ID: <875xww3tv8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> On Tue, 30 Jan 2024 at 08:47, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>
>>
>> The ath10k driver fails to properly handle fallback from board-2.bin to
>> board.bin for WCN3990 cards. This happens because the
>> ath10k_hw_params_list doesn't include .fw.board* parameters for the
>> WCN3990 platform.
>>
>> Add board data configuration for WCN3990. While we are at it, merge
>> common pieces of BDF support: drop .board and .eboard names from struct
>> ath10k_hw_params_fw and use the common name instead.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>> Dmitry Baryshkov (3):
>>       wifi: ath10k: populate board data for WCN3990
>>       wifi: ath10k: drop chip-specific board data file name
>>       wifi: ath10k: drop fw.eboard file name
>>
>>  drivers/net/wireless/ath/ath10k/core.c      | 32 ++++-------------------------
>>  drivers/net/wireless/ath/ath10k/hw.h        | 14 ++-----------
>>  drivers/net/wireless/ath/ath10k/pci.c       | 10 ++++-----
>>  drivers/net/wireless/ath/ath10k/targaddrs.h |  3 +++
>>  4 files changed, 14 insertions(+), 45 deletions(-)
>> ---
>> base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
>> change-id: 20240129-wcn3990-board-fw-a2d97507a712
>
> Kalle, Jeff, is there anything pending on me on this series?

This is in my queue (Deferred state):

https://patchwork.kernel.org/project/linux-wireless/list/?series=821157&state=*&order=date

Unfortunately there is not really much time for ath10k nowadays so there
will be delays.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

