Return-Path: <linux-wireless+bounces-428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20538058A2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 16:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C5A1F2177A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946B568EA1;
	Tue,  5 Dec 2023 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfpLwMkv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74268AD56
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 15:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BC4C433C7;
	Tue,  5 Dec 2023 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701790072;
	bh=ombZDzMaoX08v30FB7mD3sP1qHxKoXQdX0hgGl58V3o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nfpLwMkvO1AI8LVy2HHXeKsPX1NZW5gb1gnM37n+x1pDoZA8pAYJCZBj5qJqnXFzZ
	 VhZS5Ck7+FxpY/SpYLZ1PuJDrvM1/UDi6YircYs//rU4PiO2mxioymfXQmONMZyCqe
	 IxJ6x8kSASxIyQlTwc9AOnpYlEHO70Xj8iiDo+FjkoMbFsQjmC1uV5iNSZy9htyrpU
	 xWdjRFuumqphqdUG2BIqsldMt4pijojFvMgjpd0NTXzX95gnc95k26vpHbd7HJVfd3
	 lbZAzjbtL2o2gwaDLynWa/CdKUWoXIyqCTW8lrVWdaC7aclqhLi7zSBgNp9oQPHmL5
	 vCW0YT+k/aOOQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: James Prestwood <prestwoj@gmail.com>,  <linux-wireless@vger.kernel.org>,
  <ath10k@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: ath10k: add support to allow broadcast action
 frame RX
References: <20231116173246.40458-1-prestwoj@gmail.com>
	<be472f3f-c1fc-4ab4-acca-1b1357c8b407@quicinc.com>
Date: Tue, 05 Dec 2023 17:27:50 +0200
In-Reply-To: <be472f3f-c1fc-4ab4-acca-1b1357c8b407@quicinc.com> (Jeff
	Johnson's message of "Thu, 16 Nov 2023 12:05:31 -0800")
Message-ID: <87il5cpt3d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 11/16/2023 9:32 AM, James Prestwood wrote:
>
>> Broadcast action frames are needed for the Device Provisioning
>> Protocol (DPP) for Presence and PKEX Exchange requests. Currently
>> just ath9k has this capability so this is being enabled for
>> ath10k (for at least one hardware variant).
>> 
>> Add a new capability flag in ath10k_hw_params to indicate support
>> for receiving multicast action frames. This bit is then checked
>> when configuring the RX filter and (if set) multicast action frame
>> registration is enabled.
>> 
>> Until more hardware can be tested only the "qca6174 hw3.2" variant
>> is enabling this feature.
>> 
>> Note: I went ahead and removed the 'changed_flags' mask operation
>> since it had no effect, that parameter was not being used anywhere.
>> 
>> Tested-on: QCA6174 hw3.2 WLAN.RM.4.4.1-00288-
>> 
>> Signed-off-by: James Prestwood <prestwoj@gmail.com>

[...]

>> --- a/drivers/net/wireless/ath/ath10k/core.c
>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>> @@ -381,6 +381,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
>>  		.hw_restart_disconnect = false,
>>  		.use_fw_tx_credits = true,
>>  		.delay_unmap_buffer = false,
>> +		.mcast_frame_registration = true,

I forgot to mention that I prefer explicitly setting the false cases as
well so I added those in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=51daeadfbecc13b2ce8a9a4b7697e4056cbb358f

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

