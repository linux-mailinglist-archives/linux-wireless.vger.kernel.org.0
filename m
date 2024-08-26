Return-Path: <linux-wireless+bounces-11995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9571095F483
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 17:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3271B21208
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F9F189BA2;
	Mon, 26 Aug 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFl3mBqI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE01CD25;
	Mon, 26 Aug 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684499; cv=none; b=YTTEAQMPa0xHBxiINsKx1HksKpvQ0gzFiQOuvqlSKgVTVZMh1U88SvAAiU81kAj5QetEIeZloDdtbHPzrdUHiwMciCMYB4jZJYwMfqNMK0SpKI2O97IznPhFwmmLPbsK3aXbW1HPwHMdBN/8qLa4dPRmYpi6z+SIN5liS1GFhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684499; c=relaxed/simple;
	bh=7+sDG1ieaSjQRgA3TjmKJayTJNuyCoDila3FWzk87+E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=vGtsJrK79qjAKcC3ws3MMx/MIjifjiB3XlRh1SjArtM9MHCwqfq6g3yB1lGzNF2aKdJFqkR3+cEVhGFJuiSeYta4ehk3yoX8Oaq9weghiJDQamdVs+smHZ4txTzMw9x65wBj/jZ/vYm349RWaBsFj1XQuRSpf0MpuyVd0ruS+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFl3mBqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B2EC4FE9C;
	Mon, 26 Aug 2024 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724684499;
	bh=7+sDG1ieaSjQRgA3TjmKJayTJNuyCoDila3FWzk87+E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tFl3mBqIpAvbEhwLFfu75ii4g9JGAayzRx6Qb0RgjH48NbplXr7uzqsXakDLWqSTS
	 xm3NpmasW8OgMe0W8z643dufLgrdvtXv+MMkYffE5V5BVeBFYLtaY/QZSh0gvWbsj0
	 1gYnb7+GyWJXA19TsuKoL/dyIYJvqwh3FtZZU7kbKVUx9JYaOu9G7mMmLSNlf6eGeh
	 TanxOS8MGrylx9J048j4tvx+3uuFxd/O3hN4nhoO8+TYGgrcGkXmD8nI7J91fWf5GV
	 d+Lwqk7Z3wrbrzRM8Goxr0bWctbNZjGq1YdFFkPLRUvgzT4GBQ1qcuG/XXrRMbCe1Q
	 p5f5lzcIvs8Ww==
From: Kalle Valo <kvalo@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: gregkh@linuxfoundation.org,  linux-kernel@vger.kernel.org,
  linux-usb@vger.kernel.org,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,
  syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com,
  syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] wifi: ath6kl: Replace ath6kl_usb_submit_ctrl_in with
 usb_control_msg_recv
References: <87seurfr3r.fsf@kernel.org>
	<tencent_5CE6CD937FE377496123A8A454F77F977805@qq.com>
Date: Mon, 26 Aug 2024 18:01:35 +0300
In-Reply-To: <tencent_5CE6CD937FE377496123A8A454F77F977805@qq.com> (Edward
	Adam Davis's message of "Mon, 26 Aug 2024 21:06:16 +0800")
Message-ID: <87jzg3uy40.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Edward Adam Davis <eadavis@qq.com> writes:

> On Mon, 26 Aug 2024 14:42:00 +0300, Kalle Valo wrote:
>> > ath6kl_usb_submit_ctrl_in() did not take into account the situation where
>> > the length of the data read from the device is not equal to the len, and
>> > such missing judgments will result in subsequent code using incorrect data.
>> >
>> > usb_control_msg_recv() handles the abnormal length of the returned data,
>> > so using it directly can fix this warning.
>> >
>> > Reported-by: syzbot+92c6dd14aaa230be6855@syzkaller.appspotmail.com
>> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> 
>> Did you test this on real ath6kl hardware?
>
> I don't have ath6kl hardware, I have only tested it on a virtual machine.

Virtual machine? I guess you mean syzbot? That gives no assurance if
this works on a real device or not. Please add to the commit message
"Compile tested only" so that we know it's untested.

And I have to warn that in wireless we are very reluctant to take syzbot
fixes which have not been tested on real hardware, they have caused
problems in the past.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

