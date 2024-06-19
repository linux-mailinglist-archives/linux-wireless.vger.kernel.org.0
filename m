Return-Path: <linux-wireless+bounces-9245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE20390EF8F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 15:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D941281CD1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5763D14F13E;
	Wed, 19 Jun 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOK6em7c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C42139CD
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805585; cv=none; b=d2gFmPb45DTkRIslLg+5iOyBcb10F1jVZphMSGP/1j17pvkUrSe0/3H39s/VLY+VS+QmZfdd4b3jxHw+u9slCodJ0gVCxnjkZZPhWBLboeGjs9CqM/tByhBKaYdYjR3UTd1n+k08mapdB0RgU0dwlhmxnc5dssvdq6ydV9pubxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805585; c=relaxed/simple;
	bh=GP053fVcCmP+9oGR31yF9XjPlWhocHir6VNmV2sdCFk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=r1Fwkap3XNevU9DDlQz1KvEQlV2V7yAGFkyLMaveniu3ruENYOy3ciTRL8gCPgpRA2rFIMuilR0cWXvmKKY70R8/RLWduBRGrT2NR78zirtWm4D7o4OekUxYHHvLv9o6fh1F0E4dgkDmQUcJSS6nIw2AYIuoZ5t7hbo5VZxCfWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOK6em7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDA9C2BBFC;
	Wed, 19 Jun 2024 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805584;
	bh=GP053fVcCmP+9oGR31yF9XjPlWhocHir6VNmV2sdCFk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=AOK6em7ck0o0p7BUVC3Lpw1zNBYyxHKDzkgdf9T3BH+f0GHowO/sKCg9afdQP3QtH
	 5K27ZYs+unRgkTsSWjVlapb0FElZ5YMPIHkQSLonCysFEZeVTJcscbRIEGNhveEpjH
	 0QcogrpSKCu8fwl+S2WrvqHY8t9GUYwvHTsfSxWxP2lcAPuBaWiMkLZ6hC4QX34BnC
	 qKqI34AQMPkNSKJ3rmG3DKeCa8LYXVVUgSEayKlrdBbFa2zdOybNhMqB6I2voxNjJY
	 lhe+QFZM88q8H6tCocj1xqUN1n/WhFQ3Z28Y34EZLCTFnd5VByGCTXFY4WB8RjmjQD
	 04cZFAJFhML6w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix ack signal strength calculation
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240611022550.59078-1-quic_lingbok@quicinc.com>
References: <20240611022550.59078-1-quic_lingbok@quicinc.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_lingbok@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171880558194.581414.2662611449809906719.kvalo@kernel.org>
Date: Wed, 19 Jun 2024 13:59:43 +0000 (UTC)

Lingbo Kong <quic_lingbok@quicinc.com> wrote:

> Currently, the calculation of ack signal strength is incorrect.
> 
> This is because before calculating the ack signal strength, ath11k need
> to determine whether the hardware and firmware support db2dbm. If the
> hardware and firmware support db2dbm, do not need to add noise floor,
> otherwise, need to add noise floor.
> 
> Besides, the value of ack_rssi passed by firmware to ath11k should be a
> signed number, so change its type to s8.
> 
> After that, "iw wlan0 station dump" show the correct ack signal strength.
> 
> Such as:
> root@CDCCSTEX0799733-LIN:~# iw wlp88s0 station dump
> Station 00:03:7f:12:df:df (on wlp88s0)
>         inactive time:  75 ms
>         rx bytes:       11599
>         rx packets:     99
>         tx bytes:       9029
>         tx packets:     81
>         tx retries:     4
>         tx failed:      0
>         rx drop misc:   2
>         signal:         -16 dBm
>         signal avg:     -24 dBm
>         tx bitrate:     1560.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 4
>         tx duration:    9230 us
>         rx bitrate:     1560.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 4
>         rx duration:    7201 us
>         last ack signal:-23 dBm
>         avg ack signal: -22 dBm
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

94f228ac4f5b wifi: ath11k: fix ack signal strength calculation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240611022550.59078-1-quic_lingbok@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


