Return-Path: <linux-wireless+bounces-4957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8836880E56
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 10:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625F12834B0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49D739AC4;
	Wed, 20 Mar 2024 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI4YOufQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3C39AC1
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925814; cv=none; b=B7w8j49/vXq6X7ZKOtnhYLz2f3oWT4zmCL52rIuEnqGnyZTL7dCSIidYN8dZqtHzPpLSBrN238KUg5Cmr7ffg8MotjR84MlR5kxYo4lYGSdZsD5vRqltTniYl3wGrLMKemgoNI/21GvhdZzOoYkAH7yzWVgvACR/Sk9P13WYXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925814; c=relaxed/simple;
	bh=uSnOLaMSrNSN7NQwwpSh1i+Rm3BY5Q2gfZ25rx42k8c=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mhKz+mspEh4CAiIxFzMftl61zIJoSR1PI4VB0e9IrNDg8z0Pvekgo330fobfzMDJc1oRABpIGXCG/YNpRK6jb39ejyDgH/oyvuJy+nN0TLy0bwEdOxoI29G4UEaSjTmOF6KYcPnrZZSIY4uGwI6DenyFMolP9D7oL5Hv7nywZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI4YOufQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF36C433C7;
	Wed, 20 Mar 2024 09:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710925814;
	bh=uSnOLaMSrNSN7NQwwpSh1i+Rm3BY5Q2gfZ25rx42k8c=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dI4YOufQ7Zc6vxs1s0bLojiGcjS52ae1TvCcuuFltk1IDVpLBsKp9sA8RfQcNE/c4
	 V/rPNQpfUh5oSPBGOXs15rd/s4f5JH+wRO6spGj7Y5XPf5wqipVn8iGEslvz/+locm
	 /RvA+0B8IYPGOk3Kfjgqdf+tegrn35i0At0R7u6Cym3x4an80myL/VD9pBWEz1o3hm
	 PoHsY5zQBUVLPmNii5I6sTyTEIa4KH2tuqN6t7rDSfkLlffyIgLwq++Pu0DngjXfy9
	 sy9gIySVC/OzjZtojOVeEHpNwLrt6y1or0uB7hDnadmB4PjrO0MeESppo08/WIckFt
	 qCVGc1YIEjydg==
From: Kalle Valo <kvalo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name,  linux-wireless@vger.kernel.org,
  lorenzo.bianconi@redhat.com,  shayne.chen@mediatek.com,
  ryder.lee@mediatek.com
Subject: Re: [PATCH] wifi: mt76: mt7915: workaround too long expansion
 sparse warnings
References: <5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org>
Date: Wed, 20 Mar 2024 11:10:11 +0200
In-Reply-To: <5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org>
	(Lorenzo Bianconi's message of "Tue, 19 Mar 2024 16:12:47 +0100")
Message-ID: <87h6h12rrg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix the following sparse warnings:
>
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
>
> No functional changes, compile tested only.
>
> Fixes: e3296759f347 ("wifi: mt76: mt7915: enable per bandwidth power limit support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Thanks Lorenzo! Could I take this directly to wireless-next? We are very
close of being sparse clean in the wireless subsystem, there are just
few warnings left ath drivers.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

