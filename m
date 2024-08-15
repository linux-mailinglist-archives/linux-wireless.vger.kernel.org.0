Return-Path: <linux-wireless+bounces-11488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558869532E0
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 16:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021FC288E77
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978D31AC44F;
	Thu, 15 Aug 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tchp6JIp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D438DC8
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730918; cv=none; b=b7yWgtPXt4DmF5k/3+R10bCwrt53B0DrwEWJi8DaVYeVbrEd3pqQjCedNcl7pdN3ZsUvGmVRQqJxqA+7ypoY8c5gCgxiXCUXX06VPHhL6K2c2FP3QO3PyoAFV4wuculHWTiWWwmQYhBt2SwXrNjmocGa44m7z3hw06l9h50tbNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730918; c=relaxed/simple;
	bh=FuzAVsapDXM2kPBH1JbstQry8C9ktAsU6/i96DIuXk8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=G1Gj06RBQvrsrDxPzYvJkooZLPEKpETaXBNN2jlh7T/WAfOxu2Zz4KNXH9FwWEwuofDvSj8Fe1yBqYDPQurx7y9n23zT4iUhTG3ZE78WWUe24mvq0CD8HjLfMRq+JtVJWlcftaBkLGSdkNOfg41hUVfDff7FSoIwiTdbK+8kFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tchp6JIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A604C4AF0C;
	Thu, 15 Aug 2024 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730918;
	bh=FuzAVsapDXM2kPBH1JbstQry8C9ktAsU6/i96DIuXk8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Tchp6JIpLlKomNlqI8m35yx/80/xClZOt5eVhKCgTTGaHm6T5vhmGRrV5+wkrsx12
	 rOqCC0VDwAd8PzVJixaWGVFopvbQft3GAwmxC+xKeoZ2WtWYVhZIqFYRAS+YsUIhgy
	 IPaiW6CRBxr4aQFdPm1jQgcawTYy3iQqtiWVhgSprvsVitLjj/1zrMS+3VNYJzgIR8
	 BP1b6qwy2BZrVrV6gDEfygQItlIOS0yT5T2rG83BzD3S4xQ2hqeWtw9KdpAypN58/9
	 SL71VGTP6mgUI3Id3jSc0LLsH2Ic4oCR3iLnt2jv3wGvVwBf45VJVSt3E7UfZ9u4Gu
	 bfloSOr7G4UcQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] wifi: ath11k: Add firmware coredump collection
 support
References: <20240813013028.2708111-1-quic_miaoqing@quicinc.com>
	<20240813013028.2708111-2-quic_miaoqing@quicinc.com>
	<4fc3d4a1-7dbe-412b-a6bc-72d0a5d13196@quicinc.com>
Date: Thu, 15 Aug 2024 17:08:35 +0300
In-Reply-To: <4fc3d4a1-7dbe-412b-a6bc-72d0a5d13196@quicinc.com> (Jeff
	Johnson's message of "Tue, 13 Aug 2024 12:12:12 -0700")
Message-ID: <87ikw1yj30.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/12/2024 6:30 PM, Miaoqing Pan wrote:
>> In case of firmware assert snapshot of firmware memory is essential for
>> debugging. Add firmware coredump collection support for PCI bus.
>> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
>> format and also pack various memory shared during QMI phase in separate
>> TLVs.  Add necessary header and share the dumps to user space using dev
>> coredump framework. Coredump collection is controlled by
>> CONFIG_DEV_COREDUMP. Dump collected for a radio is 55 MB approximately.
>> 
>> The changeset is mostly copied from:
>> https://lore.kernel.org/all/20240325183414.4016663-1-quic_ssreeela@quicinc.com/.
>> 
>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> 
>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>
> Kalle, are you able to test this? I don't currently have a HSP setup

Yes, I have a WCN6855 test setup and I'll test this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

