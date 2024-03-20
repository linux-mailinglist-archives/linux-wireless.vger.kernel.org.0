Return-Path: <linux-wireless+bounces-4966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 513F5880F5B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF472846A3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 10:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA483C08F;
	Wed, 20 Mar 2024 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD/shUz3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3443BBF7
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929443; cv=none; b=RnxHWV09JaykaeTEVTbuG9+3pKZ6kBnK7ep5lmiUIzH9CBsLhV/bSV7nLTdI+SjWU4ZlvgiCYlVxOr6a6abgWyMrgw1hr+s2GxhaTwPU6dk9vR1IS3WS4KQnbdQBtazEg2ZSMzq2RbaRuAqHIQRqbBVgGqtKSAFc9WSWqL88kek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929443; c=relaxed/simple;
	bh=4TwZ4eTytvpjDqWUFlc3s3YWRHki+yQ9NNjbPrJCSsI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=sFz92z/tzvYnap+g89OIolz8/WPLxJ11nWqnHahJQ/mr4qs15JAisB+dV9jrdjt+TeFSg6FYQoth7ZLS7Zyodi/xW8cdXVCa8SbsM/yys0GDphcs1cDpQUUyEPXx87fipODK1VmbE0DGDyNxak2ehVRdsj3aK2OyqMyE0TSV14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD/shUz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF303C43390;
	Wed, 20 Mar 2024 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710929441;
	bh=4TwZ4eTytvpjDqWUFlc3s3YWRHki+yQ9NNjbPrJCSsI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UD/shUz3aHZTM9P0cgIp4XayZpkUhD8VFC/TUZdVHM81N8xAoJYZXTH6pua5kyUlQ
	 iUzcANF8b2GxYqJlUKgvr9ttp571LTNBy4x30WNkyisCfUypB14z5az+0SFbfVTeTq
	 stLS22mDEV6cvTWPZWXdqa915Rx5d2p/Lz5c37oYgRqC8vEhpCZWFz4ziSh/dd10uM
	 ZIi7FYqDb1fhNgB8ttCO2UTvBvTea/ASXg8WiUnn4psb+J967i8uj6gprRjtb3lMkH
	 s11WNKe+TCTbGDcxcSj1MTPJ7KsZ0wciAjAEPEKaC6sfbUF1hWViBKwEjrhvPEIuxg
	 IbaVbM4gVTlUw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: use correct flag field for 320 MHz
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240314204651.11075-1-quic_alokad@quicinc.com>
References: <20240314204651.11075-1-quic_alokad@quicinc.com>
To: Aloka Dixit <quic_alokad@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Aloka Dixit <quic_alokad@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171092943914.3054175.1910579955534536390.kvalo@kernel.org>
Date: Wed, 20 Mar 2024 10:10:40 +0000 (UTC)

Aloka Dixit <quic_alokad@quicinc.com> wrote:

> Due to an error during rebasing the patchset 320 MHz channel support got
> broken. ath12k was setting the QoS bit instead of the correct flag.
> WMI_PEER_EXT_320MHZ (0x2) is defined as an extended flag, replace
> peer_flags by peer_flags_ext while sending peer data.
> 
> This affected both QCN9274 and WCN7850 which use the same flag.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 6734cf9b4cc7 ("wifi: ath12k: peer assoc for 320 MHz")
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

020e08ae5e68 wifi: ath12k: use correct flag field for 320 MHz channels

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240314204651.11075-1-quic_alokad@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


