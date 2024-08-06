Return-Path: <linux-wireless+bounces-11018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC49949598
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 18:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A102286D1D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4919743AB4;
	Tue,  6 Aug 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRpd6JFK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C943ABD
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961955; cv=none; b=CRrw317r2R+zZiYkqNbWPnHcy3WTAuL8kTR2nK+VRdBoxQ0LGXinhOYCbx2d5jeq/VAnTjaOhr1Sl2w7SoTQmmeOxJg2pNygkF+l5IhIFxWf6oKPvfCK1CxJwCLv9DkLfQ/9OasMyFy9QlFASQ1xW8Eaaw4rbywbV4pDqMIofig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961955; c=relaxed/simple;
	bh=ThAnpjMgWYwVRIgApNu4yXNd2bSsni8iuQB3jx3mIxM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Jz83sCSP0cukal1AYPfkDaQitm2w96g+5jwA9y8mdcX/Nb3JQYIwmbXvvmYOGSZgLu+ad15uA+x1BrUdtFKRS6jABckmU3fjXouWCv6rL9QTtV2LKgJnqKxTMnz3BIw5gTEv0UCROF7x5niIpzxR+vBaSvDCpiCG/p1fTeKNuIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRpd6JFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E954C4AF0D;
	Tue,  6 Aug 2024 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722961954;
	bh=ThAnpjMgWYwVRIgApNu4yXNd2bSsni8iuQB3jx3mIxM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DRpd6JFKQxkp/BXAMVELbvuMS63Po9Mby//cv2/k1LYb714RXVUrGOVi/ngkFboS2
	 Ly/4x0AZKe96FNSblNBO+CPi+A+cw+aYy/M0ytS5f+sL/tP4zgn8nRI37hgYcRUGtz
	 fMRsbmg2S8Zw2FIfsPHRnaGx0s58cyvkaGB6nqCcxMpIsj6T1sPIZfLANEXFDL54iM
	 n2hRTSDl+0x9ghalbfWbnHDtRvZP4rc7wYA/tvEEP3ENnAc+hOjUvGAMahhSe6sL2B
	 FP4pWHeKgsdrIUgGhBTWoIRwneo5kjAo68SQ9hpx/BJLwUa15LGaLJgEXLLEZH63C0
	 lss0N0qqO+sGQ==
From: Kalle Valo <kvalo@kernel.org>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Sriram
 R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH v6 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
References: <20240711165511.3100433-1-quic_ramess@quicinc.com>
	<20240711165511.3100433-2-quic_ramess@quicinc.com>
	<87plql6djk.fsf@kernel.org>
	<1510a11a-c31c-4a05-80c0-bffa81fa340a@quicinc.com>
Date: Tue, 06 Aug 2024 19:32:31 +0300
In-Reply-To: <1510a11a-c31c-4a05-80c0-bffa81fa340a@quicinc.com> (Aditya Kumar
	Singh's message of "Tue, 6 Aug 2024 21:32:14 +0530")
Message-ID: <875xsd628w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Kumar Singh <quic_adisi@quicinc.com> writes:

> On 8/6/24 17:58, Kalle Valo wrote:
>
>> Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:
>> 
>>> From: Sriram R <quic_srirrama@quicinc.com>
>>>
>>> To prepare the driver for MLO support, split the driver vif
>>> data structure to scale for multiple links. This requires changing
>>> the use of arvif to per link and not per hw which can now
>>> comprise of multiple links.
>>> Also since most configurations from mac80211 are done per link, do refactoring
>>> of the driver functions to apply these configurations at link level.
>> Something I noticed while reviewing this patchset:
>> 
>>>   static int ath12k_mac_op_add_interface(struct ieee80211_hw *hw,
>>>   				       struct ieee80211_vif *vif)
>>>   {
>>> -	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>>> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>>> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>>> +	struct ath12k_link_vif *arvif;
>>>   	int i;
>>>   -	memset(arvif, 0, sizeof(*arvif));
>>> +	mutex_lock(&ah->conf_mutex);
>>> +	memset(ahvif, 0, sizeof(*ahvif));
>> Here we are we clearing ahvif so ahvif->deflink is NULL.
>
> deflink is not a pointer member. It is statically defined inside
> ahvif. So basically this memsets the whole deflink memory region to 0.
>> 
>>> -	arvif->vif = vif;
>>> +	ahvif->ah = ah;
>>> +	ahvif->vif = vif;
>>> +	arvif = &ahvif->deflink;
>> So here we assign arvif to NULL.
>
> This would be a still valid pointer.
>> 
>>> +	arvif->ahvif = ahvif;
>> And because arvif is NULL this is a null pointer reference, right?
>> Or am
>> I missing something?
>
> So since it is valid pointer, this is not a NULL pointer de-reference.

Ah, of course. Clearly my vacation was too good and I forgot C :) Thanks!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

