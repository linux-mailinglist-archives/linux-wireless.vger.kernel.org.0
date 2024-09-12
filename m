Return-Path: <linux-wireless+bounces-12808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA49797617E
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 08:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F14283C12
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 06:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EC0188A00;
	Thu, 12 Sep 2024 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlEqGkHs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F89188910;
	Thu, 12 Sep 2024 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122490; cv=none; b=vGthHrrEwr6opPgNwwzJj4InMbyfxIMXZ33uwdSrdNT+HKEjO8nGYRhmOmOB4+M4roZSSuJsFtCgngor/RMaU/C1MeuVf2GKe4VIbWsRzVjHnExnq7UFcvDLx73I9TyOXp0MVwoNYprGos29BYD63yC+f3/zsy6+QlAvRoF8w9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122490; c=relaxed/simple;
	bh=MjQ4E1MdMZz5nmkOxdl7He+3j4kR0BpCjX0PWe777WY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qy91Icr/ZvrsQTpq+rYjpAzWon4D+gc26+3jKAMwv6WO7z6rxcjuWKNVOjSC2GCxkEiKHSLywQOH/EQcjr3YuhXYdW5N0KWjweRg1NvxYMx00zIbv55nRscKoU9P6rbhLKBgjymFV5bfTlohPtNmdNg2kvnIngk39BmrGVxogMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlEqGkHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F88C4CEC3;
	Thu, 12 Sep 2024 06:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726122490;
	bh=MjQ4E1MdMZz5nmkOxdl7He+3j4kR0BpCjX0PWe777WY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=hlEqGkHsNvxElPbuaF9AHV7rcqRJCkvoWBBA8BmKXYPs6NPSbko9YXMYLDVZ2WX7I
	 AA3PjxwMqyuxQ+ocbyOZwUsVk/RDz9iws0s8T9B2gWOtemcH61SqXpur31e6m536tm
	 DKhCG3AZcnwJE/JIL4USe7Qp2z+vxAx5wWMN9kvTEnyh2xlEmTlsA3Ur+XYgkuq49L
	 8PIlA5dOSnQRNveoR6/DUgpkiiWRbVmn2fYB7DgJdue8A3gVEifzLwD9aDbcHOro5W
	 9bmv6lxKlItyqrzwgK3emF/UxvpkdV+9zBujvCyIrXDssB+C4+Y58U4JDbi2Tc/CVx
	 gcuUqIsQp8BSw==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: wireless-next-2024-09-11
References: <20240911084147.A205DC4AF0F@smtp.kernel.org>
	<20240911134521.7f510329@kernel.org> <87ikv1bz8e.fsf@kernel.org>
	<20240911153633.7a01a6c7@kernel.org>
	<20240911153817.0c150bc6@kernel.org>
	<0b6a69a39d6b463da41c5a83b747e4cd@realtek.com>
Date: Thu, 12 Sep 2024 09:28:07 +0300
In-Reply-To: <0b6a69a39d6b463da41c5a83b747e4cd@realtek.com> (Ping-Ke Shih's
	message of "Thu, 12 Sep 2024 02:33:08 +0000")
Message-ID: <878qvxfkso.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Jakub Kicinski <kuba@kernel.org> wrote:
>> On Wed, 11 Sep 2024 15:36:33 -0700 Jakub Kicinski wrote:
>> > > What's the deadline for these? Do you need the fixes tomorrow or can it
>> > > wait a week or two?
>> >
>> > It can wait, half of them are old anyway
>> 
>> Oh, that's because they are in staging :) I missed that.
>> But anyway, I don't think that a harmless, single compiler,
>> W=1 warning is a blocker.

Ok, we'll send the rtw89 fix in the normal wireless pull request,
hopefully before the merge window closes.

> I have fixed warnings of "wifi: rtw89" by [1]. For staging code, I use another
> patchset [2] to fix it.

Oh wow, that was quick. We have 24/7 watch around the world :) Thanks Ping!

> I'm not sure [1] should go wireless or rtw tree. Please guide me. Thanks. 

Let's queue the rtw89 fix for wireless so that the quick goes to net
tree soon. So please assign it to me on patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

