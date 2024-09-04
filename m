Return-Path: <linux-wireless+bounces-12487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F6596C125
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89532883B1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 14:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512B81DC183;
	Wed,  4 Sep 2024 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3018xlu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295951DB53C;
	Wed,  4 Sep 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461305; cv=none; b=XzMd+0OLmqWPp/nUtQBFcSzQLzHf8pZ9DICpcGRnmbQulMNV8mt7lIM7PYIQkDerX1e65u1z6WJ/Omc29MYJhliBPVV5arWkhsgz2y2fjtTwAuVS3hR1HLnDhJkRPNt2z6sfWsYkPS1vMZ9r8BAz02267bDoQl5qo9cYp9rh86I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461305; c=relaxed/simple;
	bh=aSgyay04rukkSKGyNBhfbxPLHP5fFfaqSa1WJf5ZLLc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tBIIKgTQ5wq6xFNnnB0RRYCbldFpNuZ7yBEvIqlCCKIS/bjiNEMIVo8jeEJ7bauiZ8OaaSAKESjHT3MgqP1V8a8Zesb8A2QnI82m1yTTM5Ec+RIg/MpMzux7qNf8LuFurEN09XG+UwAaY2gNatq1fzOtTtyhsXISi9P/qezvGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3018xlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63793C4CEC6;
	Wed,  4 Sep 2024 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725461303;
	bh=aSgyay04rukkSKGyNBhfbxPLHP5fFfaqSa1WJf5ZLLc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=b3018xlu7QLwoY8krfOJEpp46QB0pBmlOkn5EtTAJeb5aEZCAi7RDgN2RvCv/APQv
	 7gTc9+IiF8duZDpW8td8kZdTzc70iFf65C0Gzvb9/MMb1W88wcC73DwWqL9YsEbp9x
	 64m38WOwjO+7Cwc8XIDdjRd5Gn/Nf6MWE5CEDOnRrm7T8cUOI0+hyLDtqEoEV/AA8I
	 eFdWdzcn+GRluvBxxR6rBrYWxaQH1hi4LI/YyJYldJaISP5G/Yc+58Hl/XTG0IMaFI
	 THdGawCOnativ+acb2RiTt/dF/vzTbHOTxC20f+v1+LT1QEe5t2dc8jAbxdu8TT1Mj
	 e9obJEKbU5hJg==
From: Kalle Valo <kvalo@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  James Prestwood
 <prestwoj@gmail.com>,  linux-wireless@vger.kernel.org,
  ath10k@lists.infradead.org,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware
 (-110) (ETIMEDOUT)
References: <d8253ab3-f4f0-40fd-a550-d75eef121b56@molgen.mpg.de>
Date: Wed, 04 Sep 2024 17:48:20 +0300
In-Reply-To: <d8253ab3-f4f0-40fd-a550-d75eef121b56@molgen.mpg.de> (Paul
	Menzel's message of "Wed, 4 Sep 2024 12:45:01 +0200")
Message-ID: <87bk13jwzv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Menzel <pmenzel@molgen.mpg.de> writes:

> Dear Linux folks,
>
>
> Linux 6.11-rc6+ logged the warning below when resuming from ACPI S3
> (or unloading and loading the `ath10k_core`/`ath10k_pci` modules)
> having been connected to an AVM network:
>
>     wlp58s0: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware
>     (-110)
>
> Error code 110 is the value for ETIMEDOUT. I saw James patch [1], and
> applied it, and the error is still there (as exepected).
>
> Can the warning be improved so the user know, which component is at fault?

The warning comes from mac80211 and it already contains your network
interface name (wlp58s0). What else would you want to see?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

