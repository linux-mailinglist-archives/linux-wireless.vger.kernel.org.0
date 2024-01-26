Return-Path: <linux-wireless+bounces-2514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C53583D475
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CB72873A9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4F14277;
	Fri, 26 Jan 2024 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2gXCpVQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B12AD24
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250588; cv=none; b=RJU/6slosTQiDWg4Gc8pQs5an+3cl66KRjDuj86xsFGubpQcRpVr6BsjlttQynFjeBSlqGkqO6jfJiHi50q3DPBkzWmPlaoLxGc1jp4QGjF+g4FJLGNzIIBHrEq/zvofvK1sBsDrRvZKrEe/UrfNvlpOm3tW0XZ8TRNdzQkyzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250588; c=relaxed/simple;
	bh=ODo9eWVFBoq7PHZ3CbEoITgaaJyDN6Z4o2AT4SCyLVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TrNz14Rk/mCj+MAZK2bUQI80mKKVHJJ6ifXUePJUDiaCqs0rHlDSWIJqADrQiLubMruhDjeGDVOmhbjT9ib1ioRxnGFtoeYur8foG2UM+xzfAtVzMxRTHK6pj7tu8rT3hy3lOIQ5r1Oph5OcVnKe+uur3bIQhA6wFiZn70eucYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2gXCpVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C108CC43390;
	Fri, 26 Jan 2024 06:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706250587;
	bh=ODo9eWVFBoq7PHZ3CbEoITgaaJyDN6Z4o2AT4SCyLVs=;
	h=From:To:Cc:Subject:Date:From;
	b=A2gXCpVQv9tusE9zLhu9WaJuEEq/t+zk0/IRWqsLIQsmVw1Uh/FFhnhcn2csZf4Zj
	 vUbrg0Y6lWtZGb/X2wInnaQZ+A0D5BVFAiT/6UPx0iYQWyPLFXhX3klvP1xoQ5HRw8
	 mN+UtHR/rF4VLXR9M2NjX4ewS//a/c+b8qbsFETYp+B4pNt9Uni2eezuw91eAeSfcI
	 yHVAdZw5w4+wJvwlsrLSyDf+5gPSejmFwZNsRcWahqrrt9vFa20rRAFllIRsBsYpEJ
	 98oZ3ivuCzP04xyOGNW9kBWTo9FfNazDjOhDRizyMsaWL8lJut4nFAFN28yzJ0WjRf
	 1ReM0HDvAX5ag==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
    linux-wireless@vger.kernel.org
Subject: iwlwifi: warning: Excess struct member 'trans_len' description in
 'iwl_fw_dump_ptrs'
Date: Fri, 26 Jan 2024 08:29:44 +0200
Message-ID: <87il3gzjxj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Miri,

I noticed a new warning in wireless tree:

drivers/net/wireless/intel/iwlwifi/fw/dbg.c:29: warning: Excess struct member 'trans_len' description in 'iwl_fw_dump_ptrs'

I don't know what commit caused it but can you fix it, please?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

