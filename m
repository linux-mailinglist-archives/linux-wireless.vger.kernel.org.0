Return-Path: <linux-wireless+bounces-12508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3849296C9A9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 23:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB46F284C2A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 21:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8D155A4F;
	Wed,  4 Sep 2024 21:43:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CD15531A;
	Wed,  4 Sep 2024 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486184; cv=none; b=MW+knvfB9F83NUUhOa9AcJKyI7U3n8I6Ikg50mLPW5T9tbmN6uza8s+k6dZgRTwSwfCaA4ryB3ZR6uEbMYt42wvZFwz3yxC8m9eFk9gT23PWapKRUi/FuwDy9WD1EjGI7lZeDdKsEv377TA4t9x9BA55Fp0P5K24DrxLMfmEpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486184; c=relaxed/simple;
	bh=c637fvQ9m864a9dV43oK2SUAn6MJ3Wfk1nc/ohfSLig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIVnmZy+8zRk7TCw23SKgy8GOsAbHbKV/tYuk98b2UJGdoEze0Ks5WbT9m2Ev3/4WrBihzMBvanOpJcH2MMfSYj935n/4xrRrqtQMBboeVelWvBo8bYu4MNAbKfzSktoq/WWQk4wg/SBAgl6bMJEXyAtFGe7YzDVhs4Q78/+kGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.62.3.196] (unknown [24.40.161.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 83A7661E5FE05;
	Wed,  4 Sep 2024 23:42:36 +0200 (CEST)
Message-ID: <00dfdaab-4d26-45f6-b69d-049ae489b2bd@molgen.mpg.de>
Date: Wed, 4 Sep 2024 23:42:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware (-110)
 (ETIMEDOUT)
To: Kalle Valo <kvalo@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
 James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
References: <d8253ab3-f4f0-40fd-a550-d75eef121b56@molgen.mpg.de>
 <87bk13jwzv.fsf@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <87bk13jwzv.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kalle,


Thank you for your reply.


Am 04.09.24 um 16:48 schrieb Kalle Valo:
> Paul Menzel writes:

>> Linux 6.11-rc6+ logged the warning below when resuming from ACPI S3
>> (or unloading and loading the `ath10k_core`/`ath10k_pci` modules)
>> having been connected to an AVM network:
>>
>>      wlp58s0: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware (-110)
>>
>> Error code 110 is the value for ETIMEDOUT. I saw James patch [1], and
>> applied it, and the error is still there (as expected).
>>
>> Can the warning be improved so the user know, which component is at fault?
> 
> The warning comes from mac80211 and it already contains your network
> interface name (wlp58s0). What else would you want to see?

As an ignorant user, I do not know what to do with the warning. I’d like 
to see a suggestion how to get rid of the warning. Maybe:

     wlp58s0: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware 
in X s (-110), please report it to the vendor firmware


Kind regards,

Paul

