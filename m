Return-Path: <linux-wireless+bounces-7457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5F38C260D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 15:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3691C213BD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2E12C550;
	Fri, 10 May 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI2Z35V+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FA12BF39;
	Fri, 10 May 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349057; cv=none; b=rro70WPxsL7XHT+rKRLHE2jRqeuZgrdOUkCQoCMSFRxA4C08bUQy/OxEcoAuuAJbYmNpj2fNIjUkWTIdjXQxNs0TN0plHcLUIMR9eRXM7yduKeIcmUVg6f39KX+3e9K6OHzYpC/BqGKhTNjIwRaXKYQ9oroLnPvbfY+7DBLtik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349057; c=relaxed/simple;
	bh=1o5pwPx9wrewqRpso30hR7MfPzjEudJwCui/sX1m3SY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MTOjQDoDdllmFL3JwA7Z61KRLVXzwjUnAus8ivv33j09RRhrpiBzheXjqWDpvea3tCX9jvoAulvBpSHmOrmVYurolX3kdd/GswN9u4/wxXRZG25RxSmovqR1sYuUtQVQ1jt5YpuyvGLXpazQmgghyIKAgAe2Jzwf8kYrK3zF7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI2Z35V+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328D6C113CC;
	Fri, 10 May 2024 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715349056;
	bh=1o5pwPx9wrewqRpso30hR7MfPzjEudJwCui/sX1m3SY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OI2Z35V+XCNTV1UDJaNCiVB+oz/Nl7JOH5NMPltS4N0lFk7kFn/c5zRHQoSC8Z4qh
	 Zu+Yv2b93c6mXPMeMfjo7x32z2RaCH15eSpxMemdO2p7aMrEDR97wk+XMNttsAO0yI
	 WyqixIrBrcZINuOTeoNdr9tF3VCGLbB6YJuaU7L3MdRPtrlvDAoKaEYgRDb/HZSKfZ
	 GQYvhnj+/iFIsHrO3VoRRY3n5rXt+KEb+h+d2FClI+qu/PvYV0Br8eB+zmYKJ3bfm5
	 3dRNQ6E267bfPRfncksQ92R+Wck/iBwS/8eCtGQbVati6pDgYrhyd/bQ7uV6nBQtu5
	 JkgqRABfTlhBQ==
From: Kalle Valo <kvalo@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  linux-kernel@vger.kernel.org,
  ath10k@lists.infradead.org,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  Sebastian Gottschall <s.gottschall@dd-wrt.com>,
  Steve deRosier <derosier@cal-sierra.com>,  Stefan Lippers-Hollmann
 <s.l-h@gmx.de>
Subject: Re: [PATCH v14] ath10k: add LED and GPIO controlling support for
 various chipsets
References: <20230611080505.17393-1-ansuelsmth@gmail.com>
	<878rcjbaqs.fsf@kernel.org>
	<648cdebb.5d0a0220.be7f8.a096@mx.google.com>
	<648ded2a.df0a0220.b78de.4603@mx.google.com>
	<CA+_ehUzzVq_sVTgVCM+r=oLp=GNn-6nJRBG=bndJjrRDhCodaw@mail.gmail.com>
	<87v83nlhb3.fsf@kernel.org>
	<663c9fc7.050a0220.5fb3a.4e87@mx.google.com>
Date: Fri, 10 May 2024 16:50:52 +0300
In-Reply-To: <663c9fc7.050a0220.5fb3a.4e87@mx.google.com> (Christian Marangi's
	message of "Thu, 9 May 2024 12:04:52 +0200")
Message-ID: <87a5kxlqrn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Marangi <ansuelsmth@gmail.com> writes:

>> 
>> Sorry for the delay but finally I looked at this again. I decided to
>> just remove the fixme and otherwise it looks good for me. Please check
>> my changes:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=688130a66ed49f20ca0ce02c3987f6a474f7c93a
>>
>
> All ok for me, Just I notice the ATH10K_LEDS is not exposed anymore? Is
> that intended?

Yes. It follows the same idea as other wireless drivers do, for example iwlwifi:

config IWLWIFI_LEDS
	bool
	depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
	depends on IWLMVM || IWLDVM
	select LEDS_TRIGGERS
	select MAC80211_LEDS
	default y

So what this patch now does:

config ATH10K_LEDS
	bool
	depends on ATH10K
	depends on LEDS_CLASS=y || LEDS_CLASS=MAC80211
	default y

The idea being that if LEDS_CLASS is enabled then ATH10K_LEDS is
automatically enabled. But please let us know if something is wrong
here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

