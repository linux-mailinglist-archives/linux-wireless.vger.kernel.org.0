Return-Path: <linux-wireless+bounces-7732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7FB8C7295
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 10:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C95281FAA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659426D1AF;
	Thu, 16 May 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3H4vIfg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C96CDA8
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847283; cv=none; b=eQyO89pCFzGcEWW0X2TSPks/aipv9/zGnOvDOJ6L1WU472imJMFzPeB+nrRzsQ0AthQo+YSEfTpcsrGMbOQ55Q/VApEMSdmh7gX7FlQeSUY5b3rPFBnznLcFC7UHtqZShDO6sChR213qB+R4PwQk4AV92Q9Oenum2R+0+1eDLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847283; c=relaxed/simple;
	bh=wn/F+J5SVSvsBC//lVjkwnoyTcauUvEZVGt08Eaw8DA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=I7uqzkvZTezKQ5P5QnAyYAN93fP64aY/gMfTOQZZcdT9c312h82QaygrQE+gLiXUE6R7ZBt8edHqIXKRNGOg5SG0xZ84l+cKCPRsxRV294ML44lZjgXCiXKTOI4lz01hb07iObEDL4GiTp/UE5Q9HjQTvG0XRQ1TwZC31WOF4bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3H4vIfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F85DC113CC;
	Thu, 16 May 2024 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715847283;
	bh=wn/F+J5SVSvsBC//lVjkwnoyTcauUvEZVGt08Eaw8DA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Y3H4vIfggMyvT27b0YA78hVdWIo4JmQDP3RUwMPCxq7/lMsgZe7f1GAjXbR542dna
	 ZVyD9SqZYy0LOVOWsH/MAqfwvZZpd+96bRb5gjFcpNgMO12KQsUOssnsg57czh5Xdd
	 E6F1vJgcFZxY3MFz7BB3GspH4TBcEJwT+J+oLAUHRK7rqe4FMBqSQEzoZnZhBH9PPn
	 CG/JW2wpWnPxkSYdWxale4g6Xxc0Yl82O5sF+4WK+iIUd+7m6xY14JJJIKAqI19Qax
	 3e+yq4VkkC0wtleG/S3HmALW85iti+RzL1AlOPyMscAWx1GtzAefUdlqUWa7RzTG15
	 qBTO6GvAjTGQA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V5 1/6] wifi: ath12k: add channel 2 into 6 GHz channel
 list
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240508173655.22191-2-quic_pradeepc@quicinc.com>
References: <20240508173655.22191-2-quic_pradeepc@quicinc.com>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171584728006.2755978.5369432703895117154.kvalo@kernel.org>
Date: Thu, 16 May 2024 08:14:41 +0000 (UTC)

Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> wrote:

> Add support for the 6 GHz channel 2 with center frequency
> 5935 MHz and operating class 136 per IEEE Std 802.11ax-2021,
> Table E-4.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

6 patches applied to ath-next branch of ath.git, thanks.

3745d7963cc3 wifi: ath12k: add channel 2 into 6 GHz channel list
c3c84a74bd79 wifi: ath12k: Correct 6 GHz frequency value in rx status
70e3be54bbdd wifi: ath12k: fix survey dump collection in 6 GHz
112dbc6af807 wifi: ath12k: add 6 GHz params in peer assoc command
f0e61dc7ecf9 wifi: ath12k: refactor SMPS configuration
97b7cbb7a3cb wifi: ath12k: support SMPS configuration for 6 GHz

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240508173655.22191-2-quic_pradeepc@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


