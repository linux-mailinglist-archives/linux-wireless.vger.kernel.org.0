Return-Path: <linux-wireless+bounces-5079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA78881C4B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 07:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803371C21023
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 06:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50DD3FB9A;
	Thu, 21 Mar 2024 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVHhYVgK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2E3FE42
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000880; cv=none; b=aZpGFC7sFs92VPOOqO8NlPNEZvr6UFUTa93lbIUcPLWRDwqVQWlDpizEzuhbD1+Rr/WQt4YHLVLjJ6kxPfwWU8xuRp4vboUqp8gentQXzCUgVwDggiVfjCwNnquzVBnTMgZiMPyRB2TY12GevHlTko3m/9WwLK5qPyxZ56PPMxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000880; c=relaxed/simple;
	bh=9vDSU43ID4EehPVWxOOZ4I/DycXAv9Jxhyg+f6qla7A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=u3w42YhRYmkrQjKekK2rc8dfQRqJf4yWp1/+FoM+R3uoAsJ15mV202bfhsCoJoiLMJfDZtYTlDlrrN+DxclVFK9kJlNnWJcucuxLslgiNRHlteoTGcZ9b0E4rGblr23sx9siCQ+ixaCL6C1F/MQUnLR4sCOO4AkIPrNmNEE0E+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVHhYVgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1F7C433F1;
	Thu, 21 Mar 2024 06:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711000880;
	bh=9vDSU43ID4EehPVWxOOZ4I/DycXAv9Jxhyg+f6qla7A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=IVHhYVgKMB3/HAXNRVjynkdcfgHYvXyYgmUA+JEn5VT0ywLgjq6oFFn7Qsu9qpyS/
	 swq/EY2qHnQRS592IDGA1jLviTOxrufV5GgvxuDTuszWda+aI6M96UlWQCKb5OrmA4
	 5T4AnHvszHm/i/SxfkC1Xmnarz1yRcqLQoMogZJ6t7umNmWcMD3i5mpW5XL03PWqm3
	 kclq2fAn61/8aSyp0xrfpLes4iSJoD6Yo0FKKgFJlCnpEHBXAdEh5oKa9qBoKjP7xw
	 ucVY35ZP9QqDBOEcoz5FqwB42hchyNQpnX3dzDP+KYuUV8iW+b6jCAkUsgJB3NuG4r
	 DprdlfttzevzA==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "Leo.Li" <leo.li@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: disable txptctrl IMR to avoid flase alarm
References: <20240321025603.20614-1-pkshih@realtek.com>
	<878r2c2mob.fsf@kernel.org>
	<2eefd73994778c1fa1dc03acf04708d686ec3185.camel@realtek.com>
Date: Thu, 21 Mar 2024 08:01:17 +0200
In-Reply-To: <2eefd73994778c1fa1dc03acf04708d686ec3185.camel@realtek.com>
	(Ping-Ke Shih's message of "Thu, 21 Mar 2024 05:33:07 +0000")
Message-ID: <87jzlw9l8y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> On Thu, 2024-03-21 at 07:12 +0200, Kalle Valo wrote:
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > From: Chia-Yuan Li <leo.li@realtek.com>
>> > 
>> > The hardware command parser of txptctrl (TX protocol control) has overly
>> > stringent timeout conditions, which results in false alarm. So disable it.
>> > 
>> > Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> I'm in the To field, do you maybe want me to take this to wireless tree?
>> 
>
> No, it should go via rtw.git. I just send this patch as usual. 

Ok.

> Should I change to wireless mailing list as To field and no need to
> add you in neither To field nor Cc field in the future?

Yes, please drop me from To and Cc fields. And if there's an important
fix you want to go to wireless tree please label it as "[PATCH
wireless]" (or comment on the patch) and assign to me on patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

