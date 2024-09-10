Return-Path: <linux-wireless+bounces-12743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889A7972D6D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11013B23C56
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101E2187857;
	Tue, 10 Sep 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9oS43Th"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AAF1862B8
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 09:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960229; cv=none; b=VcMkLI+0M68uyG4xd0+ougU8eiHj7BVJtnMQrotIwq9GrS6RpHIGXyqhrg/xE3Mf5kALE7rmR5QQmjHYnIYGrVUkcmBMNhg5kNJVa0GN65oUp/aatUXnvc81gTrsPTqELxqLY59RMlzmnnE64+5BtA0cC9aulIoxctRejpH3KaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960229; c=relaxed/simple;
	bh=tJP9GHCMCIAfr4hsxjN4iN1wAuceXtlv1/bK0SLhwJE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HYSUJmbXYC3inV5sxkC60kbtyu8DOq2x8ryNhZmjchhH+Ym0dGJFFehUnTSXw7/O4LSox0iojP1TmKG2rKQNxSBoicN64dwbU6C+n3Tpvo8xJsXUtQVmaUdMcxDFq9hv0VTvwwLxJJNmmWPr4fVepusKj12rAWM0jzM5LNXK+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9oS43Th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7670C4CEC3;
	Tue, 10 Sep 2024 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960228;
	bh=tJP9GHCMCIAfr4hsxjN4iN1wAuceXtlv1/bK0SLhwJE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=L9oS43ThCEcb8eQF0g8LE/Fhr0uKEWS3EQtrWaSQKrBQrgxUtjC8QWiMQ+tYTsQu3
	 rurft+KIjLgnVgl4llTBSugBuo26vMMPUPaFoHO59JU8QlV8QmXmgrp7kD2QZ6sUz9
	 ssCYJGNLbdq6dwg/zg6CKQqLviY8/xLoh+ifOh1N3l/WptFOT3+4tmfEG3ttWFTewn
	 pNjB5K6oTFl9Lr/bmIe11L77vll+6GIKNV9Vu8qi4BiNl/MRWUgFARcP+JLzu3OKUo
	 5MqnqnbkoCs5oGScZXXXntKbam8c7vhfgqkyLNbY8G1JAozGG9fdwWcBnNX0Rxi4wy
	 eiZgbVHpErhaA==
From: Kalle Valo <kvalo@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  ath11k@lists.infradead.org,
  ath10k <ath10k@lists.infradead.org>,  ath12k
 <ath12k@lists.infradead.org>,  linux-wireless
 <linux-wireless@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>
Subject: Re: New staging repos for ath1*k firmware
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
	<CA+HBbNFQ+25u_PK2j3vYtiCZwv+shVAVeAHKqQCwhyCopORt4Q@mail.gmail.com>
	<3772134.MHq7AAxBmi@ripper>
Date: Tue, 10 Sep 2024 12:23:44 +0300
In-Reply-To: <3772134.MHq7AAxBmi@ripper> (Sven Eckelmann's message of "Tue, 10
	Sep 2024 11:00:52 +0200")
Message-ID: <87h6ang8v3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sven Eckelmann <sven@narfation.org> writes:

> On Thursday, 7 March 2024 09:39:26 CEST Robert Marko wrote:
>> Can I please ask for IPQ6018 firmware to be updated to 2.9.0.1 as well?
>> 
>
> I've asked them via their support platform. They closed the ticket after Jeff 
> uploaded the 2.7.0.1 firmware (which was given to him by the firmware team).
>
> I will ask again...
>
> (Btw. thanks to Jeff and Kalle for managing the new firmware repositories - I 
> just hope that you get better input from the firmware teams)

Thanks, this is not easy but we are trying to improve. It's just that
the progress is so slow that it's really frustrating.

As there are so many different branches I have lost track, do you have a
list of missing firmware updates? We could try to push for updates on
our own end as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

