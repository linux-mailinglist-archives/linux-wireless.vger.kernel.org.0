Return-Path: <linux-wireless+bounces-1723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279C582B27B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8602839A4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C614F5E9;
	Thu, 11 Jan 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaqEqfRz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1A4F5E6
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C27C433C7;
	Thu, 11 Jan 2024 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704989328;
	bh=0+BrsDPlPGTnVAptII451a+IY2CU9MdrCfvLNwEyBTk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YaqEqfRzGoDNo9HYYRxY7VOdQevSp8LjtmP47v6At6KsVVMF/r1t6nUySsFQlLekj
	 z5IuA0xPdA0hKGj64mZqEVLKxIa4yZRPO204U+8ScgX08f8iJfnHRIRDTJoxUPlIXE
	 AhTqZBX+GlFlWUV33cPOc9B1bL1AYFDl+TjKDXMWF0oXrHOZAPmOgzHhPfK7UWEBT2
	 cUTEB/auC/Md4F7Yd5QxJAG1Qp17Tem0opQFMCXn65Ue5sghI75mvJakETG0kIn50e
	 82TTQ0s/pLwKmnrpdIkdkZAUuAXkew8+GMDIGpl1IoI3itBRZ0Z3xJjCY6P/tVHmMq
	 LHKjwJUSCY/jg==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v10 00/12] wifi: ath11k: add support for 6 GHz station
 for various modes : LPI, SP and VLP
References: <20231218085844.2658-1-quic_bqiang@quicinc.com>
Date: Thu, 11 Jan 2024 18:08:45 +0200
In-Reply-To: <20231218085844.2658-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Mon, 18 Dec 2023 16:58:32 +0800")
Message-ID: <87mstbam42.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> This introduced some new concept:
> power type of AP(STANDARD_POWER_AP, INDOOR_AP, VERY_LOW_POWER_AP)
> power type of STATION(DEFAULT_CLIENT, SUBORDINATE_CLIENT)
> power spectral density(psd)
>
> This patchset is to implement the new rules for 6 GHz band in
> ath11k.
>
> ath11k parsed the reg rules from new WMI event
> WMI_REG_CHAN_LIST_CC_EXT_EVENTID and parse the
> transmit power envelope element in beacon of AP
> and then set new WMI command WMI_VDEV_SET_TPC_POWER_CMDID
> to firmware when connect to 6G AP, also support backward
> compatibility with firmware which not support new wmi
> cmd WMI_VDEV_SET_TPC_POWER_CMDID.
>
> v10:
>  1. [PATCH 02/12] wifi: ath11k: store cur_regulatory_info for each radio
>   a. s/muti/multi/
>  2. [PATCH v9 09/12] wifi: ath11k: fill parameters for vdev set tpc power WMI command
>   a. add idle_ps check when calculating EIRP.

I don't see Jeff's ack in patches 1, 11 and 12. Jeff, are you ok with
these?

I did some changes in the pending branch, below is a some kind of list
of the changes. The changed patches are available in the pending branch
(tag ath-pending-202401111604):

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=pending

multiple patches

o whitespace changes, especially adding empty line before after if and
  for statements (also in other pathches)

patch 1

o remove unneeded parenthesis

patch 2

o ath11k_reg_reset_info(): invert if check

o ath11k_reg_reset_info(), ath11k_reg_handle_chan_list(),
  ath11k_reg_get_ar_vdev_type(), ath11k_reg_is_world_alpha:
       move to reg.c, I did also consider renaming these to use
       ath11k_wmi_ prefix but thought that reg.c is more approriate
       place for them

patch 11

o remove comments from enum wmi_tlv_cmd_id

o other cosmetic changes in wmi.h

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

