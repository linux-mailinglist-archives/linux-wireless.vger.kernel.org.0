Return-Path: <linux-wireless+bounces-12531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2912196DA2F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 15:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD1B1C23A0F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFC619D078;
	Thu,  5 Sep 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJNk0sKR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02B19AA73;
	Thu,  5 Sep 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542599; cv=none; b=R8gwso3+cTnlegmkvg0Swi1AbkSKR+nMSs3AdcnxgBa9JYmNcK5A3U5KcO0AO99iiY/7cmSgwPJZbbAK4kvoE3Vw3cFzsfzvJNk+K+A9tzPm6HSkJVOPXf6nJ8SWtGC1reyDZj57x7mUTNqrkSYWs9dkpL7Q/umfibSv6UY5wtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542599; c=relaxed/simple;
	bh=h+XbA3+VCIeuLn9lhEd8QO33LVVy/IJRQcMcL8Ekg3g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oMcBanb16gv/bjMjcldPvB57zs2pBt07+lgQLROUZ/on7+JOFgVT/JAmTBi9WjZLX/lg+JOSXFs2r5xLz6XFKCVjX0nPRpym7pLeE5fEZH6BI/hkdHqR901EEEgpalZrAakFJ67lkLvtVu3JYd9sW6zeOtlwN6WHtoeqPuY7eac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJNk0sKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE12FC4CEC3;
	Thu,  5 Sep 2024 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725542599;
	bh=h+XbA3+VCIeuLn9lhEd8QO33LVVy/IJRQcMcL8Ekg3g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FJNk0sKRWaKGiQHD2tLO2bJzbExykEVZTAnVu7Y7XOAyMw+ZkkBcdgilkwrHJ6yUk
	 qbY8qZr6GdqhG9O0VfJ5Q8wGmY9W3TRAJoyjsM3uIqfV0pD24pjpw3k71A5CttjCXj
	 Ol0XM/C3aR4oaDOC9x0RBQAfttl5vxKNXXcaAZElf1AWChmaJEUENSq6S+pKuhiZOH
	 m/B2m/dg3qd+wlfVAnANk4ayhl4pZwir/BeqxNHuQc6W/XNPi4IvwFAUYFoyYFfnGv
	 NLepWwPO6y4eZXTCPpuKoPpEiK01WFrIpPH5sovgzEqIBceh3SU+1FhtDZPUrSvET8
	 8/rjbdW8dUYPA==
From: Kalle Valo <kvalo@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  James Prestwood
 <prestwoj@gmail.com>,  linux-wireless@vger.kernel.org,
  ath10k@lists.infradead.org,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware
 (-110) (ETIMEDOUT)
References: <d8253ab3-f4f0-40fd-a550-d75eef121b56@molgen.mpg.de>
	<87bk13jwzv.fsf@kernel.org>
	<00dfdaab-4d26-45f6-b69d-049ae489b2bd@molgen.mpg.de>
Date: Thu, 05 Sep 2024 16:23:15 +0300
In-Reply-To: <00dfdaab-4d26-45f6-b69d-049ae489b2bd@molgen.mpg.de> (Paul
	Menzel's message of "Wed, 4 Sep 2024 23:42:35 +0200")
Message-ID: <877cbqcjzw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Menzel <pmenzel@molgen.mpg.de> writes:

> Am 04.09.24 um 16:48 schrieb Kalle Valo:
>> Paul Menzel writes:
>
>>> Linux 6.11-rc6+ logged the warning below when resuming from ACPI S3
>>> (or unloading and loading the `ath10k_core`/`ath10k_pci` modules)
>>> having been connected to an AVM network:
>>>
>>>      wlp58s0: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware=
 (-110)
>>>
>>> Error code 110 is the value for ETIMEDOUT. I saw James patch [1], and
>>> applied it, and the error is still there (as expected).
>>>
>>> Can the warning be improved so the user know, which component is at fau=
lt?
>> The warning comes from mac80211 and it already contains your network
>> interface name (wlp58s0). What else would you want to see?
>
> As an ignorant user, I do not know what to do with the warning. I=E2=80=
=99d
> like to see a suggestion how to get rid of the warning. Maybe:
>
>     wlp58s0: failed to remove key (0, ce:ce:1e:27:bb:e0) from hardware
>     in X s (-110), please report it to the vendor firmware

The warning can come due to different reasons in different drivers, it's
not really easy to identify what the user should do.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

