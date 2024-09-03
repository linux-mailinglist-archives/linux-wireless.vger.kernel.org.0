Return-Path: <linux-wireless+bounces-12368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C2B9695F7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 09:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9077E2822F1
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 07:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407551D6DD4;
	Tue,  3 Sep 2024 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9VGjz8t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC0E1D6C48
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349675; cv=none; b=seb5C+tUcfKzQlMaEfVjvfiaUBihgLJ/lTkLRO98Msdykx3FkDxT45gse+GkC/cZFFjy+H5ItxXDOwdaTCubT8X8P/NMzor7P8wm7wyQlYKFfKwQVDySpYlb3GKwCWKL4CUPo7RbrzLsY2NA4nDKdPdM1kojVnteHietWu9Muno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349675; c=relaxed/simple;
	bh=PJ0iF1A09ij98ZFolpxphon2vSG84bDBPK3X5ONQHrY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Au5wAtGeZDgrDgRid6PgWaWHMoOCbYiFQQafsg/LaOnJvC7u8L5HzOJTUCEy/r0B2a/8IlSBZYGgUg8PxVQn9Zak/0sMMJQsRo65ZAqTpN8FHz+/wfDNX3hi65pq4XSbESnHy37YwQuuayPawqZeVuVtqYAsoBuoEaE2tXDZ8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9VGjz8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC73C4CEC5;
	Tue,  3 Sep 2024 07:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725349674;
	bh=PJ0iF1A09ij98ZFolpxphon2vSG84bDBPK3X5ONQHrY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=U9VGjz8tpddNQ/q7pQBZJtThpNG0jiBzU9o+lLUeozBEbXkrK0o5vYPWgy05HZBh2
	 iVrRotvXsgBKEfRQNXVzAwrkIkJK8AIYZB5zgbRhpkiIz+aspHqQ6EvSy0wXe0nGeZ
	 Jhpovx9IPr9r9rHCXFIatKn0pKvpuMp+FVbbEXRe8HYMNhuuTXmm4hlHYhEP1SP4BQ
	 AVvYaH9gDGid6zoPgjXxk/mM0kAZ4UU80emMW+ssfuHkYPHz/18ms8w4lzH8MYwPc3
	 VVI4ovlfU8NDn/a2zSJGS3AgPgeCT5vMYMRo3w4YNRQgt0zG5lcaY5Pg295d/HIcRl
	 PJyDhg4Vv5ISQ==
From: Kalle Valo <kvalo@kernel.org>
To: david Atkins <david@3adesign.co.uk>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  "ath12k@lists.infradead.org"
 <ath12k@lists.infradead.org>,
    linux-wireless@vger.kernel.org
Subject: Re: wcn7850 issues
References: <LO0P123MB4057D6C2F6FEFF335B30EE7CD6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<LO0P123MB4057122D4C7D07C7114F5ABED6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<be53813c-3edc-4734-b59d-83f43f14ea91@quicinc.com>
	<LO0P123MB4057C3085F445434F5E87B3AD6872@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<26bb8ec7-7170-4a09-ada3-c7c753c16e87@quicinc.com>
	<LO0P123MB40573F46A6D63145363C6B13D6812@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<cfe8e314-a28b-4ea3-85b2-9f5b4ac2db09@quicinc.com>
	<LO0P123MB405769E063E48B0F7AE18C5FD68C2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<LO0P123MB4057E823BDB7B9ECCCD75840D6972@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<a6c609fc-150b-4779-b3f6-dddbd6ce93dc@quicinc.com>
	<LO0P123MB40578A6CEC43AEFE301F9ED8D6912@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<86bc1623-8845-43fa-9aad-a8a6066b1448@quicinc.com>
	<LO0P123MB4057266AFF389FA69FDC84B8D6922@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	<fb455a66-b29b-4eb0-984c-254f9a1c5626@quicinc.com>
	<LO0P123MB40578B26075CD4C9C66D144BD6932@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
Date: Tue, 03 Sep 2024 10:47:51 +0300
In-Reply-To: <LO0P123MB40578B26075CD4C9C66D144BD6932@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	(david Atkins's message of "Tue, 3 Sep 2024 06:29:29 +0000")
Message-ID: <871q21kwk8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

+ linux-wireless

david Atkins <david@3adesign.co.uk> writes:

> ...
>> >>>         Ext Tag: EHT Operation (802.11be D3.0)
>> >>>             Ext Tag length: 8 (Tag len: 9)
>> >>>             Ext Tag Number: EHT Operation (802.11be D3.0) (106)
>> >>>             EHT Operation Parameters: 0x01, EHT Operation Information
>> Present
>> >>>                 .... ...1 = EHT Operation Information Present: True
>> >>>                 .... ..0. = Disabled Subchannel Bitmap Present: False
>> >>>                 .... .0.. = EHT Default PE Duration: False
>> >>>                 .... 0... = Group Addressed BU Indication Limit: False
>> >>>                 ..00 .... = Group Addressed BU Indication Exponent: 0
>> >>>                 00.. .... = Reserved: 0x0
>> >>>             Basic EHT-MCS And Nss Set: 0x44444444
>> >>>             Control: 0x02, Channel Width: 80 MHz EHT BSS bandwidth
>> >>>                 .... .010 = Channel Width: 80 MHz EHT BSS bandwidth (2)
>> >>>                 0000 0... = Reserved: 0x00
>> >>>
>> >>> Are you saying the ath12k driver does not support these features? If
>> >>> not can
>> >> you clarify the issue so I can raise with the AP team.
>> >>>
>> >> ath12k/WCN7850 supports EHT, but with NSS only 2. Here the AP
>> >> requires NSS to be no less than 4, that is why EHT connection was disabled.
>> >
>> > Which field is requiring NSS of 4, I'm only seeing a maximum of 4, the
>> Qualcomm windows driver will connect to the same AP, we had assumed that
>> that ath12k would do the same.
>> Basic EHT-MCS And Nss Set: 0x44444444
>
> My understanding of the spec is that there are maximum numbers of
> streams though, are you saying the AP has to advertise 0x22222222
> which would then prevent a 4x4 client (say an extender) from
> connecting with 4 streams? I note that the Qualcomm windows driver for
> Hamilton works with the AP and an Intel BE200 also works both of which
> will be in at most 2x2

Did you test Intel BE200 with the Windows driver? Johannes mentioned
that ieee80211_verify_sta_eht_mcs_support() in mac80211 checks this so I
would assume that iwlwifi also behaves like ath12k.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

