Return-Path: <linux-wireless+bounces-9254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0BD90F500
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 19:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3C91C2284B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E830155C94;
	Wed, 19 Jun 2024 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNm1NptU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F52152166
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817993; cv=none; b=XOYHDlyYluICwRsp/qeDE3S0NQuqklsHuu3cR89txk06Qo5NaaLvyq9N5BhyVq5O8X5ImlizvVBWeqJOH8UiQK4KLjRgpDu3EPoQHaE+vSxScLjLzzrVOcoAAzlrcOV2NKpyltbv8wSS8SsisDIm6vcyBzHLzvqHIb1mu1Kt4CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817993; c=relaxed/simple;
	bh=LQw+/TonZhZDttlWr3droi1gEt1TcWFwPUmwR/RQLM4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ANDju95E28VJludV5GbASe86YN5un1Y8ePk+FjRw1OJQgHLbBf2YoX6BYiwRDt4SMunap+CCJ53DT3GalorH4u91bqB0Tb+qPxbLIG3iEUrQXNDCb66L+lwJaoZhXQYWgieEw68jAE8gjxnmRzY3wdWarINs6RRw42nC9r4P1l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNm1NptU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24D3C32786;
	Wed, 19 Jun 2024 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718817992;
	bh=LQw+/TonZhZDttlWr3droi1gEt1TcWFwPUmwR/RQLM4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iNm1NptUUgN3vogGU7B+FK0vwBlqM3BtfbFSGcg6yqlTRhGcuajvoi5xrSbosBfiE
	 nP9R2o0Cbnmd7PSWPf4geROhaSsmlfIUuohMcgPo7r+M/OAL8qnuCl8hbTFpZsw0Px
	 PqPNw6LhVaGM89JghiJZp+PwoHTFrVF5CSocJfoI3THMfOAOdo8oPTkmU5h9hn0PtA
	 nSvRUEXJ9yvp9RlU+eOHz2q4IgBcuv3ToEeeksckEyLcnoMTbmuqOrwCXKac5wW3hK
	 eYjW+7pRf8NEpkIrOfRBVbAQgT/1qFaPpY5CPieRDnHx8XXHwmxwe+He2sfdl8MJ6U
	 N36hIEPCEFOuQ==
From: Kalle Valo <kvalo@kernel.org>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  "Lingbo Kong" <quic_lingbok@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Fix pdev id sent to firmware for single
 phy devices
References: <20240611043342.2672998-1-quic_rgnanase@quicinc.com>
	<878qz1kokv.fsf@kernel.org>
	<eb7ab3a3-4365-44fe-a33b-fdcd47524778@quicinc.com>
Date: Wed, 19 Jun 2024 20:26:29 +0300
In-Reply-To: <eb7ab3a3-4365-44fe-a33b-fdcd47524778@quicinc.com> (Ramya
	Gnanasekar's message of "Wed, 19 Jun 2024 21:42:35 +0530")
Message-ID: <874j9olu7u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:

> On 6/19/2024 7:43 PM, Kalle Valo wrote:
>> Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:
>> 
>>> From: Lingbo Kong <quic_lingbok@quicinc.com>
>>>
>>> Pdev id from mac phy capabilities will be sent as a part of
>>> HTT/WMI command to firmware. This causes issue with single pdev
>>> devices where firmware does not respond to the WMI/HTT request
>>> sent from host.
>> 
>> But WCN7850 already works so I'm not really understanding the bug
>> description. Can you elaborate, please?
>
> pdev id from mac capabilities sent as a part of HTT stats request or WMI
> control path stats request was not expected by WCN7850 and hence fails
> to send the stats response.

Ok, now I understand. Please include that info to the commit message.

>>> @@ -81,5 +81,8 @@ int ath12k_mac_rfkill_config(struct ath12k *ar);
>>>  int ath12k_mac_wait_tx_complete(struct ath12k *ar);
>>>  void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb);
>>>  void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id);
>>> +u8 ath12k_mac_get_target_pdev_id(struct ath12k *ar);
>>> +u8 ath12k_mac_get_target_pdev_id_from_vif(struct ath12k_vif *arvif);
>>> +struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k *ar);
>> 
>> AFAICS ath12k_mac_get_target_pdev_id_from_vif() and
>> ath12k_mac_get_vif_up() can be static, no need to add them to mac.h.
>
> Ah! Sure Kalle. I will take care.

Thanks.

>> So we are left with ath12k_mac_get_target_pdev_id() but I don't see it
>> called anywhere. Isn't that dead code we are adding?
>
> The wrapper is used by upcoming HTT stats and WMI control path stats
> support. Initially this change was added in the HTT stats infrastructure
> support series. Since WMI control path stats also depends on this patch,
> to eliminate the another patch series dependency, I pulled out this
> patch from HTT stats series.
> This wrapper will be used by below changes:
> HTT stats:
> https://lore.kernel.org/linux-wireless/20240614063404.2659089-1-quic_rgnanase@quicinc.com/T/
> WMI control path stats:
> https://patchwork.kernel.org/project/linux-wireless/patch/20240529180920.1472003-1-quic_rgnanase@quicinc.com/
>
> WMI control path stats has to be rebased on this current patch. Since it
> is deferred, I refrained from sending v2.

Ok, you could for example mention this is in a comment after '---' line.
Adding dead code is usually suspicious.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

