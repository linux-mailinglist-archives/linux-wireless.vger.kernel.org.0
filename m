Return-Path: <linux-wireless+bounces-16031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F1A9E914A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 12:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6441887180
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9372218ACE;
	Mon,  9 Dec 2024 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFjo47Rv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84849217656;
	Mon,  9 Dec 2024 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742115; cv=none; b=AA8MwbSsd34Ig5F+NFe0N9DcvzmZDcifGsGXml1IRKxzvygVtHrCjLXVm8ciSsUbvLK6i+f6Ygx9KSBLzLOE/bgiF0mC0R3TB9gGwPE0Hu43e5g8IiYK/dIojefrHva1R77hhxSm7gwfpfCq9Rqr8kbS2/9UiaEDmLUzVnaz9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742115; c=relaxed/simple;
	bh=BTD6Nq7Hyt9oanQjIFlZhjxksd0IkVLulg5hidZbUPw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Dek2PgQJHErQfqjo3U3KIBUNAgn/Rb5rRRI2qgDJqE4VipZJUKo9MVaXZuRX/QWNRI5sbiLm3HGNCwJLI/rP5fVr9+eQqrYlv+NLp4GtfElHKh4Jnhqg4bQ3HYmquIWeuyAHWdjKs6dgiOKBetG95c7uIgOlIxwnP60tE5XBH0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFjo47Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7451C4CEDE;
	Mon,  9 Dec 2024 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733742115;
	bh=BTD6Nq7Hyt9oanQjIFlZhjxksd0IkVLulg5hidZbUPw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FFjo47Rvx1IsuaSfSG5z9G6Gzj1XQU8xH7qMipu2oo3C+ror65st/MjmkdWHOb9iL
	 hD1H9cP1l9/gVRBZlF4K1zPm0nJgdk6AFQhFtIGIdML7hV7+mP4ENk2p/JAJXuYIJ4
	 CY1LBVHhKwJ/+k74e2dw/szo7u71R7LuxdmlbcaKpP3dEBLAlkH02CwkkGoUsz/u02
	 rDUG79gJZTYb6AMq2uUzm4CnV3/pAN6ZW1Iy0O8ae2GCusew8zx3QkakCAl9/Fq7G7
	 nQit97q7gGTiADXP95qpVIRkh0shnKtiXXkhf+87jwAlVvtDkn8+NLya7QdrEWD/Yn
	 cf8CoFZFPmgSA==
From: Kalle Valo <kvalo@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>,  Jes Sorensen
 <Jes.Sorensen@gmail.com>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "stable@vger.kernel.org"
 <stable@vger.kernel.org>,  Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
References: <20241107140833.274986-1-hdegoede@redhat.com>
	<6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
	<094431c4-1f82-43e0-b3f0-e9c127198e98@redhat.com>
	<8e0a643ecdc2469f936c607dbd555b4c@realtek.com>
	<1d59a602-053a-47f1-9dac-5c95483d07b6@redhat.com>
Date: Mon, 09 Dec 2024 13:01:51 +0200
In-Reply-To: <1d59a602-053a-47f1-9dac-5c95483d07b6@redhat.com> (Hans de
	Goede's message of "Mon, 9 Dec 2024 09:30:39 +0100")
Message-ID: <87ldwpt90g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hans de Goede <hdegoede@redhat.com> writes:

> Hi,
>
> On 9-Dec-24 1:26 AM, Ping-Ke Shih wrote:
>> Hans de Goede <hdegoede@redhat.com> wrote:
>>> Hi,
>>>
>>> On 18-Nov-24 3:23 AM, Ping-Ke Shih wrote:
>>>> Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>>> The rtl8xxxu has all the rtl8192cu USB IDs from rtlwifi/rtl8192cu/sw.c
>>>>> except for the following 10, add these to the untested section so they
>>>>> can be used with the rtl8xxxu as the rtl8192cu are well supported.
>>>>>
>>>>> This fixes these wifi modules not working on distributions which have
>>>>> disabled CONFIG_RTL8192CU replacing it with CONFIG_RTL8XXXU_UNTESTED,
>>>>> like Fedora.
>>>>>
>>>>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>>>>> Cc: stable@vger.kernel.org
>>>>> Cc: Peter Robinson <pbrobinson@gmail.com>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>>>>
>>>> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
>>>>
>>>> 31be3175bd7b wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
>>>
>>> Thank you for merging this, since this is a bugfix patch, see e.g. :
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>>>
>>> I was expecting this patch to show up in 6.13-rc1 but it does
>>> not appear to be there.
>>>
>>> Can you please include this in a fixes-pull-request to the network
>>> maintainer so that gets added to a 6.13-rc# release soon and then
>>> can be backported to various stable kernels ?
>>>
>> 
>> This patch stays in rtw.git and 6.14 will have it, and then drain to stable
>> trees. For the redhat users, could you ask the distro maintainer to take this
>> patch ahead?
>
> That is not how things are supposed to work. You are supposed to have a fixes
> tree/branch and a next tree/branch and fixes should be send out ASAP.

Please understand that we are more or less volunteers and working with
limited time.

> Ideally you would have already send this out as a fixes pull-request for
> 6.12 but waiting till 6.14 really is not acceptable IMHO.

If you have an important fix please document that somehow, for example
"[PATCH wireless]" or "[PATCH v6.13]". If there's nothing like that most
likely the patch goes to -next, we (in wireless) don't take every fix to
-rc.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

