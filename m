Return-Path: <linux-wireless+bounces-6187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832128A1C36
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 19:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E091F25F70
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C9215AD88;
	Thu, 11 Apr 2024 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jblsBXOT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D315AD85
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851909; cv=none; b=R09g3G9BQahW3OepmdTyX4N9e4YDvWaOh9j5YpU1ehzk5NsQS8i2MC2/IrCOYAt4zcJK36ogpAS2/dXm4piQnndkzB4MWkRS0gUsolpWlMCsg+abESm4qyf1KoOo1P/FNt+U27nap83wfc7Wx+CEEH8Wf20vpelvMWKoDytvhZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851909; c=relaxed/simple;
	bh=oPu+pMXZ7sRT7O7K/FKCAc6Llc8DXE8N568jWkHtkNY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fA/lR5e00po9Fe4re4B1XeToUlsF2wwvyni/moYZEHrawXPXssh2oaVlmRr6/tBWS0iKQj77U6W2mu0d1t9mxw9u7JiqP34uF3mLAuveAUgmgsQxGqIh9dkRe3qrxTVfAUucFU4LotQNKQ042DTA0NhwhBLT/d6f03bDoCW+PAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jblsBXOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D62BC072AA;
	Thu, 11 Apr 2024 16:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851909;
	bh=oPu+pMXZ7sRT7O7K/FKCAc6Llc8DXE8N568jWkHtkNY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jblsBXOTD+h7jlVDV66ht7fwDJbS60pdTPAcYYxdRC+bgR7AUFjeRj+1fNxFlk50i
	 UpH9F8gNgdO/wNSV+GmGUo2B20/GnIiX50R3pfJNc3hPBsHl7nnNHyuke8zp16HxGg
	 y85+d5pP5F/nmJLEQctLufi3Esug2SjgEUiX3sMrIXq4LenzJku8vD0hFX+MQTNEIQ
	 XZtyGNbTWubk7BqZ4LyVXXW1lUc5GK5buQYkY1/wBPBGy4ZT+2fBqfOo0R33CYxHoP
	 NdL2zhD6fxTVXKBVXUP8EZkoPbFymz59DAd9xd6Kcp/KQqvN+YzIXVgcdtP8CYH2MS
	 A41z2OUm1OX+g==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: add support to handle beacon miss for
 WCN7850
References: <20240319023032.719-1-quic_kangyang@quicinc.com>
	<8734rsz0gk.fsf@kernel.org>
	<e7c11c22-0b2c-4c54-b9f5-c01b8ba3a4b5@quicinc.com>
Date: Thu, 11 Apr 2024 19:11:46 +0300
In-Reply-To: <e7c11c22-0b2c-4c54-b9f5-c01b8ba3a4b5@quicinc.com> (Kang Yang's
	message of "Thu, 11 Apr 2024 19:31:41 +0800")
Message-ID: <87y19jyj3x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> On 4/11/2024 5:56 PM, Kalle Valo wrote:
>> kangyang <quic_kangyang@quicinc.com> writes:
>> 
>>> From: Kang Yang <quic_kangyang@quicinc.com>
>>>
>>> When AP goes down or too far away without indication to STA, beacon miss
>>> will be detected. Then for WCN7850's firmware, it will use roam event
>>> to send beacon miss to host.
>>>
>>> If STA doesn't handle the beacon miss, will keep the fake connection
>>> and unable to roam.
>>>
>>> So add support for WCN7850 to trigger disconnection from AP when
>>> receiving this event from firmware.
>>>
>>> It has to be noted that beacon miss event notification for QCN9274
>>> to be handled in a separate patch as it uses STA kickout WMI event
>>> to notify beacon miss and the current STA kickout event is processed
>>> as low_ack.
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>>
>> There were conflicts but I fixed in the pending branch, though I
>> admit I
>> did that hastily:
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=e5b7eced753bc7e5af133624f6ff37141c5b3442
>> But now I see warnings like below, I don't if it's caused my
>> conflict
>> fixes or was there originally.

[...]

> 	I just tried on latest ath.tag. After i fixed conflict, there
> 	is no warning.
>
>
> 	I saw conflict only happen at add/remove_interface(). Could
> 	you show me your conflict fix? I cannot reproduce this
> 	warning.

I already gave you the URL of my rebased commit above but here it is again:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=e5b7eced753bc7e5af133624f6ff37141c5b3442

But please submit your rebased version as v2 and I'll test that one.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

