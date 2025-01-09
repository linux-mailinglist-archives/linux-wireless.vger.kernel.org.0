Return-Path: <linux-wireless+bounces-17244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7BCA07748
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 14:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FAE160452
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD858217F28;
	Thu,  9 Jan 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSAJyiid"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F42040BF
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429103; cv=none; b=VZDpHLnKz0HkaSkFO9UVEBLbSDR3CZRqVQkUuCWLc43m/JpdYKLgx8FNk2hFFrUG60I2pWtbIMOiVLCUzGrhIRkJfNW4Wx43nCPahy1RnKhefFImJFjFCUwCY2s3LpW2uCAVTssRIXG43lclnSkBxSzSyauckm5ykM5U9+p+PNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429103; c=relaxed/simple;
	bh=LhdUenZrd6/uD68Zn3fDML7StxjZY1azKu975pcyTlM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uGhgfvgCH/wssm276dsnrHjfnCuP6jWbuoaGDO7l0j4AlZO304cwdT5SFIIls7dCMPHTRQocgynA28ssm8T0I5vzXCXgYW1N3TW7INUgLqBpvlcjsLcctkREtyp/sG4weM3C3un1AjWzF59T9cdMQ9297Ev6J0TxwB0bHwwfEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSAJyiid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363BEC4CED2;
	Thu,  9 Jan 2025 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736429103;
	bh=LhdUenZrd6/uD68Zn3fDML7StxjZY1azKu975pcyTlM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kSAJyiidkUN+I7EtcEH9S25xznCQ9o6SNVWfCRh6yvXBi53GSeTDaUHCAAS8iicty
	 j4lWYkQ1ixn9wJNO24AckOdYL/J1RQc2d/2n+e2Mb/nZu1xd/wdZEoBfefrHX5nPCu
	 PuRMOE8hoIL2shSJPDjw+Xi+53lf4w2PGUIFFUuj97kWKLhJK0XAtyuZF9vtBNeyuL
	 F7dYapeXRc+wXpxx4YfRaAL9JNYnj/LsJopkbUixqh9rMwPD4NNFMEjPTTLUgWApwt
	 Ag5v/KzR6t2LdlviKcyEm9DQlNwceKnN8RuulX0TT6QOICrRJZ1yXwrJz1admu3pd7
	 cpMGk8JQMds3g==
From: Kalle Valo <kvalo@kernel.org>
To: "Nicolas Escande" <nico.escande@gmail.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  "Steffen Moser" <lists@steffen-moser.de>
Subject: Re: Potential Broadcast Issues After GTK Key Exchange on ath11k
 with IPQ8072A (QCN5024/QCN5054)
References: <c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de>
	<Z2Q9POuV-6MIdzRf@pilgrim>
	<b18ede18-0c33-4d14-a7c5-0066cbec39c9@steffen-moser.de>
	<D6VX7M6MGZQB.3LU3FBYJK6CZH@gmail.com>
Date: Thu, 09 Jan 2025 15:25:00 +0200
In-Reply-To: <D6VX7M6MGZQB.3LU3FBYJK6CZH@gmail.com> (Nicolas Escande's message
	of "Tue, 07 Jan 2025 15:45:52 +0100")
Message-ID: <878qrkdsr7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nicolas Escande" <nico.escande@gmail.com> writes:

> On Sat Dec 28, 2024 at 11:13 AM CET, Steffen Moser wrote:
>> Dear Remi,
>>
>> thank you very much for the pointer to the patch. Sebastian integrated 
>> it into DD-WRT. Now the DynaLink DL-WRX36 runs absolutely smoothly, the 
>> WLAN links are stable, the packet loss is gone. No weird states anymore, 
>> independent from the group key exchange interval:
>>
>> https://data.saps.uni-ulm.de/index.php/s/NLNpWqjc8iGsaEM
>>
>> So your idea was a direct hit! Thank you very, very much. Several months 
>> of debugging have come to an end...
>
> So this is at least the second time this commit breaks a setup.
>  
> @ath11k why isn't this pushed to mainline ?
> This seems to be a clear regression, so even if there is no need to rush things
> in the long run this still needs to to reverted mainline right ?

Good question, I don't have an answer to that. Could someone (also
outside of Qualcomm) send a proper patch ASAP so that we can solve this?
And it's good ot include the link to this discussion and describe the
symptoms the revert is fixing.

This is the patch in question:

https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.3.0.r24/patches/ath11k/350-ath11k-Revert-clear-the-keys-properly-when-DISABLE_K.patch

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

