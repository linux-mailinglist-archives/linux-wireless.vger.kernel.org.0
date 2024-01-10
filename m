Return-Path: <linux-wireless+bounces-1665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71061829BC4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08650282AB3
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F1495C6;
	Wed, 10 Jan 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngdY3fBQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF548CC7
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 13:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE40BC433C7;
	Wed, 10 Jan 2024 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704894595;
	bh=MVID6r38g1l+bGAUAMzcuNJf21BLWjXML2xd0ZzLb/4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ngdY3fBQbptm+yDPwci8As+iUSZw0Dcm0Pxil5Pv51kIYKDmQlP4CrAYLS/sX7NDp
	 inyeGO6Bf2JOb1BeLVcw/ueiIbu8WRtOVqjLbLd1kPW8GNZRNjOoNzW2zPQfkJ5Sm9
	 fRfle5ksWZ3aJmdrSGEZMi9dh6xOCysO7QWOWLdBUqetEXmqztOgFyYRAX9ybNXByw
	 NRiWA/McEHm7LQcpEe9KRXEZraHQPyd9kY1paL0KuweUyz47yHti83GlEnqycjZMNF
	 MM5VVloSIPq1DZmYa2w/0uTHTGPAzMDHkkVGTyF0/UEhZYEnNVG8CzU9lqTDKvA0uD
	 O0O+5JpA4dhtw==
From: Kalle Valo <kvalo@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: linux-wireless@vger.kernel.org,  ath11k@lists.infradead.org
Subject: Re: ath11k and vfio-pci support
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	<8734v5zhol.fsf@kernel.org>
	<87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
Date: Wed, 10 Jan 2024 15:49:52 +0200
In-Reply-To: <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com> (James
	Prestwood's message of "Wed, 10 Jan 2024 05:04:52 -0800")
Message-ID: <87r0ipcn7j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Prestwood <prestwoj@gmail.com> writes:

>> But I have also no idea what is causing this, I guess we are doing
>> something wrong with the PCI communication? That reminds me, you could
>> try this in case that helps:
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>
> Heh, I saw this pop up a day after I sent this and was wondering. Is
> this something I'd need on the host kernel, guest, or both?

On the guest where ath11k is running. I'm not optimistic that this would
solve your issue, I suspect there can be also other bugs, but good to
know if the patch changes anything.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

