Return-Path: <linux-wireless+bounces-9251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A1090F037
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 16:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BA31C2420C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3951F14267;
	Wed, 19 Jun 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB9VMtBI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA71429B
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806777; cv=none; b=bD6la9N74oNvhnBVAwrF+YhIzojaKxUFeeiHfdxGZP712UQj+35pHT+yMl5SqqbToC6bCQXpGsX0vxfEmoUom6Sy6CC6CREpU7RdwQNKIIiwsBBO4FUFXQ1EQs/wIsIHOuXcb13qAkeCtCIxKkiFrsyagV/16ecG1qEZQMNVgdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806777; c=relaxed/simple;
	bh=HWVfMfjWZ/vMTwY3ZpK0EH21tQByP3aCi/L4ISOnflI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=M8Dy3CvsJrV+lNdogg7zA7gwpF5thQrp/25i3ArQgYICrQClVubx5BWVKBKANv577rnUvJSl1LwncXK0SXArNrHmicAmADXf6ukvAmVvK6yGsBGcNiQ79/H3qd1c5NlFu0PyCMD7f7RAEcdn6RcQtYs6vE++di8qI4rsDZvi//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB9VMtBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB792C2BBFC;
	Wed, 19 Jun 2024 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718806776;
	bh=HWVfMfjWZ/vMTwY3ZpK0EH21tQByP3aCi/L4ISOnflI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fB9VMtBI7ESgpkK1Rfq/FeTG3mgX7i+NfziIYLayB3UzjsBzBDYh7hZa2TiDayzAf
	 GBDyNIQVhd5GE2erG/a6VHjaxZg5CEVjgE84/kVvZg4LN2CScXRaRUv9OBjR+hH1df
	 qkXbAFkqZAHw0rr/ZLQe8tgfrOtzSAm9/4SVkajhKPlc/Xc8f+tDzQg8/Rh0SX8yVE
	 D4Cj1xQ9E7/czxsYrxwPg52LGncapFUd3tF2b/bcg2PyYtSLpQzKZSOGjmxENRToA5
	 07S0pSx6gahSQipWXSGrwwoNCMBvLPaM06rU42H6H61KQgJF4ZyRAX8kVqeaUDBzxY
	 HvbaM/JcOC91A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix mbssid max interface advertisement
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240613153813.3509837-1-quic_periyasa@quicinc.com>
References: <20240613153813.3509837-1-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171880677412.605247.6164895888072038617.kvalo@kernel.org>
Date: Wed, 19 Jun 2024 14:19:35 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> The Current method for advertising the maximum MBSSID interface count
> assumes single radio per wiphy (multi wiphy model). However, this
> assumption is incorrect for multi radio per wiphy (single wiphy model).
> Therefore, populate the parameter for each radio present in the MAC
> abstraction layer (ah). This approach ensure scalability for both single
> wiphy and multi wiphy models.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 519a545cfee7 ("wifi: ath12k: advertise driver capabilities for MBSSID and EMA")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

253ec89c9013 wifi: ath12k: fix mbssid max interface advertisement

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240613153813.3509837-1-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


