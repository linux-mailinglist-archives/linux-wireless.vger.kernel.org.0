Return-Path: <linux-wireless+bounces-3929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB24385FBAE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 15:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D261F24ED0
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12D1474BF;
	Thu, 22 Feb 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcizg/rD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760D17BAA
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613908; cv=none; b=px99fkKT0KpJ8zR432q65gFBPvxfO0uEPsEUamlv9uZiE7Xqcdh+gB51xcNu4cvkXhMKilpaY/2f5KIRI28kOusrOU1pG7MSs6qHKyO6x4w9jnc675cIlGchaub1tSLb4oaXAvqcHtzV7xYNhpMBq9CTZWU/aA0pBvHMdoSpgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613908; c=relaxed/simple;
	bh=d1/TmCT/PSUNMvVkg8Qx4qfwGfw5wg3z0Xbjn1a9QyE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MzB7qGVFXlM9rYkrR2kehd+6NubAKebrHo0orZtqbrcLg9rDOdlwwFgfSTSPJcA/wAhq1oUHonACKRDF29Cy0Nwx521x8MIxebZ/3gRIKzKBMr+rgkChZOT9vmZ/9VKLEwRyxQjjoKVYB9UspOzXyi2C9RuRqMgeizUmooeLfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcizg/rD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65248C433F1;
	Thu, 22 Feb 2024 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708613908;
	bh=d1/TmCT/PSUNMvVkg8Qx4qfwGfw5wg3z0Xbjn1a9QyE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mcizg/rDjPKnH38U1Sd/QOmL95ab3MqUaFnWGjlNfFA+hCbOiSua4Opheb/vQxz0F
	 kRzrxEr3wk6gPiBE4hhGsEsGhHz0J6fUvmnenTfKdYc5my9CVMFmUn7MlsPD15SCTJ
	 ao9vzQWbjnw9XgbToI76FSCMqfAvkCFeGVIKShXCDTSGeJNdcLKVmBOYYkx3k+hPg0
	 sgSTRzn3+rSV+DSSFBOdfhKTCv3OM3h62/iva+6fNePycgsgS6pD3Hw8dg4VKkvz0H
	 UCC074LPP42o8uONTdyrUh1rsJCYm6G15+11AjDmgpXctfbqNY0d2a5WfWjnIJAgwM
	 dYq7NftC3jSGw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: ath11k: thermal: don't try to register
 multiple times
References: <20240221024725.10057-1-quic_bqiang@quicinc.com>
	<20240221024725.10057-6-quic_bqiang@quicinc.com>
	<df08dfd4-189c-407b-8a2e-6fd2bbf3b22f@quicinc.com>
	<5828b835-6b4d-4245-991a-7f6b54ee8b51@quicinc.com>
	<871q95audb.fsf@kernel.org>
	<f2536171-f878-4a71-a49b-ca87abb17251@quicinc.com>
Date: Thu, 22 Feb 2024 16:58:25 +0200
In-Reply-To: <f2536171-f878-4a71-a49b-ca87abb17251@quicinc.com> (Baochen
	Qiang's message of "Thu, 22 Feb 2024 15:43:22 +0800")
Message-ID: <87cysolf5a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 2/22/2024 2:25 PM, Kalle Valo wrote:
>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>> 
>>> On 2/22/2024 1:15 AM, Jeff Johnson wrote:
>>>> On 2/20/2024 6:47 PM, Baochen Qiang wrote:
>>>>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>>>>
>>>>> Every time the firmware boots we call ath11k_core_qmi_firmware_ready() which
>>>>> ends up calling ath11k_thermal_register(). So we try to register thermal
>>>>> devices multiple times. And when we power off the firmware during
>>>>> suspend/hibernation (implemented in the next patch) we get a warning in resume:
>>>>>
>>>>> hwmon hwmon4: PM: parent phy0 should not be sleeping
>>>>>
>>>>> Workaround this similarly like ath11k_mac_register() does by testing
>>>>> ATH11K_FLAG_REGISTERED.
>>>>>
>>>>> Tested-on: WCN6855 hw2.0 PCI
>>>>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>>>>
>>>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>>> you need to add your own S-O-B
>>> Oh, sorry for missing that.
>>>
>>> Hi Kalle, I see you have put this series in pending branch. I am
>>> wondering if I need to send a v2 to add my S-O-B tag, or you have any
>>> other plan?
>> I can add it in the pending branch if you send it to me as a reply
>> to
>> this mail. s-o-b is like a signature so I won't add it on my own.
> Understood Kalle. So please help add below tag to this patch in
> pending branch:
> 	Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Thanks, added:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=a88f2007763465f2be307c3a5ed542233bc3c77e

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

