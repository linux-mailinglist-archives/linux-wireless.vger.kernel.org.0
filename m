Return-Path: <linux-wireless+bounces-12643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4E9711C2
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 10:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9EC1F230B8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097B31B3740;
	Mon,  9 Sep 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY13niA/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E251B2ECE
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870006; cv=none; b=PMLtKim97vocAl8RKmgmNphoYPx7Okm/61H3uV+2tSGFVlAjZ2C0wkTf5fJtDfEGumfPb0eEFg12lKdkVTx1nh7Hhl9V/J6EFVRGUkwob/Ev0jVFE8VkM0BsftHRFVA7zxXy3mcPCKmvC3dl5ahoLPjrtRXWNwA0g4tP0GYfVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870006; c=relaxed/simple;
	bh=nftCCg3xr9iMdRFwKo8dmWs2AdDWec8YwwDeUcGNarY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=FE0Id1wkp5RIBPtHCCntOmoELk5DmEBQ7BBhMCcF5P1pF4f4ScHpo2r1WI4CvHD9npaEugKx+RWiyS0kJfKg23VYrPbT+yuJ63wWldbuNZ8fBpKwmG1y4PmCe1Rt7dbCjBDsXZlxX6RTtkSA+IITLM+YH/tmg2hauwmV3Aj94RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eY13niA/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c1120a32so2339806f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Sep 2024 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725870003; x=1726474803; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYxQL+AwWPUpkZIR0+trIt2GDXuzD4IQQ4A284hhb9I=;
        b=eY13niA/TAa2j5/ItrM97xCnN0T/W7wcU78E/OfMyMrLBXuMdr3nsKN0tX2YylPB/H
         7QWie8LOaT/wHggu5XD4yAXktvw7MgBSZiOMUWwDYhlwO1np1JONH0mkMjN+I6LD18TO
         QNznaINqY20bXjopdjsU6LSBvJywegjGiw8cwAgpl2Acax967R9t2R8TLCm5BVIx5//z
         y3YxCMtGdarSnXJzZCnQ8dioem4JuK55Lc2xhv6yGcphVuUfKfiA01Rsg5ANBDsqpDsi
         uTTBnyPpnJ3keyNuliLnr2KW8oD6CfDSv6ecnLiVKLhVZB02IpACF2UhZ50p8FXqHvj+
         XRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725870003; x=1726474803;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kYxQL+AwWPUpkZIR0+trIt2GDXuzD4IQQ4A284hhb9I=;
        b=TdBZblvG9rrhRWUQOCE4D4GlgIFTw7bU+nDwEqF41He7MELHieEowHktF4RhlPQOVn
         9w+N4KB1cblBe3f1h0tus8Hi43cr+cS0A4j9tanNKCfJ6RfcIbrNLjAPwiXWl5m3Rb3e
         M+J0JGBkGLZSKGqYNDxS2ovolACUZRqmrfoyDrkb6M3+isq9Zxb1x0nINJdq+g3rYIHe
         YbMH6INZkTxtrh8ntjMdts6BMy1xUgt5vkROcQEeRFwkokH69MTDdIX1ahT6zWSb5TMT
         oMubdliLCC4ffQdtgpHD0wwC8zpELv4rf1KHDs8fKJv8qWgmKw+tcx3hJnHN+mT96QOK
         0Lvw==
X-Gm-Message-State: AOJu0YzBByo0JoP7k3gTAZU0oJpS3J+c9879YpZvxho5LnrC3zNKBpEe
	tHiQFMAVb1orllpdMPqBmo1p5HHb89NolSEhVOz8OZ/BpxT5/VC3
X-Google-Smtp-Source: AGHT+IGN+BoofNmMeHUz9Lq2MtQ6Am0gVi84ik5ZQiHHf/w/yaIaOq4INjY2jim5cYBYLFEzOAsV7w==
X-Received: by 2002:a05:6000:128c:b0:378:7dc1:b22 with SMTP id ffacd0b85a97d-378895c5b75mr6870691f8f.12.1725870003233;
        Mon, 09 Sep 2024 01:20:03 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb32b0csm69033015e9.18.2024.09.09.01.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Sep 2024 10:20:02 +0200
Message-Id: <D41LUTO0MIC3.12475D2J3VNX3@gmail.com>
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Santhosh Ramesh" <quic_santrame@quicinc.com>,
 <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>, "Sathishkumar Muruganandam"
 <quic_murugana@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: fix tx power, max reg power update to
 firmware
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240909073049.3423035-1-quic_santrame@quicinc.com>
In-Reply-To: <20240909073049.3423035-1-quic_santrame@quicinc.com>

On Mon Sep 9, 2024 at 9:30 AM CEST, Santhosh Ramesh wrote:

[...]

> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless=
/ath/ath12k/mac.c
> index 137394c36460..6d7a005d83b4 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -7217,9 +7217,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *ar=
vif,
>  							chandef->chan->band,
>  							arvif->vif->type);
>  	arg.min_power =3D 0;
> -	arg.max_power =3D chandef->chan->max_power * 2;
> -	arg.max_reg_power =3D chandef->chan->max_reg_power * 2;
> -	arg.max_antenna_gain =3D chandef->chan->max_antenna_gain * 2;
> +	arg.max_power =3D chandef->chan->max_power;
> +	arg.max_reg_power =3D chandef->chan->max_reg_power;
> +	arg.max_antenna_gain =3D chandef->chan->max_antenna_gain;
> =20

For what it's worth, I already got a similar patch from QCA a few month ago=
, and
it fixed some tx power problems when scanning so I know there is truth in t=
his.

>  	arg.pref_tx_streams =3D ar->num_tx_chains;
>  	arg.pref_rx_streams =3D ar->num_rx_chains;
>
> base-commit: 903aaf66edc97dd5b9e3118d19677291051a9c40

But there also was more in the patch:

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/a=
th/ath12k/wmi.c
index a97e1399eeed..87e3ae49afa5 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2563,6 +2563,8 @@ int ath12k_wmi_send_scan_chan_list_cmd(struct ath12k =
*ar,
 						  WMI_CHAN_REG_INFO1_REG_CLS);
 			*reg2 |=3D le32_encode_bits(channel_arg->antennamax,
 						  WMI_CHAN_REG_INFO2_ANT_MAX);
+			*reg2 |=3D le32_encode_bits(channel_arg->maxregpower,
+						  WMI_CHAN_REG_INFO2_MAX_TX_PWR);
=20
 			ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
 				   "WMI chan scan list chan[%d] =3D %u, chan_info->info %8x\n",

It seems that ath11k has a similar piece of code in the equivalent function
ath11k_wmi_send_scan_chan_list_cmd . Isn't this needed ?

Also I see that in ath12k/reg.c in ath12k_reg_update_chan_list we also send=
 to
the firmware:
			ch->maxpower =3D channel->max_power * 2;
			ch->maxregpower =3D channel->max_reg_power * 2;
			ch->antennamax =3D channel->max_antenna_gain * 2;

As it is in a different wmi message, I guess the units are different. 0.5 d=
Bm
increment in struct ath12k_wmi_channel_arg right ? Or should we remove the =
'*2'

