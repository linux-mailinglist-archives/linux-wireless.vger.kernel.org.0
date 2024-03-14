Return-Path: <linux-wireless+bounces-4728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECFA87B92C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 09:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6631C20A06
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514EC5D488;
	Thu, 14 Mar 2024 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNTFsRl7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA2E5B1EB
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404297; cv=none; b=CJrA4theipiqpnUuxGiAm+lfDK+EFgh3RoWTL9PkKQJklSGGO1PA+hUFre7mgDl2x7gnw4K6DdGpGx6UotETNdKdyt5MB6Q/BCXFgIIlaVKJN8hqT9qDatTnoBxlt+keFY+dguwDjngMmhTzu5q+jzRYainuuqTXG3VtumcY6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404297; c=relaxed/simple;
	bh=h4Fk7j4U/R67oc9Ho9G3bq00MWYct2I4+JUX8xs5apE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OnUCzbiSCWoMYq/T+++lXceFP2QvtEKT+fI4GEAyMTbeANghHkA0IGW/8ivj3txpCfc9mTMKpvf/Hm2vSPOiOlbpkXUDBK5/g8eja/+58Gbj3AAIjsdgn9dIUkC5GssBxxxO2W42D4SW7gQGqKIpZhLxJWETLX+VSkFO4tpiTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNTFsRl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55644C433C7;
	Thu, 14 Mar 2024 08:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710404296;
	bh=h4Fk7j4U/R67oc9Ho9G3bq00MWYct2I4+JUX8xs5apE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eNTFsRl7uaclE9SvMJVAmfv/1ati9qiTLmB36HHvpDBUjgYtxvbA6G/HBqxn3ZMRu
	 RWeWjZN+l4CWWP5kxEzw6XBN0k7b08L8j+Gegyc0oULs2nWN7RKSewfU66M0+wzni8
	 dr/xQYK7adBlahFlH36aRMx0dyirFLl1VVKS9QC93843MXHfmUlxnuU0R10Nvbmp9r
	 INUu4ZPWNSNXktqDKw8jrraCrbDWE634PHLq9SOj7MwQXmxDKI8PFotphNRm+AU7MF
	 mOiu5sdSQ5Xw6H2jzvEqtC9phPRR+0TbC1ZfpG7JCh84lFnW8VwY/cbuNAtXazy6Df
	 QUslPKnAIsWuA==
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
Date: Thu, 14 Mar 2024 10:18:13 +0200
In-Reply-To: <7fd2d445-9db0-4170-8d89-78d42f476255@gmail.com> (Bitterblue
	Smith's message of "Thu, 14 Mar 2024 00:46:13 +0200")
Message-ID: <87a5n1fcqi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> On 13/03/2024 10:58, Kalle Valo wrote:
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>> 
>>> Create the new module rtl8192d-common and move some code into it from
>>> rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driver
>>> (USB) can share some of the code.
>>>
>>> This is mostly the code that required little effort to make it
>>> shareable. There are a few more functions which they could share, with
>>> some changes.
>>>
>>> The only other changes in this patch should be adjusting whitespace and
>>> renaming some functions.
>>>
>>> Tested only with RTL8192DU.
>>>
>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> 
>> A cover letter is would be really good to have.
>
> I can add one. What should I write in it?

Basically just a short (few sentences) introduction what the patchset
adds and if there are problematic/broken/todo items, for example in this
case that the firmware upload is pending. This info helps the reviewers
and also having the cover letters makes the grouping in email
applications better.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

