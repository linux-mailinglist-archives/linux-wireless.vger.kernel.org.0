Return-Path: <linux-wireless+bounces-4731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD4D87B96C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 09:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722C2B237D5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BECC6AFB6;
	Thu, 14 Mar 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HokYpw6E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686684D9E3
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405730; cv=none; b=qSGcOU4rcBra0L9+sT6wvukZmr0/3vpS8owiZsfOw1JGFkXYeCQ2HqeHCnYJJEkMlyi++WD1JBri7EmESF4XDh8IqIprl2aTBpEDYFRnawtMcoiaTbLJGVwuWS37c+rBsMYLObHOcp1yXTCU1PPeDgs9aDoVPgtVjWkW+YmfJ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405730; c=relaxed/simple;
	bh=V1q0KMiGDwvOqYeDNv3r+GHu462jmQQ/0FV4uq/Y9Ug=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AqFujF9DLg8O9aJG87xu0UTbbr8zIkLkGMiuuMraJ8qi75COQhSeKISnxkq1aTRJ32HQsKPoqFSWDzyaAUlW0s126/S6LxYlsXAuzR5XgNxlw1HsY2264s9h+neNxoUJpToe5hj0N/a4AH0AcHReGUzbgckKZ2lbq8p6QMc3Hzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HokYpw6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9111C433F1;
	Thu, 14 Mar 2024 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710405729;
	bh=V1q0KMiGDwvOqYeDNv3r+GHu462jmQQ/0FV4uq/Y9Ug=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HokYpw6EJIEkyK1TbGyQQ5an8fCByTsKP5Bj/SykVaSute3iT41yp2lvQXW46QJzG
	 qPXC6g8bOeFVNGjTqFXyfbyKa0Uc9LzOWhhynfmqE56BXLrbsDo9NwpEdqOPDVA0GH
	 5L6qeYEyKGv9SFeuMB1R+VUXs/wD01kds6l++FfLIyoFJeuVV8Cl+lrn8rz4G3t/nA
	 3cR+UbTNNraMC4w8afrl5wbNIPkv4Saw/0PHeDZfOrIjd6VZDEY1QECVgbykbjCrcv
	 O4C++1+etT/VnY9GC0ZsFF3tns8SftH+JK4PtgIbfBx3tky2VWvmY6/zbpa7dkq4dj
	 G//A1HNPHWxNg==
From: Kalle Valo <kvalo@kernel.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  Ping-Ke Shih <pkshih@realtek.com>,  Larry Finger
 <Larry.Finger@lwfinger.net>,  Stefan Lippers-Hollmann <s.l-h@gmx.de>,
  Christian Hewitt <chewitt@libreelec.tv>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	<87jzm64ig6.fsf@kernel.org>
	<7fd2d445-9db0-4170-8d89-78d42f476255@gmail.com>
	<87a5n1fcqi.fsf@kernel.org>
Date: Thu, 14 Mar 2024 10:42:05 +0200
In-Reply-To: <87a5n1fcqi.fsf@kernel.org> (Kalle Valo's message of "Thu, 14 Mar
	2024 10:18:13 +0200")
Message-ID: <871q8dfbmq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>
>> On 13/03/2024 10:58, Kalle Valo wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>>> 
>>>> Create the new module rtl8192d-common and move some code into it from
>>>> rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driver
>>>> (USB) can share some of the code.
>>>>
>>>> This is mostly the code that required little effort to make it
>>>> shareable. There are a few more functions which they could share, with
>>>> some changes.
>>>>
>>>> The only other changes in this patch should be adjusting whitespace and
>>>> renaming some functions.
>>>>
>>>> Tested only with RTL8192DU.
>>>>
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>> 
>>> A cover letter is would be really good to have.
>>
>> I can add one. What should I write in it?
>
> Basically just a short (few sentences) introduction what the patchset
> adds and if there are problematic/broken/todo items, for example in this
> case that the firmware upload is pending. This info helps the reviewers
> and also having the cover letters makes the grouping in email
> applications better.

Here's a very good example of a cover letter:

https://patchwork.kernel.org/project/linux-wireless/cover/20240311103735.615541-1-fiona.klute@gmx.de/

The only gripe I have is that the version change log should be in
reverse order (v4, v3, v2 instead of v2, v3, v4) but that's just
cosmetics.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

