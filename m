Return-Path: <linux-wireless+bounces-4963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BCA880F06
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 10:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A35B2100C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456653B7AC;
	Wed, 20 Mar 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE2ZIcdC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21507381AC
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928183; cv=none; b=mKhJnn3F22fhPY+KCQr3ekJhRH+M9vgL5YOEQ0oS0oFPFKUMJv79KmQLUNBM4rZye+J7toFWma1K2OUXogzANTH8DQk+cwj/9HuyPFKppMjsuivM0Gs49DyF6+7E8ubjuKwPqxmeUK94R4VZjOaN63OYIjg1eL/tDIKRJLXyzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928183; c=relaxed/simple;
	bh=JAgI20ULW6DK5MOZN0D5EEF6osxNo2oLgmzYysLLCPc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fmlhTnLVJgge6afynrEOMsHuzG8koqMiW0wym8JkXPKBRAziXWRQhtylSP33wZCkVt3ToZJ9v+Vs/ZyqXIk5KPxlfYPSRS7T8VNkhz/M0gPh7IWxYvLWFUrslstZdLlCxcObkz7trIZfMDhd8cuPy4XjpoHVj2C9zdeTawuU4b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE2ZIcdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45111C433C7;
	Wed, 20 Mar 2024 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710928182;
	bh=JAgI20ULW6DK5MOZN0D5EEF6osxNo2oLgmzYysLLCPc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CE2ZIcdCoOLq+kzkUbGP2Ff7Yupwu5HOSZyv8s1P0+sslqGBIhrxO99ssummQw0Gu
	 VDdPWzqxANK2RFoD4k1PYPcuj/lBkK7MV4Vc6yN0ISrAPzMH/C5WE/vfHK2b64akiJ
	 fegAUpZ6j2DRIqLx2HqSMmU8oXhP3PmYMq+C6SlqldHhWiH1D+0qVl9PwFE0sBXkEW
	 OIXejOzPqPGVwXeZOmfvpNLMD91gFptfJPtV+RD+PEa0iH0icLXDq2bo6mIViKAvad
	 zMZtqLPDUZ+kwrqjMeX5VJJyZX3/037/exwhbduHYBfTaN8UAkZZfPsIRbJhn+vm9U
	 6yG5mI/R3QmfA==
From: Kalle Valo <kvalo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,  linux-wireless@vger.kernel.org,
  lorenzo.bianconi@redhat.com,  shayne.chen@mediatek.com,
  ryder.lee@mediatek.com
Subject: Re: [PATCH] wifi: mt76: mt7915: workaround too long expansion
 sparse warnings
References: <5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org>
	<87h6h12rrg.fsf@kernel.org> <Zfqo0I3CpWE6tHTh@lore-desk>
	<69f0cd9d-79de-4497-a964-07c981ac1a6f@nbd.name>
Date: Wed, 20 Mar 2024 11:49:39 +0200
In-Reply-To: <69f0cd9d-79de-4497-a964-07c981ac1a6f@nbd.name> (Felix Fietkau's
	message of "Wed, 20 Mar 2024 10:18:57 +0100")
Message-ID: <87a5mtb5cc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Felix Fietkau <nbd@nbd.name> writes:

> On 20.03.24 10:13, Lorenzo Bianconi wrote:
>>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>>  > Fix the following sparse warnings:
>>> >
>>> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29:
>>> > error: too long token expansion
>>> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29:
>>> > error: too long token expansion
>>> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29:
>>> > error: too long token expansion
>>> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29:
>>> > error: too long token expansion
>>> >
>>> > No functional changes, compile tested only.
>>> >
>>> > Fixes: e3296759f347 ("wifi: mt76: mt7915: enable per bandwidth
>>> > power limit support")
>>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> Thanks Lorenzo! Could I take this directly to wireless-next? We are
>>> very
>>> close of being sparse clean in the wireless subsystem, there are just
>>> few warnings left ath drivers.
>> sure, I am fine with it.
>> @Felix?
> Sure.
> Acked-by: Felix Fietkau <nbd@nbd.name>

Great, I now assigned this to me in patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

