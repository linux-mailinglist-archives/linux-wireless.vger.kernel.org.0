Return-Path: <linux-wireless+bounces-7899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571718CAD46
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 13:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C301C21EDC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B37581A;
	Tue, 21 May 2024 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWtljR7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C975818;
	Tue, 21 May 2024 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716290441; cv=none; b=Zu8Z3X1t8DwH362/o45ZmLkB2Z/A1J2oX25BPzbgnJfyHjUUxmjCfjPQyZiX5S9x80L8dHrJVk/kYHoDSCquHWuLhcdtwaa4+I3gz6hyJh6xCiEKw0cXptC+APof/LgQ0+G9uco+myhO/il/7+aU20jIAu1LdkX74mI/CSolBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716290441; c=relaxed/simple;
	bh=wWzpBfqS6gfocOcYq61FVsITwdyGEdoO2FcMClgUahs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TWwHmQTlzrbpOMxIlULvswZu9etAxP84lxAVHKvL50gO11i+6S6SdYWjpqw5fboh53EXALcsUuRfqdtKilKnLETSyz2MtDDJWrtinvjK8iUuDz64D8xrTAFHP/Bgr1PLfM6ybHrwreT9bzAmO4QIWzfQAQezu7Z3Gitnxin/7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWtljR7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065A1C2BD11;
	Tue, 21 May 2024 11:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716290441;
	bh=wWzpBfqS6gfocOcYq61FVsITwdyGEdoO2FcMClgUahs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CWtljR7CkZBF4Vz4fhIRTYAUQb9nXzsdaXgTiYY4i+cO9p9i0Ii+LmMUI6DkJqRA1
	 kFX4MIEXkRG6My5WjKY3emmLMRtADTjc2pydbnYdgpaCEZWSNSajpqQPXAUjCUIE54
	 uFO2gp5AvOfYsgEfNKwsqnO7VpPH1y+Z1235QczQQwNv8akbiz+6Qtfm89GzT8Lj7x
	 teHOHdwJHJ8TWg3JnwWacb+BEd5MKrS6dUiJK94dNDmTBu7YsBxcme1Fo5z7pxOvVd
	 A5oG/3JYqLQPZUOiSebj4gdmVlv/EZYu9SwQ0ftwqZN1lya9nLaxtI1A314yObZ8qt
	 lncBLEW8P6ZRQ==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org,  Bjorn Andersson <andersson@kernel.org>,
  Konrad Dybcio <konrad.dybcio@linaro.org>,  Loic Poulain
 <loic.poulain@linaro.org>,  Mathieu Poirier <mathieu.poirier@linaro.org>,
  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-arm-msm@vger.kernel.org,  wcn36xx@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-remoteproc@vger.kernel.org,
  devicetree@vger.kernel.org,  Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/12] soc: qcom: add firmware name helper
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
	<20240521-qcom-firmware-name-v1-1-99a6d32b1e5e@linaro.org>
	<a45b53f3-b2a5-4094-af5a-1281e0f94d2f@linaro.org>
	<CAA8EJprxYsoug0ipRHTmX45vaFLzJCUF0dQWOc=QLs4y6uZ1rA@mail.gmail.com>
Date: Tue, 21 May 2024 14:20:36 +0300
In-Reply-To: <CAA8EJprxYsoug0ipRHTmX45vaFLzJCUF0dQWOc=QLs4y6uZ1rA@mail.gmail.com>
	(Dmitry Baryshkov's message of "Tue, 21 May 2024 13:01:45 +0300")
Message-ID: <878r03csxn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> On Tue, 21 May 2024 at 12:52, <neil.armstrong@linaro.org> wrote:
>>
>> On 21/05/2024 11:45, Dmitry Baryshkov wrote:
>> > Qualcomm platforms have different sets of the firmware files, which
>> > differ from platform to platform (and from board to board, due to the
>> > embedded signatures). Rather than listing all the firmware files,
>> > including full paths, in the DT, provide a way to determine firmware
>> > path based on the root DT node compatible.
>>
>> Ok this looks quite over-engineered but necessary to handle the legacy,
>> but I really think we should add a way to look for a board-specific path
>> first and fallback to those SoC specific paths.
>
> Again, CONFIG_FW_LOADER_USER_HELPER => delays.

To me this also looks like very over-engineered, can you elaborate more
why this is needed? Concrete examples would help to understand better.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

