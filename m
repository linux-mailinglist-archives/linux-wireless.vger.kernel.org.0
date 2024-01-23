Return-Path: <linux-wireless+bounces-2372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708DE838D1A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 12:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E611C211CF
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005FE5D727;
	Tue, 23 Jan 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKyqhV7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19535D725
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008437; cv=none; b=Mjx/EnJdMPvYyQOD91IEhYvX20ogguAacSSU6nkY+5Hc9y6LO7YatMUdEWLP+YRnDRqHi+DJA8LPspkzkJry+pQSeyEro8rPxE5ichAVpUcqrR7jW/78j0ccnKat1T9jAF1TGQPEe/XPUnpDaWt1+yPGoCIItNjjHYqedEC+5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008437; c=relaxed/simple;
	bh=1XJThjrtaCvmoFbHnTwpeqliwRYvGoxjsvJkfuZKUv0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rPixYVpOZ8UVam8jCJ8IDzdxe86JaYyWHQVJlGrLr9Y5iWGjybeWt0zqY5MLzMZSVVSDgDtbc2CQIJrOJphTK3aRsyE60HMIBpnhebhLO5KSVckTCIp2UScGcIWoZqkqoKtSv+JnANLpEhL2vPVOuoAau4eC3k04hu7moBPg+Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKyqhV7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92054C433C7;
	Tue, 23 Jan 2024 11:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706008437;
	bh=1XJThjrtaCvmoFbHnTwpeqliwRYvGoxjsvJkfuZKUv0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pKyqhV7FjPHZjvR6o7xvv51nSUCFzmCQ8+274rmLt3t/TZsX34PHtF9LDHqwuI6Kj
	 nR6WvCsZTnA/vZ1m7OMOLiDU9zsyxdUBid7I6UxSDWQbDRvtKSf+SB8Ip+3NZy0ZVT
	 GUmk/ny+l8j7fdU2sKtaSapLDqLCN0WsqRhSvDImV2O4RuxndW7ijqxj6qYS4e1IyR
	 QUp+rEFFEzh3EbmobPODsYF9kX62UkDA9BpQu4h85pmkXQJPca5B/7rdayXySsW8lP
	 BV5cWEwiaitVwf/q2pCPOYm8y0BkBRVan/P/Og47wNp3U83gOP1aS07d9+NQuqX5Je
	 E8wfwf9EYBl6Q==
From: Kalle Valo <kvalo@kernel.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>,  linux-wireless
 <linux-wireless@vger.kernel.org>,  Lorenzo Bianconi <lorenzo@kernel.org>,
  Ryder Lee <ryder.lee@mediatek.com>,  Evelyn Tsai
 <evelyn.tsai@mediatek.com>,  Bo Jiao <Bo.Jiao@mediatek.com>,
  linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 11/12] wifi: mt76: connac: set correct muar_idx for
 mt799x chipsets
References: <20240119085708.23592-1-shayne.chen@mediatek.com>
	<20240119085708.23592-11-shayne.chen@mediatek.com>
Date: Tue, 23 Jan 2024 13:13:53 +0200
In-Reply-To: <20240119085708.23592-11-shayne.chen@mediatek.com> (Shayne Chen's
	message of "Fri, 19 Jan 2024 16:57:07 +0800")
Message-ID: <87zfwwcnf2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shayne Chen <shayne.chen@mediatek.com> writes:

> Set the muar_idx to 0xe for the BMC WTBL entries of mt799x chipsets.

The commit message should always answer to the question "Why?".

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

