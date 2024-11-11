Return-Path: <linux-wireless+bounces-15187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C95499C44F5
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 19:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA9B25276
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 17:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2B61A76CD;
	Mon, 11 Nov 2024 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwgmUV20"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB0C14D283;
	Mon, 11 Nov 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347885; cv=none; b=YKMvvy/T09FBjpsqV2I91hoFdNWUnS3GCs9xaTLTCRIi91IL3LrgJ5LqyYurYVqfHTGtu6y47sCu34TayzjCyC8dMhgOyNP5u+QzelKOxav0ZcPDpF+EGhcz74AN0Fmm84VXufj/nNtbBiMLUt5XQ6y8eNyigVZilSO3dEWbNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347885; c=relaxed/simple;
	bh=o3CQlzBRpJV7aSV4DDZJsHMn6BJpLIqcjJ/aGt/TrPw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ld88jEZGV8e54PtKxDrp1xGBOJiGb7x7GmEzLOFkv6wYFZbyklkmvMKT93KbrOH4xV50RsTwUCIjNhakKk9IOEDGyuFjAxdyir+MS2C1cvcnSJyO4Wmvvu/5QACAJk+q3FjJxqeXviecGrAA/+6Tz+mT+m3M7rcZEYycE9X6CEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwgmUV20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DC7C4CECF;
	Mon, 11 Nov 2024 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347884;
	bh=o3CQlzBRpJV7aSV4DDZJsHMn6BJpLIqcjJ/aGt/TrPw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pwgmUV20E5aFcgwiIvoi9A192iBJ8Zm9CVa0R7SLCKwUtHCxAbSDAhm7yBGz2lqNr
	 jETq5UW1TzB8BWPmXi8TZ9WhuhNv5gfmYbIQmJTr83Mm/DKDsdONzg3sARLRzUTLWr
	 XtqGGPVPnT812jB0Nw6XJ/yj6Yozw1dhC0of3Q98xk9yfk19deIkHKE2a+pfV4HYG1
	 MWhjiyluh/cLJH6+4dSS2Z5awGosMnSLw+gxt4NuzZZJRbdS0MvpmJCqiO5NUSUSGw
	 t18OJG06Wdk8UweroCF29N+UUt7Y7igbWNkx2Gl2hi43SzSmreioKTylBHJVD2u1LF
	 LgbFFtHfTLqUQ==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,  Raj Kumar Bhagat
 <quic_rajkbhag@quicinc.com>,  ath12k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Jeff Johnson <jjohnson@kernel.org>,  Bjorn
 Andersson <andersson@kernel.org>,  Konrad Dybcio <konradybcio@kernel.org>,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] wifi: ath12k: Add wifi device node with WSI
 for QCN9274 in RDP433
References: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
	<49a6ec0d-8a0b-49aa-a9eb-1174cff930f6@kernel.org>
	<cmvfpctliqggra33u6ituguoxh3jxcuxiyjpbtcjbcgpu6lhoi@4zdthfkc2ed3>
	<692503b8-cf39-4d6b-b70e-910fcc710d69@kernel.org>
	<CAA8EJpqMCbyK0dodMNyfs8dNjV2QoB2nyWm233eOS9xo8BaFJg@mail.gmail.com>
	<9d158c25-197a-49fd-b639-45287a46438f@kernel.org>
Date: Mon, 11 Nov 2024 19:57:59 +0200
In-Reply-To: <9d158c25-197a-49fd-b639-45287a46438f@kernel.org> (Krzysztof
	Kozlowski's message of "Thu, 7 Nov 2024 13:16:56 +0100")
Message-ID: <87wmh94pqw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 07/11/2024 13:03, Dmitry Baryshkov wrote:
>
>> On Thu, 7 Nov 2024 at 11:29, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> On 07/11/2024 12:06, Dmitry Baryshkov wrote:
>>>> On Thu, Nov 07, 2024 at 11:23:20AM +0100, Krzysztof Kozlowski wrote:
>>>>> On 05/11/2024 19:04, Raj Kumar Bhagat wrote:
>>>>>> The RDP433 is a Qualcomm Reference Design Platform based on the
>>>>>> IPQ9574. It features three QCN9274 WiFi devices connected to PCIe1,
>>>>>> PCIe2, and PCIe3. These devices are also interconnected via a WLAN
>>>>>> Serial Interface (WSI) connection. This WSI connection is essential
>>>>>> for exchanging control information among these devices.
>>>>>>
>>>>>> This patch series describes the WSI interface found in QCN9274 in
>>>>>> device tree and uses this device tree node in the Ath12k driver to get the
>>>>>> details of WSI connection for Multi Link Operation (MLO) among multiple
>>>>>> QCN9274 devices.
>>>>>>
>>>>>> NOTES:
>>>>>> 1. As ath12k MLO patches are not ready yet, this patchset does not apply
>>>>>>    to the ath.git ath-next branch and that's why the patchset is marked
>>>>>>    as RFC. These are the work-in-progress patches we have at the moment.
>>>>>>    The full set of MLO patches is available at:
>>>>>>    https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/log/?h=ath12k-mlo-qcn9274
>>>>>>
>>>>>> 2. The dependency marked below applies only to the DTS patch. The
>>>>>>    dt-bindings patches do not have this dependency.
>>>>>>
>>>>>> Depends-On: [PATCH V7 0/4] Add PCIe support for IPQ9574
>>>>>> Link: https://lore.kernel.org/linux-pci/20240801054803.3015572-1-quic_srichara@quicinc.com/
>>>>>>
>>>>>> v3:
>>>>>> - Created a separate binding "qcom,ath12k-wsi.yaml" to describe ath12k PCI
>>>>>>   devices with WSI interface.
>>>>>
>>>>> Thanks for the changes. When you finish with testing/RFC, please send
>>>>> proper version for review (just remember to keep numbering, next one is
>>>>> v4 regardless whether this is RFC or not).
>>>>
>>>> Isn't the 'RFC' being an invitation for review per the nature of the tag
>>>> itself?
>>>
>>> No, RFC means patch is not ready, might change. This was brought on the
>>> lists multiple times and some maintainers clearly ignore RFC. Including me.
>> 
>> Thanks, point noted. I'll stop marking my patches with RFC tag.
>
> Wait, you can keep marking them RFC! It all depends what do you want to
> achieve. Get some comments on early work or actual review for something
> you believe is a finished work.
>
> I looked here briefly, no comments from me and I assume that was the
> intention of RFC.

Exactly, we just wanted to have early feedback how to handle this
feature. We will now incorporate these changes to our work-in-progress
ath12kl-mlo branches, test them and once everything else in ath12k is
ready we will submit the next patchset without RFC tag.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

